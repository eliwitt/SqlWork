select ep.employee_key, ep.enrollment_dt, emp.group_key, grp.company_nm 
from emp_employeeproduct ep
	join emp_employee emp on ep.employee_key = emp.person_key
	join grp_group grp on emp.group_key = grp.group_key
where ep.enrollment_dt is not null