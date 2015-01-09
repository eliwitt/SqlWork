select vehpass.vehiclenumber as vehiclenumber, vehpass.OurDriverIndex, 
 person.id as perID, person.FirstName, person.lastname, 
 person.suffixid, stext.[desc] as sdesc, person.titleid, ttext.[desc] as tdesc, person.dateofbirth, person.genderid, 
 person.maritalstatusid, person.ssn, person.licensenumber, person.licensestate, person.homephone, 
 person.cellphone, person.workphone, person.emailaddress, 
 party.id as invID, party.LossRoleid, ltext.[desc] as ldesc, party.AccidentDescription, party.Injured, party.InjuryDescription, 
 party.InjurySeverityId, party.Represented, party.AttorneyPTR, party.BeingTreated, party.MedicalPofessionalPTR,  
 case when party.contacted is null then 'false' else 'true' end contacted, 
 addr.addressline1, addr.addressline2, addr.zipinfoptr, myCode.CityName + ', ' + myCode.StateAbbr locnam, myCode.Zipcode, 
 reserve.CoverageID, reserve.reserveopen resstatus, reserve.initialreserveamount myreserve, reserve.OpenedOn, reserve.ClosedOn 
from clm_vehiclepassenger vehpass 
	join clm_involvedparty party on vehpass.involvedpartyptr = party.id 
	join clm_person person on party.personptr = person.id 
	left join clm_address addr on party.addressptr = addr.id 
   left join ZipInfo myCode on addr.Zipinfoptr = myCode.id 
   left join clm_title ttext on person.titleid = ttext.id 
   left join clm_suffix stext on person.suffixid = stext.id 
   left join clm_lossrole ltext on party.LossRoleid = ltext.id 
   left join clm_reserve reserve on party.entitynumber = reserve.entitynumber and vehpass.claimmasterptr = reserve.claimnumber 
where vehpass.claimmasterPTR = 82 and (vehpass.disabled = 0 or vehpass.disabled is null)
 order by vehpass.vehiclenumber

select prop.id, prop.propertydesc, prop.damageestimate, prop.insureconame, prop.insurepolicynu, prop.insurecontactinfo,
 person.id as perID, person.FirstName, person.lastname, 
 person.suffixid, stext.[desc] as sdesc, person.titleid, ttext.[desc] as tdesc, person.dateofbirth, person.genderid, 
 person.maritalstatusid, person.ssn, person.licensenumber, person.licensestate, person.homephone, 
 person.cellphone, person.workphone, person.emailaddress, 
 party.id as invID, party.LossRoleid, ltext.[desc] as ldesc, party.AccidentDescription, party.Injured, party.InjuryDescription, 
 party.InjurySeverityId, party.Represented, party.AttorneyPTR, party.BeingTreated, party.MedicalPofessionalPTR,  
 case when party.contacted is null then 'false' else 'true' end contacted, 
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
where prop.claimmasterPTR = 82 and (prop.disabled = 0 or prop.disabled is null)
 order by prop.id