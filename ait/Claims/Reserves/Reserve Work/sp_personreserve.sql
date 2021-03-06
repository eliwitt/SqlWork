/****** Object:  StoredProcedure [dbo].[sp_personreserve]    Script Date: 09/02/2010 10:37:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:        J. Steve Witt
-- Create date: 4/16/2010
-- Description:   Either remove or insert the reserve for a person
-- =============================================
ALTER PROCEDURE [dbo].[sp_personreserve] 
      @CMastPtr	int,
      @Person   int,
      @ProType  int 
AS

BEGIN
      -- SET NOCOUNT ON added to prevent extra result sets from
      -- interfering with SELECT statements.
      SET NOCOUNT ON;

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
      @trapped          int,
      @ErrorMsg         varchar(255)

set @Debug = 0
set @OurDrv = 0
set @OurGoIdx = 0
set @OurVeh = 0
set @ResType = 0
set @Result = 0
set @ResAmt = 0
if @Debug=1 print 'At the start of the script'
-- get the policy number, and DOL from the claim's master row
select @PolicyNu=PolicyNumber, @AccDt=DateOfLoss, @LossType = LossType from CLM_ClaimMaster where id = @CMastPtr
if @Debug=1 print cast(@PolicyNu as nvarchar(10)) + ' ' + cast(@LossType as nvarchar(2))
if @Debug=1 print @AccDt

-- get the involved parties' entitynumber
select @PersonEntity=EntityNumber from CLM_InvolvedParty where id = @Person
if @Debug=1 print 'Entity ' + cast(@PersonEntity as nvarchar(2))

-- is this person the goauto driver? if so he gets MED not LIBI
-- and what car is he in?
select @OurDrv = OurDriverIndex, @VehNu = VehicleNumber from clm_vehiclepassenger where involvedpartyptr = @Person
-- is the policy active?
exec @ReOpen = sp_IsPolicyActive @PolicyNu, @AccDt
if @@ERROR > 0 return @@ERROR
if @Debug=1 print @ReOpen


--
-- a process type of 1 is to close the reserve
--
if @ProType=1
begin
      if @Debug = 1 print 'Close the reserve'
      update CLM_Reserve 
            set ClosedOn = GetDate(), ReserveOpen = 0
            where ClaimNumber = @CMastPtr and EntityNumber = @PersonEntity 

      if (@@error <> 0)
      begin

            set @trapped = 10
            set @ErrorMsg = 'Error attempting to update the clm_reserve row '
            goto Error_Handler

      end
      goto ReserveEnd

end 
--
-- policy is not active
if @ReOpen = 0
      goto ReserveEnd
--
-- We need the Policy Driver and vehicle in order to give the correct reserves
--
-- get the GoAuto OurVeh 
--
select @OurVeh=OurVehicleIndex from CLM_ClaimVehicle where ClaimMasterPTR = @CMastPtr and VehicleNumber = 1
--
-- get the index for the driver of the goauto vehicle
--
select @OurGoIdx=OurDriverIndex from clm_vehiclepassenger where ClaimMasterPTR = @CMastPtr and VehicleNumber = 1
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
		  set @ResType = 7
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
	if ( @Result > 0)
	begin
		if @ClaimLia > 0 
		begin
			-- no liability vehicle has been id'd so give UMBI
			set @ResType = 8
		end
		else
		begin
			exec @Result = sp_IsCoverageActive @PolicyNu, @AccDt, @OurVeh, @OurGoIdx, 7
			if (@Result > 0)
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
		if (@Result > 0)
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

exec sp_procreserve @CMastPtr, @PersonEntity, @ResType, @ReOpen, @PolicyNu, @AccDt, @OurVeh, @OurGoIdx
if @@ERROR > 0 return @@ERROR

ReserveEnd:
if exists(select id from clm_reserve where claimnumber = @CMastPtr and ReserveOpen = 1)
begin	
	update clm_claimmaster set ReservesClosed = 0 where id = @CMastPtr
end 
else
begin
	update clm_claimmaster set ReservesClosed = 1 where id = @CMastPtr
end

return

--
-- bottom of the script
--
Error_Handler:

if @Debug > 5
    print 'In the Error Handler'

IF @ErrorMsg IS NOT NULL
BEGIN
    SELECT @ErrorMsg = 'Claim Update script personreserve: ' + @ErrorMsg + '  ' + convert(varchar(10), @trapped)
    -- Using "with log" inserts a message into the event log
    RAISERROR(@ErrorMsg, 11, 1) with log 
    --    RAISERROR(@ErrorMsg, 11, 1)
    --return 21
END

END