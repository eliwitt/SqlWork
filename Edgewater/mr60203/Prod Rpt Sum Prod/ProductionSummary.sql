-- ProductionSummary
declare @cmdStr		nvarchar(4000),
	@orgStr		nvarchar(4000),
	@debug		int,
	@FromDate	smalldatetime,
	@ThruDate	smalldatetime,
	@Division_key	nvarchar(1000),
	@Group_key 	nvarchar(1000),
	@Grp_key	nvarchar(1000),
	@EnrollmentPeriod nvarchar(1000),
	@ErrorMsg	varchar(255)
set @EnrollmentPeriod = ''
set @orgStr = ''
set @Grp_key = ''
set @ThruDate = ''
set @FromDate = ''
--set @ThruDate = '06/30/2008'
--set @FromDate = '01/01/2001'
--
-- group  -------------------------------------------------
--
set @Group_key = 'ALL'
--	Ace 818b16ff-161e-4bf5-8d17-355d64510f7f
--set @Group_key = '''{818b16ff-161e-4bf5-8d17-355d64510f7f}'''
--	Chatt Chamber dd973c8a-1884-49fd-8e79-6bf5a83a3bb2
--	Hermitage Medical Associates 4b676ae6-34ea-466e-b3ac-2949c654a621
set @Group_key = 'dd973c8a-1884-49fd-8e79-6bf5a83a3bb2'
--
-- enrollment period  ---------------------------------------
--
--	Ace FA05C718-5C66-49D2-A67D-2984F18DF5A2
--set @EnrollmentPeriod = '''{FA05C718-5C66-49D2-A67D-2984F18DF5A2}'''
--	Chatt Chamber 8b1acbc0-ac07-4383-8271-379001be7097
--set @EnrollmentPeriod = '''{8b1acbc0-ac07-4383-8271-379001be7097}'''
--	Hermitage Medical Associates 878387af-f666-4e6c-bd5a-b9b90e401c62
--set @EnrollmentPeriod = '''{878387af-f666-4e6c-bd5a-b9b90e401c62}'''
--
--  division  -----------------------------------------------
--set @Division_key = '''{E2BB4AAB-78D4-4919-9F79-415BC7BEBFEB}'''
set @Division_key = 'ALL'
--
--  set @debug to an integer and you will get print statements
--  0 = turn off
--  1 = high level 
--  2 = detail
--  3 = stop after the build of the cmd str
set @debug = 2
-- if the table exists then drop it

drop table #Enrollment

create table #Enrollment
(
 Employee_key uniqueIdentifier, 
 Group_key uniqueIdentifier,
 EnrollmentPeriod_key uniqueIdentifier,
 Enroller_key uniqueIdentifier,
 User_key uniqueIdentifier
)
set @cmdStr = 'INSERT INTO #Enrollment(Employee_key, Group_key, EnrollmentPeriod_key, Enroller_key, User_key)

SELECT 	Distinct 
		ee.Employee_key, 
		emp.Group_key, 
		ee.EnrollmentPeriod_key, 
		ee.Enroller_key, 
		ee.User_key
FROM	v_EmployeeEnroller ee
JOIN	emp_employee emp 		ON ee.employee_key = emp.person_key
join	EMP_EmployeeProduct ep		on emp.Person_key = ep.Employee_key
JOIN	EMP_EmployeeProductEnrollment epe ON epe.EmployeeProduct_key = ep.EmployeeProduct_key
JOIN	EMP_EmployeeEnrollmentPeriod eep ON eep.Person_key = emp.Person_key AND eep.EnrollmentPeriod_key = epe.EnrollmentPeriod_key
JOIN	v_ReportingGroup rg 	ON rg.IncludedGroup_key = emp.Group_key
JOIN	GRP_Group g 			ON g.Group_key = rg.IncludedGroup_key
JOIN	GRP_EnrollmentPeriod gep	ON gep.Group_key = rg.PrimaryGroup_key
WHERE	ep.EmployeeProductStatus_vv = ''ENROLLED''
		AND eep.EnrollmentStatus_vv = ''ENROLLED''
'
--
-- start checking the parameters to use in the select statement
--
if @Group_key <> 'ALL'
	goto Group_Script
if @Division_key <> 'ALL'
	goto Div_Script
--
-- Retrieve all groups and divs
--
if @debug > 0
	print 'Get ALL Groups and Divs'
-- get the date parameter
goto Begin_the_Date
--
-- the following will retrieve the selected group data
--
Group_Script:
if @debug > 0
	print 'In Group_Script '
