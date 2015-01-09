-- 5.4 employees by group

select distinct grp.company_nm, count(eep.EmployeeProductStatus_vv) as enrolled,
	enrollment_dt
from EMP_Employee emp
inner join grp_group grp
	on emp.group_key = grp.group_key
inner join emp_person ep
	on    ep.person_key = emp.person_key
join	EMP_EmployeeProduct eep		
	on emp.Person_key = eep.Employee_key
where eep.EmployeeProductStatus_vv = 'ENROLLED'
--group by company_nm, eep.EmployeeProductStatus_vv, enrollment_dt
--order by company_nm, enrolled, enrollment_dt
