declare @ClaimMast int, @logID integer
set @logID = 20689
select  * from clm_claimlog where id = @logID
select @ClaimMast = claimid from clm_claimlog where id = @logID
select * from clm_claimmaster where id = @ClaimMast
--update clm_claimmaster set disabled = 0 where id = 146
select distinct veh.vehiclenumber, veh.[Year], veh.Make, veh.Model, veh.insureconame as InsCoNam,
	veh.insurepolicynu as InsPolNu, veh.insurecontactinfo as InsConInfo, veh.id as vehID, veh.entitynumber,
	case when veh.contacted is null then 'false' else 'true' end contacted, veh.disabled
from clm_claimvehicle veh
where veh.claimmasterPTR = @ClaimMast
order by veh.vehiclenumber

select 'Backup', * 
	from clm_personbackup
		where personptr in (
			select person.id from clm_vehiclepassenger vehpass
				join clm_involvedparty party on vehpass.involvedpartyptr = party.id
				join clm_person person on party.personptr = person.id
			where vehpass.claimmasterPTR = @ClaimMast)

select 'Passengers' as Passengers, vehpass.vehiclenumber as vehiclenumber, vehpass.involvedpartyptr, party.id, person.id, person.FirstName, person.lastname, 
	person.homephone, person.cellphone, person.workphone, person.emailaddress, party.entitynumber, party.injured, party.attorneyptr, party.lossroleid,
	case when party.contacted is null then 'false' else 'true' end contacted, vehpass.disabled
from clm_vehiclepassenger vehpass 
	join clm_involvedparty party on vehpass.involvedpartyptr = party.id
	join clm_person person on party.personptr = person.id 
where vehpass.vehiclenumber <> 0 And vehpass.claimmasterPTR = @ClaimMast
order by vehpass.vehiclenumber
		
--select 'others' as others, prop.id, prop.propertydesc, prop.damageestimate, prop.insureconame, prop.insurepolicynu, prop.insurecontactinfo, 
--prop.entitynumber, person.id as perID, person.FirstName, person.lastname, 
--person.suffixid, stext.[desc] as sdesc, person.titleid, ttext.[desc] as tdesc, person.dateofbirth, person.genderid, 
--person.maritalstatusid, person.ssn, person.licensenumber, person.licensestate, person.homephone, 
--person.cellphone, person.workphone, person.emailaddress, 
--party.id as invID, party.LossRoleid, ltext.[desc] as ldesc, party.AccidentDescription, party.Injured, party.InjuryDescription, 
--party.InjurySeverityId, party.Represented, party.AttorneyPTR, party.BeingTreated, party.MedicalPofessionalPTR, 
-- case when prop.contacted is null then 'false' else 'true' end contacted, prop.contacted contactdt,
-- addr.addressline1, addr.addressline2, addr.zipinfoptr, myCode.CityName + ', ' + myCode.StateAbbr locnam, myCode.Zipcode, 
-- reserve.CoverageID, reserve.reserveopen resstatus, reserve.initialreserveamount myreserve, reserve.OpenedOn, reserve.ClosedOn 
--from clm_otherproperty prop 
--	join clm_involvedparty party on prop.involvedpartyptr = party.id 
--	join clm_person person on party.personptr = person.id 
--	left join clm_address addr on party.addressptr = addr.id 
--   left join ZipInfo myCode on addr.Zipinfoptr = myCode.id 
--   left join clm_title ttext on person.titleid = ttext.id 
--   left join clm_suffix stext on person.suffixid = stext.id 
--   left join clm_lossrole ltext on party.LossRoleid = ltext.id 
--   left join clm_reserve reserve on party.entitynumber = reserve.entitynumber and prop.claimmasterPTR = reserve.claimnumber 
--where prop.claimmasterPTR = @ClaimMast And (prop.disabled = 0 Or prop.disabled Is null) 
-- order by prop.id 
--
--select id, claimnumber, entitynumber, Coverageid, (select [desc] from clm_coverage where id = Coverageid) CoverDesc, 
--	reserveopen, openedon, closedon, AmountPaid, forcedclosed from clm_reserve where claimnumber = @ClaimMast