-- add the selected groups
set @cmdStr = @cmdStr + ' 	AND	rg.ReportingGroup_key in ('
set @Grp_key = @Group_key
while (charindex(',',@Grp_key)>0)
begin

  if len(@orgStr) > 0
	set @orgStr = @orgStr + ',''{' + ltrim(rtrim(substring(@Grp_key, 1,charindex(',',@Grp_key)-1))) + '}'''
  else
	set @orgStr = @orgStr + '''{' + ltrim(rtrim(substring(@Grp_key, 1,charindex(',',@Grp_key)-1))) + '}'''
  set @Grp_key = substring(@Grp_key,charindex(',',@Grp_key) + 1,len(@Grp_key))
end

 if len(@orgStr) > 0
	set @orgStr = @orgStr + ',''{' + @Grp_key + '}'''
else
	set @orgStr = @orgStr + '''{' + @Grp_key + '}'''
set @cmdStr = @cmdStr + @orgStr + ')'

if @Division_key <> 'ALL'
	goto Div_Script
goto Begin_the_Date
--
-- get the selected divisions
--
Div_Script:
if @debug > 0 
	print 'In the Div process'
if @Division_key = ''
      goto  Begin_the_Date
-- add the selected divs
set @cmdStr = @cmdStr + '	AND	g.InternalDivision_key in ( ' + @Division_key + ' )'

goto Begin_the_Date
--
--  build the date parameters we need
--
Begin_the_Date:
if @debug > 0
	print 'Dates '
