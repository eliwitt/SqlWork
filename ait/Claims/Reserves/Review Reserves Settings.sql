declare @Debug          int, 
      @MyKey            int, 
      @PersonEntity     int,
      @PolicyNu         varchar(16),
      @ReserveID        int,
      @AccDt            Datetime,
      @ReOpen           int, 
      @ResType          int,
      @LossType         int,
	  @LossRole			int,
      @OurVeh           int,
      @OurGoIdx         int,
      @OurDrv           int,
      @VehNu            int,
      @ClaimLia         int,
      @Result           int,
	  @ResAmt			money,
	  @IgnoreFault		tinyint,
      @trapped          int,
      @ErrorMsg         varchar(255),
      @CMastPtr	int,
      @Person   int,
      @ProType  int 
set @CMastPtr = 3698
set @Person = 8059
set @ProType = 2
set @Debug = 1
set @OurDrv = 0
set @OurGoIdx = 0
set @OurVeh = 0
set @ResType = 0
set @Result = 0
set @ResAmt = 0
if @Debug=1 print 'At the start of the script'
-- get the policy number, and DOL from the claim's master row
select @PolicyNu=PolicyNumber, @AccDt=DateOfLoss, @LossType = LossType, @IgnoreFault = IgnoreFaults from CLM_ClaimMaster where id = @CMastPtr
if @Debug=1 print cast(@PolicyNu as nvarchar(10)) + ' loss type ' + cast(@LossType as nvarchar(2))
if @Debug=1 print @AccDt

-- get the involved parties' entitynumber
select @PersonEntity=EntityNumber, @LossRole = lossroleid from CLM_InvolvedParty where id = @Person
if @Debug=1 print 'Entity ' + cast(@PersonEntity as nvarchar(2))
print 'Drv ' + cast(@OurDrv as nvarchar(2))
-- is this person the goauto driver? if so he gets MED not LIBI
-- and what car is he in?
select @OurDrv = OurDriverIndex, @VehNu = VehicleNumber from clm_claimvehicle where involvedpartyptr = @Person
if @VehNu>1
	set @OurDrv = 0
-- is the policy active?
exec @ReOpen = sp_IsPolicyActive @PolicyNu, @AccDt
if @@ERROR > 0 goto ReserveEnd
if @Debug=1 print @ReOpen

print 'Drv ' + cast(@OurDrv as nvarchar(2)) + ' Veh ' + cast(@VehNu as nvarchar(2)) + ' role ' + cast(@LossRole as nvarchar(2))

if @IgnoreFault = 1
begin
	set @ReOpen = 1
	goto JumpCheck
end
--
-- policy is not active
if @ReOpen = 0
      goto ReserveEnd
JumpCheck:
--
-- We need the Policy Driver and vehicle in order to give the correct reserves
--
-- get the GoAuto OurVeh 
-- get the index for the driver of the goauto vehicle
--
select @OurVeh=OurVehicleIndex, @OurGoIdx=OurDriverIndex from CLM_ClaimVehicle where ClaimMasterPTR = @CMastPtr and VehicleNumber = 1
--
--
-- if the person is a passenger they get LIBI (2)
--
set @resType = 2
--  AF
if @LossType = 1
begin
	--  Driver?
	if @LossRole = 1
	begin
		if @OurDrv>0  
		begin
		--
		-- person is the goauto driver MED (7)
		--
		--		  set @ResType = 7
			goto ReserveEnd
		end
	end
end
--
-- if the claim is NAF then everyone in the goauto car gets UMBI
--
if @LossType = 2
begin
    --
    -- Only people in the goauto car gets UMBI
    --
    if @VehNu > 1
          goto ReserveEnd

    --
    -- we need to check the other vehicle that caused the injures DID NOT HAVE liability
    --
    set @ClaimLia = 0
    select @ClaimLia=Liability from clm_claimvehicle where claimmasterptr = @CMastPtr and Liability = 1
	--
	-- check the umbi coverage
	exec @Result = sp_IsCoverageActive @PolicyNu, @AccDt, @OurVeh, @OurGoIdx, 8
	if ((@Result > 0) or (@IgnoreFault = 1))
	begin
		if @ClaimLia > 0 
		begin
			-- no liability vehicle has been id'd so give UMBI
			set @ResType = 8
		end
		else
		begin
			exec @Result = sp_IsCoverageActive @PolicyNu, @AccDt, @OurVeh, @OurGoIdx, 7
			if ((@Result > 0) or (@IgnoreFault = 1))
			begin
				-- vehicle with no liability give MED
				set @Restype = 7
			end
			else
			begin
				-- No MED coverage
				goto ReserveEnd
			end
		end
	end
	else
	begin
		exec @Result = sp_IsCoverageActive @PolicyNu, @AccDt, @OurVeh, @OurGoIdx, 7
		if ((@Result > 0) or (@IgnoreFault = 1))
		begin
			-- No umbi coverage but we do have MED
			set @Restype = 7
		end
		else
		begin
			-- No MED
			goto ReserveEnd
		end
	end
end
select @CMastPtr, @PersonEntity, @ResType, @ReOpen, @PolicyNu, @AccDt, @OurVeh, @OurGoIdx
ReserveEnd:
Print 'At the End'