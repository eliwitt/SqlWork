select SSN_txt from emp_person person
	join emp_employee emp on person.person_key = emp.person_key
	join grp_group grp on emp.group_key = grp.group_key
	join msc_organization org on org.organization_key = grp.group_key
where Organization_nm = 'Steve Group'