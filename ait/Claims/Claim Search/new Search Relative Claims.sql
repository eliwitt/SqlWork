declare @ClaimMast	int,
	@PolicyNu		varchar(16),
	@theYear		nvarchar(4),
	@theMake		nvarchar(50),
	@theModel		nvarchar(50),
	@vin			nvarchar(60),
	@First			varchar(32),
	@Last			varchar(32),
	@SSN			varchar(11),
	@License		varchar(16)
--select @ClaimMast = MAX(id) from clm_claimmaster where ClaimNumber = '9333-08-01-2010'
set @ClaimMast = 15
select @PolicyNu = LTrim(RTrim(PolicyNumber)) from CLM_ClaimMaster where ID = @ClaimMast
--
--  Collect the vehicles in the claim
--
BEGIN TRY
  DROP TABLE #myCars
END TRY
BEGIN CATCH
  PRINT '#myCars does not exist'
END CATCH
create table #myCars
(
	vehYear		nvarchar(4),
	vehMake		nvarchar(50),
	vehModel	nvarchar(50),
	vehVin		nvarchar(60)
) insert into #myCars(vehYear,vehMake, vehModel, vehVin)
select [Year], Make, Model, Vin from clm_claimvehicle
where claimmasterPTR = @ClaimMast And (disabled = 0 Or disabled Is null)
order by vehiclenumber
--
-- collect the people from the claim
--
BEGIN TRY
  DROP TABLE #myPeople
END TRY
BEGIN CATCH
  PRINT '#myPeople does not exist'
END CATCH
create table #myPeople
(
	FirstName	varchar(32),
	Lastname	varchar(32),
	SSN			varchar(11),
	License		varchar(16)
) insert into #myPeople(FirstName, Lastname, SSN, License)
select person.FirstName, person.lastname, 
	person.ssn, person.LicenseNumber
from clm_vehiclepassenger vehpass 
	join clm_involvedparty party on vehpass.involvedpartyptr = party.id
	join clm_person person on party.personptr = person.id 
where vehpass.claimmasterPTR = @ClaimMast And (vehpass.disabled = 0 Or vehpass.disabled Is null)
order by vehpass.vehiclenumber

insert into #myPeople(FirstName, Lastname, SSN, License)
select person.FirstName, person.lastname, 
	person.ssn, person.LicenseNumber
from clm_otherproperty prop 
	join clm_involvedparty party on prop.involvedpartyptr = party.id 
	join clm_person person on party.personptr = person.id 
where prop.claimmasterPTR = @ClaimMast And (prop.disabled = 0 Or prop.disabled Is null) 
 order by prop.id 
-- ====================================================================
-- dump the tables
--
--
-- collection of search results
--
BEGIN TRY
  DROP TABLE #myResults
END TRY
BEGIN CATCH
  PRINT '#myResults does not exist'
END CATCH
create table #myResults
(
	id			int,
	cmnu		varchar(20),
	artifact	int,
	arttext		varchar(120)
) insert into #myResults(id, cmnu, artifact, arttext)
select id, ClaimNumber, 1, 'Policy Number' as Linkedby from CLM_ClaimMaster where PolicyNumber like @PolicyNu + '%' and ID <> @ClaimMast
--select * from #myPeople
--
-- go through the vehicles 
--
-- the following is a collection of the policy's vehicles
--
declare myVehcursor cursor for
select vehYear, vehMake, vehModel, vehVin from #myCars
open myVehcursor

fetch next from myVehcursor into @theYear, @theMake, @theModel, @vin
while (@@fetch_status = 0)
begin
	-- search for the vehchiles
	--
	--  weak
	insert into #myResults(id, cmnu, artifact, arttext)
	select cv.ClaimMasterPTR as id, cm.claimnumber, 2, 'Vehicle(' + cv.[YEAR] + ' ' + cv.Make + ' ' + cv.Model + ')' as LinkedBy
	from CLM_ClaimVehicle cv
	join CLM_ClaimMaster cm on cv.ClaimMasterPTR = cm.id
	where cv.[Year] = @theYear and cv.Make = @theMake and cv.Model = @theModel and cm.ID <> @ClaimMast
	--
	-- stronger
	if not @vin in ('', 'unkn', 'unknown')
		insert into #myResults(id, cmnu, artifact, arttext)
		select cv.ClaimMasterPTR as id, cm.claimnumber, 2, 'Vehicle(' + cv.vin + ')' as LinkedBy
		from CLM_ClaimVehicle cv
		join CLM_ClaimMaster cm on cv.ClaimMasterPTR = cm.id
		where cv.vin = @vin and cm.ID <> @ClaimMast
	
    fetch next from myVehcursor into @theYear, @theMake, @theModel, @vin
