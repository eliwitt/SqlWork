USE [ClaimProdMar11]
GO

/****** Object:  StoredProcedure [dbo].[sp_bulkreserve]    Script Date: 04/15/2011 10:29:02 ******/
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

/****** Object:  StoredProcedure [dbo].[sp_bulkreserve_remote]    Script Date: 04/15/2011 10:29:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		J. Steve Witt
-- Create date: 4/29/2010
-- Description:	Given the claim, vehicle, and veh entity numbers in the reserve
-- =============================================
CREATE PROCEDURE [dbo].[sp_bulkreserve_remote] 
	@ClaimID int,
	@VehNu	int, 
	@MyEntity int,
	@RemoteDataBase as varchar(32) 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
declare 
	@PolicyNu		int,
	@AccDt			Datetime,
	@LossType		int,
	@OurVeh			int,
	@OurDrv			int,
	@ReOpen			int,
	@ReserveID		int,
	@ResType		int,
	@MyKey			int, 
	@ClaimLia	tinyint,
	@Debug			int,
	@trapped		int,
	@ErrorMsg		varchar(255)
set @Debug = 0
set @OurVeh = 0
set @OurDrv = 0
--
-- get the nextentity, policy number, and DOL from the claim's master row
--
select @PolicyNu=PolicyNumber, @AccDt=DateOfLoss, @LossType = LossType from CLM_ClaimMaster where id = @ClaimID
-- get the GoAuto OurVeh 
select @OurVeh=OurVehicleIndex from CLM_ClaimVehicle where ClaimMasterPTR = @ClaimID and VehicleNumber = 1
select @OurDrv=OurDriverIndex from clm_vehiclepassenger where ClaimMasterPTR = @ClaimID and VehicleNumber = 1
--
-- is the policy active?
--
set @ReOpen = 0
exec ('set @ReOpen = ' + @RemoteDataBase + '.dbo.F_Claims_IsPolicyActive(@PolicyNu,@AccDt)')
if @Debug=1 Print @ReOpen
if @LossType > 2
begin
	exec sp_nonreserves @ClaimID, @VehNu, @MyEntity
	goto NoCommit
end
--
-- begin the trans
--
begin transaction
-- 
-- policy is not enforce
--
if @ReOpen = 0
	goto NoReserve
--
-- is this an Not At Fault NAF claim
--
if @LossType = 2
	goto NAFCk
--
-- our vehicle does not get this coverage
--
if @VehNu = 1 
	goto SkipLIPD
-- does the policy have LIPD coverage
if exists(select id from CLM_Reserve where ClaimNumber = @ClaimID and EntityNumber = @MyEntity and CoverageID = 1)
begin
	if @Debug = 1 print 'Reopen the reserve'
	update CLM_Reserve 
		set ClosedOn = null, ReserveOpen = @ReOpen, OpenedOn = GetDate()
		where ClaimNumber = @ClaimID and EntityNumber = @MyEntity and CoverageID = 1
	if (@@error <> 0)
	begin
		set @trapped = 10
		set @ErrorMsg = 'Error attempting to update the clm_reserve row '
		goto Error_Handler
	end
end
else
begin
	select @MyKey=Max(ID) from CLM_Reserve
	if (@MyKey is null)
	Begin
		set @MyKey=0
	end
	set @ReserveID=@MyKey+1
	if (GoAutoProd.dbo.F_Claims_IsCoverageActive(@PolicyNu, @AccDt, @OurVeh, @OurDrv, 1) > 0) 
	begin
		if @Debug=1 Print 'Insert LIPD with reserves'
	    insert into CLM_Reserve
			values(@ReserveID, @ClaimID, @AccDt, @MyEntity, 1, 
				GoAutoProd.dbo.F_Claims_GetReserveAmount(1), @ReOpen, 0, GetDate(), GetDate(), null, null)
		if (@@error <> 0)
		begin
			set @trapped = 15
			set @ErrorMsg = 'Error attempting to insert the clm_Reserve row '
			goto Error_Handler
		end
	end
end
--
SkipLIPD:
--
-- check for other coverage the policy might cover only for our vehicle
--
if @VehNu > 1 
	goto NoReserve
--
-- does the policy cover COLL?
--
if exists(select id from CLM_Reserve where ClaimNumber = @ClaimID and EntityNumber = @MyEntity and CoverageID = 4)
begin
	if @Debug = 1 print 'Reopen the reserve'
	update CLM_Reserve 
		set ClosedOn = null, ReserveOpen = @ReOpen, OpenedOn = GetDate()
		where ClaimNumber = @ClaimID and EntityNumber = @MyEntity and CoverageID = 4
	if (@@error <> 0)
	begin
		set @trapped = 40
		set @ErrorMsg = 'Error attempting to update the clm_reserve row '
		goto Error_Handler
	end
end
else
begin
	select @MyKey=Max(ID) from CLM_Reserve
	if (@MyKey is null)
	Begin
		set @MyKey=0
	end
	set @ReserveID=@MyKey+1
	if (GoAutoProd.dbo.F_Claims_IsCoverageActive(@PolicyNu, @AccDt, @OurVeh, @OurDrv, 4) > 0) 
	begin
		if @Debug=1 Print 'Insert COLL with reserves'
		insert into CLM_Reserve
			values(@ReserveID, @ClaimID, @AccDt, @MyEntity, 4, 
				GoAutoProd.dbo.F_Claims_GetReserveAmount(4), @ReOpen, 0, GetDate(), GetDate(), null, null)
		if (@@error <> 0)
		begin
			set @trapped = 45
			set @ErrorMsg = 'Error attempting to insert the clm_Reserve row '
			goto Error_Handler
		end
	end
end
--
-- does the policy cover Towing?
--
if exists(select id from CLM_Reserve where ClaimNumber = @ClaimID and EntityNumber = @MyEntity and CoverageID = 5)
begin
	if @Debug = 1 print 'Reopen the reserve'
	update CLM_Reserve 
		set ClosedOn = null, ReserveOpen = @ReOpen, OpenedOn = GetDate()
		where ClaimNumber = @ClaimID and EntityNumber = @MyEntity and CoverageID = 5
	if (@@error <> 0)
	begin
		set @trapped = 50
		set @ErrorMsg = 'Error attempting to update the clm_reserve row '
		goto Error_Handler
	end
end
else
begin
	select @MyKey=Max(ID) from CLM_Reserve
	if (@MyKey is null)
	Begin
		set @MyKey=0
	end
	set @ReserveID=@MyKey+1
	if (GoAutoProd.dbo.F_Claims_IsCoverageActive(@PolicyNu, @AccDt, @OurVeh, @OurDrv, 5) > 0) 
	begin
		if @Debug=1 Print 'Insert Towing with reserves'
		insert into CLM_Reserve
			values(@ReserveID, @ClaimID, @AccDt, @MyEntity, 5, 
				GoAutoProd.dbo.F_Claims_GetReserveAmount(5), @ReOpen, 0, GetDate(), GetDate(), null, null)
		if (@@error <> 0)
		begin
			set @trapped = 55
			set @ErrorMsg = 'Error attempting to insert the clm_Reserve row '
			goto Error_Handler
		end
	end
end
--
-- does the policy cover Rental?
--
if exists(select id from CLM_Reserve where ClaimNumber = @ClaimID and EntityNumber = @MyEntity and CoverageID = 6)
begin
	if @Debug = 1 print 'Reopen the reserve'
	update CLM_Reserve 
		set ClosedOn = null, ReserveOpen = @ReOpen, OpenedOn = GetDate()
		where ClaimNumber = @ClaimID and EntityNumber = @MyEntity and CoverageID = 6
	if (@@error <> 0)
	begin
		set @trapped = 60
		set @ErrorMsg = 'Error attempting to update the clm_reserve row '
		goto Error_Handler
	end
end
else
begin
	select @MyKey=Max(ID) from CLM_Reserve
	if (@MyKey is null)
	Begin
		set @MyKey=0
	end
	set @ReserveID=@MyKey+1
	if (GoAutoProd.dbo.F_Claims_IsCoverageActive(@PolicyNu, @AccDt, @OurVeh, @OurDrv, 6) > 0) 
	begin
		if @Debug=1 Print 'Insert Rental with reserves'
		insert into CLM_Reserve
			values(@ReserveID, @ClaimID, @AccDt, @MyEntity, 6, 
				GoAutoProd.dbo.F_Claims_GetReserveAmount(6), @ReOpen, 0, GetDate(), GetDate(), null, null)
		if (@@error <> 0)
		begin
			set @trapped = 65
			set @ErrorMsg = 'Error attempting to insert the clm_Reserve row '
			goto Error_Handler
		end
	end
end
--
-- bottom of the AF reserves
--
goto NoReserve
--
-- For NAF check for the UMPD coverage
--
NAFCk:
--
-- only the GoAuto vehicle gets UMPD
--
if @VehNu > 1 
	goto NoReserve
--
-- check that the claim has a vehicle that did not have liability
--
set @ClaimLia = 0
select @ClaimLia=Liability from clm_claimvehicle where claimmasterptr = @ClaimID and Liability = 1
if @ClaimLia = 0
begin
	-- give Coll if there is no liability
	set @ReOpen = 1
	set @ResType = 4
end
else
begin
	set @ReOpen = 1
	set @ResType = 9
end
--
-- get the next id from the reserve table
--
select @MyKey=Max(ID) from CLM_Reserve
if (@MyKey is null)
Begin
	set @MyKey=0
end
set @ReserveID=@MyKey+1
--
-- does the policy cover UMPD or Coll?
--
if exists(select id from CLM_Reserve where ClaimNumber = @ClaimID and EntityNumber = @MyEntity and CoverageID = @ResType)
begin
	if @Debug = 1 print 'Reopen the reserve'
	update CLM_Reserve 
		set ClosedOn = null, ReserveOpen = @ReOpen, OpenedOn = GetDate()
		where ClaimNumber = @ClaimID and EntityNumber = @MyEntity and CoverageID = @ResType
	if (@@error <> 0)
	begin
		set @trapped = 90
		set @ErrorMsg = 'Error attempting to update the clm_reserve row '
		goto Error_Handler
	end
end
else
begin
	if (GoAutoProd.dbo.F_Claims_IsCoverageActive(@PolicyNu, @AccDt, @OurVeh, @OurDrv, @ResType) > 0) 
	begin
		if @Debug=1 Print 'Insert UMPD/Coll with reserves'
		insert into CLM_Reserve
			values(@ReserveID, @ClaimID, @AccDt, @MyEntity, @ResType, 
				GoAutoProd.dbo.F_Claims_GetReserveAmount(@ResType), @ReOpen, 0, GetDate(), GetDate(), null, null)
		if (@@error <> 0)
		begin
			set @trapped = 95
			set @ErrorMsg = 'Error attempting to insert the clm_Reserve row '
			goto Error_Handler
		end
	end
end
--
-- the end of the NAF reserve checks
--
NoReserve:
if @Debug=1 print 'At the end'
commit transaction;
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
	--	RAISERROR(@ErrorMsg, 11, 1)
	--return 21
END
rollback
END
GO

/****** Object:  StoredProcedure [dbo].[sp_claimentity]    Script Date: 04/15/2011 10:29:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_claimentity] 
      -- Add the parameters for the stored procedure here
      @Entity     int,
      @bizNam     varchar(128),
      @FNam varchar(32),
      @MNam varchar(32), 
      @LNam Varchar(32),
      @SufID      int,
      @TileID     int,
      @MarID      int,
      @WrkPh      varchar(16),
      @Email      varchar(128),
      @Addr1      varchar(128),
      @Addr2      varchar(128),
      @ZipPtr     int,
      @AddPh      varchar(16),
      @FedID      varchar(11),
      @HrRate     money,
      @EntTy      int,
      @ProTy      int
AS

BEGIN
      -- SET NOCOUNT ON added to prevent extra result sets from
      -- interfering with SELECT statements.
      SET NOCOUNT ON;

-- define the local variables
declare @Debug int, 
      @MyKey int, 
      @PerPtr int, 
      @AddrPtr int, 
      @BizPtr int, 
      @MedClinicPtr int, 
      @MedProPtr int,
      @FirmPtr    int,
      @AttPtr     int, 
      @ShopPtr    int,
	  @VendorPtr    int,
      @trapped          int,
      @ErrorMsg         varchar(255)

-- Entity should be one of the following:
-- 0=Medical Clinic
-- 1=Firm
-- 2=BodyShop
-- 3=Vendors
--
if @Entity=0 goto StartTheProc
if @Entity=1 goto StartTheProc
if @Entity=2 goto StartTheProc
if @Entity=3 goto StartTheProc

Print 'Invalid Entity parameter passed.'
goto EndofScript

StartTheProc:
--
set @Debug=0

-- wrap everything in a transaction
begin tran

if @Debug=1 Print 'Starting the insert'
-- get the next key from the CLM_Person table
select @MyKey=Max(ID) from CLM_Person
if (@MyKey is null)
Begin
      set @MyKey=0
end
set @PerPtr=@MyKey+1

-- insert the Person data
if @Debug=1 Print 'Insert the Person ' + convert(varchar(5),@PerPtr)
insert into CLM_Person (ID, FirstName, MiddleName, LastName, SuffixID, 
TitleID, MaritalStatusID, WorkPhone, EmailAddress)
values(@PerPtr, @FNam, @MNam, @LNam, @SufID, @TileID, @MarID, @WrkPh, @Email)

if (@@error <> 0)
begin
      set @trapped = 10
      set @ErrorMsg = 'Error attempting to insert a row in CLM_Person '
      goto Error_Handler
end

-- get the next key from the CLM_Address table
select @MyKey=Max(ID) from CLM_Address
if (@MyKey is null)
Begin
      set @MyKey=0
end
set @AddrPtr=@MyKey+1

-- insert the address data
if @Debug=1 Print 'Insert the Address ' + convert(varchar(5),@AddrPtr)
insert into CLM_Address values(@AddrPtr, @Addr1, @Addr2, @ZipPtr, @AddPh)
if (@@error <> 0)
begin
      set @trapped = 20
      set @ErrorMsg = 'Error attempting to insert a row in CLM_Address '
      goto Error_Handler
end

-- get the next key from the CLM_BusinessEntity table
select @MyKey=Max(ID) from CLM_BusinessEntity
if (@MyKey is null)
Begin
      set @MyKey=0
end
set @BizPtr=@MyKey+1

-- insert the Biz data
if @Debug=1 Print 'Insert the Biz ' + convert(varchar(5),@BizPtr)
insert into CLM_BusinessEntity values(@BizPtr, @BizNam, @AddrPtr, @PerPtr, @FedID)
if (@@error <> 0)
begin
      set @trapped = 30
      set @ErrorMsg = 'Error attempting to insert a row in CLM_BusinessEntity '
      goto Error_Handler
end

--
-- Which set of entity tables
--
if @Entity=0 goto Clinic
if @Entity=1 goto Firm
if @Entity=2 goto Shop
if @Entity=3 goto Vendors

goto ErrorRt

--
-- Clinic tables
--
Clinic:
-- get the next key from the CLM_MedicalClinic table
select @MyKey=Max(ID) from CLM_MedicalClinic
if (@MyKey is null)
Begin
      set @MyKey=0
end
set @MedClinicPtr=@MyKey+1

-- insert the MedClinic data
if @Debug=1 Print 'Insert the Clinic ' + convert(varchar(5),@MedClinicPtr)
insert into CLM_MedicalClinic (ID, ClinicTypeID, BusinessEntityPTR) values(@MedClinicPtr, @EntTy, @BizPtr)

if (@@error <> 0)
begin
      set @trapped = 40
      set @ErrorMsg = 'Error attempting to insert a row in CLM_MedicalClinic '
      goto Error_Handler
end

-- get the next key from the CLM_MedicalProfessional table
select @MyKey=Max(ID) from CLM_MedicalProfessional
if (@MyKey is null)
Begin
      set @MyKey=0
end
set @MedProPtr=@MyKey+1

-- insert the MedClinic data
if @Debug=1 Print 'Insert the Professional ' + convert(varchar(5),@MedProPtr)
insert into CLM_MedicalProfessional (ID, MedicalProTypeID, MedicalClinicPTR, PersonalInfo_PersonPTR) 
values(@MedProPtr, @ProTy, @MedClinicPtr, @PerPtr)

if (@@error <> 0)
begin
      set @trapped = 50
      set @ErrorMsg = 'Error attempting to insert a row in CLM_MedicalProfessional '
      goto Error_Handler
end

goto FinishInsert

--
-- Law Firm tables
--
Firm:
-- get the next key from the CLM_LawFirm table
select @MyKey=Max(ID) from CLM_LawFirm
if (@MyKey is null)
Begin
      set @MyKey=0
end
set @FirmPtr=@MyKey+1

-- insert the LawFirm data
if @Debug=1 Print 'Insert the Firm ' + convert(varchar(5),@FirmPtr)
insert into CLM_LawFirm (ID, FirmTypeID, BusinessEntityPTR) values(@FirmPtr, @EntTy, @BizPtr)

if (@@error <> 0)
begin
      set @trapped = 60
      set @ErrorMsg = 'Error attempting to insert a row in CLM_lawfirm '
      goto Error_Handler
end

-- get the next key from the CLM_Attorney table
select @MyKey=Max(ID) from CLM_Attorney
if (@MyKey is null)
Begin
      set @MyKey=0
end
set @AttPtr=@MyKey+1

-- insert the Attorney data
if @Debug=1 Print 'Insert the Attorney ' + convert(varchar(5),@AttPtr)
insert into CLM_Attorney (ID, AttorneyTypeID, LawFirmPTR, PersonalInfo_PersonPTR) 
      values(@AttPtr, @ProTy, @FirmPtr, @PerPtr)

if (@@error <> 0)
begin
      set @trapped = 70
      set @ErrorMsg = 'Error attempting to insert a row in CLM_Attorney '
      goto Error_Handler
end

goto FinishInsert

--
-- BodyShop tables
--
Shop:
-- get the next key from the CLM_BodyShop table
select @MyKey=Max(ID) from CLM_BodyShop
if (@MyKey is null)
Begin
      set @MyKey=0
end
set @ShopPtr=@MyKey+1

-- insert the BodyShop data
if @Debug=1 Print 'Insert the Body Shop ' + convert(varchar(5),@ShopPtr)
insert into CLM_BodyShop (ID, BodyShopTypeID, BusinessEntityPTR, HourlyRate) 
      values(@ShopPtr, @EntTy, @BizPtr, @HrRate)

if (@@error <> 0)
begin
      set @trapped = 80
      set @ErrorMsg = 'Error attempting to insert a row in CLM_BodyShop '
      goto Error_Handler
end

goto FinishInsert

--
-- Vendor table
--
Vendors:
-- get the next key from the CLM_vendor table
select @MyKey=Max(ID) from CLM_vendor
if (@MyKey is null)
Begin
      set @MyKey=0
end
set @VendorPtr=@MyKey+1

-- insert the Vendor data
if @Debug=1 Print 'Insert the Vendor ' + convert(varchar(5),@VendorPtr)
insert into CLM_vendor (id, vendortypeptr, bizptr) 
      values(@VendorPtr, @EntTy, @BizPtr)

if (@@error <> 0)
begin
      set @trapped = 90
      set @ErrorMsg = 'Error attempting to insert a row in CLM_vendor '
      goto Error_Handler
end

goto FinishInsert

--
-- Successful end of the script
--
FinishInsert:
Commit 

EndofScript:
return

-- Error routine
ErrorRt:
set @trapped = 90
set @ErrorMsg = 'Error the transaction will be rolled back'
--
-- bottom of the script
--
Error_Handler:
if @Debug > 5
      print 'In the Error Handler'

IF @ErrorMsg IS NOT NULL
BEGIN
      SELECT @ErrorMsg = 'Claim Update script claimentity: ' + @ErrorMsg + '  ' + convert(varchar(10), @trapped)
      -- Using "with log" inserts a message into the event log
       RAISERROR(@ErrorMsg, 11, 1) with log 
      --    RAISERROR(@ErrorMsg, 11, 1)
      --return 21
END

if @trapped > 9
      rollback

END
GO

/****** Object:  StoredProcedure [dbo].[sp_claimperson]    Script Date: 04/15/2011 10:29:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<J. Steve Witt>
-- Create date: <2/9/2010>
-- Description:	<Insert a person in the database>
-- =============================================
CREATE PROCEDURE [dbo].[sp_claimperson]  
	@Entity	int,
	@PeoplePtr int, 
	@FNam	varchar(32),
	@MNam	varchar(32), 
	@LNam	Varchar(32),
	@SufID	int,
	@TileID	int,
	@WrkPh	varchar(16),
	@Email	varchar(128),
	@ProTy	int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
declare @Debug int, 
	@MyKey int, 
	@PerPtr int, 
	@MedProPtr int,
	@AttPtr	int, 
	@ShopPtr	int,
	@trapped		int,
	@ErrorMsg		varchar(255)
--
set @Debug=0
-- wrap everything in a transaction
begin tran
if @Debug=1 Print 'Starting the insert'
-- get the next key from the CLM_Person table
select @MyKey=Max(ID) from CLM_Person
if (@MyKey is null)
Begin
	set @MyKey=0
end
set @PerPtr=@MyKey+1
-- insert the Person data
if @Debug=1 Print 'Insert the Person ' + convert(varchar(5),@PerPtr)
insert into CLM_Person (ID, FirstName, MiddleName, LastName, SuffixID, 
TitleID, WorkPhone, EmailAddress)
values(@PerPtr, @FNam, @MNam, @LNam, @SufID, @TileID, @WrkPh, @Email)
if (@@error <> 0)
begin
	set @trapped = 10
	set @ErrorMsg = 'Error attempting to insert a row in CLM_Person '
	goto Error_Handler
end
--
-- Which set of entity tables
--
if @Entity=0 goto Clinic
if @Entity=1 goto Firm
goto Error_Handler
--
-- Clinic tables
--
Clinic:
-- get the next key from the CLM_MedicalProfessional table
select @MyKey=Max(ID) from CLM_MedicalProfessional
if (@MyKey is null)
Begin
	set @MyKey=0
end
set @MedProPtr=@MyKey+1
-- insert the MedClinic data
if @Debug=1 Print 'Insert the Professional ' + convert(varchar(5),@MedProPtr)
insert into CLM_MedicalProfessional (ID, MedicalProTypeID, MedicalClinicPTR, PersonalInfo_PersonPTR) 
values(@MedProPtr, @ProTy, @PeoplePtr, @PerPtr)
if (@@error <> 0)
begin
	set @trapped = 20
	set @ErrorMsg = 'Error attempting to insert a row in CLM_MedicalProfessional '
	goto Error_Handler
end
-- set the MedProPtr from the row id just inserted
-- select @MedProPtr=@@IDENTITY
goto FinishInsert
--
-- Law Firm tables
--
Firm:
-- get the next key from the CLM_Attorney table
select @MyKey=Max(ID) from CLM_Attorney
if (@MyKey is null)
Begin
	set @MyKey=0
end
set @AttPtr=@MyKey+1
-- insert the Attorney data
if @Debug=1 Print 'Insert the Attorney ' + convert(varchar(5),@AttPtr)
insert into CLM_Attorney (ID, AttorneyTypeID, LawFirmPTR, PersonalInfo_PersonPTR) 
	values(@AttPtr, @ProTy, @PeoplePtr, @PerPtr)
if (@@error <> 0)
begin
	set @trapped = 30
	set @ErrorMsg = 'Error attempting to insert a row in CLM_Attorney '
	goto Error_Handler
end
-- set the MedProPtr from the row id just inserted
-- select @MedProPtr=@@IDENTITY
goto FinishInsert
--
-- Successful end of the script
--
FinishInsert:
Commit 
return
--
-- bottom of the script
--
Error_Handler:
if @Debug > 5
	print 'In the Error Handler'
IF @ErrorMsg IS NOT NULL
BEGIN
	SELECT @ErrorMsg = 'Claim Update script claimperson: ' + @ErrorMsg + '  ' + convert(varchar(10), @trapped)
	-- Using "with log" inserts a message into the event log
	 RAISERROR(@ErrorMsg, 11, 1) with log 
	--	RAISERROR(@ErrorMsg, 11, 1)
	--return 21
END
if @trapped > 9
	rollback
END

GO

/****** Object:  StoredProcedure [dbo].[sp_claimreserves]    Script Date: 04/15/2011 10:29:03 ******/
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
	  @ClaimNumber			  varchar(18),
      @myEnu                  int, 
      @myPer                  int,
	  @myOwner				  int,
      @myInjured        int

