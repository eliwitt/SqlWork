select e.person_key, e.group_key, eep.enroller_key, eep.enrollmentstatus_vv, gep.group_key, gep.enrollfrom_dt, gep.enrollthru_dt
from emp_employee e
	join emp_employeeenrollmentperiod eep on e.person_key = eep.person_key
	join grp_enrollmentperiod gep on eep.enrollmentperiod_key = gep.enrollmentperiod_key
where gep.group_key in ('{b2c6840d-0c98-4c17-880c-4f2122a69bbf}')
order by e.person_key