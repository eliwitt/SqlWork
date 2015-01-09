declare @Debug int, 
	@MyKey int, 
	@PerPtr int, 
	@MedProPtr int,
	@PeoplePtr	int,
	@AttPtr	int, 
	@ShopPtr	int
-- define the table data fields
declare
	@Entity	int,
	@FNam	varchar(32),
	@MNam	varchar(32), 
	@LNam	Varchar(32),
	@SufID	int,
	@TileID	int,
	@WrkPh	varchar(16),
	@Email	varchar(128),
	@ProTy	int
--
-- 0=Medical Clinic
-- 1=Firm
--
set @Entity=1
set @PeoplePtr = 2
set @FNam='Peter'
set	@MNam='M'
set	@LNam='Rabbit'
set	@SufID=2
set	@TileID=7
set	@WrkPh='6804561278'
set	@Email='pRabbit@hotmail.com'
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
TitleID, WorkPhone, EmailAddress)
values(@PerPtr, @FNam, @MNam, @LNam, @SufID, @TileID, @WrkPh, @Email)
--
-- Which set of entity tables
--
if @Entity=0 goto Clinic
if @Entity=1 goto Firm
goto ErrorRt
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