-- close any reserve for the claim
update CLM_Reserve 
      set ClosedOn = GetDate(), ReserveOpen = 0
      where ClaimNumber = @CMastPtr

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
--
--  Now check if any reserves have been created do we need to insert a new assignment row
--
--  we have coverage of (1) LIPD with no one assigned to it do not set the claimloaded
--
if exists(select * from clm_reserve where claimnumber = @CMastPtr and coverageid = 1 and reserveopen = 1 and not exists (
			select * from clm_adjusterassignments a where claimptr = @CMastPtr and
				a.adjusterskilltypeptr = 2))
	insert into CLM_AdjusterAssignments values(0, @ClaimNumber, @CMastPtr, 1, 2, GETDATE())
--
--  we have coverage of (2) LIBI with no one assigned to it do not set the claimloaded
--
if exists(select * from clm_reserve where claimnumber = @CMastPtr and coverageid = 2 and reserveopen = 1 and not exists (
			select * from clm_adjusterassignments a where claimptr = @CMastPtr and
				a.adjusterskilltypeptr = 4))
	insert into CLM_AdjusterAssignments values(0, @ClaimNumber, @CMastPtr, 1, 4, GETDATE())
--
--  we have coverage of (3,4) Comp/Coll with no one assigned to it do not set the claimloaded
--
if exists(select * from clm_reserve where claimnumber = @CMastPtr and coverageid in (3,4) and reserveopen = 1 and not exists (
			select * from clm_adjusterassignments a where claimptr = @CMastPtr and
				a.adjusterskilltypeptr = 6))
	insert into CLM_AdjusterAssignments values(0, @ClaimNumber, @CMastPtr, 1, 6, GETDATE())
