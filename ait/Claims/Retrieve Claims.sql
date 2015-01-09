declare @ClaimMast int
--select @ClaimMast = MAX(id) from clm_claimmaster where ClaimNumber = '30883-06-08-2011'
-- dup problem 4140 4135 4576 4837
-- data problem claim closed 3097
-- dev3 86 283
-- projecttracking 154, 169, 171, 172
-- reserve issue 6/20 58555-06-17-2011 (8652) and 45517-03-16-2011 (5657)
set @ClaimMast = 1390
--update clm_claimmaster set disabled = 0 where id = 1
select * from clm_claimmaster where id = @ClaimMast
--update clm_claimmaster set disabled = 0 where id = 146
select distinct veh.vehiclenumber, veh.[Year], veh.Make, veh.Model, veh.insureconame as InsCoNam,
	veh.insurepolicynu as InsPolNu, veh.insurecontactinfo as InsConInfo, veh.id as vehID, veh.entitynumber, 
	veh.ourvehicleindex, veh.OurDriverIndex, veh.involvedpartyptr,
	case when veh.contacted is null then 'false' else 'true' end contacted, veh.disabled
from clm_claimvehicle veh
where veh.claimmasterPTR = @ClaimMast
order by veh.vehiclenumber

select 'Veh Person' as Passengers, vehpass.vehiclenumber as vehiclenumber, vehpass.involvedpartyptr, vehpass.OurDriverIndex, person.id, person.FirstName, person.lastname, 
	person.homephone, person.cellphone, person.workphone, person.emailaddress, party.entitynumber, party.injured, party.attorneyptr, party.lossroleid,
	case when party.contacted is null then 'false' else 'true' end contacted, vehpass.disabled
from clm_vehiclepassenger vehpass 
	join clm_involvedparty party on vehpass.involvedpartyptr = party.id
	join clm_person person on party.personptr = person.id 
where vehpass.vehiclenumber <> 0 And vehpass.claimmasterPTR = @ClaimMast
order by vehpass.vehiclenumber

select 'Others' as Passengers, vehpass.vehiclenumber as vehiclenumber, vehpass.involvedpartyptr, vehpass.OurDriverIndex, person.id, person.FirstName, person.lastname, 
	person.homephone, person.cellphone, person.workphone, person.emailaddress, party.entitynumber, party.injured, party.attorneyptr, party.lossroleid,
	case when party.contacted is null then 'false' else 'true' end contacted, vehpass.disabled
from clm_vehiclepassenger vehpass 
	join clm_involvedparty party on vehpass.involvedpartyptr = party.id
	join clm_person person on party.personptr = person.id 
where vehpass.vehiclenumber = 0 And vehpass.claimmasterPTR = @ClaimMast
order by vehpass.vehiclenumber

select 'owners' as others, prop.id, prop.propertydesc, prop.damageestimate, prop.insureconame, prop.insurepolicynu, prop.insurecontactinfo, 
prop.entitynumber, person.id as perID, person.FirstName, person.lastname, 
person.suffixid, stext.[desc] as sdesc, person.titleid, ttext.[desc] as tdesc, person.dateofbirth, person.genderid, 
person.maritalstatusid, person.ssn, person.licensenumber, person.licensestate, person.homephone, 
person.cellphone, person.workphone, person.emailaddress, 
party.id as invID, party.LossRoleid, ltext.[desc] as ldesc, party.AccidentDescription, party.Injured, party.InjuryDescription, 
party.InjurySeverityId, party.Represented, party.AttorneyPTR, party.BeingTreated, party.MedicalPofessionalPTR, 
 case when prop.contacted is null then 'false' else 'true' end contacted, prop.contacted contactdt,
 addr.addressline1, addr.addressline2, addr.zipinfoptr, myCode.CityName + ', ' + myCode.StateAbbr locnam, myCode.Zipcode, 
 reserve.CoverageID, reserve.reserveopen resstatus, reserve.initialreserveamount myreserve, reserve.OpenedOn, reserve.ClosedOn 
from clm_otherproperty prop 
	join clm_involvedparty party on prop.involvedpartyptr = party.id 
	join clm_person person on party.personptr = person.id 
	left join clm_address addr on party.addressptr = addr.id 
   left join ZipInfo myCode on addr.Zipinfoptr = myCode.id 
   left join clm_title ttext on person.titleid = ttext.id 
   left join clm_suffix stext on person.suffixid = stext.id 
   left join clm_lossrole ltext on party.LossRoleid = ltext.id 
   left join clm_reserve reserve on party.entitynumber = reserve.entitynumber and prop.claimmasterPTR = reserve.claimnumber 
where prop.claimmasterPTR = @ClaimMast 
 order by prop.id 

select id, claimnumber, entitynumber, Coverageid, (select [desc] from clm_coverage where id = Coverageid) CoverDesc, 
	reserveopen, openedon, closedon, AmountPaid, forcedclosed from clm_reserve where claimnumber = @ClaimMast
select * from clm_payment where claimptr = @ClaimMast
select * from CLM_PaymentParts where PaymentPTR in (select id from clm_payment where claimptr = @ClaimMast)
select * from clm_adjusterassignments where claimptr = @ClaimMast

--select * from claimsdocuments where claimnumber = @ClaimMast
--select * from clm_coverage
--
--select * from clm_adjusterskilltype