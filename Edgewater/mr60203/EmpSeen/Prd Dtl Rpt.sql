---
--  from the detail report
----
select enrollseen.group_key, enrollseen.user_key, enrollseen.last_nm, enrollseen.first_nm, enrollseen.emptot
from
(	SELECT grp.Group_key, u.user_key, u.last_nm, u.first_nm, count(distinct cast(e.person_key as varchar(36))) as emptot
		FROM EMP_Employee e
		-- products that the user has enrolled in
		JOIN EMP_EmployeeProduct ep ON ep.Employee_key = e.Person_key
		join emp_employeeproductenrollment epe on epe.employeeproduct_key = ep.employeeproduct_key
		-- find the enroller of this product
		JOIN EMP_EmployeeEnrollmentPeriod eep ON epe.EnrollmentPeriod_key = eep.EnrollmentPeriod_key
		 and eep.Person_key = e.Person_key
		JOIN	GRP_Enroller ge ON ge.Enroller_key = epe.Enroller_key
		JOIN 	MSC_User u on u.User_key = ge.User_key
		-- Organizational information
		JOIN GRP_EnrollmentPeriod gep ON eep.EnrollmentPeriod_key = gep.EnrollmentPeriod_key
		inner join grp_group grp on gep.group_key = grp.group_key 
	WHERE ((ep.EmployeeProductStatus_vv = 'ENROLLED' 
		or ep.EmployeeProductStatus_vv = 'WAIVED') or (
		eep.enrollmentstatus_vv = 'INCOMPLETE'))
	group by grp.group_key, u.user_key, u.last_nm, u.first_nm
) enrollseen 
where enrollseen.group_key in ('{b2c6840d-0c98-4c17-880c-4f2122a69bbf}')