--
--  we have coverage of (5) Towing with no one assigned to it do not set the claimloaded
--
if exists(select * from clm_reserve where claimnumber = @CMastPtr and coverageid = 5 and reserveopen = 1 and not exists (
			select * from clm_adjusterassignments a where claimptr = @CMastPtr and
				a.adjusterskilltypeptr = 7))
	insert into CLM_AdjusterAssignments values(0, @ClaimNumber, @CMastPtr, 1, 7, GETDATE())
--
--  we have coverage of (7) MED with no one assigned to it do not set the claimloaded
--
if exists(select * from clm_reserve where claimnumber = @CMastPtr and coverageid = 7 and reserveopen = 1 and not exists (
			select * from clm_adjusterassignments a where claimptr = @CMastPtr and
				a.adjusterskilltypeptr = 8))
	insert into CLM_AdjusterAssignments values(0, @ClaimNumber, @CMastPtr, 1, 8, GETDATE())
--
--  we have coverage of (8) UMBI with no one assigned to it do not set the claimloaded
--
if exists(select * from clm_reserve where claimnumber = @CMastPtr and coverageid = 8 and reserveopen = 1 and not exists (
			select * from clm_adjusterassignments a where claimptr = @CMastPtr and
				a.adjusterskilltypeptr = 9))
	insert into CLM_AdjusterAssignments values(0, @ClaimNumber, @CMastPtr, 1, 9, GETDATE())
--
--  we have coverage of (9) UMPD with no one assigned to it do not set the claimloaded
--
if exists(select * from clm_reserve where claimnumber = @CMastPtr and coverageid = 9 and reserveopen = 1 and not exists (
			select * from clm_adjusterassignments a where claimptr = @CMastPtr and
				a.adjusterskilltypeptr = 10))
	insert into CLM_AdjusterAssignments values(0, @ClaimNumber, @CMastPtr, 1, 10, GETDATE())

end
GO

/****** Object:  StoredProcedure [dbo].[sp_claimvendor]    Script Date: 04/15/2011 10:29:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		J. Steve Witt
-- Create date: 09/28/2010
-- Description:	File the new vendors with the goauto vendor id
-- =============================================
CREATE PROCEDURE [dbo].[sp_claimvendor] 
      -- Add the parameters for the stored procedure here
      @Entity     int,
      @bizNam     varchar(128),
      @FNam varchar(32),
      @MNam varchar(32), 
      @LNam Varchar(32),
      @SufID      int,
      @TileID     int,
      @MarID      int,
      @WrkPh      varchar(16),
      @Email      varchar(128),
      @Addr1      varchar(128),
      @Addr2      varchar(128),
      @ZipPtr     int,
      @AddPh      varchar(16),
      @FedID      varchar(11),
      @HrRate     money,
      @EntTy      int,
      @VendorID   nvarchar(10)
AS

BEGIN
      -- SET NOCOUNT ON added to prevent extra result sets from
      -- interfering with SELECT statements.
      SET NOCOUNT ON;

-- define the local variables
declare @Debug int, 
      @MyKey int, 
      @PerPtr int, 
      @AddrPtr int, 
      @BizPtr int, 
      @MedClinicPtr int, 
      @MedProPtr int,
      @FirmPtr    int,
      @AttPtr     int, 
      @ShopPtr    int,
	  @VendorPtr    int,
      @trapped          int,
      @ErrorMsg         varchar(255)

-- Entity should be one of the following:
-- 3=Vendors
--
if @Entity=3 goto StartTheProc

Print 'Invalid Entity parameter passed.'
goto EndofScript

StartTheProc:
--
set @Debug=0

-- wrap everything in a transaction
begin tran

if @Debug=1 Print 'Starting the insert'
-- get the next key from the CLM_Person table
select @MyKey=Max(ID) from CLM_Person
if (@MyKey is null)
Begin
      set @MyKey=0
end
set @PerPtr=@MyKey+1

-- insert the Person data
if @Debug=1 Print 'Insert the Person ' + convert(varchar(5),@PerPtr)
insert into CLM_Person (ID, FirstName, MiddleName, LastName, SuffixID, 
TitleID, MaritalStatusID, WorkPhone, EmailAddress)
values(@PerPtr, @FNam, @MNam, @LNam, @SufID, @TileID, @MarID, @WrkPh, @Email)

if (@@error <> 0)
begin
      set @trapped = 10
      set @ErrorMsg = 'Error attempting to insert a row in CLM_Person '
      goto Error_Handler
end

-- get the next key from the CLM_Address table
select @MyKey=Max(ID) from CLM_Address
if (@MyKey is null)
Begin
      set @MyKey=0
end
set @AddrPtr=@MyKey+1

-- insert the address data
if @Debug=1 Print 'Insert the Address ' + convert(varchar(5),@AddrPtr)
insert into CLM_Address values(@AddrPtr, @Addr1, @Addr2, @ZipPtr, @AddPh)
if (@@error <> 0)
begin
      set @trapped = 20
      set @ErrorMsg = 'Error attempting to insert a row in CLM_Address '
      goto Error_Handler
end

-- get the next key from the CLM_BusinessEntity table
select @MyKey=Max(ID) from CLM_BusinessEntity
if (@MyKey is null)
Begin
      set @MyKey=0
end
set @BizPtr=@MyKey+1

-- insert the Biz data
if @Debug=1 Print 'Insert the Biz ' + convert(varchar(5),@BizPtr)
insert into CLM_BusinessEntity values(@BizPtr, @BizNam, @AddrPtr, @PerPtr, @FedID)
if (@@error <> 0)
begin
      set @trapped = 30
      set @ErrorMsg = 'Error attempting to insert a row in CLM_BusinessEntity '
      goto Error_Handler
end

--
-- Which set of entity tables
--
if @Entity=3 goto Vendors

goto ErrorRt

--
-- Vendor table
--
Vendors:
-- get the next key from the CLM_vendor table
select @MyKey=Max(ID) from CLM_vendor
if (@MyKey is null)
Begin
      set @MyKey=0
end
set @VendorPtr=@MyKey+1

-- insert the Vendor data
if @Debug=1 Print 'Insert the Vendor ' + convert(varchar(5),@VendorPtr)
insert into CLM_vendor (id, vendortypeptr, bizptr, vendorid) 
      values(@VendorPtr, @EntTy, @BizPtr, @VendorID)

if (@@error <> 0)
begin
      set @trapped = 90
      set @ErrorMsg = 'Error attempting to insert a row in CLM_vendor '
      goto Error_Handler
end

goto FinishInsert

--
-- Successful end of the script
--
FinishInsert:
Commit 

EndofScript:
return

-- Error routine
ErrorRt:
set @trapped = 90
set @ErrorMsg = 'Error the transaction will be rolled back'
--
-- bottom of the script
--
Error_Handler:
if @Debug > 5
      print 'In the Error Handler'

IF @ErrorMsg IS NOT NULL
BEGIN
      SELECT @ErrorMsg = 'Claim Update script claimvendor: ' + @ErrorMsg + '  ' + convert(varchar(10), @trapped)
      -- Using "with log" inserts a message into the event log
       RAISERROR(@ErrorMsg, 11, 1) with log 
      --    RAISERROR(@ErrorMsg, 11, 1)
      --return 21
END

if @trapped > 9
      rollback

END


GO

/****** Object:  StoredProcedure [dbo].[sp_fileclaim]    Script Date: 04/15/2011 10:29:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:      J. Steve Witt
-- Create date: 2010
-- Description: Inserts a row in the claim master
-- =============================================
CREATE PROCEDURE [dbo].[sp_fileclaim] 
      @PolicyNu		varchar(16),
      @EmployeePTR  int,
	  @TakeEmpPTR   int,
      @DOL			datetime,
      @LType		int,
      @RptVal       tinyint,
      @RptName      nvarchar(128),
      @RptDesc      nvarchar(512),
      @AccLoc       nvarchar(512),
      @PolDpt       nvarchar(512),
      @PolRpt       nvarchar(128)
AS
BEGIN
declare
    @MyKey int, 
    @MasterPtr int,
	@maxId int, 
	@maxClaimnumber varchar(18),
	@newClaimnumber varchar(18), 
	@rowct int, 
	@theChar varchar(1),
	@newChar varChar(1)
      -- SET NOCOUNT ON added to prevent extra result sets from
      -- interfering with SELECT statements.
      SET NOCOUNT ON;

-- get the next key from the CLM_ClaimMaster table
select @MyKey=Max(ID) from CLM_ClaimMaster
if (@MyKey is null)
Begin
      set @MyKey=0
end
set @MasterPtr=@MyKey+1
--
-- we need to determine if there is a dup claim for this policy on the dol
--
select @rowct = count(id) from clm_claimmaster
			where policynumber = @PolicyNu and 
			cast(convert(nvarchar(8), dateofloss, 112) as datetime) = cast(convert(nvarchar(8), @DOL, 112) as datetime)
			group by policynumber, datepart(dayofyear, dateofloss)
--select @rowct
--  find the dups
if (@rowct is null)
begin
	set @newClaimnumber = convert(nvarchar(8),@policynu) + '-' + convert(varchar(10), @DOL, 110)
end
else
begin
	if (@rowct = 1)
	begin
		set @newClaimnumber = convert(nvarchar(8),@policynu) + '-' + convert(varchar(10), @DOL, 110) + 'B'
	end
	else
	begin
		select @maxId=max(id) from clm_claimmaster
				where policynumber = @PolicyNu and 
				cast(convert(nvarchar(8), dateofloss, 112) as datetime) = cast(convert(nvarchar(8), @DOL, 112) as datetime)
		select @maxClaimnumber=claimnumber from clm_claimmaster where id = @maxId
		--
		-- the claimnumber is the policy number + dol so we should be able to get the last charactor
		--
		if len(@maxClaimnumber) = len(@PolicyNu) + 11 set @theChar = 'A' 
		else
		select @theChar = substring(@maxClaimnumber, len(@PolicyNu) + 12, 1)
		if @theChar = 'Z' set @newChar = ''
		else begin
			set @newChar = Char(ascii(@theChar) + 1)
		end
		set @newClaimnumber = convert(nvarchar(8),@policynu) + '-' + convert(varchar(10), @DOL, 110) + @newChar
	end
end
-- I need the info for the ClaimNu ClaimDesc
insert into CLM_ClaimMaster values(@MasterPtr, @PolicyNu, @DOL, @LType, 
            @newClaimnumber, '', 
			null, @EmployeePTR, 1, getdate(),
            @RptVal, @RptName, @RptDesc,
			@AccLoc, @PolDpt, @PolRpt, 0, 0, 0, 0, @TakeEmpPTR, 1, null, null, 0)

select @MasterPtr as ClaimID
END
GO

/****** Object:  StoredProcedure [dbo].[sp_GetClaimInfoForAppraiser]    Script Date: 04/15/2011 10:29:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetClaimInfoForAppraiser]
   @ClaimID int,
   @AppraiserID int,
   @EntityNumber int,
   @RequestedByID int

AS
BEGIN

	SET NOCOUNT ON;

declare @ClaimNumber    varchar(32), 
	  @AdjusterName     varchar(128),
      @AdjusterEmail	varchar(128),
      @AppraiserEmail	varchar(128),
	  @AccidentDate		varchar(64),
      @VehicleNumber    int,
	  @VehicleYMM		varchar(64),
      @VehicleDamage    varchar(512),
      @VehicleLocation  varchar(512),
      @OwnerName	    varchar(128),
      @OwnerPhone	    varchar(64),
      @OwnerAddress	    varchar(128),
      @OwnerEmailAddres varchar(128),
      @DriverName	    varchar(128),
      @DriverPhone	    varchar(128),
      @DriverAddress    varchar(128),
      @DriverEmailAddres varchar(128),
      @LossTypeID int, @LossTypeDesc varchar(64),
      @PolicyNumber varchar(16), @ExactAccidentDate datetime, @VehIndex int,
      @AssignedAdjusterPTR int

select @ClaimNumber = ClaimNumber, @AccidentDate = convert(varchar, DateOfLoss,101), @LossTypeID = LossType,
       @PolicyNumber = PolicyNumber, @ExactAccidentDate =  DateOfLoss, @AssignedAdjusterPTR = EmployeePTR  
       from CLM_ClaimMaster WHERE id = @ClaimID

select @LossTypeDesc = [Desc] from CLM_LossTypes where id = @LossTypeID

/* @RequestedByID sub'ed by @AssignedAdjusterPTR */

set @AdjusterName = (select p.firstName + ' ' + p.lastName from GoAutoProd..employee  e 
                     join GoAutoProd..person p on p.id = e.personinfoptr where e.id = @RequestedByID)

/* 20101228 changed */
/* set @AdjusterEmail = (select EmailAddress FROM GoAutoProd..Employee WHERE ID = @AssignedAdjusterPTR) */
set @AdjusterEmail = (select EmailAddress FROM GoAutoProd..Employee WHERE ID = @RequestedByID)
if @AdjusterEmail is null set @AdjusterEmail = 'jholland@goautoinsurance.com'

select @AppraiserEmail = p.EmailAddress from clm_appriaser a join clm_businessentity b on b.id = a.businessentityptr
join clm_person p on p.id = b.contact_personptr where a.id = @AppraiserID

if @AppraiserEmail is null set @AppraiserEmail = 'jholland@goautoinsurance.com'

/*
set @AdjusterEmail = 'jholland@goautoinsurance.com'
set @AppraiserEmail = 'SGreen@goautoinsurance.com'
*/

