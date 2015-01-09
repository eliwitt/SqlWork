USE [ClaimsSchema]
GO

/****** Object:  StoredProcedure [dbo].[sp_bulkreserve]    Script Date: 05/12/2011 15:12:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:        J. Steve Witt
-- Create date: 4/29/2010
-- Description:   Given the claim, vehicle, and veh entity numbers in the reserve
-- =============================================
CREATE PROCEDURE [dbo].[sp_bulkreserve] 
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
	  @IgnoreFault		tinyint,
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
select @PolicyNu=PolicyNumber, @AccDt=DateOfLoss, @LossType = LossType, @IgnoreFault = IgnoreFaults from CLM_ClaimMaster where id = @ClaimID
if @Debug=1 print cast(@PolicyNu as nvarchar(10)) + ' ' + cast(@LossType as nvarchar(2))
if @Debug=1 print @AccDt
--
-- get the GoAuto OurVeh 
--
select @OurVeh=OurVehicleIndex, @OurDrv=OurDriverIndex from CLM_ClaimVehicle where ClaimMasterPTR = @ClaimID and VehicleNumber = 1
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
if @IgnoreFault = 1
begin
	set @ReOpen = 1
	goto JumpCheck
end
--
-- policy is not active
if @ReOpen = 0
      goto NoCommit
JumpCheck:
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
--if @ClaimLia = 0
--begin
--      -- give Coll if there is no liability
--      set @ResType = 4
--end
--else
--begin
--      set @ResType = 9
--end

--
-- does the policy cover UMPD?
--
exec sp_procreserve @ClaimID, @MyEntity, 9, @ReOpen, @PolicyNu, @AccDt, @OurVeh, @OurDrv
if @@ERROR > 0 return @@ERROR
--
-- does the policy cover COLL(4)
--
exec sp_procreserve @ClaimID, @MyEntity, 4, @ReOpen, @PolicyNu, @AccDt, @OurVeh, @OurDrv
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


GO

/****** Object:  StoredProcedure [dbo].[sp_claimreserves]    Script Date: 05/12/2011 15:12:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_claimreserves] 
      @CMastPtr int,
      @AccDt            datetime
AS

BEGIN

      -- SET NOCOUNT ON added to prevent extra result sets from
      -- interfering with SELECT statements.
      SET NOCOUNT ON;

declare @myVnu                int,
	  @ClaimNumber			  varchar(20),
      @myEnu                  int, 
      @myPer                  int,
	  @myOwner				  int,
      @myInjured        int

-- close any reserve for the claim

/* changed 4/21 11:29 ET */
update CLM_Reserve 
      set ClosedOn = GetDate(), ReserveOpen = 0
      where ClaimNumber = @CMastPtr and CoverageID not in (1,3,4,6,7) and ReserveOpen = 1

-- The following statements could delete the unused rows from the old claim
delete from clm_reserve where id in (
      select id from clm_reserve where claimnumber = @CMastPtr and 
		(AmountPaid = 0 or AmountPaid is null) and
		forcedclosed = 0
)

-- the following is a collection of claim's vehicles

declare myVehcursor cursor for
select distinct cv.VehicleNumber, cv.Entitynumber 
      from clm_claimvehicle cv 
      where cv.claimmasterptr = @CMastPtr and disabled = 0

open myVehcursor
fetch next from myVehcursor into @myVnu, @myEnu
while (@@fetch_status = 0)
begin

      exec sp_bulkreserve @CMastPtr, @myVnu, @myEnu
      fetch next from myVehcursor into @myVnu, @myEnu

end

close myVehcursor
deallocate myVehcursor

-- the following is a collection of the claim's people

declare myPercursor cursor for
select ip.id, ip.injured
      from clm_vehiclepassenger vp
            join clm_involvedparty ip on vp.involvedpartyptr = ip.id
      where claimmasterptr = @CMastPtr and disabled = 0 and lossroleid in (1,2,3,4)

