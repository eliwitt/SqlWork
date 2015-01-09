declare @cmdStr nvarchar(1000),
	@orgStr nvarchar(4000),
	@debug	int,
	@FromDate	smalldatetime,
	@ThruDate	smalldatetime,
	@Division_key	nvarchar(1000),
	@Group_key nvarchar(1000)
set @ThruDate = ''
set @FromDate = ''
--set @ThruDate = '01/30/2006'
--set @FromDate = '12/30/2005'
SELECT 	distinct ee.Employee_key, p.last_nm + ' ' + p.first_nm as [name], rg.ReportingGroup_key, ee.EnrollmentPeriod_key, ee.Enroller_key, ee.User_key, [user].last_nm + ' ' + [user].first_nm as username
FROM	v_EmployeeEnroller ee
JOIN	EMP_Employee e 			ON e.Person_key = ee.Employee_key
join	emp_person p	on p.person_key = e.person_key
join	EMP_EmployeeProduct ep		on e.Person_key = ep.Employee_key
JOIN	EMP_EmployeeProductEnrollment epe ON epe.EmployeeProduct_key = ep.EmployeeProduct_key
JOIN	EMP_EmployeeEnrollmentPeriod eep ON eep.Person_key = e.Person_key AND eep.EnrollmentPeriod_key = epe.EnrollmentPeriod_key
JOIN	v_ReportingGroup rg 		ON rg.IncludedGroup_key = e.Group_key
JOIN	GRP_Group g         		ON g.Group_key = e.Group_key
JOIN	GRP_EnrollmentPeriod gep		ON gep.Group_key = rg.PrimaryGroup_key
join	msc_user [user]	on [user].user_key = ee.user_key
WHERE	ep.EmployeeProductStatus_vv = 'ENROLLED'
		AND eep.EnrollmentStatus_vv = 'ENROLLED'
 	AND	rg.ReportingGroup_key in ('{b2c6840d-0c98-4c17-880c-4f2122a69bbf}')
order by ee.enroller_key, ee.employee_key