/* set @AppraiserEmail = 'switt@adaptinfotech.com'  */




select @VehicleNumber = VehicleNumber, @VehicleYMM = [year] + ' ' + [make] + ' ' + [model],
       @VehicleLocation = convert(varchar(512),VehicleLocation), @VehicleDamage = convert(varchar(512),DamageDescription),
       @VehIndex = isnull(OurVehicleIndex ,0)
from clm_ClaimVehicle where ClaimMasterPTR = @ClaimID and EntityNumber = @EntityNumber

declare @PolicyID int
declare @CompDeduct varchar(32)
declare @CollDeduct varchar(32)
declare @CompCollDesc varchar(128)

if @VehIndex > 0
begin
   set @PolicyID = (select top 1 id from GoAutoProd..policy where PolicyNumber = @PolicyNumber and ModificationDate <= @ExactAccidentDate order by ModificationDate desc)
   if @PolicyID is not null
   begin
      set @CompDeduct = (select o.CovOptTag from GoAutoProd..policy p join GoAutoProd..vehicle v on v.policyptr = p.id and v.[Index] = @VehIndex
		  join GoAutoProd..policycoverages c on c.vehicleptr = v.id 
		  join GoAutoProd..CoverageOption o on o.CovIndex = c.CovIndex and o.ProductID = 1 and o.CovOptIndex = c.CovOptIndex
		  where p.id = @PolicyID and c.CovIndex = 3 )

      if @CompDeduct is null set @CompDeduct = 'No Coverage'
      if @CompDeduct = 'None' set @CompDeduct = 'No Coverage'
      set @CollDeduct = (select o.CovOptTag from GoAutoProd..policy p join GoAutoProd..vehicle v on v.policyptr = p.id and v.[Index] = @VehIndex
		  join GoAutoProd..policycoverages c on c.vehicleptr = v.id 
		  join GoAutoProd..CoverageOption o on o.CovIndex = c.CovIndex and o.ProductID = 1 and o.CovOptIndex = c.CovOptIndex
		  where p.id = @PolicyID and c.CovIndex = 4 )

      if @CollDeduct is null set @CollDeduct = 'No Coverage'
      if @CollDeduct = 'None' set @CollDeduct = 'No Coverage'

      set @CompCollDesc = '<br>Coll Deduct: ' + @CollDeduct + '<br>Comp Deduc: ' + @CompDeduct + '<br>'
   end
   else
   begin
      set @PolicyID = 0
      set @CompCollDesc = ''
   end
end
else
begin
      set @PolicyID = 0
      set @CompCollDesc = ''
end

if @CompCollDesc is null set @CompCollDesc = ''

set @VehicleDamage = 'Loss Type: ' + @LossTypeDesc + '<br>' + @CompCollDesc + @VehicleDamage

declare @OwnerPersonPTR int, @OwnerAddressPTR int
select @OwnerPersonPTR = i.personptr, @OwnerAddressPTR = i.addressptr from clm_vehiclepassenger v 
join clm_InvolvedParty i on v.InvolvedPartyptr = i.id
where v.claimmasterptr = @ClaimID and v.vehiclenumber = @VehicleNumber and i.lossroleid = 5

declare @DriverPersonPTR int, @DriverAddressPTR int
select @DriverPersonPTR = i.personptr, @DriverAddressPTR = i.addressptr from clm_vehiclepassenger v join clm_InvolvedParty i on v.InvolvedPartyptr = i.id
where v.claimmasterptr = @ClaimID and v.vehiclenumber = @VehicleNumber and i.lossroleid = 1

select @OwnerName = FirstName + ' ' + LastName, 
       @OwnerPhone = HomePhone + ' ' + CellPhone + ' ' + WorkPhone, 
       @OwnerEmailAddres = EmailAddress from clm_person where id = @OwnerPersonPTR

declare @OwnerZipID int
select @OwnerAddress = AddressLine1, @OwnerZipID = ZipInfoPTR from clm_address where id = @OwnerAddressPTR

if @OwnerZipID > 0 select @OwnerAddress = @OwnerAddress + ' ' + CityName + ', ' + StateAbbr FROM ZipInfo WHERE id = @OwnerZipID

declare @PolicyAddressPTR int
if @OwnerName is null and @VehIndex > 0 and @PolicyID > 0
begin
   select @OwnerName = q.FirstName + ' ' + q.LastName, 
       @OwnerPhone = q.HomePhone + ' ' + q.CellPhone + ' ' + q.WorkPhone, 
       @OwnerEmailAddres = q.EmailAddress from GoAutoProd..policy p join GoAutoProd..operator o on o.policyptr = p.id and o.[index] = 1
     join GoAutoProd..person q on q.id = o.PersonInfoPTR where p.id = @PolicyID

   select @PolicyAddressPTR = HomeAddressPTR FROM GoAutoProd..Policy WHERE ID = @PolicyID
   select @OwnerAddress = AddressLine1, @OwnerZipID = ZipInfo_ZipInfoPTR from GoAutoProd..address where id = @PolicyAddressPTR

   if @OwnerZipID > 0 select @OwnerAddress = @OwnerAddress + ' ' + CityName + ', ' + StateAbbr FROM GoAutoProd..ZipInfo WHERE id = @OwnerZipID

end

select @DriverName = FirstName + ' ' + LastName, 
       @DriverPhone = HomePhone + ' ' + CellPhone + ' ' + WorkPhone, 
       @DriverEmailAddres = EmailAddress from clm_person where id = @DriverPersonPTR

declare @DriverZipID int
select @DriverAddress = AddressLine1, @DriverZipID = ZipInfoPTR from clm_address where id = @DriverAddressPTR

if @DriverZipID > 0 select @DriverAddress = @DriverAddress + ' ' + CityName + ', ' + StateAbbr FROM ZipInfo WHERE id = @DriverZipID

select @AppraiserEmail 'AppraiserEmail', @ClaimNumber 'ClaimNumber', @AccidentDate 'AccidentDate', @AdjusterName 'AdjusterName',
       @AdjusterEmail 'AdjusterEmail', @VehicleYMM 'VehicleYMM', 
       isnull(@VehicleLocation,'') 'VehicleLocation', isnull(@VehicleDamage,'') 'VehicleDamage',
       isnull(@OwnerName,'') 'OwnerName', isnull(@OwnerPhone,'') 'OwnerPhone', 
       isnull(@OwnerEmailAddres,'') 'OwnerEmailAddress', isnull(@OwnerAddress,'') 'OwnerAddress',
       isnull(@DriverName,'') 'DriverName', isnull(@DriverPhone,'') 'DriverPhone', 
       isnull(@DriverEmailAddres,'') 'DriverEmailAddress', isnull(@DriverAddress,'') 'DriverAddress'


END


GO

