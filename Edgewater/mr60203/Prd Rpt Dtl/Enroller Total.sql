declare @cmdStr nvarchar(4000), 
	@grpStr nvarchar(1000),
	@divStr	nvarchar(1000),
	@rangeStr nvarchar(1000),
	@enrollStr nvarchar(1000),
	@FromDate	smalldatetime,
	@ThruDate	smalldatetime,
	@Division_key	nvarchar(1000),
	@Group_key 	nvarchar(1000),
	@debug		int,
	@EnrollmentPeriod_key nvarchar(1000),
	@Grp_key nvarchar(1000)
set @EnrollmentPeriod_key = ''
--  grpStr is used to build the group string
set @grpStr = ''
--  divStr is used to build the division string
set @divStr = ''
--  rangeStr is used to build the date range string
set @rangeStr = ''
--  enrollStr is used to build the enrollment date or key string
set @enrollStr = ''
--  temporary holder for the group string
set @Grp_key = ''
set @ThruDate = ''
set @FromDate = ''
--
-- group  -------------------------------------------------
--
set @Group_key = 'ALL'
--  bcbst b2c6840d-0c98-4c17-880c-4f2122a69bbf
--	Ace 818b16ff-161e-4bf5-8d17-355d64510f7f
--set @Group_key = '''{818b16ff-161e-4bf5-8d17-355d64510f7f}'''
--	Chatt Chamber dd973c8a-1884-49fd-8e79-6bf5a83a3bb2
--	Hermitage Medical Associates 4b676ae6-34ea-466e-b3ac-2949c654a621
--  	Cibo Euro Cafe c569c724-c35c-41bf-b951-0d0fcb0d5ebd
set @Group_key = 'b2c6840d-0c98-4c17-880c-4f2122a69bbf'
--
-- enrollment period  or date range or none ---------------------------------------
--
--	Ace FA05C718-5C66-49D2-A67D-2984F18DF5A2
--set @EnrollmentPeriod_key = '''{FA05C718-5C66-49D2-A67D-2984F18DF5A2}'''
--	Chatt Chamber 8b1acbc0-ac07-4383-8271-379001be7097
--set @EnrollmentPeriod_key = '''{8b1acbc0-ac07-4383-8271-379001be7097}'''
--	Hermitage Medical Associates 878387af-f666-4e6c-bd5a-b9b90e401c62
-- CIBO EURO CAFE 1 - F6BD20CB-3663-44B9-B4E7-B10774AF72FC
--
--
--set @EnrollmentPeriod_key = 'F6BD20CB-3663-44B9-B4E7-B10774AF72FC'
--
--set @ThruDate = '12/18/2006'
--set @FromDate = '11/01/2006'
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
set @debug = 0
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
set @Grp_key = @Group_key
while (charindex(',',@Grp_key)>0)
begin

  if len(@grpStr) > 0
	set @grpStr = @grpStr + ',''{' + ltrim(rtrim(substring(@Grp_key, 1,charindex(',',@Grp_key)-1))) + '}'''
  else
	set @grpStr = @grpStr + '''{' + ltrim(rtrim(substring(@Grp_key, 1,charindex(',',@Grp_key)-1))) + '}'''
  set @Grp_key = substring(@Grp_key,charindex(',',@Grp_key) + 1,len(@Grp_key))
end

 if len(@grpStr) > 0
	set @grpStr = @grpStr + ',''{' + @Grp_key + '}'''
else
	set @grpStr = @grpStr + '''{' + @Grp_key + '}'''

if @debug > 1
	print 'groups ' + @grpStr

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
set @divStr = @Division_key
if @debug > 1
	print 'divs ' + @divStr

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
	-- set @enrollStr = '	and gep.EnrollFrom_dt <= ''' + cast(@FromDate as nvarchar(30)) + ''' AND	gep.EnrollThru_dt >= ''' + cast(@ThruDate as nvarchar(30)) + ''''
	set @enrollStr = ' and ep.enrollment_dt >= ''' + cast(@FromDate as nvarchar(30)) + ''' and ep.enrollment_dt <= ''' + cast(@ThruDate as nvarchar(30)) + ''''
end
else
begin
	if @EnrollmentPeriod_key <> ''
	begin
		if @debug > 1
			print 'Use the Enrollment Period'
		set @enrollStr = '	and gep.enrollmentperiod_key =  ''{' + @EnrollmentPeriod_key + '}'''
		--set @rangeStr = @enrollStr
	end
end

if @debug > 1
begin
	-- print 'range ' + @rangeStr
	print 'enroll ' + @enrollStr
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
begin
	print 'Use the following parm: '
	print 'group ' + @grpStr 
	print ' div ' + @divStr
	print 'Dates dt range ' + @rangeStr
	print ' enroll ' + @enrollStr
