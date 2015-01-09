--
-- This script will insert accient loss claims
--
declare @Debug int, 
	@MyKey int, 
	@MasterPtr int,
	@VehPtr	int,
	@PartyPtr int,
	@VehPassPtr int
-- define the table data fields
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
	@DEstimate	money
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
if @Debug > 0 Print 'Starting the insert of non-accident claims'
-- get the next key from the CLM_ClaimMaster table
select @MyKey=Max(ID) from CLM_ClaimMaster
if (@MyKey is null)
Begin
	set @MyKey=0
end
set @MasterPtr=@MyKey+1
-- insert the claim data into the claim master
if @Debug>1 Print 'Insert the ClaimMaster ' + convert(varchar(5),@MasterPtr)
-- 23 is the claim num that I am faking
insert into CLM_ClaimMaster values(@MasterPtr, @PolicyNu, @DOL, @LType, 23, '')
-- get the next key from the CLM_ClaimVehicle table
select @MyKey=Max(ID) from CLM_ClaimVehicle
if (@MyKey is null)
Begin
	set @MyKey=0
end
set @VehPtr=@MyKey+1
-- insert the claim data into the claim master
if @Debug>1 Print 'Insert the Vehicle ' + convert(varchar(5),@VehPtr)
insert into CLM_ClaimVehicle values(@VehPtr, @MasterPTR, @VehNu, @OurVeh, 0, @VehYr, @Make, @Model, '', @OurDrv, 0, @DDesc, @DEstimate)
--
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
insert into clm_involvedparty values(@PartyPtr, 0, 1, 'Slid on the ice', 1, 1, 'Hurt my toe', 0, 0, 1, 1)
-- get the next key from the CLM_VehiclePassenger table
select @MyKey=Max(ID) from CLM_VehiclePassenger
if (@MyKey is null)
Begin
	set @MyKey=0
end
set @VehPassPtr=@MyKey+1
if @Debug>1 Print 'Insert the Veh Pass ' + convert(varchar(5),@VehPassPtr)
insert into CLM_VehiclePassenger values(@VehPassPtr, @MasterPTR, @VehNu, @OurVeh, @PartyPtr)
if @Debug > 0 Print 'End of accident claims'