/****** Object:  StoredProcedure [dbo].[SP_GetNextSeqVal]    Script Date: 04/15/2011 10:29:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GetNextSeqVal]
 @SeqName varchar(32)
AS
set nocount on
	declare @NextValue as Int
   begin transaction
      UPDATE SimpleSequence SET LastID = LastID + 1 where SequenceName = @SeqName
      SELECT @NextValue = LastID FROM SimpleSequence where SequenceName = @SeqName
   commit transaction
   select @NextValue as 'NextValue'
   

GO

/****** Object:  StoredProcedure [dbo].[sp_GetReserveAmount]    Script Date: 04/15/2011 10:29:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		J. Steve Witt
-- Create date: 9/1/2010
-- Description:	Call the function in the ploicy database using a dynamic domain
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetReserveAmount]
   @ResType int,
   @PolicyNumber varchar(32),
   @PointInTime datetime,
   @OurVehicleIndex int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
declare @Debug          int, 
	  @ResAmt           money,
	  @Domain			sysname,
	  @myState			nvarchar(4000),
      @ErrorMsg         varchar(255)
set @Debug = 0
set @ResAmt = 0    -- Insert statements for procedure here
--
-- define the results table from the dynamic sql
CREATE TABLE #ctr
( DyRsult int )
-- 
-- retrieve the domain value from the table
select @Domain=[value] from clm_sysvalues where [key] = 'domain'
if @Debug=1 print @Domain
--
-- build the statement GoAutoProd.dbo.F_Claims_GetReserveAmount(@ResType,@PolicyNu, @AccDt, @OurVeh) using the variables
select @myState = 'insert #ctr values(' + @Domain + 'F_Claims_GetReserveAmount(''' + cast(@ResType as nvarchar(1)) + ''', ''' + @PolicyNumber + ''', ''' + cast(@PointInTime as nvarchar(25)) + ''','
select @myState = @myState + cast(@OurVehicleIndex as nvarchar(2)) + '))'
if @Debug=1 print @myState
--
-- is the policy active?
exec(@myState)
IF @@ERROR = 0
BEGIN
     SELECT    @ResAmt = DyRsult
     FROM #ctr

     DROP TABLE #ctr
END
ELSE
BEGIN
     DROP TABLE #ctr
	 RAISERROR('Error with call to function F_Claims_GetReserveAmount.', 16, 1)
	return
END
if @Debug=1 print @ResAmt
return @ResAmt
END


GO

/****** Object:  StoredProcedure [dbo].[sp_insert_nonaccidents]    Script Date: 04/15/2011 10:29:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:        J. Steve Witt
-- Create date: 2/25/2010
-- Description:   Inserts the non-accident claims
-- =============================================
CREATE PROCEDURE [dbo].[sp_insert_nonaccidents]
      @PolicyNu     nvarchar(20),
      @EmployeePTR  int,
	  @TakeEmpPTR   int,
      @DOL          datetime,
      @LType        int,
      @VehNu        int, 
      @OurVeh       int, 
      @VehYr        nvarchar(4), 
      @Make         nvarchar(50), 
      @Model        nvarchar(50), 
      @OurDrv       int, 
      @DDesc        nvarchar(512),
      @DEstimate    money,
      @RptVal       tinyint,
      @RptName      nvarchar(128),
      @RptDesc      nvarchar(512),
      @AccLoc       nvarchar(512),
      @PolDpt       nvarchar(512),
      @PolRpt       nvarchar(128),
	  @Vin			nvarchar(60)
AS
BEGIN
      -- SET NOCOUNT ON added to prevent extra result sets from
      -- interfering with SELECT statements.
      SET NOCOUNT ON;

--
-- This script will insert non-accient loss claims
--
declare @Debug int, 
    @MyKey int, 
    @MasterPtr int,
    @VehPtr     int,
	@maxId int, 
	@maxClaimnumber varchar(18),
	@newClaimnumber varchar(18), 
	@rowct int, 
	@theChar varchar(1),
	@newChar varChar(1)
--
-- Debug can be 
--
-- 0 for off
-- 1 for general
-- 2 detail
set @Debug=0
if @Debug > 0 Print 'Starting the insert of non-accident claims'
-- get the next key from the CLM_ClaimMaster table

select @MyKey=Max(ID) from CLM_ClaimMaster
if (@MyKey is null)
Begin
      set @MyKey=0
end
set @MasterPtr=@MyKey+1
--
-- we need to determine if there is a dup claim for this policy on the dol
--
select @rowct = count(id) from clm_claimmaster
			where policynumber = @PolicyNu and 
			cast(convert(nvarchar(8), dateofloss, 112) as datetime) = cast(convert(nvarchar(8), @DOL, 112) as datetime)
			group by policynumber, datepart(dayofyear, dateofloss)
--select @rowct
--  find the dups
if (@rowct is null)
begin
	set @newClaimnumber = convert(nvarchar(8),@policynu) + '-' + convert(varchar(10), @DOL, 110)
end
else
begin
	if (@rowct = 1)
	begin
		set @newClaimnumber = convert(nvarchar(8),@policynu) + '-' + convert(varchar(10), @DOL, 110) + 'B'
	end
	else
	begin
		select @maxId=max(id) from clm_claimmaster
				where policynumber = @PolicyNu and 
				cast(convert(nvarchar(8), dateofloss, 112) as datetime) = cast(convert(nvarchar(8), @DOL, 112) as datetime)
		select @maxClaimnumber=claimnumber from clm_claimmaster where id = @maxId
		--
		-- the claimnumber is the policy number + dol so we should be able to get the last charactor
		--
		if len(@maxClaimnumber) = len(@PolicyNu) + 11 set @theChar = 'A' 
		else
		select @theChar = substring(@maxClaimnumber, len(@PolicyNu) + 12, 1)
		if @theChar = 'Z' set @newChar = ''
		else begin
			set @newChar = Char(ascii(@theChar) + 1)
		end
		set @newClaimnumber = convert(nvarchar(8),@policynu) + '-' + convert(varchar(10), @DOL, 110) + @newChar
	end
end
-- insert the claim data into the claim master
if @Debug>1 Print 'Insert the ClaimMaster ' + convert(varchar(5),@MasterPtr)
-- 23 is the claim num that I am faking
insert into CLM_ClaimMaster values(@MasterPtr, @PolicyNu, @DOL, @LType, 
      @newClaimnumber, '', 
		null, @EmployeePTR, 2, getdate(),
		@RptVal, @RptName, @RptDesc,
		@AccLoc, @PolDpt, @PolRpt, 0, 0, 0, 0, @TakeEmpPTR, 1, null, null, 0)

-- get the next key from the CLM_ClaimVehicle table
select @MyKey=Max(ID) from CLM_ClaimVehicle
if (@MyKey is null)
Begin
      set @MyKey=0
end
set @VehPtr=@MyKey+1

-- insert the claim data into the claim master
if @Debug>1 Print 'Insert the Vehicle ' + convert(varchar(5),@VehPtr)
insert into CLM_ClaimVehicle values(@VehPtr, @MasterPTR, @VehNu, @OurVeh, 0, @VehYr, @Make, @Model, @Vin, @OurDrv, 0, @DDesc, @DEstimate, null, null, null, null, 0, 1, 0, 0, null, null, null, null, null)
exec sp_nonreserves @MasterPTR, @VehNu, 1
select @MasterPTR as ClaimID
if @Debug > 0 Print 'The claim was successfully filed.'
END
GO

/****** Object:  StoredProcedure [dbo].[sp_insertclaimveh]    Script Date: 04/15/2011 10:29:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_insertclaimveh] 

      @ClaimID int,

      @VehNu      int, 

      @OurVeh     int, 

      @Liability  tinyint,

	  @Towing  tinyint,

      @VehYr      nvarchar(4), 

      @Make nvarchar(50), 

      @Model      nvarchar(50), 

      @DDesc      nvarchar(512),

      @DEstimate  money, 

      @Vin  nvarchar(60),

      @InsureCo   nvarchar(128), 

      @InsurePolicyNu   nvarchar(60), 

      @InsureContactInfo      nvarchar(512),

	  @VocLoc	nvarchar(512)

AS

BEGIN

      -- SET NOCOUNT ON added to prevent extra result sets from

      -- interfering with SELECT statements.

      SET NOCOUNT ON;

declare @VehPtr         int, 

      @MyKey                  int, 

      @NextEntity       int,

      @ReserveID        int,

      @AccDt                  Datetime,

      @LossType         int,

      @IsPolicyInForce  int,

      @ReOpen                 int,

      @ClaimLia   tinyint,

      @Debug                  int,

      @trapped          int,

      @ErrorMsg         varchar(255)

set @Debug = 0

begin transaction;

-- get the nextentity, policy number, and DOL from the claim's master row

select @NextEntity=NextEntityNumber,

      @AccDt=DateOfLoss, @LossType = LossType from CLM_ClaimMaster where id = @ClaimID

update CLM_ClaimMaster set NextEntityNumber=NextEntityNumber+1 where id = @ClaimID

if (@@error <> 0)

begin

      set @trapped = 10

      set @ErrorMsg = 'Error attempting to modify the NextEntityNumber on the clm_ClaimMaster row '

      goto Error_Handler

end

-- get the next key from the CLM_ClaimVehicle table

select @MyKey=Max(ID) from CLM_ClaimVehicle

if (@MyKey is null)

Begin

      set @MyKey=0

end

set @VehPtr=@MyKey+1

-- not inserting columns vindataptr, vin, ourdriver involvedparty

insert into CLM_ClaimVehicle 

values(@VehPtr, @ClaimID, @VehNu, @OurVeh, 0, @VehYr, @Make, @Model, @Vin, 

            0, 0, @DDesc, @DEstimate, @InsureCo, @InsurePolicyNu, @InsureContactInfo, 

            null, @Liability, @NextEntity, 0, @Towing, null, null, @VocLoc, null, null)

if (@@error <> 0)

begin

      set @trapped = 20

      set @ErrorMsg = 'Error attempting to insert the clm_ClaimVehicle row '

      goto Error_Handler

end

commit transaction;

--if @Debug=1 Print 'Check the reservses'

--exec sp_bulkreserve @ClaimID, @VehNu, @NextEntity

if @Debug=1 print 'At the end'

select @NextEntity vehentitynu

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

if @trapped > 9

      rollback

END


GO

/****** Object:  StoredProcedure [dbo].[sp_insertlog]    Script Date: 04/15/2011 10:29:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_insertlog] 
      @AdjusterId		int,
      @ClaimId			int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
declare @Debug			int, 
      @MyKey			int, 
      @LogPtr			int,
      @trapped			int,
      @ErrorMsg         varchar(255)
begin transaction
--
--insert the clm_PaymentParts row for the payee
-- get the next key from the CLM_PaymentParts table
--
select @MyKey=Max(ID) from CLM_ClaimLog
if (@MyKey is null)
Begin
      set @MyKey=0
end
set @LogPtr=@MyKey+1
if @Debug > 0 Print 'Insert the CLM ClaimLog ' + convert(varchar(5),@LogPtr)
insert into CLM_ClaimLog values(@LogPtr, @AdjusterId, @ClaimId, getdate())
if (@@error <> 0)
begin
      set @trapped = 10
      set @ErrorMsg = 'Error attempting to insert the clm_claimlog row '
      goto Error_Handler
end
--
-- end of the normal script processing
--
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
      SELECT @ErrorMsg = 'Claim Update script insertlog: ' + @ErrorMsg + '  ' + convert(varchar(10), @trapped)
      -- Using "with log" inserts a message into the event log
       RAISERROR(@ErrorMsg, 11, 1) with log 
      --    RAISERROR(@ErrorMsg, 11, 1)
      --return 21
END

if @trapped > 9
      rollback

END


GO

/****** Object:  StoredProcedure [dbo].[sp_insertpayment]    Script Date: 04/15/2011 10:29:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_insertpayment]
      @ClaimID          int, 
	  @EmployeePTR      int,
      @ClaimNumber      varchar(32), 
      @PayDate          datetime, 
      @PayGross         money,
      @Addr1            varchar(128),
	  @Addr2            varchar(128),
      @ZipPtr           int,
	  @GoAutoVendor		nvarchar(10),
	  @PayName			nvarchar(50),
	  @PayVoucherRef	nvarchar(30),
	  @PaySundry		nvarchar(30),
	  @PayCkDesc		nvarchar(66),
	  @PayTxnID			nvarchar(11)
AS
BEGIN
      -- SET NOCOUNT ON added to prevent extra result sets from
      -- interfering with SELECT statements.
      SET NOCOUNT ON;

declare @Debug          int, 
      @MyKey            int, 
      @PerPtr           int,
      @PayPtr           int,
      @VehPassPtr       int,
      @AddrPtr          int,
      @trapped          int,
      @PayeeMemo        nvarchar(512),
      @ErrorMsg         varchar(255)

set @Debug = 0
set @PayeeMemo = ''
begin transaction

--insert the payee's clm_address row
--
select @MyKey=Max(ID) from CLM_Address
if (@MyKey is null)
Begin
      set @MyKey=0
end
set @AddrPtr=@MyKey+1

if @Debug > 0 Print 'Insert the Address ' + convert(varchar(5),@AddrPtr)
insert into CLM_Address values(@AddrPtr, @Addr1, @Addr2, @ZipPtr, null)
if (@@error <> 0)
begin
      set @trapped = 20
      set @ErrorMsg = 'Error attempting to insert the clm_address row '
      goto Error_Handler
end

--
-- insert the clm_payment row first
-- get the next key from the CLM_Payment table
--
select @MyKey=Max(ID) from CLM_Payment
if (@MyKey is null)
Begin
      set @MyKey=0
end
set @PayPtr=@MyKey+1

if @Debug > 0 Print 'Insert the Payment ' + convert(varchar(5),@PayPtr)
insert into CLM_Payment
values(@PayPtr, @ClaimID, @ClaimNumber, @PayDate, @PayGross, 
            null, @AddrPtr, null, null, null, null, null, @PayeeMemo, 
			@GoAutoVendor, @EmployeePTR, @PayName, @PayVoucherRef,
			@PaySundry, @PayCkDesc, @PayTxnID, null, null, null)

if (@@error <> 0)
begin
      set @trapped = 30
      set @ErrorMsg = 'Error attempting to insert the clm_payment row '
      goto Error_Handler
end

--
-- end of the normal script processing
--
commit transaction
select @PayPtr as PayID
return

--
-- bottom of the script
--
Error_Handler:
if @Debug > 5
      print 'In the Error Handler'

IF @ErrorMsg IS NOT NULL
BEGIN
      SELECT @ErrorMsg = 'Claim Update script insertpayment: ' + @ErrorMsg + '  ' + convert(varchar(10), @trapped)
      -- Using "with log" inserts a message into the event log
       RAISERROR(@ErrorMsg, 11, 1) with log 
      --    RAISERROR(@ErrorMsg, 11, 1)
      --return 21
END

if @trapped > 9
      rollback

END

GO

/****** Object:  StoredProcedure [dbo].[sp_insertpaypart]    Script Date: 04/15/2011 10:29:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================

-- Author:        J. Steve Witt

-- Create date: 4/21/2010

-- Description:   Insert the payment parts rows

-- =============================================

CREATE PROCEDURE [dbo].[sp_insertpaypart] 
      @PayID	int, 
      @ResID    int,
      @ResAmt   money,
      @CloseRes tinyint,
	  @JobCode	varchar(6)
AS

BEGIN
      -- SET NOCOUNT ON added to prevent extra result sets from
      -- interfering with SELECT statements.
      SET NOCOUNT ON;

declare @Debug  int, 
      @MyKey    int, 
      @PayPtr   int,
      @OrgAmt   money,
      @trapped	int,
	  @CMastPtr	int,
      @ErrorMsg         varchar(255)

set @Debug = 0

begin transaction
--
--insert the clm_PaymentParts row for the payee
-- get the next key from the CLM_PaymentParts table
--
select @MyKey=Max(ID) from CLM_PaymentParts
if (@MyKey is null)
Begin
      set @MyKey=0
end
set @PayPtr=@MyKey+1
if @Debug > 0 Print 'Insert the CLM PaymentParts ' + convert(varchar(5),@PayPtr)
insert into CLM_PaymentParts values(@PayPtr, @PayID, @ResID, @ResAmt, @CloseRes, 0, @JobCode)
if (@@error <> 0)
begin
      set @trapped = 10
      set @ErrorMsg = 'Error attempting to insert the clm_PaymentParts row '
      goto Error_Handler
end

select @CMastPtr=ClaimNumber from clm_reserve where id = @ResID
--if @OrgAmt is null 
--      set @OrgAmt = 0
--
--select @OrgAmt=@OrgAmt+@ResAmt
if @CloseRes=1
begin
	if (select AmountPaid from clm_reserve where id = @ResID) is null
		update CLM_Reserve set AmountPaid = @ResAmt, ReserveOpen = 0, ClosedOn = GetDate() where id = @ResID
	else
		update CLM_Reserve set AmountPaid = AmountPaid + @ResAmt, ReserveOpen = 0, ClosedOn = GetDate() where id = @ResID
end
else
begin
	if (select AmountPaid from clm_reserve where id = @ResID) is null
      update CLM_Reserve set AmountPaid = @ResAmt where id = @ResID
	else
      update CLM_Reserve set AmountPaid = AmountPaid + @ResAmt where id = @ResID
end

if (@@error <> 0)
begin
      set @trapped = 20
      set @ErrorMsg = 'Error attempting to update the clm_reserve row '
      goto Error_Handler
end

if exists(select id from clm_reserve where claimnumber = @CMastPtr and ReserveOpen = 1)
begin	
	update clm_claimmaster set ReservesClosed = 0 where id = @CMastPtr
end 
else
begin
	update clm_claimmaster set ReservesClosed = 1 where id = @CMastPtr
end
--

-- end of the normal script processing

--

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

      SELECT @ErrorMsg = 'Claim Update script insertpaypart: ' + @ErrorMsg + '  ' + convert(varchar(10), @trapped)

      -- Using "with log" inserts a message into the event log

       RAISERROR(@ErrorMsg, 11, 1) with log 

      --    RAISERROR(@ErrorMsg, 11, 1)

      --return 21

END

if @trapped > 9

      rollback

END
GO

/****** Object:  StoredProcedure [dbo].[sp_insertperson]    Script Date: 04/15/2011 10:29:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_insertperson]

      @CMastPtr int, 

      @VehNu      int, 

      @OurDrv     int,

      @Lossid     int,

	  @Owner	  int,

      @AccDesc    nvarchar(512),

      @Injured    int,

      @Severtyid  int,

      @InjDesc    nvarchar(512),

      @Rep  int,

      @Attid      int,

      @Treat      int,

      @Medid      int,

      @FNam varchar(32),

      @MNam varchar(32), 

      @LNam Varchar(32),

      @SufID      int,

      @TileID     int,

      @DOB datetime,

      @Gender     int,

      @Married    int,

      @SSN  varchar(11), 

      @LiceNu     varchar(16),

      @LiceSt     char(2),

      @HomePh     varchar(16),

      @CellPh     varchar(16),

      @WrkPh      varchar(16),

      @Email      varchar(128), 

      @Addr1      varchar(128),

      @Addr2      varchar(128),

      @ZipPtr     int
--	 @Contacted	  tinyint

AS

BEGIN

      -- SET NOCOUNT ON added to prevent extra result sets from

      -- interfering with SELECT statements.

      SET NOCOUNT ON;

declare @Debug          int, 
      @MyKey                  int, 
      @MasterPtr        int,
      @VehPtr                 int,
      @PartyPtr         int,
      @PerPtr                 int,
	  @PerBKPtr			int,
      @VehPassPtr       int,
      @AddrPtr          int,
      @NextEntity       int,
      @PolicyNu         varchar(16),
      @ReserveID        int,
      @AccDt                  Datetime,
      @ClaimLia   tinyint,
      @LossType         int,
      @ReOpen                 int, 
      @ResType          int,
      @OurVeh                 int,
      @trapped          int,
      @ErrorMsg         varchar(255)
--	  @ConDt            Datetime,

-- Debug can be 

--

-- 0 for off

-- 1 for general

-- 2 detail

set @Debug=0
if @Debug > 0 Print 'Starting the insert of accident people'

begin transaction
-- get the nextentity, policy number, DOL, and losstype from the claim's master row
select @NextEntity=NextEntityNumber, @PolicyNu=PolicyNumber, 
            @AccDt=DateOfLoss, @LossType = LossType from CLM_ClaimMaster where id = @CMastPtr
update CLM_ClaimMaster set NextEntityNumber=NextEntityNumber+1 where id = @CMastPtr

if (@@error <> 0)
begin
      set @trapped = 10
      set @ErrorMsg = 'Error attempting to modify the NextEntityNumber on the clm_ClaimMaster row '
      goto Error_Handler
end

--
-- insert the clm_person
-- get the next key from the CLM_Person table
select @MyKey=Max(ID) from CLM_Person
if (@MyKey is null)
Begin
      set @MyKey=0
end
set @PerPtr=@MyKey+1

-- insert the Person data
if @Debug>1 Print 'Insert the CLM Person ' + convert(varchar(5),@PerPtr)
insert into CLM_Person 
values(@PerPtr, @FNam, @MNam, @LNam, @SufID, @TileID, @DOB,
      @Gender,
      @Married,
      @SSN, 
      @LiceNu,
      @LiceSt,
      @HomePh,
      @CellPh,@WrkPh, @Email)

if (@@error <> 0)
begin
      set @trapped = 20
      set @ErrorMsg = 'Error attempting to insert the clm_person row '
      goto Error_Handler
end
--
-- insert the clm_personbackup
-- get the next key from the CLM_PersonBackup table
select @MyKey=Max(ID) from CLM_PersonBackup
if (@MyKey is null)
Begin
      set @MyKey=0
end
set @PerBKPtr=@MyKey+1
-- insert the PersonBackup data
if @Debug>1 Print 'Insert the CLM PersonBackup ' + convert(varchar(5),@PerPtr)
insert into CLM_PersonBackup 
values(@PerBKPtr, @PerPtr, @FNam, @MNam, @LNam, @SufID, @TileID, @DOB,
      @Gender,
      @Married,
      @SSN, 
      @LiceNu,
      @LiceSt,
      @HomePh,
      @CellPh,@WrkPh, @Email, getdate(), 'Insert')

if (@@error <> 0)
begin
      set @trapped = 25
      set @ErrorMsg = 'Error attempting to insert the clm_personbackup row '
      goto Error_Handler
end

-- get the next key from the CLM_Address table
select @MyKey=Max(ID) from CLM_Address
if (@MyKey is null)
Begin
      set @MyKey=0
end
set @AddrPtr=@MyKey+1

-- insert the address data

if @Debug=1 Print 'Insert the Address ' + convert(varchar(5),@AddrPtr)

insert into CLM_Address values(@AddrPtr, @Addr1, @Addr2, @ZipPtr, null)

if (@@error <> 0)

begin

      set @trapped = 30

      set @ErrorMsg = 'Error attempting to insert the clm_address row '

      goto Error_Handler

end

-- get the next key from the CLM_InvolvedParty table

select @MyKey=Max(ID) from CLM_InvolvedParty

if (@MyKey is null)

Begin

      set @MyKey=0

end

set @PartyPtr=@MyKey+1

--if @Contacted = 1 
--begin 
--	set @ConDt = GetDate()
--end
--else
--begin
--	set @ConDt = null
--end
if @Debug>1 Print 'Insert the Involved Party ' + convert(varchar(5),@PartyPtr)

insert into clm_involvedparty values(@PartyPtr, @PerPtr, @Lossid,

      @AccDesc,

      @Injured,

      @Severtyid,

      @InjDesc,

      @Rep,

      @Attid,

      @Treat,

      @Medid, null, @AddrPtr, @NextEntity, @Owner

)

if (@@error <> 0)

begin

      set @trapped = 40

      set @ErrorMsg = 'Error attempting to insert the clm_involvedparty row '

      goto Error_Handler

end

-- get the next key from the CLM_VehiclePassenger table

select @MyKey=Max(ID) from CLM_VehiclePassenger

if (@MyKey is null)

Begin

      set @MyKey=0

end

set @VehPassPtr=@MyKey+1

if @Debug>1 Print 'Insert the Veh Pass ' + convert(varchar(5),@VehPassPtr)

insert into CLM_VehiclePassenger values(@VehPassPtr, @CMastPtr, @VehNu, @OurDrv, @PartyPtr, 0)

if (@@error <> 0)

begin

      set @trapped = 50

      set @ErrorMsg = 'Error attempting to insert the clm_VehiclePassenger row '

      goto Error_Handler

end

--

--  update the vehicle that this driver was driving

--

if (@lossid = 1) or (@lossid = 5 and @LossType >2)

      begin

      if @Debug>1 Print 'Update the Veh Pass with the driver info from ' + convert(varchar(5),@PartyPtr)

      update clm_claimvehicle set OurDriverIndex = @OurDrv, InvolvedPartyPTR = @PartyPTR

      where ClaimMasterPTR = @CMastPtr and VehicleNumber = @VehNu

      if (@@error <> 0)

      begin

            set @trapped = 60

            set @ErrorMsg = 'Error attempting to insert the clm_claimvehicle row '

            goto Error_Handler

      end

end

commit transaction

--exec sp_personreserve @CMastPtr, @PartyPtr, 2

if @Debug > 0 Print 'End of accident claims'

select @NextEntity as entityptr, @PartyPtr as invptr
return

--

-- bottom of the script

--

Error_Handler:

if @Debug > 5

      print 'In the Error Handler'

IF @ErrorMsg IS NOT NULL

BEGIN

      SELECT @ErrorMsg = 'Claim Update script insertperson: ' + @ErrorMsg + '  ' + convert(varchar(10), @trapped)

      -- Using "with log" inserts a message into the event log

       RAISERROR(@ErrorMsg, 11, 1) with log 

      --    RAISERROR(@ErrorMsg, 11, 1)

      --return 21

END

if @trapped > 9

      rollback

END


GO

/****** Object:  StoredProcedure [dbo].[sp_insertproperty]    Script Date: 04/15/2011 10:29:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================

-- Author:        J. Steve Witt

-- Create date: 2/26/2010

-- Description:   Inserts the clm_person, involvedparty, and 

--              vehiclepassenger for a filedclaim

-- =============================================
CREATE PROCEDURE [dbo].[sp_insertproperty]

      @CMastPtr int, 

      @PropertyDesc    nvarchar(512),

	@DamageEstimate	money,
	
	@InsureCoName	nvarchar(128),

	@InsurePolicyNu	nvarchar(60),

	@InsureContactInfo	nvarchar(512),

      @Injured    int,

      @Rep  int,

      @Attid      int,

      @FNam varchar(32),

      @MNam varchar(32), 

      @LNam Varchar(32),

      @SufID      int,

      @TileID     int,

      @DOB datetime,

      @Gender     int,

      @Married    int,

      @SSN  varchar(11), 

      @LiceNu     varchar(16),

      @LiceSt     char(2),

      @HomePh     varchar(16),

      @CellPh     varchar(16),

      @WrkPh      varchar(16),

      @Email      varchar(128), 

      @Addr1      varchar(128),

      @Addr2      varchar(128),

      @ZipPtr     int

AS

BEGIN

      -- SET NOCOUNT ON added to prevent extra result sets from

      -- interfering with SELECT statements.

      SET NOCOUNT ON;

declare @Debug          int, 

      @MyKey                  int, 

      @MasterPtr        int,

      @VehPtr                 int,

      @PartyPtr         int,

      @PerPtr                 int,

      @OtherPropPtr       int,

      @AddrPtr          int,

      @PersonEntity     int,
	@PropertyEntity		int,

      @PolicyNu         nvarchar(8),

      @ReserveID        int,

      @AccDt                  Datetime,

      @ClaimLia   tinyint,

      @LossType         int,

      @ReOpen                 int, 

      @ResType          int,

      @OurVeh                 int,

      @trapped          int,

      @ErrorMsg         varchar(255)

-- Debug can be 

--

-- 0 for off

-- 1 for general

-- 2 detail

set @Debug=0

if @Debug > 0 Print 'Starting the insert of accident people'

begin transaction


-- get the nextentity, policy number, DOL, and losstype from the claim's master row

select @PersonEntity=NextEntityNumber, @PolicyNu=PolicyNumber, 

            @AccDt=DateOfLoss, @LossType = LossType from CLM_ClaimMaster where id = @CMastPtr

--

-- insert the clm_person

-- get the next key from the CLM_Person table

select @MyKey=Max(ID) from CLM_Person

if (@MyKey is null)

Begin

      set @MyKey=0

end

set @PerPtr=@MyKey+1

-- insert the Person data

if @Debug>1 Print 'Insert the CLM Person ' + convert(varchar(5),@PerPtr)

insert into CLM_Person 

values(@PerPtr, @FNam, @MNam, @LNam, @SufID, @TileID, @DOB,

      @Gender,

      @Married,

      @SSN, 

      @LiceNu,

      @LiceSt,

      @HomePh,

      @CellPh,@WrkPh, @Email)

if (@@error <> 0)

begin

      set @trapped = 20

      set @ErrorMsg = 'Error attempting to insert the clm_person row '

      goto Error_Handler

end

-- get the next key from the CLM_Address table

select @MyKey=Max(ID) from CLM_Address

if (@MyKey is null)

Begin

      set @MyKey=0

end

set @AddrPtr=@MyKey+1

-- insert the address data

if @Debug>1 Print 'Insert the Address ' + convert(varchar(5),@AddrPtr)

insert into CLM_Address values(@AddrPtr, @Addr1, @Addr2, @ZipPtr, null)

if (@@error <> 0)

begin

      set @trapped = 30

      set @ErrorMsg = 'Error attempting to insert the clm_address row '

      goto Error_Handler

end

-- get the next key from the CLM_InvolvedParty table

select @MyKey=Max(ID) from CLM_InvolvedParty

if (@MyKey is null)

Begin

      set @MyKey=0

end

set @PartyPtr=@MyKey+1

if @Debug>1 Print 'Insert the Involved Party ' + convert(varchar(5),@PartyPtr)

insert into clm_involvedparty values(@PartyPtr, @PerPtr, 0,

      null,

      @Injured,

      0,

      null,

      @Rep,

      @Attid,

      0,

      0, null, @AddrPtr, @PersonEntity, 0

)

if (@@error <> 0)

begin

      set @trapped = 40

      set @ErrorMsg = 'Error attempting to insert the clm_involvedparty row '

      goto Error_Handler

end

set @PropertyEntity=@PersonEntity+1

-- get the next key from the CLM_OtherProperty table

select @MyKey=Max(ID) from CLM_OtherProperty 

if (@MyKey is null)

Begin

      set @MyKey=0

end

set @OtherPropPtr=@MyKey+1

if @Debug>1 Print 'Insert the Other Property ' + convert(varchar(5),@OtherPropPtr)

insert into CLM_OtherProperty values(@OtherPropPtr, @CMastPtr, @PropertyEntity, @PropertyDesc, @PartyPtr, @DamageEstimate,
	@InsureCoName, @InsurePolicyNu, @InsureContactInfo, null, 0)

if (@@error <> 0)

begin

      set @trapped = 50

      set @ErrorMsg = 'Error attempting to insert the Other Property row '

      goto Error_Handler

end

update CLM_ClaimMaster set NextEntityNumber=@PropertyEntity+1 where id = @CMastPtr

if (@@error <> 0)

begin

      set @trapped = 10

      set @ErrorMsg = 'Error attempting to modify the NextEntityNumber on the clm_ClaimMaster row '

      goto Error_Handler

end

commit transaction

--exec sp_personreserve @CMastPtr, @PartyPtr, 2
select @PartyPtr invPtr, @PropertyEntity propertyentity

if @Debug > 0 Print 'End of accident claims'

return

--

-- bottom of the script

--

Error_Handler:

if @Debug > 5

      print 'In the Error Handler'

IF @ErrorMsg IS NOT NULL

BEGIN

      SELECT @ErrorMsg = 'Claim Update script insertperson: ' + @ErrorMsg + '  ' + convert(varchar(10), @trapped)

      -- Using "with log" inserts a message into the event log

       RAISERROR(@ErrorMsg, 11, 1) with log 

      --    RAISERROR(@ErrorMsg, 11, 1)

      --return 21

END

if @trapped > 9

      rollback
END

GO

/****** Object:  StoredProcedure [dbo].[sp_IsCoverageActive]    Script Date: 04/15/2011 10:29:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_IsCoverageActive]
   @PolicyNumber varchar(32),
   @PointInTime datetime,
   @OurVehicleIndex int,
   @OurDriverIndex int,
   @CovID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
declare @Debug          int, 
	  @Covered           int,
	  @Domain			sysname,
	  @myState			nvarchar(4000),
      @ErrorMsg         varchar(255)
set @Debug = 0
set @Covered = 0
--
-- define the results table from the dynamic sql
CREATE TABLE #ctr
( DyRsult int )
-- 
-- retrieve the domain value from the table
select @Domain=[value] from clm_sysvalues where [key] = 'domain'
if @Debug=1 print @Domain
--
-- build the statement GoAutoProd.dbo.F_Claims_IsCoverageActive(@PolicyNu, @AccDt, @OurVeh, @OurGoIdx, 7) using the variables
select @myState = 'insert #ctr values(' + @Domain + 'F_Claims_IsCoverageActive(''' + @PolicyNumber + ''', ''' + cast(@PointInTime as nvarchar(25)) + ''','
select @myState = @myState + cast(@OurVehicleIndex as nvarchar(2)) + ', ' + cast(@OurDriverIndex as nvarchar(2)) + ', ' + cast(@CovID as nvarchar(2)) + '))'
if @Debug=1 print @myState
--
-- is the policy active?
exec(@myState)
IF @@ERROR = 0
BEGIN
     SELECT    @Covered = DyRsult
     FROM #ctr

     DROP TABLE #ctr
END
ELSE
BEGIN
     DROP TABLE #ctr
	 RAISERROR('Error with call to function F_Claims_IsCoverageActive.', 16, 1)
	return
END
if @Debug=1 print @Covered

return @Covered
END

GO

/****** Object:  StoredProcedure [dbo].[sp_IsPolicyActive]    Script Date: 04/15/2011 10:29:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		J. Steve Witt
-- Create date: 08/26/2010
-- Description:	Dynamic call to the Goauto function
-- =============================================
CREATE PROCEDURE [dbo].[sp_IsPolicyActive] 
      @PolicyId		nvarchar(60),
      @Dol			datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
declare @Debug          int, 
	  @ReOpen           int,
	  @Domain			sysname,
	  @myState			nvarchar(4000),
      @ErrorMsg         varchar(255)
set @Debug = 0
set @ReOpen = 0
--
-- define the results table from the dynamic sql
CREATE TABLE #ctr
( DyRsult int )
-- 
-- retrieve the domain value from the table
select @Domain=[value] from clm_sysvalues where [key] = 'domain'
if @Debug=1 print 'Domain ' + @Domain
--
-- build the statement GoAutoProd.dbo.F_Claims_IsPolicyActive(@PolicyNu,@AccDt) using the variables
select @myState = 'insert #ctr values(' + @Domain + 'F_Claims_IsPolicyActive(''' + @PolicyId + ''', ''' + cast(@Dol as nvarchar(25)) + '''))'
if @Debug=1 print @myState
--
-- is the policy active?
exec(@myState)
IF @@ERROR = 0
BEGIN
     SELECT    @ReOpen = DyRsult
     FROM #ctr

     DROP TABLE #ctr
END
ELSE
BEGIN
     DROP TABLE #ctr
	 RAISERROR('Error with call to function F_Claims_IsPolicyActive.', 16, 1)
	return
END
if @Debug=1 print @ReOpen
return @ReOpen
END

GO

/****** Object:  StoredProcedure [dbo].[sp_issuepayment]    Script Date: 04/15/2011 10:29:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		John S. Witt
-- Create date: 03/29/2011
-- Description:	Issued payments sets the different columns
-- and records the check number used in the payment.
-- =============================================
CREATE PROCEDURE [dbo].[sp_issuepayment]
	@Paypartsid int,
	@checknumber int
AS
BEGIN
declare @myPartId	int,
	@myPayId		int,
    @myResId		int, 
	@theAmount		money,
	@checknu		int,
	@payvoided		tinyint,
	@payissued		tinyint,	
	@debug			int

set @debug = 0
select @myPayId = payment.id, @checknu = cast(checknu as int), @payvoided = voided, @payissued = payment.issued 
from clm_paymentparts payparts
	join clm_payment payment on payparts.paymentptr = payment.id
	where payparts.id = @Paypartsid
		
if @checknu is null
	set @checknu = 0
if @payvoided is null 
	set @payvoided = 0
if @payissued is null 
	set @payissued = 0	
if @debug = 1 
	select @myPayid, @checknu, @payissued, @payvoided

if @checknumber < @checknu
	goto EndOfProc
if @checknumber = @checknu and @payissued = 1
	goto EndOfProc

if @debug = 1
	select 'Set the payment'
update clm_paymentparts set issued = 1 where id = @Paypartsid
	
update clm_payment set checknu = replace(str(@checknumber, 10, 0), ' ', '0'), issued = 1, uploaded = 1, approved = 1,
		IssuedDateTime = getdate(), voided = 0, rejected = 0,  VoidedDateTime = null where id = @myPayId

if @payvoided = 1
	goto ResetThem
      		
goto EndOfProc

-- set the parts and reserves
ResetThem:
-- reset the paymentparts and any reserves they have
declare myVoidPartscursor cursor for
select id, reserveptr, amountpaid 
from clm_paymentparts
where paymentptr = @myPayid

open myVoidPartscursor
fetch next from myVoidPartscursor into @myPartId, @myResId, @theAmount 
while (@@fetch_status = 0)
begin
	if @debug = 1
	begin
		select 'reserve' as rowbefore, id, amountpaid, reserveopen, closedon
		from clm_reserve where id = @myResId
	end
	update clm_reserve set AmountPaid = AmountPaid + @theAmount,
			ReserveOpen = 0, ClosedOn = getdate()
		where id = @myResId
	if @debug = 1
	begin
		select 'reserve' as rowupdt, id, amountpaid, reserveopen, closedon
		from clm_reserve where id = @myResId
	end
	fetch next from myVoidPartscursor into @myPartId, @myResId, @theAmount 
end
close myVoidPartscursor
deallocate myVoidPartscursor
-- end of the proc
EndOfProc:
if @debug = 1
	select 'The end'
END

GO

/****** Object:  StoredProcedure [dbo].[sp_nonreserves]    Script Date: 04/15/2011 10:29:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:        J. Steve Witt
-- Create date: 5/11/2010
-- Description:   Process Non-accident reserves
-- =============================================
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
GO

/****** Object:  StoredProcedure [dbo].[sp_personreserve]    Script Date: 04/15/2011 10:29:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:        J. Steve Witt
-- Create date: 4/16/2010
-- Description:   Either remove or insert the reserve for a person
-- =============================================
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

GO

/****** Object:  StoredProcedure [dbo].[sp_procreserve]    Script Date: 04/15/2011 10:29:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		J. Steve Witt
-- Create date: 9/1/2010
-- Description:	Process the reserve
-- =============================================
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

/****** Object:  StoredProcedure [dbo].[sp_propertyreserve]    Script Date: 04/15/2011 10:29:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:        J. Steve Witt
-- Create date: 5/24/2010
-- Description:   Process the reserves for the properties
-- =============================================
CREATE PROCEDURE [dbo].[sp_propertyreserve] 
      @CMastPtr int,
      @Owner    int,
      @ProType  int 
AS

BEGIN
      -- SET NOCOUNT ON added to prevent extra result sets from
      -- interfering with SELECT statements.
      SET NOCOUNT ON;
declare @Debug      int, 
    @MyKey          int, 
    @OwnerEntity    int,
	@OwnerInjured	int,
	@PropEntity		int,
    @PolicyNu       varchar(16),
    @ReserveID      int,
    @AccDt          Datetime,
    @ReOpen         int, 
    @ResType        int,
    @LossType       int,
    @OurVeh         int,
    @OurDrv         int,
    @Result         int,
	@ResAmt			money,    
    @trapped        int,
    @ErrorMsg       varchar(255)

set @Debug = 0
set @OurDrv = 0
set @OurVeh = 0
set @ResType = 0
set @Result = 0
set @ResAmt = 0
-- get the policy number, and DOL from the claim's master row
select @PolicyNu=PolicyNumber, @AccDt=DateOfLoss, @LossType = LossType from CLM_ClaimMaster where id = @CMastPtr
if @Debug>1 print cast(@PolicyNu as nvarchar(10)) + ' ' + cast(@LossType as nvarchar(2))
if @Debug>1 print @AccDt
-- get the owner entitynumber, wheather he was injured and the property entitynumber
select @OwnerEntity=owner.EntityNumber, @OwnerInjured=owner.injured, @PropEntity=Prop.EntityNumber
	from clm_otherproperty Prop
	left join clm_involvedparty [owner] on Prop.involvedpartyptr = owner.id
where Prop.claimmasterptr = @CMastPtr and owner.id = @Owner
if @Debug>1 print 'Entity ' + cast(@OwnerEntity as nvarchar(2))
if @Debug>1 print @OwnerInjured
if @Debug>1 print @PropEntity
-- Does the goauto driver have the LIBI coverage for the reserve
select @OurDrv = OurDriverIndex, @OurVeh=OurVehicleIndex from clm_claimvehicle where claimmasterptr =  @CMastPtr and VehicleNumber = 1
-- is the policy active?
exec @ReOpen = sp_IsPolicyActive @PolicyNu, @AccDt
if @@ERROR > 0 return @@ERROR
if @Debug=1 print @ReOpen
--
-- a process type of 1 is to close the reserve
--
if @ProType=1
begin
      if @Debug > 1 print 'Close the reserve'
      update CLM_Reserve 
            set ClosedOn = GetDate(), ReserveOpen = 0
            where ClaimNumber = @CMastPtr and EntityNumber = @OwnerEntity 
      if (@@error <> 0)
      begin
            set @trapped = 10
            set @ErrorMsg = 'Error attempting to update the clm_reserve row '
            goto Error_Handler
      end
      goto ReserveEnd
end 
if @LossType > 1
	goto ReserveEnd
if @ReOpen = 0
      goto ReserveEnd
if @Debug > 1 print 'Open the property reserves'
-- the owner is not injured so akip the libi
if @OwnerInjured = 0 
	goto CheckProp

-- if the owner is injured then check if we can give him LIBI
set @ResType = 2
--
-- check LIBI coverage
--
exec sp_procreserve @CMastPtr, @OwnerEntity, @ResType, @ReOpen, @PolicyNu, @AccDt, @OurVeh, @OurDrv
if @@ERROR > 0 return @@ERROR

CheckProp:
if @Debug > 1 print 'check the property'
--
-- the property gets LIPD
set @ResType = 1
--
-- check LIPD coverage
--
exec sp_procreserve @CMastPtr, @PropEntity, @ResType, @ReOpen, @PolicyNu, @AccDt, @OurVeh, @OurDrv
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


GO

/****** Object:  StoredProcedure [dbo].[sp_resetpayment]    Script Date: 04/15/2011 10:29:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		John S. Witt
-- Create date: 12/22/2010
-- Description:	Resets the payment to either a void state or a rejected state
-- =============================================
CREATE PROCEDURE [dbo].[sp_resetpayment]
	@resettype int,
	@checknumber int,
	@Payid	int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
declare @myPartId	int,
    @myResId		int, 
	@theAmount		money,
	@checknu		int,
	@payvoided		tinyint,
	@debug			int

set @debug = 0
select @checknu = cast(checknu as int), @payvoided = voided from clm_payment where id = @Payid
if @checknu is null
	set @checknu = 0
if @payvoided is null 
	set @payvoided = 0
if @debug = 1 
	select @Payid, @checknu, @theAmount, @payvoided
if @resettype = 2
	goto RejectthePayment
if @checknumber < @checknu
	goto EndOfProc
if @checknumber = @checknu and @payvoided = 1
	goto EndOfProc
-- if reset type is 1 then void
if @resettype = 1
begin
	if @debug = 1
		select 'Reject the payment'
	-- void the payment once for all of it's parts
	if exists(select id from clm_payment where id = @Payid)
	begin
		update clm_payment set issued = 0, uploaded = 0, approved = 0, issueddatetime = null,
		rejected = 0, voided = 1, VoidedDateTime = getdate(), checknu = replace(str(@checknumber, 10, 0), ' ', '0')
			where id = @Payid
		if @payvoided = 1
			goto EndOfProc
		goto ResetThem
	end
	if @debug = 1
		select 'NotUpdt', @Payid 

	goto EndOfProc
end
RejectthePayment:
-- if reset type is 2 then reject
if @resettype = 2
begin
	if exists(select id from clm_payment where id = @Payid)
	begin
		Update clm_payment set issued = 0, uploaded = 0, approved = 0, voided = 0, rejected = 1,
		 issueddatetime = null, voideddatetime = null, checknu = ''
		where id = @PayId
		if @payvoided = 1
			goto EndOfProc
		goto ResetThem
	end
	if @debug = 1
	begin
		select 'NotUpdt', @Payid 
	end
	goto EndOfProc
end
goto EndOfProc

-- set the parts and reserves
ResetThem:
-- reset the paymentparts and any reserves they have
declare myVoidPartscursor cursor for
select id, reserveptr, amountpaid 
from clm_paymentparts
where paymentptr = @Payid

open myVoidPartscursor
fetch next from myVoidPartscursor into @myPartId, @myResId, @theAmount 
while (@@fetch_status = 0)
begin
	if @debug = 1
	begin
		select 'parts' as rowbefore, id, issued from clm_paymentparts where id =  @myPartId
		select 'reserve' as rowbefore, id, amountpaid, reserveopen, closedon
		from clm_reserve where id = @myResId
	end
	update clm_paymentparts set issued = 0 where id = @myPartId
	--
	-- do NOT re-open the reserve on the void
	--
	if @resettype = 1
		update clm_reserve set AmountPaid = AmountPaid - @theAmount where id = @myResId
	else
		update clm_reserve set AmountPaid = AmountPaid - @theAmount,
			ReserveOpen = 1, ClosedOn = null
			where id = @myResId
	if @debug = 1
	begin
		select 'parts' as rowupdt, id, issued from clm_paymentparts where id =  @myPartId
		select 'reserve' as rowupdt, id, amountpaid, reserveopen, closedon
		from clm_reserve where id = @myResId
	end
	fetch next from myVoidPartscursor into @myPartId, @myResId, @theAmount 
end
close myVoidPartscursor
deallocate myVoidPartscursor
-- end of the proc
EndOfProc:
END

GO

/****** Object:  StoredProcedure [dbo].[sp_RestTheLoaded]    Script Date: 04/15/2011 10:29:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		john s. witt
-- Create date: 12/31/2010
-- Description:	set the claimloaded flag
-- =============================================
CREATE PROCEDURE [dbo].[sp_RestTheLoaded]
	@theClaim int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
declare @setit int
set @setit = 1
--
--  we have coverage of (1) LIPD with no one assigned to it do not set the claimloaded
--
if exists(select * from clm_reserve where claimnumber = @theClaim and coverageid = 1 and reserveopen = 1 and not exists (
			select * from clm_adjusterassignments a where claimptr = @theClaim and
				a.adjusterskilltypeptr = 2))
	set @setit = 0
--
--  we have coverage of (2) LIBI with no one assigned to it do not set the claimloaded
--
if exists(select * from clm_reserve where claimnumber = @theClaim and coverageid = 2 and reserveopen = 1 and not exists (
			select * from clm_adjusterassignments a where claimptr = @theClaim and
				a.adjusterskilltypeptr = 4))
	set @setit = 0
--
--  we have coverage of (3,4) Comp/Coll with no one assigned to it do not set the claimloaded
--
if exists(select * from clm_reserve where claimnumber = @theClaim and coverageid in (3,4) and reserveopen = 1 and not exists (
			select * from clm_adjusterassignments a where claimptr = @theClaim and
				a.adjusterskilltypeptr = 6))
	set @setit = 0
--
--  we have coverage of (5) Towing with no one assigned to it do not set the claimloaded
--
if exists(select * from clm_reserve where claimnumber = @theClaim and coverageid = 5 and reserveopen = 1 and not exists (
			select * from clm_adjusterassignments a where claimptr = @theClaim and
				a.adjusterskilltypeptr = 7))
	set @setit = 0
--
--  we have coverage of (7) MED with no one assigned to it do not set the claimloaded
--
if exists(select * from clm_reserve where claimnumber = @theClaim and coverageid = 7 and reserveopen = 1 and not exists (
			select * from clm_adjusterassignments a where claimptr = @theClaim and
				a.adjusterskilltypeptr = 8))
	set @setit = 0
--
--  we have coverage of (8) UMBI with no one assigned to it do not set the claimloaded
--
if exists(select * from clm_reserve where claimnumber = @theClaim and coverageid = 8 and reserveopen = 1 and not exists (
			select * from clm_adjusterassignments a where claimptr = @theClaim and
				a.adjusterskilltypeptr = 9))
	set @setit = 0
--
--  we have coverage of (9) UMPD with no one assigned to it do not set the claimloaded
--
if exists(select * from clm_reserve where claimnumber = @theClaim and coverageid = 9 and reserveopen = 1 and not exists (
			select * from clm_adjusterassignments a where claimptr = @theClaim and
				a.adjusterskilltypeptr = 10))
	set @setit = 0
if not exists(select * from clm_reserve where claimnumber = @theClaim)
begin
	if exists(select * from clm_adjusterassignments where claimptr = @theClaim and adjusterskilltypeptr = 3)
		set @setit = 1
	else 
		set @setit = 0
end
if @setit = 1
	update clm_claimmaster set claimloaded = 0 where id = @theClaim 
END


GO

/****** Object:  StoredProcedure [dbo].[sp_UnassignedSkills]    Script Date: 04/15/2011 10:29:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		John S. Witt
-- Create date: 12/29/2010
-- Description:	Check for unassigned adjuster skills
-- =============================================
CREATE PROCEDURE [dbo].[sp_UnassignedSkills] 
	@theClaim int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
declare @losstype int
select @losstype = losstype from clm_claimmaster where id = @theClaim
if (@losstype = 7)
begin
	--
	--  towing only skill
	select (select [desc] from clm_adjusterskilltype where id = 7) as UnSkill 
	from clm_reserve b
	where b.claimnumber = @theClaim and b.openedon >= '12/23/2010' and b.coverageid = 5 
		and not exists (
			select * from clm_adjusterassignments a where claimptr = @theClaim and
			a.adjusterskilltypeptr = 7 and a.EmployeePTR > 0)
end
else
begin
	--  the other loss type skills we care about are (1)LIPD, (2)LIBI, (3)COMP, (4)COLL
	--  and the adjuster skill of (2) LIPD, (4)LIBI, (6)Comp/Coll
	--
	select (select [desc] from clm_adjusterskilltype where id = 2) as UnSkill 
	from clm_reserve b
	where b.claimnumber = @theClaim and b.openedon >= '12/23/2010' and b.coverageid = 1 
		and not exists (
			select * from clm_adjusterassignments a where claimptr = @theClaim and
			a.adjusterskilltypeptr = 2 and a.EmployeePTR > 0)
	union
	select (select [desc] from clm_adjusterskilltype where id = 4) as UnSkill 
	from clm_reserve b
	where b.claimnumber = @theClaim and b.openedon >= '12/23/2010' and b.coverageid = 2 
		and not exists (
			select * from clm_adjusterassignments a where claimptr = @theClaim and
			a.adjusterskilltypeptr = 4 and a.EmployeePTR > 0)
	union
	select (select [desc] from clm_adjusterskilltype where id = 6) as UnSkill 
	from clm_reserve b
	where b.claimnumber = @theClaim and b.openedon >= '12/23/2010' and b.coverageid in (3,4) 
		and not exists (
			select * from clm_adjusterassignments a where claimptr = @theClaim and
			a.adjusterskilltypeptr = 6 and a.EmployeePTR > 0)
	union
	select (select [desc] from clm_adjusterskilltype where id = 9) as UnSkill 
	from clm_reserve b
	where b.claimnumber = @theClaim and b.openedon >= '12/23/2010' and b.coverageid = 8 
		and not exists (
			select * from clm_adjusterassignments a where claimptr = @theClaim and
			a.adjusterskilltypeptr = 9 and a.EmployeePTR > 0)			
end
END

GO

/****** Object:  StoredProcedure [dbo].[sp_updateclaimmaster]    Script Date: 04/15/2011 10:29:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		J. Steve Witt
-- Create date: 02/24/2011
-- Description:	Update the claim master
-- =============================================
CREATE PROCEDURE [dbo].[sp_updateclaimmaster]
	  @ClaimNu		int,
      @PolicyNu		varchar(16) = null,
      @DOL			datetime = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
declare
	@oldPolicy int,
	@oldDOL datetime, 
	@maxId int, 
	@maxClaimnumber varchar(18),
	@newClaimnumber varchar(18), 
	@rowct int, 
	@theChar varchar(1),
	@newChar varChar(1)
if @PolicyNu is null and @DOL is null goto SkipIT

if @PolicyNu is null goto JustDate

if @DOL is null
	select @DOL = dateofloss from clm_claimmaster where id = @ClaimNu
--
-- we need to determine if there is a dup claim for this policy on the dol
--
select @rowct = count(id) from clm_claimmaster
			where policynumber = @PolicyNu and 
			cast(convert(nvarchar(8), dateofloss, 112) as datetime) = cast(convert(nvarchar(8), @DOL, 112) as datetime)
			group by policynumber, datepart(dayofyear, dateofloss)
--select @rowct
--  find the dups
if (@rowct is null)
begin
	set @newClaimnumber = convert(nvarchar(8),@policynu) + '-' + convert(varchar(10), @DOL, 110)
end
else
begin
	if (@rowct = 1)
	begin
		set @newClaimnumber = convert(nvarchar(8),@policynu) + '-' + convert(varchar(10), @DOL, 110) + 'B'
	end
	else
	begin
		select @maxId=max(id) from clm_claimmaster
				where policynumber = @PolicyNu and 
				cast(convert(nvarchar(8), dateofloss, 112) as datetime) = cast(convert(nvarchar(8), @DOL, 112) as datetime)
		select @maxClaimnumber=claimnumber from clm_claimmaster where id = @maxId
		--
		-- the claimnumber is the policy number + dol so we should be able to get the last charactor
		--
		if len(@maxClaimnumber) = len(@PolicyNu) + 11 set @theChar = 'A' 
		else
		select @theChar = substring(@maxClaimnumber, len(@PolicyNu) + 12, 1)
		if @theChar = 'Z' set @newChar = ''
		else begin
			set @newChar = Char(ascii(@theChar) + 1)
		end
		set @newClaimnumber = convert(nvarchar(8),@policynu) + '-' + convert(varchar(10), @DOL, 110) + @newChar
	end
end
update clm_claimmaster set policynumber = @PolicyNu, DateOfLoss = @DOL, claimnumber = @newClaimnumber where id = @ClaimNu
--print 'update the policy nu and claimnumber ' + @newClaimnumber
select 0 returnval
return
JustDate:
--
--  do we have a change in the day of the loss
--  or is it just a change in the time in which case there is no
--  change
--
if @DOL is null goto SkipIT
select @PolicyNu = PolicyNumber, @oldDOL = dateofloss from clm_claimmaster where id = @ClaimNu
--select @PolicyNu, @oldDol Original, @DOL newDate, datediff(day, @DOL, @oldDOL)
if (select datediff(day, @DOL, @oldDOL)) = 0 goto SkipIT
--
-- we need to determine if there is a dup claim for this policy on the dol
--
select @rowct = count(id) from clm_claimmaster
			where policynumber = @PolicyNu and 
			cast(convert(nvarchar(8), dateofloss, 112) as datetime) = cast(convert(nvarchar(8), @DOL, 112) as datetime)
			group by policynumber, datepart(dayofyear, dateofloss)
--select @rowct
--  find the dups
if (@rowct is null)
begin
	set @newClaimnumber = convert(nvarchar(8),@policynu) + '-' + convert(varchar(10), @DOL, 110)
end
else
begin
	if (@rowct = 1)
	begin
		set @newClaimnumber = convert(nvarchar(8),@policynu) + '-' + convert(varchar(10), @DOL, 110) + 'B'
	end
	else
	begin
		select @maxId=max(id) from clm_claimmaster
				where policynumber = @PolicyNu and 
				cast(convert(nvarchar(8), dateofloss, 112) as datetime) = cast(convert(nvarchar(8), @DOL, 112) as datetime)
--		select @maxId
		select @maxClaimnumber=claimnumber from clm_claimmaster where id = @maxId
		--
		-- the claimnumber is the policy number + dol so we should be able to get the last charactor
		--
		if len(@maxClaimnumber) = len(@PolicyNu) + 11 set @theChar = 'A' 
		else
		select @theChar = substring(@maxClaimnumber, len(@PolicyNu) + 12, 1)
		if @theChar = 'Z' set @newChar = ''
		else begin
			set @newChar = Char(ascii(@theChar) + 1)
		end
		set @newClaimnumber = convert(nvarchar(8),@policynu) + '-' + convert(varchar(10), @DOL, 110) + @newChar
	end
end
update clm_claimmaster set DateOfLoss = @DOL, claimnumber = @newClaimnumber where id = @ClaimNu
--print 'update the date and claimnumber ' + @newClaimnumber
select 0 returnval
return

SkipIT:
--print 'Forget it'
select -1 returnval
return
END

GO

/****** Object:  StoredProcedure [dbo].[sp_voidreservepayments]    Script Date: 04/15/2011 10:29:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_voidreservepayments] 
      @PayPtr int
AS
BEGIN
      -- SET NOCOUNT ON added to prevent extra result sets from
      -- interfering with SELECT statements.
      SET NOCOUNT ON;

declare @myPayId        int,
      @myResPtr         int, 
      @myResAmt         int

-- set the voided column on the clm_payment
update CLM_Payment
      set Voided = 1, Approved = 0, VoidedDateTime = getdate()
      where id = @PayPtr 
-- use the payment id for the parts rows to back out
--select @myPayId = id from CLM_Payment
--      where ClaimPtr = @CMastPtr and
--		(paymentdatetime > @PayDt and paymentdatetime < @PaydtEnd )
-- the following is a collection of payments to back out of the reserves
declare myPartscursor cursor for
select reserveptr, amountpaid from clm_paymentParts where PaymentPtr = @PayPtr

open myPartscursor
fetch next from myPartscursor into @myResPtr, @myResAmt
while (@@fetch_status = 0)
begin
      update clm_reserve set AmountPaid = AmountPaid - @myResAmt, ReserveOpen = 1, ClosedOn = null  where id = @myResPtr
      fetch next from myPartscursor into @myResPtr, @myResAmt
end
close myPartscursor
deallocate myPartscursor

END


GO