open myPercursor
fetch next from myPercursor into @myPer, @myInjured
while (@@fetch_status = 0)
begin

      if @myInjured = 1
            exec sp_personreserve @CMastPtr,@myPer, 2
      fetch next from myPercursor into @myPer, @myInjured

end

close myPercursor
deallocate myPercursor

-- the following is a collection of the owners and their properties
declare myPropcursor cursor for
select involvedpartyptr from clm_otherproperty where claimmasterptr = @CMastPtr and (disabled = 0 or disabled is null)
open myPropcursor
fetch next from myPropcursor into @myOwner
while (@@fetch_status = 0)
begin

      exec sp_propertyreserve @CMastPtr,@myOwner, 2
      fetch next from myPropcursor into @myOwner

end
close myPropcursor
deallocate myPropcursor


if exists(select id from clm_reserve where claimnumber = @CMastPtr and ReserveOpen = 1)
begin	
	update clm_claimmaster set ReservesClosed = 0 where id = @CMastPtr
end 
else
begin
	update clm_claimmaster set ReservesClosed = 1 where id = @CMastPtr
end
select @ClaimNumber = ClaimNumber from CLM_ClaimMaster where id = @CMastPtr
declare @DOL datetime 
select @DOL = DateOfLoss from CLM_ClaimMaster where id = @CMastPtr
if @DOL >= '11/01/2010'
begin
--
--  Now check if any reserves have been created do we need to insert a new assignment row
--
--  we have coverage of (1) LIPD with no one assigned to it do not set the claimloaded
--
if exists(select * from clm_reserve where claimnumber = @CMastPtr and coverageid = 1 and reserveopen = 1 and not exists (
			select * from clm_adjusterassignments a where claimptr = @CMastPtr and
				a.adjusterskilltypeptr = 2))
	insert into CLM_AdjusterAssignments values(66436, @ClaimNumber, @CMastPtr, 1, 2, GETDATE())
--
--  we have coverage of (2) LIBI with no one assigned to it do not set the claimloaded
--
if exists(select * from clm_reserve where claimnumber = @CMastPtr and coverageid = 2 and reserveopen = 1 and not exists (
			select * from clm_adjusterassignments a where claimptr = @CMastPtr and
				a.adjusterskilltypeptr = 4))
	insert into CLM_AdjusterAssignments values(66436, @ClaimNumber, @CMastPtr, 1, 4, GETDATE())
--
--  we have coverage of (3,4) Comp/Coll with no one assigned to it do not set the claimloaded
--
if exists(select * from clm_reserve where claimnumber = @CMastPtr and coverageid in (3,4) and reserveopen = 1 and not exists (
			select * from clm_adjusterassignments a where claimptr = @CMastPtr and
				a.adjusterskilltypeptr = 6))
	insert into CLM_AdjusterAssignments values(66436, @ClaimNumber, @CMastPtr, 1, 6, GETDATE())
--
--  we have coverage of (5) Towing with no one assigned to it do not set the claimloaded
--
if exists(select * from clm_reserve where claimnumber = @CMastPtr and coverageid = 5 and reserveopen = 1 and not exists (
			select * from clm_adjusterassignments a where claimptr = @CMastPtr and
				a.adjusterskilltypeptr = 7))
	insert into CLM_AdjusterAssignments values(66436, @ClaimNumber, @CMastPtr, 1, 7, GETDATE())
--
--  we have coverage of (7) MED with no one assigned to it do not set the claimloaded
--
if exists(select * from clm_reserve where claimnumber = @CMastPtr and coverageid = 7 and reserveopen = 1 and not exists (
			select * from clm_adjusterassignments a where claimptr = @CMastPtr and
				a.adjusterskilltypeptr = 8))
	insert into CLM_AdjusterAssignments values(66436, @ClaimNumber, @CMastPtr, 1, 8, GETDATE())
