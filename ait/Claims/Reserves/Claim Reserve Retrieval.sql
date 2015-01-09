select distinct reserve.CoverageID ResType, 
		(select [desc] from clm_coverage where id = reserve.CoverageID) ResTitle,
		case when reserve.reserveopen =1 then
			'Open'
		else 
			'Closed' end ResStatus, reserve.initialreserveamount Reserve, 
		reserve.OpenedOn ResOpened, reserve.ClosedOn Resclosed, reserve.entitynumber, 
		case when reserve.CoverageID = 2 then
			people.firstname + ' ' + people.lastname
		else
			veh.year + ' ' + veh.make + ' ' + veh.model end entitytitle
from clm_reserve reserve 
	left join clm_claimvehicle veh on reserve.entitynumber = veh.entitynumber and reserve.claimnumber = veh.claimmasterptr
	left join (
		select claimmasterptr, invperson.id, invperson.entitynumber, invperson.personptr, 
			person.firstname, person.lastname, invperson.injured
			from clm_vehiclepassenger pass 
				left join clm_involvedparty invperson on pass.involvedpartyptr = invperson.id 
				left join clm_person person on invperson.personptr = person.id
	) people on reserve.claimnumber = people.claimmasterptr and reserve.entitynumber = people.entitynumber
	where claimnumber = 1 and CoverageID = 2 and people.injured = 1
order by reserve.entitynumber