end

if @debug < 3
begin
drop table #PrdDetail
create table #PrdDetail (
	group_key	uniqueidentifier,
	user_key	uniqueidentifier,
	rowInd		char(1),
	product_key	uniqueidentifier,
	parent		uniqueidentifier,
	prdname		varchar(60),
	benefit		varchar(30),
	enrollmenttype	varchar(16),
	enrollfrom_dt	datetime,
	enrollthru_dt	datetime,
	rider		char(1),
	volprd		char(1),
	prods		int,
	totpremium	money
)
end
-- gather the product detail information

-- gather products that the group employees bought
set @cmdStr = '
insert into #PrdDetail (group_key, user_key, rowInd, product_key, parent, 
prdname, benefit, enrollmenttype, enrollfrom_dt, enrollthru_dt, rider, volprd, prods, totpremium)
-- products that the group employees bought
select e.group_key, u.user_key, ''E'', prd.product_key, prd.product_key as parent, prd.product_nm, 
	upper(Benefit.Short_nm) benefit, gep.EnrollmentType_vv enrollmenttype,
	gep.enrollfrom_dt, gep.enrollthru_dt,
	prd.rider_flg, prd.VoluntaryProduct_flg, 
	count(distinct cast(e.person_key as varchar(36))) as numprods,
	SUM( Case
		When(IsNull(EmployeeYearlyCost_amt, 0) + IsNull(EmployerYearlyCost_amt, 0)) - 
			(IsNull(EmployeeStartCost_amt, 0)  + IsNull(EmployerStartCost_amt, 0)) <= 0 
			Then 0
		Else (IsNull(EmployeeYearlyCost_amt, 0) + IsNull(EmployerYearlyCost_amt, 0)) - 
			 (IsNull(EmployeeStartCost_amt, 0)  + IsNull(EmployerStartCost_amt, 0)) 
	END ) TotalSubmittedPremium
from emp_person p
	JOIN EMP_Employee e ON e.Person_key = p.Person_key
	join EMP_EmployeeProduct ep ON ep.Employee_key = e.Person_key
	join emp_employeeproductenrollment epe on epe.employeeproduct_key = ep.employeeproduct_key
	-- find the enroller of this product
	JOIN EMP_EmployeeEnrollmentPeriod eep ON epe.EnrollmentPeriod_key = eep.EnrollmentPeriod_key
	 	and eep.Person_key = e.Person_key
	JOIN	GRP_Enroller ge ON ge.Enroller_key = epe.Enroller_key
	JOIN 	MSC_User u on u.User_key = ge.User_key
	-- Organizational information
	JOIN GRP_EnrollmentPeriod gep ON eep.EnrollmentPeriod_key = gep.EnrollmentPeriod_key
	inner join grp_group grp on gep.group_key = grp.group_key
	-- Product Information
	JOIN PRD_Customization c ON c.GroupProduct_key = ep.GroupProduct_key
	join grp_groupproduct gp on gp.groupproduct_key = ep.groupproduct_key
	JOIN GRP_GroupTableValue Benefit ON gp.BenefitType_key = Benefit.GroupTableValue_key
	join prd_product prd on prd.product_key = gp.product_key
where ep.EmployeeProductStatus_vv = ''ENROLLED''
'
if len(@grpStr) > 0 
	set @cmdStr = @cmdStr + '		and e.group_key in ( ' + @grpStr + ' )'
if len(@divStr) > 0
	set @cmdStr = @cmdStr + '	AND	grp.InternalDivision_key in ( ' + @divStr + ' )'
if len(@enrollStr) > 0
begin
	set @cmdStr = @cmdStr + @enrollStr
end
set @cmdStr = @cmdStr + '	group by e.group_key, u.user_key, prd.product_key, prd.product_nm,Benefit.Short_nm, gep.EnrollmentType_vv, gep.enrollfrom_dt, gep.enrollthru_dt, prd.rider_flg, prd.VoluntaryProduct_flg'
if @debug < 3
	exec (@cmdStr)
else
	print 'Products info ' + @cmdStr

--select * from #PrdDetail

set @cmdStr = '
insert into #PrdDetail (group_key, user_key, rowInd, prods, totpremium)
-- products that the group employees bought
select group_key, user_key, ''T'', sum(prods), sum(totpremium)
from #PrdDetail
group by group_key, user_key'
if @debug < 3
	exec (@cmdStr)
else
	print 'Products totals ' + @cmdStr