--
--  we have coverage of (8) UMBI with no one assigned to it do not set the claimloaded
--
if exists(select * from clm_reserve where claimnumber = @CMastPtr and coverageid = 8 and reserveopen = 1 and not exists (
			select * from clm_adjusterassignments a where claimptr = @CMastPtr and
				a.adjusterskilltypeptr = 9))
	insert into CLM_AdjusterAssignments values(66436, @ClaimNumber, @CMastPtr, 1, 9, GETDATE())
--
--  we have coverage of (9) UMPD with no one assigned to it do not set the claimloaded
--
if exists(select * from clm_reserve where claimnumber = @CMastPtr and coverageid = 9 and reserveopen = 1 and not exists (
			select * from clm_adjusterassignments a where claimptr = @CMastPtr and
				a.adjusterskilltypeptr = 10))
	insert into CLM_AdjusterAssignments values(66436, @ClaimNumber, @CMastPtr, 1, 10, GETDATE())

end

end


GO

/****** Object:  StoredProcedure [dbo].[sp_nonreserves]    Script Date: 05/12/2011 15:12:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_nonreserves] 
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
      @ClaimNumber	varchar(20),
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

select @ClaimNumber = ClaimNumber from CLM_ClaimMaster where id = @ClaimID
declare @DOL datetime 
select @DOL = DateOfLoss from CLM_ClaimMaster where id = @ClaimID
if @DOL >= '11/01/2010'
begin
--
--  Now check if any reserves have been created do we need to insert a new assignment row
--
--  we have coverage of (1) LIPD with no one assigned to it do not set the claimloaded
--
if exists(select * from clm_reserve where claimnumber = @ClaimID and coverageid = 1 and reserveopen = 1 and not exists (
			select * from clm_adjusterassignments a where claimptr = @ClaimID and
				a.adjusterskilltypeptr = 2))
	insert into CLM_AdjusterAssignments values(66436, @ClaimNumber, @ClaimID, 1, 2, GETDATE())
--
--  we have coverage of (2) LIBI with no one assigned to it do not set the claimloaded
--
if exists(select * from clm_reserve where claimnumber = @ClaimID and coverageid = 2 and reserveopen = 1 and not exists (
			select * from clm_adjusterassignments a where claimptr = @ClaimID and
				a.adjusterskilltypeptr = 4))
	insert into CLM_AdjusterAssignments values(66436, @ClaimNumber, @ClaimID, 1, 4, GETDATE())
--
--  we have coverage of (3,4) Comp/Coll with no one assigned to it do not set the claimloaded
--
if exists(select * from clm_reserve where claimnumber = @ClaimID and coverageid in (3,4) and reserveopen = 1 and not exists (
			select * from clm_adjusterassignments a where claimptr = @ClaimID and
				a.adjusterskilltypeptr = 6))
	insert into CLM_AdjusterAssignments values(66436, @ClaimNumber, @ClaimID, 1, 6, GETDATE())
--
--  we have coverage of (5) Towing with no one assigned to it do not set the claimloaded
--
if exists(select * from clm_reserve where claimnumber = @ClaimID and coverageid = 5 and reserveopen = 1 and not exists (
			select * from clm_adjusterassignments a where claimptr = @ClaimID and
				a.adjusterskilltypeptr = 7))
	insert into CLM_AdjusterAssignments values(66436, @ClaimNumber, @ClaimID, 1, 7, GETDATE())
--
--  we have coverage of (7) MED with no one assigned to it do not set the claimloaded
--
if exists(select * from clm_reserve where claimnumber = @ClaimID and coverageid = 7 and reserveopen = 1 and not exists (
			select * from clm_adjusterassignments a where claimptr = @ClaimID and
				a.adjusterskilltypeptr = 8))
	insert into CLM_AdjusterAssignments values(66436, @ClaimNumber, @ClaimID, 1, 8, GETDATE())
--
--  we have coverage of (8) UMBI with no one assigned to it do not set the claimloaded
--
if exists(select * from clm_reserve where claimnumber = @ClaimID and coverageid = 8 and reserveopen = 1 and not exists (
			select * from clm_adjusterassignments a where claimptr = @ClaimID and
				a.adjusterskilltypeptr = 9))
	insert into CLM_AdjusterAssignments values(66436, @ClaimNumber, @ClaimID, 1, 9, GETDATE())
--
--  we have coverage of (9) UMPD with no one assigned to it do not set the claimloaded
--
if exists(select * from clm_reserve where claimnumber = @ClaimID and coverageid = 9 and reserveopen = 1 and not exists (
			select * from clm_adjusterassignments a where claimptr = @ClaimID and
				a.adjusterskilltypeptr = 10))
	insert into CLM_AdjusterAssignments values(66436, @ClaimNumber, @ClaimID, 1, 10, GETDATE())
	
end

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


GO

/****** Object:  StoredProcedure [dbo].[sp_personreserve]    Script Date: 05/12/2011 15:12:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_personreserve] 
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
	  @IgnoreFault		tinyint,
      @trapped          int,
	  @ClaimNumber		varchar(20),
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
select @PolicyNu=PolicyNumber, @AccDt=DateOfLoss, @LossType = LossType, @IgnoreFault = IgnoreFaults from CLM_ClaimMaster where id = @CMastPtr
if @Debug=1 print cast(@PolicyNu as nvarchar(10)) + ' ' + cast(@LossType as nvarchar(2))
if @Debug=1 print @AccDt

-- get the involved parties' entitynumber
select @PersonEntity=EntityNumber from CLM_InvolvedParty where id = @Person
if @Debug=1 print 'Entity ' + cast(@PersonEntity as nvarchar(2))

-- is this person the goauto driver? if so he gets MED not LIBI
-- and what car is he in?
--select @OurDrv = OurDriverIndex, @VehNu = VehicleNumber from clm_claimvehicle where involvedpartyptr = @Person
select @OurDrv = OurDriverIndex, @VehNu = VehicleNumber, @LossRole = lossroleid from clm_claimvehicle veh
join clm_involvedparty party on party.id = veh.involvedpartyptr
where claimmasterptr = @CMastPtr and involvedpartyptr = @Person and party.lossroleid = 1
if @VehNu>1
	set @OurDrv = 0
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
	if @LossRole = 1 and @VehNu = 1
	begin
		if @OurDrv>0  
		begin
		--
		-- person is the goauto driver MED (7)
		--
				  set @ResType = 7
			--goto ReserveEnd
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
			exec @Result = sp_IsCoverageActive @PolicyNu, @AccDt, @OurVeh, @OurGoIdx, 7
			if (@Result > 0)
			begin
			   set @ResType = 8 + 7
			end
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

if @ResType < 10
begin
   exec sp_procreserve @CMastPtr, @PersonEntity, @ResType, @ReOpen, @PolicyNu, @AccDt, @OurVeh, @OurGoIdx
end
else
begin
   exec sp_procreserve @CMastPtr, @PersonEntity, 7, @ReOpen, @PolicyNu, @AccDt, @OurVeh, @OurGoIdx
   exec sp_procreserve @CMastPtr, @PersonEntity, 8, @ReOpen, @PolicyNu, @AccDt, @OurVeh, @OurGoIdx
end
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
select @ClaimNumber = ClaimNumber from CLM_ClaimMaster where id = @CMastPtr
--
--  Now check if any reserves have been created do we need to insert a new assignment row
--
--  we have coverage of (2) LIBI with no one assigned to it do not set the claimloaded
--
if exists(select * from clm_reserve where claimnumber = @CMastPtr and coverageid = 2 and reserveopen = 1 and not exists (
			select * from clm_adjusterassignments a where claimptr = @CMastPtr and
				a.adjusterskilltypeptr = 4))
	insert into CLM_AdjusterAssignments values(66436, @ClaimNumber, @CMastPtr, 1, 4, GETDATE())
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



GO

/****** Object:  StoredProcedure [dbo].[sp_procreserve]    Script Date: 05/12/2011 15:12:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_procreserve] 
	@CMastPtr	int,
	@EntityPtr	int,
	@ResType	int,
	@ReOpen		int,
	@PolicyNu	varchar(16), 
	@AccDt		Datetime, 
	@OurVeh		int, 
	@OurDrv		int
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
declare @Debug          int, 
      @MyKey            int, 
      @ReserveID        int,
      @Result           int,
	  @ResAmt			money,
	  @IgnoreFault		tinyint,
      @trapped          int,
      @ErrorMsg         varchar(255)

set @Debug = 0
set @Result = 0
set @ResAmt = 0
set @MyKey = 0
set @ReserveID = 0
select @IgnoreFault = IgnoreFaults from CLM_ClaimMaster where id = @CMastPtr
begin transaction
if exists(select id from CLM_Reserve where ClaimNumber = @CMastPtr and EntityNumber = @EntityPtr and CoverageID = @ResType)
begin
	-- we need to check and not re-open a closed reserve
	if exists(select id from CLM_Reserve where ClaimNumber = @CMastPtr and EntityNumber = @EntityPtr and ReserveOpen = 1)
	begin
      if @Debug = 1 print 'Reopen the reserve'
      update CLM_Reserve 
            set ClosedOn = null, ReserveOpen = @ReOpen, OpenedOn = GetDate()
            where ClaimNumber = @CMastPtr and EntityNumber = @EntityPtr and CoverageID = @ResType and forcedclosed = 0

      if (@@error <> 0)
      begin
            set @trapped = 10
            set @ErrorMsg = 'Error attempting to update the clm_reserve row '
            goto Error_Handler
      end
	end
end
else
begin

    if @Debug = 1 print 'Insert the reserve'
    select @MyKey=Max(ID) from CLM_Reserve
    if (@MyKey is null)
    Begin
          set @MyKey=0
    end

    set @ReserveID=@MyKey+1
	exec @Result = sp_IsCoverageActive @PolicyNu, @AccDt, @OurVeh, @OurDrv, @ResType
	if ((@Result > 0) or (@IgnoreFault = 1))
    begin
		exec @ResAmt = sp_GetReserveAmount @ResType, @PolicyNu, @AccDt, @OurVeh
		if @Debug = 1 print 'The amount we would use is ' + cast(@ResAmt as nvarchar(8))
		insert into CLM_Reserve
			values(@ReserveID, @CMastPtr, @AccDt, @EntityPtr, @ResType, 
				@ResAmt, @ReOpen, 0, GetDate(), GetDate(), null, null, 0)

		if (@@error <> 0)
        begin
			set @trapped = 20
            set @ErrorMsg = 'Error attempting to insert the clm_reserve row '
            goto Error_Handler
        end

		if @ResType in (1,2,3,4)
        begin
           if (select count(*) from CLM_Reserve where ClaimNumber = @CMastPtr and CoverageID = @ResType and ID < @ReserveID) = 0
           begin
              update CLM_ClaimMaster SET ClaimLoaded = 1 where id = @CMastPtr
           end
        end

    end
end
commit transaction
return

--
-- bottom of the script
--
Error_Handler:

if @Debug > 5
      print 'In the Error Handler'

IF @ErrorMsg IS NOT NULL
BEGIN
      SELECT @ErrorMsg = 'Claim Update script procreserve: ' + @ErrorMsg + '  ' + convert(varchar(10), @trapped)
      -- Using "with log" inserts a message into the event log
       RAISERROR(@ErrorMsg, 11, 1) with log 
      --    RAISERROR(@ErrorMsg, 11, 1)
      --return 21
END

if @trapped > 9
      rollback

END



GO

