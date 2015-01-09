-- 5.4 employees by group

select distinct emp.group_key, grp.company_nm, last_nm, first_nm
from EMP_Employee emp
inner join grp_group grp
on emp.group_key = grp.group_key
inner join emp_person ep
on    ep.person_key = emp.person_key
where company_nm = 'Chattanooga Chamber'
order by company_nm, last_nm