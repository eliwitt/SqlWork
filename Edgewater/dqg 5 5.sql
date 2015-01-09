-- 5.5 employees with dependents by group 

select distinct ep.person_key,
	ep.last_nm as [Emp Last], 
	ep.first_nm as [Emp First], 
	ep.persontype_vv, 
	ed.dependent_key, 
	depend.last_nm as [Depend Last], 
	depend.first_nm as [Depend First], 
	depend.persontype_vv, 
	DependentType_vv
from EMP_Employee emp
	inner join grp_group grp
		on emp.group_key = grp.group_key
	inner join emp_person ep
		on    ep.person_key = emp.person_key
	left outer join emp_dependent ed
		on    emp.person_key = ed.employee_key
	left outer join emp_person depend
		on ed.dependent_key = depend.person_key
where company_nm = 'Hermitage Medical Associates'
order by ep.last_nm