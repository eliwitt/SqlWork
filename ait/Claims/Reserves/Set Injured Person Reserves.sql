--
-- this statement will update specific rows in the clm_reserve based on columns from the person's row
--
update CLM_Reserve 
	set ClosedOn = null, ReserveOpen = 1, OpenedOn = GetDate()
from clm_reserve reserve 
	left join (
		select claimmasterptr, invperson.id, invperson.entitynumber, invperson.personptr, 
			person.firstname, person.lastname, invperson.injured
			from clm_vehiclepassenger pass 
				left join clm_involvedparty invperson on pass.involvedpartyptr = invperson.id 
				left join clm_person person on invperson.personptr = person.id
	) people on reserve.claimnumber = people.claimmasterptr and reserve.entitynumber = people.entitynumber
where ClaimNumber = 1 and CoverageID = 2 and people.injured = 1