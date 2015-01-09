declare @ClaimMast int
set @ClaimMast = 32

select vehpass.vehiclenumber as vehiclenumber, vehpass.involvedpartyptr, person.id, person.FirstName, person.lastname, 
	person.homephone, person.cellphone, person.workphone, person.emailaddress, 
	case when party.contacted is null then 'false' else 'true' end contacted, vehpass.disabled, party.entitynumber, party.attorneyptr, party.injured
from clm_vehiclepassenger vehpass 
	join clm_involvedparty party on vehpass.involvedpartyptr = party.id
	join clm_person person on party.personptr = person.id 
where vehpass.vehiclenumber <> 0 And vehpass.claimmasterPTR = @ClaimMast
order by vehpass.vehiclenumber

select * from clm_reserve res
	join clm_vehiclepassenger vehpass on res.claimnumber = vehpass.claimmasterptr
	join clm_involvedparty party on vehpass.involvedpartyptr = party.id and res.entitynumber = party.entitynumber
where claimnumber = @ClaimMast
select * from clm_reserve res where claimnumber = @ClaimMast

select '3' as skilltype, res.id, res.entitynumber, claimnumber, coverageid, amountpaid 
	from clm_reserve res
	join clm_vehiclepassenger vehpass on res.claimnumber = vehpass.claimmasterptr
	join clm_involvedparty party on vehpass.involvedpartyptr = party.id and res.entitynumber = party.entitynumber
where party.attorneyptr > 0 and res.coverageid in (select id from clm_coverage where [desc] in ('LIBI', 'UMBI'))
order by claimnumber
