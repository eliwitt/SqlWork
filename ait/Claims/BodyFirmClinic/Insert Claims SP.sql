declare @Debug int, 
	@MyKey int, 
	@PerPtr int, 
	@AddrPtr int, 
	@BizPtr int, 
	@MedClinicPtr int, 
	@MedProPtr int,
	@FirmPtr	int,
	@AttPtr	int, 
	@ShopPtr	int
-- define the table data fields
declare
	@Entity	int,
	@bizNam	varchar(128),
	@FNam	varchar(32),
	@MNam	varchar(32), 
	@LNam	Varchar(32),
	@SufID	int,
	@TileID	int,
	@MarID	int,
	@WrkPh	varchar(16),
	@Email	varchar(128),
	@Addr1	varchar(128),
	@Addr2	varchar(128),
	@ZipPtr	int,
	@AddPh	varchar(16),
	@FedID	varchar(11),
	@HrRate	money,
	@EntTy	int,
	@ProTy	int
--
-- 0=Medical Clinic
-- 1=Firm
-- 2=BodyShop
--
set @Entity=2
set @BizNam='Billy''s BodyShop'
set @FNam='Peter'
set	@MNam='M'
set	@LNam='Todd'
set	@SufID=2
set	@TileID=7
set	@MarID=1
set	@WrkPh='6804561278'
set	@Email='ptodd@hotmail.com'
set	@Addr1='1500 North FLW Blvd.'
set	@Addr2=''
set	@ZipPtr=0
set	@AddPh='3146459023'
set	@FedID='T345Y4576'
set @HrRate=50
set @EntTy=2
set @ProTy=1
--
set @Debug=1
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
-- set the MedClinicPtr from the row id just inserted
-- select @MedClinicPtr=@@IDENTITY
-- get the next key from the CLM_Attorney table
--select @MyKey=Max(ID) from CLM_Attorney
--if (@MyKey is null)
--Begin
--	set @MyKey=0
--end
--set @AttPtr=@MyKey+1
---- insert the MedClinic data
--if @Debug=1 Print 'Insert the Attorney ' + convert(varchar(5),@AttPtr)
--insert into CLM_Attorney (ID, AttorneyTypeID, LawFirmPTR, PersonalInfo_PersonPTR) 
--values(@AttPtr, @ProTy, @FirmPtr, @PerPtr)
-- set the MedProPtr from the row id just inserted
-- select @MedProPtr=@@IDENTITY
goto FinishInsert
--
-- Successful end of the script
--
FinishInsert:
Commit 
goto EndofScript
-- Error routine
ErrorRt:
if @Debug=1 Print 'Error the transaction will be rolled back '
rollback tran
EndofScript:
if @Debug=1 Print 'End of the inserts '