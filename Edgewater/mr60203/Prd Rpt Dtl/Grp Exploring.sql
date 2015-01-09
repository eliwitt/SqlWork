select distinct grp.group_key, upper(grp.company_nm) as company,
	upper(ido.Organization_nm) InternalDivision_nm,
	upper(go.Organization_nm) Group_nm,
	upper(go.OrganizationShort_nm) Group_ID,
	gep.enrollfrom_dt, gep.enrollthru_dt,
	mu.user_key, UPPER(mu.first_nm) First_nm, 
	UPPER(mu.last_nm) Last_nm, UPPER(Enroller_ID) Enroller_ID,
	UPPER(p.last_nm) + ' ' + UPPER(p.first_nm) as empname
	
 from grp_enrollmentperiod gep
	-- enrollers in the group
	inner join grp_group grp on gep.group_key = grp.group_key
	inner JOIN MSC_Organization go ON go.Organization_key = grp.Group_key
	join msc_organization ido on grp.internaldivision_key = ido.organization_key
	inner join grp_enroller ge on   ge.EnrollmentPeriod_key = gep.EnrollmentPeriod_key
	inner join msc_user mu on   ge.user_key = mu.user_key
	-- employee product information
JOIN	EMP_EmployeeEnrollmentPeriod eep ON gep.enrollmentperiod_key = eep.enrollmentperiod_key 
JOIN	EMP_Employee e 			ON e.Person_key = eep.person_key
join	emp_person p	on p.person_key = e.person_key
join	EMP_EmployeeProduct ep		on e.Person_key = ep.Employee_key
JOIN	EMP_EmployeeProductEnrollment epe ON epe.EmployeeProduct_key = ep.EmployeeProduct_key

WHERE	ep.EmployeeProductStatus_vv = 'ENROLLED'
		AND eep.EnrollmentStatus_vv = 'ENROLLED' and p.personstatus_vv = 'ACTIVE'
 	AND	grp.group_key in ('{b2c6840d-0c98-4c17-880c-4f2122a69bbf}')
order by mu.user_key, empname