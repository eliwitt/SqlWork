/****** Object:  StoredProcedure [dbo].[sp_nonreserves]    Script Date: 09/02/2010 10:36:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:        J. Steve Witt
-- Create date: 5/11/2010
-- Description:   Process Non-accident reserves
-- =============================================
ALTER PROCEDURE [dbo].[sp_nonreserves] 
      @ClaimID int,
      @VehNu      int, 
      @MyEntity   int
AS

BEGIN
      -- SET NOCOUNT ON added to prevent extra result sets from
      -- interfering with SELECT statements.
      SET NOCOUNT ON;

declare 
      @PolicyNu		int,
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
      @Debug        int,
      @trapped      int,
      @ErrorMsg     varchar(255)

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
if @Debug>1 print cast(@PolicyNu as nvarchar(10)) + ' ' + cast(@LossType as nvarchar(2))
if @Debug>1 print @AccDt
-- get the GoAuto OurVeh 
select @OurVeh=OurVehicleIndex from CLM_ClaimVehicle where ClaimMasterPTR = @ClaimID and VehicleNumber = 1
select @OurDrv=OurDriverIndex from clm_vehiclepassenger where ClaimMasterPTR = @ClaimID and VehicleNumber = 1
if @Debug>1 print @OurVeh
if @Debug>1 print @OurDrv
--
-- is the policy active?
--
set @ReOpen = 0
exec @ReOpen = sp_IsPolicyActive @PolicyNu, @AccDt
if @@ERROR > 0 return @@ERROR
if @Debug=1 Print @ReOpen
-- 
-- policy is not enforce
--
if @ReOpen = 0
      goto NoReserve

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
exec sp_procreserve @ClaimID, @MyEntity, @ResType, @ReOpen, @PolicyNu, @AccDt, @OurVeh, @OurDrv
if @@ERROR > 0 return @@ERROR
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
exec sp_procreserve @ClaimID, @MyEntity, 6, @ReOpen, @PolicyNu, @AccDt, @OurVeh, @OurDrv
if @@ERROR > 0 return @@ERROR

--
-- the end of the NAF reserve checks
--
NoReserve:

if @Debug=1 print 'At the end'

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