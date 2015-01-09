declare @Debug          int, 
	  @MyKey			int,
      @PerPtr           int,
      @AddrPtr          int,
      @BizPtr           int,
	  @ApprPtr			int,
	  @ZipPtr			int,
      @trapped          int,
      @FNam				varchar(32),
      @MNam				varchar(32), 
      @LNam				Varchar(32),
      @SufID			int,
      @TileID			int,
      @DOB				datetime,
      @Gender			int,
      @Married			int,
      @SSN				varchar(11), 
      @LiceNu			varchar(16),
      @LiceSt			char(2),
      @HomePh			varchar(16),
      @CellPh			varchar(16),
      @BizPh			varchar(16),
      @WrkPh			varchar(16),
      @Email			varchar(128),
	  @Zipcode			varchar(5),
	  @Addr1			varchar(128),
	  @Addr2			varchar(128),
	  @BizNam			varchar(128),
	  @FedTaxID			varchar(11),
      @ErrorMsg         varchar(255)
set @debug = 1
--  the contact person
set @Fnam = 'Isaac'
set @MNam = ''
set @LNam = 'Sparrow'
set @SufID = 0
set @TileID = 0
set @DOB = ''
set @Gender = 0
set @Married = 0
set @SSN = ''
set @LiceNu = ''
set @LiceSt = ''
set @HomePh = ''
set @CellPh = ''
set @WrkPh = ''
set @Email = 'USappraisals10@yahoo.com'
--  Biz address
set @Addr1 = '1528 Sierra Vista Drive'
set @Addr2 = ''
set @Zipcode = '70815'
--  Biz info
set @BizNam = 'US Appraisal Service'
set @FedTaxID = '438-48-2343'
set @BizPh = ''

------------------------------------------  person  --------------------------------
-- insert the contact clm_person
-- get the next key from the CLM_Person table
select @MyKey=Max(ID) from CLM_Person
if (@MyKey is null)
Begin
      set @MyKey=0
end
set @PerPtr=@MyKey+1
-- insert the Person data
if @Debug = 1 Print 'Insert the CLM Person ' + convert(varchar(5),@PerPtr)

insert into CLM_Person 
values(@PerPtr, @FNam, @MNam, @LNam, @SufID, @TileID, @DOB, @Gender, @Married, @SSN, @LiceNu, @LiceSt, @HomePh, @CellPh, @WrkPh, @Email)

if (@@error <> 0)
begin
      set @trapped = 20
      set @ErrorMsg = 'Error attempting to insert the clm_person row '
      goto Error_Handler
end
----------------------------------------------  address ------------------------------
-- get the zip code ptr
if exists(select top 1 id from zipinfo where zipcode = @Zipcode)
begin
	select top 1 @ZipPtr = id from zipinfo where zipcode = @Zipcode
end
else
begin
	set @ZipPtr = 0
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
insert into CLM_Address values(@AddrPtr, @Addr1, @Addr2, @ZipPtr, @BizPh)

if (@@error <> 0)
begin
      set @trapped = 30
      set @ErrorMsg = 'Error attempting to insert the clm_address row '
      goto Error_Handler
end
---------------------------------------------  Business info ---------------------
-- get the next key from the CLM_BusinessEntity table
select @MyKey=Max(ID) from CLM_BusinessEntity
if (@MyKey is null)
Begin
      set @MyKey=0
end
set @BizPtr=@MyKey+1
-- insert the biz data
if @Debug=1 Print 'Insert the Biz ' + convert(varchar(5),@BizPtr)
insert into CLM_BusinessEntity values(@BizPtr, @BizNam, @AddrPtr, @PerPtr, @FedTaxID)

if (@@error <> 0)
begin
      set @trapped = 30
      set @ErrorMsg = 'Error attempting to insert the clm_biz row '
      goto Error_Handler
end
---------------------------------------------  Appriaser ---------------------
-- get the next key from the CLM_Appriaser table
select @MyKey=Max(ID) from CLM_Appriaser
if (@MyKey is null)
Begin
      set @MyKey=0
end
set @ApprPtr=@MyKey+1
-- insert the biz data
if @Debug=1 Print 'Insert the Appriaser ' + convert(varchar(5),@ApprPtr)
insert into CLM_Appriaser values(@ApprPtr, @BizPtr)

if (@@error <> 0)
begin
      set @trapped = 30
      set @ErrorMsg = 'Error attempting to insert the clm_appriaser row '
      goto Error_Handler
end

--
-- bottom of the script
--
Error_Handler:
select @trapped errornu, @ErrorMsg msg