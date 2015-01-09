declare @myPolicy	nvarchar(16), 
		@theVeh		int, 
		@vehDesc	nvarchar(60), 
		@ClaimPtr	int, 
		@drvidx		int, 
		@FullNam	nvarchar(60),		
		@mydate		datetime,
		@vin		nvarchar(60)

select top 1 @ClaimPtr = id from CLM_ClaimMaster where PolicyNumber = '9333'
if @ClaimPtr is null
begin
	print 'Pick a different policy'
	return
end
select @drvidx =OurDriverIndex from clm_vehiclepassenger where ClaimMasterPTR = @ClaimPtr 
 and VehicleNumber = 1 and (disabled = 0 or disabled is null)
--set @drvidx = 2
select @myPolicy=PolicyNumber, @theVeh=cv.OurVehicleIndex, @mydate = dateofloss from clm_claimmaster cm
		left join clm_ClaimVehicle cv on cm.id = cv.claimmasterptr and cv.vehiclenumber = 1
	where cm.id = @ClaimPtr 
select @ClaimPtr id, @myPolicy Policy, @mydate dol, @theVeh Vehicle, @drvidx OurDrv
select effectivedate, expirationdate from GoAutoProd.dbo.Policy where policynumber = @myPolicy
--
-- Retrieve the Policy vehicles
--
create table #myCars
(
	id int,
	vehDesc nvarchar(60),
	vin nvarchar(60)
)
insert into #myCars(id, vehDesc, vin) exec GoAutoProd.dbo.Sp_Claims_GetVehicleList @myPolicy
--
-- Retrieve the Policy Drivers
--
create table #myDrivers
(
	id int,	FullNam nvarchar(70), FirstNam nvarchar(40), LastNam nvarchar(40), Old int,
	Born nvarchar(40), GenderId int, martialstat int, addr1 nvarchar(65), citynam nvarchar(65),
	stateaddr nvarchar(5), zipcode nvarchar(10), zipinfoptr int, homephone nvarchar(20), cellphone nvarchar(20),
	workphone nvarchar(20), dlnumber nvarchar(20), dlstate nvarchar(5), ssn nvarchar(25), email nvarchar(200)
)
insert into #myDrivers(id, FullNam, FirstNam, LastNam, 
	Old, Born, GenderId, martialstat, addr1, citynam,
	stateaddr, zipcode, zipinfoptr, homephone, cellphone,
	workphone, dlnumber, dlstate, ssn, email
	) exec GoAutoProd.dbo.Sp_Claims_GetDriverList @myPolicy
select COUNT(*) 'Total claim vehicles' from #myCars
select COUNT(*) 'Total claim drivers' from #myDrivers
--
-- go through the vehicles and drivers
--
-- the following is a collection of the policy's vehicles
--
declare myVehcursor cursor for
select id, vehDesc, vin from #myCars
open myVehcursor

fetch next from myVehcursor into @theVeh, @vehDesc, @vin
while (@@fetch_status = 0)
begin
	--
	-- Now using the vehicle and driver determine the coverage for each
	--
	declare myDvrcursor cursor for
		select id, FullNam from #myDrivers

	open myDvrcursor
	fetch next from myDvrcursor into @drvidx, @FullNam
	while (@@fetch_status = 0)
	begin
		select @drvidx Number, @FullNam Name, GoAutoProd.dbo.F_Claims_IsDriverExcluded(@myPolicy, @mydate, @theVeh, @drvidx) DrvExcluded,
			GoAutoProd.dbo.F_Claims_IsPolicyActive(@myPolicy, @mydate) PolicyInForce,
			GoAutoProd.dbo.F_Claims_IsCoverageActive(@myPolicy, @mydate, @theVeh, @drvidx, 1) LIPD, 
			GoAutoProd.dbo.F_Claims_IsCoverageActive(@myPolicy, @mydate, @theVeh, @drvidx, 2) LIBI, 
			GoAutoProd.dbo.F_Claims_IsCoverageActive(@myPolicy, @mydate, @theVeh, @drvidx, 4) COLL, 
			GoAutoProd.dbo.F_Claims_IsCoverageActive(@myPolicy, @mydate, @theVeh, @drvidx, 5) TOWG, 
			GoAutoProd.dbo.F_Claims_IsCoverageActive(@myPolicy, @mydate, @theVeh, @drvidx, 6) RENT, 
			GoAutoProd.dbo.F_Claims_IsCoverageActive(@myPolicy, @mydate, @theVeh, @drvidx, 7) MED,
			GoAutoProd.dbo.F_Claims_IsCoverageActive(@myPolicy, @mydate, @theVeh, @drvidx, 8) UMBI,
			GoAutoProd.dbo.F_Claims_IsCoverageActive(@myPolicy, @mydate, @theVeh, @drvidx, 9) UMPD
		fetch next from myDvrcursor into @drvidx, @FullNam
	end
	close myDvrcursor
	deallocate myDvrcursor

    fetch next from myVehcursor into @theVeh, @vehDesc, @vin
end
close myVehcursor
deallocate myVehcursor
drop table #myDrivers
drop table #myCars