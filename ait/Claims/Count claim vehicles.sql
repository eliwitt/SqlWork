select claim.id, claim.policynumber, count(veh.claimmasterptr) [number of vehicles]
from clm_claimmaster claim
	join clm_claimvehicle veh on claim.id = veh.claimmasterptr
group by claim.id, claim.policynumber

select veh.*
from clm_claimmaster claim
	join clm_claimvehicle veh on claim.id = veh.claimmasterptr
where claim.id = 86