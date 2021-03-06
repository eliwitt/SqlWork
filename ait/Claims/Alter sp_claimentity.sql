USE [ClaimsSchema]
GO
/****** Object:  StoredProcedure [dbo].[sp_claimentity]    Script Date: 09/15/2010 08:14:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_claimentity] 

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

      @trapped          int,

      @ErrorMsg         varchar(255)

-- Entity should be one of the following:

-- 0=Medical Clinic

-- 1=Firm

-- 2=BodyShop

if @Entity=0 goto StartTheProc

if @Entity=1 goto StartTheProc

if @Entity=2 goto StartTheProc

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

-- set the PerPtr from the row id just inserted

-- select @PerPtr=@@IDENTITY

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

-- set the AddrPtr from the row id just inserted

-- select @AddrPtr=@@IDENTITY

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

-- set the BizPtr from the row id just inserted

-- select @BizPtr=@@IDENTITY

--

-- Which set of entity tables

--

if @Entity=0 goto Clinic

if @Entity=1 goto Firm

if @Entity=2 goto Shop

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

-- set the MedClinicPtr from the row id just inserted

-- select @MedClinicPtr=@@IDENTITY

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

-- set the MedProPtr from the row id just inserted

-- select @MedProPtr=@@IDENTITY

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

-- set the MedClinicPtr from the row id just inserted

-- select @MedClinicPtr=@@IDENTITY

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

-- set the MedProPtr from the row id just inserted

-- select @MedProPtr=@@IDENTITY

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

