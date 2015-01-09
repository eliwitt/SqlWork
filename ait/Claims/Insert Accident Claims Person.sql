--
-- This script will insert accient loss claims
--
declare @Debug int, 
	@MyKey int, 
	@MasterPtr int,
	@VehPtr	int,
	@PartyPtr int,
	@PerPtr int,
	@VehPassPtr int
-- define the table data fields for the claim
declare
	@PolicyNu int,
	@DOL	datetime,
	@LType	int,
	@VehNu	int, 
	@OurVeh	int, 
	@VehYr	nvarchar(4), 
	@Make	nvarchar(50), 
	@Model	nvarchar(50), 
	@OurDrv	int, 
	@DDesc	nvarchar(512),
	@DEstimate	money,
	@Lossid	int,
	@AccDesc	nvarchar(512),
	@Injured	int,
	@Severtyid	int,
	@InjDesc	nvarchar(512),
	@Rep	int,
	@Attid	int,
	@Treat	int,
	@Medid	int
-- define the clm_person fields
declare
	@FNam	varchar(32),
	@MNam	varchar(32), 
	@LNam	Varchar(32),
	@SufID	int,
	@TileID	int,
	@DOB datetime,
	@Gender	int,
	@Married	int,
	@SSN	varchar(11), 
	@LiceNu	varchar(16),
	@LiceSt	char(2),
	@HomePh	varchar(16),
	@CellPh	varchar(16),
	@WrkPh	varchar(16),
	@Email	varchar(128)
--  claim fields
set @PolicyNu = '1033'
set	@DOL = '1/13/2011'
set	@LType = 1
set	@VehNu = 1
set	@OurVeh = 2 
set	@VehYr = '2005'
set	@Make = 'Witt'
set	@Model = 'Steve'
set	@OurDrv	= 0
set	@DDesc = 'Ice'
set	@DEstimate = 100.23
set @Lossid = 1
set @AccDesc = 'Slid on the ice'
set @Injured = 1
set @Severtyid = 1
set @InjDesc = 'Hurt my toe'
set @Rep = 0
set @Attid = 0
set @Treat = 1
set @Medid = 1
--  clm_person fields
set @FNam='Tom'
set	@MNam='T'
set	@LNam='Hall'
set	@SufID=2
set	@TileID=7
set	@DOB = '1/18/1959'
set	@Gender	= 1
set	@Married = 1
set	@SSN = '231778812' 
set	@LiceNu	= 'wed1234to0123456'
set	@LiceSt	= 'OH'
set	@HomePh	= '5132347812'
set	@CellPh	= '9372315612'
set	@WrkPh='6804561278'
set	@Email='tthall@hotmail.com'
--exec sp_insertperson 1, @VehNu, @OurDrv, @Lossid, @AccDesc, @Injured, @Severtyid, @InjDesc,
--	@Rep, @Attid, @Treat, @Medid, @FNam, @MNam, @LNam, @SufID, @TileID, @DOB, @Gender, @Married,
--	@SSN, @LiceNu, @LiceSt, @HomePh, @CellPh, @WrkPh, @Email
--exec sp_insertclaimveh 1, @VehNu, @OurVeh, @VehYr, @Make, @Model, @DDesc, @DEstimate
--exec sp_fileclaim @PolicyNu, @DOL, @LType
-- exec sp_insert_nonaccidents @PolicyNu, @DOL, @LType, @VehNu, @OurVeh, @VehYr, @Make, @Model, @OurDrv, @DDesc, @DEstimate
--
-- Debug can be 
--
-- 0 for off
-- 1 for general
-- 2 detail
set @Debug=2
if @Debug > 0 Print 'Starting the insert of accident people'
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
--  now let's add a driver
--
-- get the next key from the CLM_InvolvedParty table
select @MyKey=Max(ID) from CLM_InvolvedParty
if (@MyKey is null)
Begin
	set @MyKey=0
end
set @PartyPtr=@MyKey+1
if @Debug>1 Print 'Insert the Involved Party ' + convert(varchar(5),@PartyPtr)
insert into clm_involvedparty values(@PartyPtr, @PerPtr, 1, 'Slid on the ice', 1, 1, 'Hurt my toe', 0, 0, 1, 1)
-- get the next key from the CLM_VehiclePassenger table
select @MyKey=Max(ID) from CLM_VehiclePassenger
if (@MyKey is null)
Begin
	set @MyKey=0
end
set @VehPassPtr=@MyKey+1
if @Debug>1 Print 'Insert the Veh Pass ' + convert(varchar(5),@VehPassPtr)
insert into CLM_VehiclePassenger values(@VehPassPtr, 1, @VehNu, @OurVeh, @PartyPtr)
if @Debug > 0 Print 'End of accident claims'
