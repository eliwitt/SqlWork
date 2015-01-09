declare @cmdStr nvarchar(4000),
	@orgStr nvarchar(4000),
	@debug	int,
	@Grp_key nvarchar(1000),
	@FromDate	smalldatetime,
	@ThruDate	smalldatetime,
	@Division_key	nvarchar(1000),
	@Group_key nvarchar(1000),
	@EnrollmentPeriod_key nvarchar(1000),
	@ErrorMsg varchar(255)

set @orgStr = ''
set @ThruDate = ''
set @FromDate = ''
--set @ThruDate = '06/30/2007'
--set @FromDate = '01/01/2005'
--
-- group  -------------------------------------------------
--
--	Ace 818b16ff-161e-4bf5-8d17-355d64510f7f
--set @Group_key = '''{818b16ff-161e-4bf5-8d17-355d64510f7f}'''
--	Chatt Chamber dd973c8a-1884-49fd-8e79-6bf5a83a3bb2
--	Hermitage Medical Associates 4b676ae6-34ea-466e-b3ac-2949c654a621
--
-- BCBS b2c6840d-0c98-4c17-880c-4f2122a69bbf
--
set @Group_key = 'b2c6840d-0c98-4c17-880c-4f2122a69bbf'
--
--set @Group_key = 'ALL'
-- enrollment period  ---------------------------------------
--
--	Ace FA05C718-5C66-49D2-A67D-2984F18DF5A2
--set @EnrollmentPeriod = '''{FA05C718-5C66-49D2-A67D-2984F18DF5A2}'''
--	Chatt Chamber 8b1acbc0-ac07-4383-8271-379001be7097
--set @EnrollmentPeriod = '''{8b1acbc0-ac07-4383-8271-379001be7097}'''
--	Hermitage Medical Associates 878387af-f666-4e6c-bd5a-b9b90e401c62
--set @EnrollmentPeriod_key = '''{878387af-f666-4e6c-bd5a-b9b90e401c62}'''
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
--
--  create the enrollment table
--
drop table #Enrollment
create table #Enrollment
(
 Employee_key uniqueIdentifier, 
 Group_key uniqueIdentifier,
 EnrollmentPeriod_key uniqueIdentifier,
 Enroller_key uniqueIdentifier,
 User_key uniqueIdentifier
)
--
--  build the start of the cmd str
--
set @cmdStr = 'INSERT INTO #Enrollment(Employee_key, Group_key, EnrollmentPeriod_key, Enroller_key, User_key)
SELECT 	Distinct ee.Employee_key, 
	rg.ReportingGroup_key GroupKey, 
	ee.EnrollmentPeriod_key, 
	ee.Enroller_key, 
	ee.User_key
FROM	v_EmployeeEnroller ee
JOIN	EMP_Employee e 	ON e.Person_key = ee.Employee_key
join	EMP_EmployeeProduct ep	on e.Person_key = ep.Employee_key
JOIN	EMP_EmployeeProductEnrollment epe ON epe.EmployeeProduct_key = ep.EmployeeProduct_key
JOIN	EMP_EmployeeEnrollmentPeriod eep ON eep.Person_key = e.Person_key AND eep.EnrollmentPeriod_key = epe.EnrollmentPeriod_key
JOIN	v_ReportingGroup rg ON rg.IncludedGroup_key = e.Group_key
JOIN	GRP_Group g ON g.Group_key = e.Group_key
JOIN	GRP_EnrollmentPeriod gep ON gep.Group_key = rg.PrimaryGroup_key
WHERE ep.EmployeeProductStatus_vv = ''ENROLLED''
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
	print 'In the Group process'
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
if @Division_key = ''
      goto  Begin_the_Date
if @debug > 0 
	print 'In the Div process'
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
	set @cmdStr = @cmdStr + ' and ep.enrollment_dt >= ''' + cast(@FromDate as nvarchar(30)) + ''' and ep.enrollment_dt <= ''' + cast(@ThruDate as nvarchar(30)) + ''''
	goto End_Of_Script
end
if @EnrollmentPeriod_key <> ''
begin
	if @debug > 1
		print 'Use the Enrollment Period'
	set @cmdStr = @cmdStr + '	and gep.enrollmentperiod_key = ''{' + @EnrollmentPeriod_key + '}'''
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
SELECT  distinct upper(u.Last_nm) Last_nm, 
		upper(u.First_nm) First_nm,
		upper(u.Enroller_ID) Enroller_ID,
		EnrollmentType_vv,
		AccountType_vv,
		upper(g.Company_nm) Company_nm,
		go.Logo_bin Logo,
		upper(Division.Organization_nm) InternalDivision_nm,
		upper(go.Organization_nm) Group_nm,
		go.OrganizationShort_nm Group_ID,
		gep.enrollfrom_dt, gep.enrollthru_dt,
		upper(Benefit.Short_nm) Benefit,
		upper(Carrier.OrganizationShort_nm) Carrier,
		upper(ProductDisplay_nm) ProductDisplay_nm, gp.GroupProduct_key,
		VoluntaryProduct_flg, rider_flg,
		IsNull(TotalSubmittedPremium, 0) TotalSubmittedPremium,
		IsNull(Products, 0) NumProducts,
		IsNull(Employees_Seen, 0) Employees_Seen ,
		IsNull(Enroller_Employees_Seen, 0) Enroller_Employees_Seen, 
		IsNull(Enroller_Employees_Seen_tot, 0) Enroller_Emp_Seen_tot
