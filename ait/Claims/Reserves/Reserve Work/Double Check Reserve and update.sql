declare 
      @PolicyNu		varchar(16),
      @AccDt        Datetime,
      @LossType     int,
      @OurVeh       int,
      @OurDrv       int,
      @ReOpen       int,
      @ReserveID    int,
      @ResType      int,
      @MyKey        int, 
      @ClaimLia		tinyint,
      @Result       int,
	  @ResAmt		money,
	  @IgnoreFault		tinyint,
      @Debug        int,
      @trapped      int,
      @ErrorMsg     varchar(255),
      @ClaimID int,
      @VehNu      int, 
      @MyEntity   int

set @Debug = 1
set @OurVeh = 0
set @OurDrv = 0
set @ResType = 0
set @Result = 0
set @ResAmt = 0
set @ClaimID = 4755
set @MyEntity = 1
if @Debug=1 print 'At the start of the script'
--
-- get the nextentity, policy number, and DOL from the claim's master row
--
select @PolicyNu=PolicyNumber, @AccDt=DateOfLoss, @LossType = LossType, @IgnoreFault = IgnoreFaults from CLM_ClaimMaster where id = @ClaimID
if @Debug>1 print cast(@PolicyNu as nvarchar(10)) + ' ' + cast(@LossType as nvarchar(2))
if @Debug>1 print @AccDt
-- get the GoAuto OurVeh 
select @OurVeh=OurVehicleIndex, @OurDrv=OurDriverIndex from CLM_ClaimVehicle where ClaimMasterPTR = @ClaimID and VehicleNumber = 1
if @Debug>1 print @OurVeh
if @Debug>1 print @OurDrv
--
-- is the policy active?
--
set @ReOpen = 0
exec @ReOpen = sp_IsPolicyActive @PolicyNu, @AccDt
--if @@ERROR > 0 return @@ERROR
if @Debug=1 Print @ReOpen
if @IgnoreFault = 1
begin
	set @ReOpen = 1
	goto JumpCheck
end
--
-- policy is not active
if @ReOpen = 0
      goto NoReserve
JumpCheck:
--
-- what type of claim do we have
--
--  Hit an Aminal
if @LossType = 6
begin
	set @ResType = 4
end
-- Towing Only
if @LossType = 7
begin
	set @ResType = 5
end
else
begin
	set @ResType = 3
end

--
-- the acc type of 3, 4, 5 receives Comp(3) while 6 receives Coll(4) and 7 reserves towing only(5)
--
exec @Result = sp_IsCoverageActive @PolicyNu, @AccDt, @OurVeh, @OurDrv, @ResType
exec @ResAmt = sp_GetReserveAmount @ResType, @PolicyNu, @AccDt, @OurVeh
select '3, 4, 5', @ClaimID, @MyEntity, @ResType, @ReOpen, @PolicyNu, @AccDt, @OurVeh, @OurDrv
--exec sp_procreserve @ClaimID, @MyEntity, @ResType, @ReOpen, @PolicyNu, @AccDt, @OurVeh, 2
--
-- Hit and Other may receive rental
--
if @LossType = 4
	goto Rental
if @LossType = 6
	goto Rental
goto NoReserve

Rental:
--
-- does the policy cover Rental for Acc Type Hit an animal?
--
exec @Result = sp_IsCoverageActive @PolicyNu, @AccDt, @OurVeh, 2, 6
exec @ResAmt = sp_GetReserveAmount 6, @PolicyNu, @AccDt, @OurVeh
select 'Rental', @ClaimID, @MyEntity, 6, @ReOpen, @PolicyNu, @AccDt, @OurVeh, @OurDrv, @Result, @ResAmt
--exec sp_procreserve @ClaimID, @MyEntity, 6, @ReOpen, @PolicyNu, @AccDt, @OurVeh, 2


NoReserve:
print 'No reservers'
