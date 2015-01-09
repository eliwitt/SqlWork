select distinct reserve.id, reserve.CoverageID ResType, 
	(select [desc] from clm_coverage where id = reserve.CoverageID) ResTitle, 
	case when reserve.reserveopen =1 then 
		'Open' 
	else  
		'Closed' end ResStatus, 
	GoAutoProd.dbo.F_Claims_GetReserveAmount(reserve.CoverageID, cmast.policynumber, cmast.dateofloss, veh.ourvehicleindex) Reserve, 
	reserve.OpenedOn ResOpened, reserve.ClosedOn Resclosed, reserve.entitynumber, 
	case when (reserve.CoverageID = 2) or (reserve.CoverageID = 7) or (reserve.CoverageID = 8) then 
		people.firstname + ' ' + people.lastname 
	else 
		veh.proptitle end entitytitle, 
	case when (select [desc] from clm_coverage where id = reserve.CoverageID) in('COLL', 'COMP') then 
		case when GoAutoProd.dbo.F_Claims_VehicleHasLien(cmast.policynumber, cmast.dateofloss, veh.ourvehicleindex) = 1 then 
			'true' 
		else 
			'false' end 
	else 
		'false' end lienshow, veh.ourvehicleindex 
from clm_reserve reserve  
	left join ( 
		select claimmasterptr, entitynumber, year + ' ' + make + ' ' + model proptitle, ourvehicleindex, disabled  
			from clm_claimvehicle 
		union 
		select cmaster.id, prop.entitynumber, powner.firstname + ' ' + powner.lastname + ':' + prop.PropertyDesc proptitle, 1 ourvehicleindex, prop.disabled 
			from clm_claimmaster cmaster
				left join clm_otherproperty prop on cmaster.id = prop.claimmasterptr 
				left join clm_involvedparty [owner] on Prop.involvedpartyptr = owner.id 
				left join clm_person powner on owner.personptr = powner.id 				
	) veh on reserve.entitynumber = veh.entitynumber and reserve.claimnumber = veh.claimmasterptr 
	left join ( 
		select claimmasterptr, invperson.id, invperson.entitynumber, invperson.personptr, 
	       person.firstname, person.lastname, pass.disabled 
			from clm_vehiclepassenger pass  
				left join clm_involvedparty invperson on pass.involvedpartyptr = invperson.id  
				left join clm_person person on invperson.personptr = person.id 
		union 
		select cmaster.id, owner.id, owner.entitynumber, owner.personptr, 
	       powner.firstname, powner.lastname, prop.disabled 
			from clm_claimmaster cmaster 
				left join clm_otherproperty prop on cmaster.id = prop.claimmasterptr 
				left join clm_involvedparty [owner] on Prop.involvedpartyptr = owner.id 
				left join clm_person powner on owner.personptr = powner.id 
	) people on reserve.claimnumber = people.claimmasterptr and reserve.entitynumber = people.entitynumber 
   left join clm_claimmaster  cmast on reserve.claimnumber = cmast.id 
where reserve.claimnumber = 15 and reserveopen = 1 
	and (veh.disabled = 0 or veh.disabled is null)  
	and (people.disabled = 0 or people.disabled is null) 
 order by reserve.entitynumber