-- gather riders that the group employees bought
set @cmdStr = '
insert into #PrdDetail (group_key, user_key, rowInd, product_key, parent, 
prdname, benefit, enrollmenttype, enrollfrom_dt, enrollthru_dt, rider, volprd, prods, totpremium)
-- riders that the group employees bought
select e.group_key, u.user_key, ''E'', prd.product_key, rider.product_key as parent, prd.product_nm, 
	upper(Benefit.Short_nm) benefit, gep.EnrollmentType_vv enrollmenttype,
	gep.enrollfrom_dt, gep.enrollthru_dt,
	prd.rider_flg, prd.VoluntaryProduct_flg, 
	count(distinct cast(e.person_key as varchar(36))) as numprods,
	SUM( Case
		When(IsNull(epr.EmployeeYearlyCost_amt, 0) + IsNull(epr.EmployerYearlyCost_amt, 0)) - 
			(IsNull(EmployeeStartCost_amt, 0)  + IsNull(EmployerStartCost_amt, 0)) <= 0 
			Then 0
		Else (IsNull(epr.EmployeeYearlyCost_amt, 0) + IsNull(epr.EmployerYearlyCost_amt, 0)) - 
			 (IsNull(EmployeeStartCost_amt, 0)  + IsNull(EmployerStartCost_amt, 0)) 
	END ) TotalSubmittedPremium
from emp_person p
	JOIN EMP_Employee e ON e.Person_key = p.Person_key
	join EMP_EmployeeProduct ep ON ep.Employee_key = e.Person_key
	join emp_productrider epr on ep.employeeproduct_key = epr.employeeproduct_key
	join emp_employeeproductenrollment epe on epe.employeeproduct_key = ep.employeeproduct_key
	-- find the enroller of this product
	JOIN EMP_EmployeeEnrollmentPeriod eep ON epe.EnrollmentPeriod_key = eep.EnrollmentPeriod_key
	 	and eep.Person_key = e.Person_key
	JOIN	GRP_Enroller ge ON ge.Enroller_key = epe.Enroller_key
	JOIN 	MSC_User u on u.User_key = ge.User_key
	-- Organizational information
	JOIN GRP_EnrollmentPeriod gep ON eep.EnrollmentPeriod_key = gep.EnrollmentPeriod_key
	inner join grp_group grp on gep.group_key = grp.group_key
	-- Rider Information
	JOIN PRD_Customization c ON c.GroupProduct_key = ep.GroupProduct_key
	join grp_groupproduct gp on gp.groupproduct_key = ep.groupproduct_key
	JOIN GRP_GroupTableValue Benefit ON gp.BenefitType_key = Benefit.GroupTableValue_key
	join prd_product prd on prd.product_key = epr.rider_key
	join prd_rider rider on rider.rider_key = prd.product_key
where ep.EmployeeProductStatus_vv = ''ENROLLED''
'
if len(@grpStr) > 0 
	set @cmdStr = @cmdStr + '		and e.group_key in ( ' + @grpStr + ' )'
if len(@divStr) > 0
	set @cmdStr = @cmdStr + '	AND	grp.InternalDivision_key in ( ' + @divStr + ' )'
if len(@enrollStr) > 0
begin
	set @cmdStr = @cmdStr + @enrollStr
end
set @cmdStr = @cmdStr + 'group by e.group_key, u.user_key, prd.product_key, rider.product_key, prd.product_nm,Benefit.Short_nm, gep.EnrollmentType_vv, gep.enrollfrom_dt, gep.enrollthru_dt, prd.rider_flg, prd.VoluntaryProduct_flg'
if @debug < 3
	exec (@cmdStr)
else
	print 'Rider info ' + @cmdStr
--select * from #PrdDetail
if @debug < 3
begin
-- merge the product information with the group information
select 	#PrdDetail.group_key, #PrdDetail.user_key, 
	prods as NumProducts, totemps as Employees_Seen, totpremium as TotalSubmittedPremium
from #PrdDetail
	-- count how many employees enrolled in a product
	join (
	SELECT gep.Group_key, u.user_key, count(distinct cast(e.person_key as varchar(36))) as totemps
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
	WHERE ep.EmployeeProductStatus_vv = 'ENROLLED' or ep.EmployeeProductStatus_vv = 'WAIVED'
	group by gep.group_key, u.user_key
	) totemps on totemps.group_key = #PrdDetail.group_key and totemps.user_key = #PrdDetail.user_key
	-- get the group info
	inner join grp_group grp on #PrdDetail.group_key = grp.group_key
	inner JOIN MSC_Organization go ON go.Organization_key = grp.Group_key
	join msc_organization ido on grp.internaldivision_key = ido.organization_key
	-- get the enrollers info
	inner join msc_user mu on #PrdDetail.user_key = mu.user_key 
where rowInd = 'T'
ORDER BY #PrdDetail.group_key, #PrdDetail.user_key, parent, rider
end