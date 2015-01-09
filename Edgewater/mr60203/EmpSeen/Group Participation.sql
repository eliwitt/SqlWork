--
-- from the group participation
--
left join (
 SELECT gep.Group_key, count(distinct cast(e.person_key as varchar(36))) as grpempct
			FROM GRP_EnrollmentPeriod gep
				JOIN EMP_Employee e ON e.group_key = gep.group_key
				-- products that the user has enrolled in
				left jOIN EMP_EmployeeProduct ep ON ep.Employee_key = e.Person_key
				left jOIN EMP_EmployeeData ed ON ed.person_key = e.Person_key
			WHERE gep.group_key in (' + @grpctStr + ')
		 group by gep.group_key
	) GrpEmp on g.group_key = GrpEmp.group_key


