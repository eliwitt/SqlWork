USE [ClaimProdMar11]
GO
/****** Object:  StoredProcedure [dbo].[sp_nonreserves]    Script Date: 04/13/2011 09:38:07 ******/
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
      @ClaimNumber	varchar(18),
      @Result       int,
	  @ResAmt		money,
	  @IgnoreFault		tinyint,
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
select @PolicyNu=PolicyNumber, @AccDt=DateOfLoss, @LossType = LossType, @IgnoreFault = IgnoreFaults, @ClaimNumber = ClaimNumber from CLM_ClaimMaster where id = @ClaimID
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
if @@ERROR > 0 return @@ERROR
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
exec sp_procreserve @ClaimID, @MyEntity, @ResType, @ReOpen, @PolicyNu, @AccDt, @OurVeh, @OurDrv
if @@ERROR > 0 return @@ERROR
--
-- Hit animal, hail, and Other may receive rental
--
if @LossType = 3
	goto Rental
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
--
--  Now check if any reserves have been created do we need to insert a new assignment row
--
--  we have coverage of (1) LIPD with no one assigned to it do not set the claimloaded
--
if exists(select * from clm_reserve where claimnumber = @ClaimID and coverageid = 1 and reserveopen = 1 and not exists (
			select * from clm_adjusterassignments a where claimptr = @ClaimID and
				a.adjusterskilltypeptr = 2))
	insert into CLM_AdjusterAssignments values(0, @ClaimNumber, @ClaimID, 1, 2, GETDATE())
--
--  we have coverage of (2) LIBI with no one assigned to it do not set the claimloaded
--
if exists(select * from clm_reserve where claimnumber = @ClaimID and coverageid = 2 and reserveopen = 1 and not exists (
			select * from clm_adjusterassignments a where claimptr = @ClaimID and
				a.adjusterskilltypeptr = 4))
	insert into CLM_AdjusterAssignments values(0, @ClaimNumber, @ClaimID, 1, 4, GETDATE())
--
--  we have coverage of (3,4) Comp/Coll with no one assigned to it do not set the claimloaded
--
if exists(select * from clm_reserve where claimnumber = @ClaimID and coverageid in (3,4) and reserveopen = 1 and not exists (
			select * from clm_adjusterassignments a where claimptr = @ClaimID and
				a.adjusterskilltypeptr = 6))
	insert into CLM_AdjusterAssignments values(0, @ClaimNumber, @ClaimID, 1, 6, GETDATE())
--
--  we have coverage of (5) Towing with no one assigned to it do not set the claimloaded
--
if exists(select * from clm_reserve where claimnumber = @ClaimID and coverageid = 5 and reserveopen = 1 and not exists (
			select * from clm_adjusterassignments a where claimptr = @ClaimID and
				a.adjusterskilltypeptr = 7))
	insert into CLM_AdjusterAssignments values(0, @ClaimNumber, @ClaimID, 1, 7, GETDATE())
--
--  we have coverage of (7) MED with no one assigned to it do not set the claimloaded
--
if exists(select * from clm_reserve where claimnumber = @ClaimID and coverageid = 7 and reserveopen = 1 and not exists (
			select * from clm_adjusterassignments a where claimptr = @ClaimID and
				a.adjusterskilltypeptr = 8))
	insert into CLM_AdjusterAssignments values(0, @ClaimNumber, @ClaimID, 1, 8, GETDATE())
--
--  we have coverage of (8) UMBI with no one assigned to it do not set the claimloaded
--
if exists(select * from clm_reserve where claimnumber = @ClaimID and coverageid = 8 and reserveopen = 1 and not exists (
			select * from clm_adjusterassignments a where claimptr = @ClaimID and
				a.adjusterskilltypeptr = 9))
	insert into CLM_AdjusterAssignments values(0, @ClaimNumber, @ClaimID, 1, 9, GETDATE())
--
--  we have coverage of (9) UMPD with no one assigned to it do not set the claimloaded
--
if exists(select * from clm_reserve where claimnumber = @ClaimID and coverageid = 9 and reserveopen = 1 and not exists (
			select * from clm_adjusterassignments a where claimptr = @ClaimID and
				a.adjusterskilltypeptr = 10))
	insert into CLM_AdjusterAssignments values(0, @ClaimNumber, @ClaimID, 1, 10, GETDATE())

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