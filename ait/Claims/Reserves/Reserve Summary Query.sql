SELECT     reserve.id, reserve.CoverageID ResType, (select [desc] from clm_coverage where id = reserve.CoverageID) ResTitle, 
	case when reserveopen =1 then 
		'Open'
 else  
		'Closed' end ResStatus, 
case when reserve.reserveopen =1 then 
   reserve.initialreserveamount 
else 
   0 end	Reserve,  
case when reserve.amountpaid is null then 
   0 
else  
   reserve.amountpaid end amountpaid, 
OpenedOn ResOpened, ClosedOn Resclosed, veh.entitynumber, year + ' ' + make + ' ' + model entitytitle,
		case when reserve.CoverageID in(3, 4) then
			case when GoAutoProd.dbo.F_Claims_VehicleHasLien(cmast.policynumber, cmast.dateofloss, veh.ourvehicleindex) = 1 then
				'true'
			else
				'false' end
		else
			'false'
		end leinshow 
FROM clm_claimmaster  cmast
	left join clm_claimvehicle veh on cmast.id = veh.claimmasterptr 
			and (veh.disabled = 0 or veh.disabled is null)
	join CLM_Reserve reserve on cmast.id = reserve.claimnumber 
			and veh.entitynumber = reserve.entitynumber
			and coverageid in (1, 3, 4, 5, 6, 9)
			and reserveopen = 1
 WHERE     cmast.id = 890  
union 
SELECT     reserve.id, reserve.CoverageID ResType, (select [desc] from clm_coverage where id = reserve.CoverageID) ResTitle, 
	case when reserveopen =1 then
		'Open'
	else 
		'Closed' end ResStatus, 
case when reserve.reserveopen =1 then 
   reserve.initialreserveamount 
else 
   0 end	Reserve,  
case when reserve.amountpaid is null then 
   0 
else  
   reserve.amountpaid end amountpaid, 
   OpenedOn ResOpened, ClosedOn Resclosed, invperson.entitynumber, person.firstname + ' ' + person.lastname entitytitle, 'false' leinshow 
FROM clm_claimmaster  cmast
    left join clm_vehiclepassenger pass on cmast.id = pass.claimmasterptr 
				and (pass.disabled = 0 or pass.disabled is null)
    left join clm_involvedparty invperson on pass.involvedpartyptr = invperson.id 
    left join clm_person person on invperson.personptr = person.id
	join CLM_Reserve reserve on cmast.id = reserve.claimnumber 
				and invperson.entitynumber = reserve.entitynumber
				and coverageid in (2, 7, 8) 
				and reserveopen = 1 
WHERE     cmast.id = 890  
 union 
SELECT     reserve.id, reserve.CoverageID ResType, (select [desc] from clm_coverage where id = reserve.CoverageID) ResTitle, 
	case when reserveopen =1 then
		'Open'
	else
		'Closed' end ResStatus, 
case when reserve.reserveopen =1 then 
   reserve.initialreserveamount 
else 
   0 end	Reserve,  
case when reserve.amountpaid is null then 
   0 
else  
   reserve.amountpaid end amountpaid, 
   OpenedOn ResOpened, ClosedOn Resclosed, prop.entitynumber, prop.PropertyDesc entitytitle,
	'false' leinshow 
FROM clm_claimmaster  cmast
	left join clm_otherproperty prop on cmast.id = prop.claimmasterptr 
					and (prop.disabled = 0 or prop.disabled is null)
	join CLM_Reserve reserve on (cmast.id = reserve.claimnumber 
						and  prop.entitynumber = reserve.entitynumber)
						and coverageid in (1, 3, 4, 5, 6, 9)
						and reserveopen = 1
 WHERE     cmast.id = 890   
union 
SELECT     reserve.id, reserve.CoverageID ResType, (select [desc] from clm_coverage where id = reserve.CoverageID) ResTitle, 
	case when reserveopen =1 then
		'Open'
	else 
		'Closed' end ResStatus, 
case when reserve.reserveopen =1 then 
   reserve.initialreserveamount 
else 
   0 end	Reserve,  
case when reserve.amountpaid is null then 
   0 
else  
   reserve.amountpaid end amountpaid, 
  OpenedOn ResOpened, ClosedOn Resclosed, [owner].entitynumber, powner.firstname + ' ' + powner.lastname entitytitle, 'false' leinshow 
FROM clm_claimmaster  cmast
    	left join clm_otherproperty prop on cmast.id = prop.claimmasterptr 
			and (prop.disabled = 0 or prop.disabled is null)
  	left join clm_involvedparty [owner] on prop.involvedpartyptr = owner.id 
 	left join clm_person powner on owner.personptr = powner.id 
 	join CLM_Reserve reserve on cmast.id = reserve.claimnumber 
			and [owner].entitynumber = reserve.entitynumber 
			and coverageid in (2, 7, 8) 
			and reserveopen = 1 
where cmast.id = 890 
order by entitynumber