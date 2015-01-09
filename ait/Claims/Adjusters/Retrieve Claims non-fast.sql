declare @ClaimMast int
set @ClaimMast = 1

select distinct veh.vehiclenumber, veh.[Year], veh.Make, veh.Model, veh.insureconame as InsCoNam,
	veh.insurepolicynu as InsPolNu, veh.insurecontactinfo as InsConInfo, veh.id as vehID,
	case when veh.contacted is null then 'false' else 'true' end contacted, veh.disabled, veh.entitynumber
from clm_claimvehicle veh
where veh.claimmasterPTR = @ClaimMast
order by veh.vehiclenumber

select * from clm_reserve res
	join clm_claimvehicle theCar on res.claimnumber = theCar.claimmasterptr and res.entitynumber = theCar.entitynumber
where claimnumber = @ClaimMast

	-- Find the non-fast track reserves LIPD, COMP, or COLL 
		select '2' as skilltype, res.id, res.entitynumber, claimnumber, coverageid, amountpaid, theCar.disabled from clm_reserve res
			join (
				select claimmasterptr from clm_claimvehicle where disabled = 0
					group by claimmasterptr having count(entitynumber) > 1) multiVeh 
			on res.claimnumber = multiVeh.claimmasterptr
			join clm_claimvehicle theCar on res.claimnumber = theCar.claimmasterptr and res.entitynumber = theCar.entitynumber
		where res.coverageid in (select id from clm_coverage where [desc] in ('LIPD', 'COMP', 'COLL')) and theCar.disabled = 0
		order by claimnumber