from	#Enrollment e
JOIN 	msc_user u 					ON u.user_key = e.user_key
JOIN	EMP_Employee emp			ON emp.Person_key = e.Employee_key
JOIN	GRP_EnrollmentPeriod gep 	ON e.EnrollmentPeriod_key = gep.EnrollmentPeriod_key
JOIN	Grp_Group g					ON e.Group_key = g.Group_key
JOIN	MSC_Organization go			ON go.Organization_key = e.Group_key
JOIN	MSC_Organization pg			ON pg.Organization_key = gep.Group_key
JOIN	GRP_GroupProduct gp 		ON gep.Group_key = gp.Group_key
JOIN 	PRD_Product p 				ON gp.Product_key = p.Product_key
JOIN	PRD_Customization cz 		ON gp.GroupProduct_key = cz.GroupProduct_key
JOIN 	GRP_GroupTableValue Benefit	ON gp.BenefitType_key = Benefit.GroupTableValue_key
JOIN	MSC_Organization Carrier	ON Carrier.Organization_key = p.Carrier_key
LEFT JOIN MSC_Organization Division	ON g.InternalDivision_key = Division.Organization_key
LEFT JOIN
		(
			SELECT	e.User_key, 
					e.Group_key, 
					ep.GroupProduct_key, 
					gp.Product_key, 
					Count(*) Products,
					SUM(
						Case
						When(IsNull(EmployeeYearlyCost_amt, 0) + IsNull(EmployerYearlyCost_amt, 0)) - 
							(IsNull(EmployeeStartCost_amt, 0)  + IsNull(EmployerStartCost_amt, 0)) <= 0 
						Then 0
						Else (IsNull(EmployeeYearlyCost_amt, 0) + IsNull(EmployerYearlyCost_amt, 0)) - 
							 (IsNull(EmployeeStartCost_amt, 0)  + IsNull(EmployerStartCost_amt, 0)) 
						END
					) TotalSubmittedPremium
			FROM 		#Enrollment e
			JOIN		EMP_EmployeeProductEnrollment epe 	ON epe.EnrollmentPeriod_key = e.EnrollmentPeriod_key AND epe.Enroller_key = e.Enroller_key
			JOIN		EMP_EmployeeProduct ep 				ON ep.EmployeeProduct_key = epe.EmployeeProduct_key AND ep.Employee_key = e.Employee_key
			JOIN		EMP_EmployeeEnrollmentPeriod eep	ON eep.Person_key = e.Employee_key AND eep.EnrollmentPeriod_key = e.EnrollmentPeriod_key
			JOIN 		GRP_GroupProduct gp 				ON gp.GroupProduct_key = ep.GroupProduct_key
			WHERE 		ep.EmployeeProductStatus_vv = 'ENROLLED' 
						AND eep.EnrollmentStatus_vv = 'ENROLLED'
			GROUP BY	e.User_key, e.Group_key, ep.GroupProduct_key, gp.Product_key
) Apps ON Apps.Product_key = p.Product_key AND e.User_key = Apps.User_key AND g.Group_key = Apps.Group_key

LEFT JOIN
		(
			Select	e.Group_key, e.User_key, Count(Cast(e.Employee_key as varchar(36))) Employees_Seen
			From	#Enrollment e
			Group By e.User_key, e.Group_key
		) Emp_Seen ON e.User_key = Emp_Seen.User_key AND e.Group_key = Emp_Seen.Group_key
LEFT JOIN
		(
			Select 	User_key, Count(Cast(Employee_key as varchar(36))) Enroller_Employees_Seen
			from 	#Enrollment
			Group by User_key
		) Enroller_Emp_Seen
		On	 e.User_key = Enroller_Emp_Seen.User_key
 -- get the total fo the enrollers emp sign ups
LEFT JOIN
		(
			Select 	Group_key, Count(Distinct Cast(Employee_key as varchar(36))) Enroller_Employees_Seen_tot
			from 	#Enrollment
			Group by Group_key
		) Enroller_Emp_Seen_tot
		On	 e.Group_key = Enroller_Emp_Seen_tot.Group_key

WHERE 		gp.ConfigurationStatus_vv = 'ACTIVE' OR IsNull(Products, 0) > 0
Order By 	g.Company_nm, go.OrganizationShort_nm, u.Last_nm, u.First_nm, u.Enroller_ID