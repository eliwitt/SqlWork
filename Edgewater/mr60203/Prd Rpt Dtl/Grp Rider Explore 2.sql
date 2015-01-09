select p.person_key, e.group_key, ep.employeeproduct_key, epr.productrider_key
from emp_person p
	JOIN EMP_Employee e ON e.Person_key = p.Person_key
	-- products that the user has enrolled in
	jOIN EMP_EmployeeProduct ep ON ep.Employee_key = e.Person_key
	join emp_productrider epr on ep.employeeproduct_key = epr.employeeproduct_key
	join emp_employeeproductenrollment epe on epe.employeeproduct_key = ep.employeeproduct_key
	-- find the enroller of this product
	JOIN EMP_EmployeeEnrollmentPeriod eep ON epe.EnrollmentPeriod_key = eep.EnrollmentPeriod_key
	 and eep.Person_key = e.Person_key
	-- Organizational information
	JOIN GRP_EnrollmentPeriod gep ON eep.EnrollmentPeriod_key = gep.EnrollmentPeriod_key
	inner join grp_group grp on gep.group_key = grp.group_key
where ep.EmployeeProductStatus_vv = 'ENROLLED'
order by grp.group_key