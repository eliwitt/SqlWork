select * from clm_adjusterassignments adj
	join clm_claimmaster cm on adj.Claimptr = cm.id and cm.reservesclosed = 0
 where adj.employeeptr = 467741

--update adj set employeeptr = 3833872 
--	from clm_adjusterassignments adj
--	join clm_claimmaster cm on adj.Claimptr = cm.id and cm.reservesclosed = 0
--	where adj.employeeptr = 467741
--update clm_claimmaster set employeeptr = 3833872 where employeeptr = 467741 and reservesclosed = 0


select * from clm_claimmaster where employeeptr = 467741