if @FromDate <> '' and @ThruDate <> ''
begin
	if @debug > 1 
		print 'Use the date range'
	-- set @cmdStr = @cmdStr + '	and gep.EnrollFrom_dt >= ''' + cast(@FromDate as nvarchar(30)) + ''' AND	gep.EnrollThru_dt <= ''' + cast(@ThruDate as nvarchar(30)) + ''''
	set @cmdStr = @cmdStr + ' and ep.enrollment_dt > ''' + cast(@FromDate as nvarchar(30)) + ''' and ep.enrollment_dt < ''' + cast(@ThruDate as nvarchar(30)) + ''''
end
else
begin
	if @EnrollmentPeriod <> ''
	begin
		if @debug > 1
			print 'Use the Enrollment Period'
		set @cmdStr = @cmdStr + '	and gep.enrollmentperiod_key = ' + @EnrollmentPeriod
	end
end

goto End_Of_Script
--
--  bottom of the script
--
End_Of_Script:
if @debug > 0
	print 'Starting the End of Script procedure'
--
-- The script to popluate the temp table has been created now use it
--
if @debug > 1
	print @cmdStr
--
-- stop if debug is 3
--
if @debug = 3
	return

exec(@cmdStr)
--
--  execute the select statement from the original script that
--  uses the tempDB..Enrollment table
--

SELECT	upper(EmpEnrGrp.Company_nm) Company_nm,
	EmpEnrGrp.Logo_bin Logo,
	upper(EmpEnrGrp.Organization_nm) InternalDivision_nm,
	upper(EmpEnrGrp.Organization_nm) Group_nm,
	EmpEnrGrp.OrganizationShort_nm Group_ID,
	EmpEnrGrp.User_key, 
		UPPER(First_nm) First_nm, 
		UPPER(Last_nm) Last_nm, 
		UPPER(Enroller_ID) Enroller_ID, 
		IsNull(Employees_Seen, 0) Employees_Seen, 
		IsNull(VolProductsEnrolled, 0) VolProductsEnrolled,
		IsNull(Products.Products, 0) Products,
		IsNull(NumEmployees, 0) NumEmployees,
		IsNull(VolProducts, 0) NumVolProducts, 
		NumGroups
FROM
		--Number of Employees in Groups Assigned to enroller--
		(
			SELECT 	g.Group_key, g.Company_nm, go.Logo_bin, go.Organization_nm, go.OrganizationShort_nm,
				u.User_key, u.First_nm, u.Last_nm, u.Enroller_ID, Count(*)NumEmployees
			FROM 	EMP_Employee e 
			JOIN 	EMP_Person p 			ON e.Person_key = p.Person_key
			JOIN 	GRP_Group g 			ON e.Group_key = g.Group_key
			JOIN	MSC_Organization go		ON go.Organization_key = e.Group_key
			JOIN 	GRP_EnrollmentPeriod ep ON g.PrimaryGroup_key = ep.Group_key
			JOIN	GRP_Enroller enr 		ON ep.EnrollmentPeriod_key = enr.EnrollmentPeriod_key
			JOIN	MSC_User u 				ON u.User_key = enr.User_key
			WHERE	g.Group_key in (SELECT DISTINCT Group_key from #Enrollment) and
				p.PersonStatus_vv = 'ACTIVE' 
				AND enr.EnrollmentPeriod_key in (SELECT DISTINCT EnrollmentPeriod_key from #Enrollment)
			GROUP BY g.Group_key, g.Company_nm, go.Logo_bin, go.Organization_nm, go.OrganizationShort_nm, u.User_key, u.First_nm, u.Last_nm, u.Enroller_ID
		) EmpEnrGrp 
LEFT JOIN
		--Number of Groups Per Enroller--
		(	
			SELECT	g.Group_key, User_key, Count(*) NumGroups
			FROM 	GRP_Group g
			JOIN 	GRP_EnrollmentPeriod gep ON g.Group_key = gep.Group_key
			JOIN 	GRP_Enroller ge 		 ON ge.EnrollmentPeriod_key = gep.EnrollmentPeriod_key
			WHERE 	gep.EnrollmentPeriod_key in (Select Distinct EnrollmentPeriod_key from #Enrollment)
			GROUP BY g.Group_key, User_key
		)EnrGrp 
		ON EmpEnrGrp.Group_key = EnrGrp.Group_key and EmpEnrGrp.User_key = EnrGrp.User_key
LEFT JOIN
		--Number of Employees Seen for this enroller--
		(
			SELECT	Group_key, User_key, Count(Cast(Employee_key as varchar(36))) Employees_Seen 
			FROM 	#Enrollment 
			Group By Group_key, User_key
		)EmpSeen 
		ON EmpSeen.Group_key = EnrGrp.Group_key and EmpSeen.User_key = EnrGrp.User_key
LEFT JOIN	
		-- Number of Voluntary Products Enrolled --
		(
			SELECT 	enr.Group_key, User_key, Count(*) VolProductsEnrolled
	        FROM 	#Enrollment enr
			JOIN	EMP_EmployeeProduct epr 			ON epr.Employee_key = enr.Employee_key
			JOIN 	GRP_GroupProduct gp 				ON gp.GroupProduct_key = epr.groupproduct_key
			JOIN 	PRD_Product p 						ON p.Product_key = gp.Product_key
			JOIN	EMP_EmployeeProductEnrollment epe 	ON epe.EmployeeProduct_key = epr.EmployeeProduct_key
			WHERE 	EmployeeProductStatus_vv = 'ENROLLED' AND p.VoluntaryProduct_flg = 'Y' AND epe.Enroller_key = enr.Enroller_key
			GROUP BY enr.Group_key, user_key
		) VolProductsEnrolled
	ON EmpEnrGrp.Group_key = VolProductsEnrolled.Group_key and EmpEnrGrp.User_key = VolProductsEnrolled.User_key
LEFT JOIN
		-- Number of Non Voluntary Products Enrolled --
		(
			SELECT enr.Group_key, User_key, Count(*) Products
	        FROM 	#Enrollment enr
			JOIN	EMP_EmployeeProduct epr 			ON epr.Employee_key = enr.Employee_key
			JOIN 	GRP_GroupProduct gp 				ON gp.GroupProduct_key = epr.groupproduct_key
			JOIN 	PRD_Product p 						ON p.Product_key = gp.Product_key
			JOIN	EMP_EmployeeProductEnrollment epe 	ON epe.EmployeeProduct_key = epr.EmployeeProduct_key
			WHERE 	EmployeeProductStatus_vv = 'ENROLLED' AND p.VoluntaryProduct_flg <> 'Y' AND epe.Enroller_key = enr.Enroller_key
			GROUP BY enr.Group_key, user_key
		)  Products
		ON EmpEnrGrp.Group_key = Products.Group_key and EmpEnrGrp.User_key = Products.User_key
LEFT JOIN
		-- of employees who purchased non voluntary products --
		(
			SELECT enr.Group_key, User_key, Count(Distinct Cast(enr.Employee_key as varchar(50))) VolProducts
			FROM 	#Enrollment enr
			JOIN	EMP_EmployeeProduct epr ON epr.Employee_key = enr.Employee_key
			JOIN 	GRP_GroupProduct gp 	ON gp.GroupProduct_key = epr.groupproduct_key
			JOIN 	PRD_Product p 			ON p.Product_key = gp.Product_key
			JOIN	EMP_EmployeeProductEnrollment epe 	ON epe.EmployeeProduct_key = epr.EmployeeProduct_key
			WHERE 	EmployeeProductStatus_vv = 'ENROLLED' AND p.VoluntaryProduct_flg = 'Y' AND epe.Enroller_key = enr.Enroller_key
			GROUP BY enr.Group_key, user_key
		) VolProducts
		ON EmpEnrGrp.Group_key = VolProducts.Group_key and EmpEnrGrp.User_key = VolProducts.User_key
ORDER BY EmpEnrGrp.Company_nm, Last_nm, First_nm, Enroller_ID
return
-- bottom of the script
Error_Handler:
if @debug > 0 
	print 'Error Handler'

IF @ErrorMsg IS NOT NULL
BEGIN
	SELECT @ErrorMsg = 'ProductionSummary: ' + @ErrorMsg 
	RAISERROR(@ErrorMsg, 11, 1)
	--return 21
END