end
close myVehcursor
deallocate myVehcursor

-- Now search for the people
--
declare myDvrcursor cursor for
	select FirstName, Lastname,	SSN, License from #myPeople

open myDvrcursor
fetch next from myDvrcursor into @First, @Last,	@SSN, @License
while (@@fetch_status = 0)
begin
	--  search for people matches
	--
	-- weak
	if not RTrim(RTrim(@First) + @Last) in ('', 'unkunk', 'unknunkn', 'unknownunknown')
		insert into #myResults(id, cmnu, artifact, arttext)
		select vehpass.ClaimMasterPTR as id, cm.claimnumber, 3,
		case party.LossRoleid when 1 then 
			case party.Owner when 1 then
			'Owner(' + RTrim(person.FirstName) + ' ' + RTrim(person.lastname) + ')'
			else
			'Driver(' + RTrim(person.FirstName) + ' ' + RTrim(person.lastname) + ')'
			end
		when 2 then
			case party.Owner when 1 then
			'Owner(' + RTrim(person.FirstName) + ' ' + RTrim(person.lastname) + ')'
			else
			'Passenger(' + RTrim(person.FirstName) + ' ' + RTrim(person.lastname) + ')'
			end
		when 5 then
			'Owner(' + RTrim(person.FirstName) + ' ' + RTrim(person.lastname) + ')'		
		else
			'Other(' + RTrim(person.FirstName) + ' ' + RTrim(person.lastname) + ')'
		end as Linkedby
		from clm_person person
		join clm_involvedparty party on person.id = party.PersonPTR
		join clm_vehiclepassenger vehpass on party.ID = vehpass.InvolvedPartyPTR
		join CLM_ClaimMaster cm on vehpass.ClaimMasterPTR = cm.id
		where RTrim(RTrim(person.FirstName) + ' ' + person.LastName) = RTRIM(RTRIM(@First) + ' ' + @Last) and
		vehpass.claimmasterPTR <> @ClaimMast And (vehpass.disabled = 0 Or vehpass.disabled Is null)
	--
	-- stronger
	if not @SSN in ('', 'unk', 'unkn', 'unknown')
		insert into #myResults(id, cmnu, artifact, arttext)
		select vehpass.ClaimMasterPTR as id, cm.claimnumber, 3, 
		case party.LossRoleid when 1 then 
			case party.Owner when 1 then
			'Owner SSN(' + RTrim(person.FirstName) + ' ' + RTrim(person.lastname) + ')'
			else
			'Driver SSN(' + RTrim(person.FirstName) + ' ' + RTrim(person.lastname) + ')'
			end
		when 2 then
			case party.Owner when 1 then
			'Owner SSN(' + RTrim(person.FirstName) + ' ' + RTrim(person.lastname) + ')'
			else
			'Passenger SSN(' + RTrim(person.FirstName) + ' ' + RTrim(person.lastname) + ')'
			end
		when 5 then
			'Owner SSN(' + RTrim(person.FirstName) + ' ' + RTrim(person.lastname) + ')'		
		else
			'Other SSN(' + RTrim(person.FirstName) + ' ' + RTrim(person.lastname) + ')'
		end as Linkedby
		from clm_person person
		join clm_involvedparty party on person.id = party.PersonPTR
		join clm_vehiclepassenger vehpass on party.ID = vehpass.InvolvedPartyPTR
		join CLM_ClaimMaster cm on vehpass.ClaimMasterPTR = cm.id
		where person.SSN = @SSN and
		vehpass.claimmasterPTR <> @ClaimMast And (vehpass.disabled = 0 Or vehpass.disabled Is null)
	--
	-- stronger
	if not @License in ('', 'unk', 'unkn', 'unknown')
		insert into #myResults(id, cmnu, artifact, arttext)
		select vehpass.ClaimMasterPTR as id, cm.claimnumber, 3, 
		case party.LossRoleid when 1 then 
			case party.Owner when 1 then
			'Owner DL(' + RTrim(person.FirstName) + ' ' + RTrim(person.lastname) + ')'
			else
			'Driver DL(' + RTrim(person.FirstName) + ' ' + RTrim(person.lastname) + ')'
			end
		when 2 then
			case party.Owner when 1 then
			'Owner DL(' + RTrim(person.FirstName) + ' ' + RTrim(person.lastname) + ')'
			else
			'Passenger DL(' + RTrim(person.FirstName) + ' ' + RTrim(person.lastname) + ')'
			end
		when 5 then
			'Owner DL(' + RTrim(person.FirstName) + ' ' + RTrim(person.lastname) + ')'		
		else
			'Other DL(' + RTrim(person.FirstName) + ' ' + RTrim(person.lastname) + ')'
		end as Linkedby
		from clm_person person
		join clm_involvedparty party on person.id = party.PersonPTR
		join clm_vehiclepassenger vehpass on party.ID = vehpass.InvolvedPartyPTR
		join CLM_ClaimMaster cm on vehpass.ClaimMasterPTR = cm.id
		where person.LicenseNumber = @License and
		vehpass.claimmasterPTR <> @ClaimMast And (vehpass.disabled = 0 Or vehpass.disabled Is null)	
	-- check the properies --------------------------------------------------------------
	if not RTrim(RTrim(@First) + @Last) in ('', 'unkunk', 'unknunkn', 'unknownunknown')
		insert into #myResults(id, cmnu, artifact, arttext)
		select prop.ClaimMasterPTR as id, cm.claimnumber, 4,
			'Property(' + RTrim(person.FirstName) + ' ' + RTrim(person.lastname) + ')' as LinkedBy
		from clm_person person
		join clm_involvedparty party on person.id = party.PersonPTR 
		join clm_otherproperty prop on party.ID = prop.InvolvedPartyPTR
		join CLM_ClaimMaster cm on prop.ClaimMasterPTR = cm.id
		where RTrim(RTrim(person.FirstName) + ' ' + person.LastName) = RTRIM(RTRIM(@First) + ' ' + @Last) and
		prop.claimmasterPTR <> @ClaimMast And (prop.disabled = 0 Or prop.disabled Is null) 
	--
	-- stronger SSN
	if not @SSN in ('', 'unk', 'unkn', 'unknown')
		insert into #myResults(id, cmnu, artifact, arttext)
		select prop.ClaimMasterPTR as id, cm.claimnumber, 4,
			'Property SSN(' + RTrim(person.FirstName) + ' ' + RTrim(person.lastname) + ')' as LinkedBy
		from clm_person person
		join clm_involvedparty party on person.id = party.PersonPTR 
		join clm_otherproperty prop on party.ID = prop.InvolvedPartyPTR
		join CLM_ClaimMaster cm on prop.ClaimMasterPTR = cm.id
		where person.SSN = @SSN and
		prop.claimmasterPTR <> @ClaimMast And (prop.disabled = 0 Or prop.disabled Is null) 					

	--
	-- stronger SSN
	if not @License in ('', 'unk', 'unkn', 'unknown')
		insert into #myResults(id, cmnu, artifact, arttext)
		select prop.ClaimMasterPTR as id, cm.claimnumber, 4,
			'Property DL(' + RTrim(person.FirstName) + ' ' + RTrim(person.lastname) + ')' as LinkedBy
		from clm_person person
		join clm_involvedparty party on person.id = party.PersonPTR 
		join clm_otherproperty prop on party.ID = prop.InvolvedPartyPTR
		join CLM_ClaimMaster cm on prop.ClaimMasterPTR = cm.id
		where person.LicenseNumber = @License and
		prop.claimmasterPTR <> @ClaimMast And (prop.disabled = 0 Or prop.disabled Is null)		
			
	--  bottom of loop ------------------------------		
	fetch next from myDvrcursor into @First, @Last,	@SSN, @License
end
close myDvrcursor
deallocate myDvrcursor

select distinct * from #myResults order by cmnu, artifact

BEGIN TRY
  DROP TABLE #myCars
END TRY
BEGIN CATCH
  PRINT '#myCars does not exist'
END CATCH
BEGIN TRY
  DROP TABLE #myPeople
END TRY
BEGIN CATCH
  PRINT '#myPeople does not exist'
END CATCH
BEGIN TRY
  DROP TABLE #myResults
END TRY
BEGIN CATCH
  PRINT '#myResults does not exist'
END CATCH