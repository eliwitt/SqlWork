declare @myPolicy	nvarchar(16), 
		@theVeh		int, 
		@ClaimPtr	int, 
		@drvidx		int,
		@myIndx		int,
		@FullNam	nvarchar(60),
		@mydate		datetime
select top 1 @ClaimPtr = id from CLM_ClaimMaster where PolicyNumber = '10068'
if @ClaimPtr is null
begin
	print 'Pick a different policy'
	return
end
--select @drvidx =OurDriverIndex from clm_vehiclepassenger where ClaimMasterPTR = @ClaimPtr 
-- and VehicleNumber = 1 and (disabled = 0 or disabled is null)
--set @drvidx = 2
select @myPolicy=PolicyNumber from clm_claimmaster cm
		left join clm_ClaimVehicle cv on cm.id = cv.claimmasterptr and cv.vehiclenumber = 1
	where cm.id = @ClaimPtr 
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
-- the following is a collection of the policy's drivers
declare myDvrcursor cursor for
select id, FullNam from #myDrivers

open myDvrcursor
fetch next from myDvrcursor into @myIndx, @FullNam
while (@@fetch_status = 0)
begin
      print 'Dr Nu ' + cast(@myIndx as nvarchar(3)) + ' ' + @FullNam
      fetch next from myDvrcursor into @myIndx, @FullNam
end
close myDvrcursor
deallocate myDvrcursor
drop table #myDrivers