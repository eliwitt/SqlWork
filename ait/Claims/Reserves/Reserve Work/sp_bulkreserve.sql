USE [ClaimsSchema_0616]
GO
/****** Object:  StoredProcedure [dbo].[sp_bulkreserve]    Script Date: 09/02/2010 10:34:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:        J. Steve Witt
-- Create date: 4/29/2010
-- Description:   Given the claim, vehicle, and veh entity numbers in the reserve
-- =============================================
ALTER PROCEDURE [dbo].[sp_bulkreserve] 
      @ClaimID int,
      @VehNu      int, 
      @MyEntity   int
AS

BEGIN
      -- SET NOCOUNT ON added to prevent extra result sets from
      -- interfering with SELECT statements.
      SET NOCOUNT ON;

declare 
      @PolicyNu         varchar(16),
      @AccDt            Datetime,
      @LossType         int,
      @OurVeh           int,
      @OurDrv           int,
      @ReOpen           int,
      @ReserveID        int,
      @ResType          int,
      @MyKey            int, 
	  @NeedATow			int,
      @ClaimLia			tinyint,
      @Result           int,
	  @ResAmt			money,
      @Debug            int,
      @trapped          int,
      @ErrorMsg         varchar(255)

set @Debug = 0
set @OurVeh = 0
set @OurDrv = 0
set @ResType = 0
set @Result = 0
set @ResAmt = 0
if @Debug=1 print 'At the start of the script'

--
-- get the nextentity, policy number, and DOL from the claim's master row
--
select @PolicyNu=PolicyNumber, @AccDt=DateOfLoss, @LossType = LossType from CLM_ClaimMaster where id = @ClaimID
if @Debug=1 print cast(@PolicyNu as nvarchar(10)) + ' ' + cast(@LossType as nvarchar(2))
if @Debug=1 print @AccDt
--
-- get the GoAuto OurVeh 
--
select @OurVeh=OurVehicleIndex from CLM_ClaimVehicle where ClaimMasterPTR = @ClaimID and VehicleNumber = 1
select @OurDrv=OurDriverIndex from clm_vehiclepassenger where ClaimMasterPTR = @ClaimID and VehicleNumber = 1

--
-- is the policy active?
--
set @ReOpen = 0
exec @ReOpen = sp_IsPolicyActive @PolicyNu, @AccDt
if @@ERROR > 0 return @@ERROR
if @Debug=1 Print @ReOpen

if @LossType > 2
begin
    exec sp_nonreserves @ClaimID, @VehNu, @MyEntity
    goto NoCommit
end

-- 
-- policy is not enforce
--
if @ReOpen = 0
	goto NoCommit

--
-- is this an Not-At-Fault NAF claim
--
if @LossType = 2
    goto NAFCk

--
-- the policy vehicle does not get LIPD coverage
--
if @VehNu = 1 
	goto SkipLIPD

--
-- does the policy have LIPD(1) coverage
--
exec sp_procreserve @ClaimID, @MyEntity, 1, @ReOpen, @PolicyNu, @AccDt, @OurVeh, @OurDrv
if @@ERROR > 0 return @@ERROR

-- only the policy vehicle gets more reserves
goto NoReserve

--
SkipLIPD:
--
-- check for other coverages the policy might cover only for the policy vehicle
--

--
-- does the policy cover COLL(4)
--
exec sp_procreserve @ClaimID, @MyEntity, 4, @ReOpen, @PolicyNu, @AccDt, @OurVeh, @OurDrv
if @@ERROR > 0 return @@ERROR

--
-- does the policy cover Towing(5)
--
--  check if the vehicle needs a tow
--
select @NeedATow=NeedsTowing from CLM_ClaimVehicle where ClaimMasterPTR = @ClaimID and VehicleNumber = @VehNu
if @NeedATow = 1
begin
	--
	-- Vehicle needs a tow(5) but is it covered?
	--
	exec sp_procreserve @ClaimID, @MyEntity, 5, @ReOpen, @PolicyNu, @AccDt, @OurVeh, @OurDrv
	if @@ERROR > 0 return @@ERROR
end

--
-- does the policy cover Rental(6)
--
exec sp_procreserve @ClaimID, @MyEntity, 6, @ReOpen, @PolicyNu, @AccDt, @OurVeh, @OurDrv
if @@ERROR > 0 return @@ERROR

--
-- bottom of the AF reserves
--
goto NoReserve

--
-- For NAF check for the UMPD coverage
--
NAFCk:
--
-- For Not-At-Fault NAF claims only the policy vehicle gets coverage
--
if @VehNu > 1 
      goto NoReserve
-- had to set this to open in order to get the reserves to be created for NAF claim types
set @ReOpen = 1
--
-- check that the claim has a vehicle that did not have liability
--
set @ClaimLia = 0
select @ClaimLia=Liability from clm_claimvehicle where claimmasterptr = @ClaimID and Liability = 1
if @ClaimLia = 0
begin
      -- give Coll if there is no liability
      set @ResType = 4
end
else
begin
      set @ResType = 9
end

--
-- does the policy cover UMPD or Coll?
--
exec sp_procreserve @ClaimID, @MyEntity, @ResType, @ReOpen, @PolicyNu, @AccDt, @OurVeh, @OurDrv
if @@ERROR > 0 return @@ERROR
--
--  check if the vehicle needs a tow
--
select @NeedATow=NeedsTowing from CLM_ClaimVehicle where ClaimMasterPTR = @ClaimID and VehicleNumber = @VehNu
if @NeedATow = 1
begin
	--
	-- Vehicle needs a tow(5) but is it covered?
	--
	exec sp_procreserve @ClaimID, @MyEntity, 5, @ReOpen, @PolicyNu, @AccDt, @OurVeh, @OurDrv
	if @@ERROR > 0 return @@ERROR
end

--
-- does the policy cover Rental(6)
--
exec sp_procreserve @ClaimID, @MyEntity, 6, @ReOpen, @PolicyNu, @AccDt, @OurVeh, @OurDrv
if @@ERROR > 0 return @@ERROR

--
-- the end of the NAF reserve checks
--
NoReserve:

if @Debug=1 print 'At the end'

NoCommit:
return

--
-- bottom of the script
--
Error_Handler:

if @Debug > 5
      print 'In the Error Handler'

IF @ErrorMsg IS NOT NULL
BEGIN
   SELECT @ErrorMsg = 'Claim Update script insertclaimveh: ' + @ErrorMsg + '  ' + convert(varchar(10), @trapped)
   -- Using "with log" inserts a message into the event log
   RAISERROR(@ErrorMsg, 11, 1) with log 
   --    RAISERROR(@ErrorMsg, 11, 1)
   --return 21
END

END

