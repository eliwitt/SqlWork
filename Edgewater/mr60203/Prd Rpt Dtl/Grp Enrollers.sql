select grp.group_key, upper(grp.company_nm),
	upper(ido.Organization_nm) InternalDivision_nm,
	upper(go.Organization_nm) Group_nm,
	upper(go.OrganizationShort_nm) Group_ID,
	gep.enrollfrom_dt, gep.enrollthru_dt,
	mu.user_key, UPPER(mu.first_nm) First_nm, 
	UPPER(mu.last_nm) Last_nm, UPPER(Enroller_ID) Enroller_ID, 0, 0, 0, 0, 0
 from grp_enrollmentperiod gep
	-- enrollers in the group
	inner join grp_group grp on gep.group_key = grp.group_key
	inner JOIN MSC_Organization go ON go.Organization_key = grp.Group_key
	join msc_organization ido on grp.internaldivision_key = ido.organization_key
	inner join grp_enroller ge on   ge.EnrollmentPeriod_key = gep.EnrollmentPeriod_key
	inner join msc_user mu on   ge.user_key = mu.user_key 
where grp.group_key in ( '{b2c6840d-0c98-4c17-880c-4f2122a69bbf}' ) 
ORDER BY Company_nm, Last_nm, First_nm, Enroller_ID