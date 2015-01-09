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
--	Ace 818b16ff-161e-4bf5-8d17-355d64510f7f
--set @Group_key = '''{818b16ff-161e-4bf5-8d17-355d64510f7f}'''
--	Chatt Chamber dd973c8a-1884-49fd-8e79-6bf5a83a3bb2
--	Hermitage Medical Associates 4b676ae6-34ea-466e-b3ac-2949c654a621
--  	Cibo Euro Cafe c569c724-c35c-41bf-b951-0d0fcb0d5ebd
set @Group_key = 'dd973c8a-1884-49fd-8e79-6bf5a83a3bb2'
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
--set @ThruDate = '11/30/2006'
--set @FromDate = '11/20/2006'
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
	set @enrollStr = '	and gep.EnrollFrom_dt <= ''' + cast(@FromDate as nvarchar(30)) + ''' AND	gep.EnrollThru_dt >= ''' + cast(@ThruDate as nvarchar(30)) + ''''
	set @rangeStr = ' and ep.enrollment_dt >= ''' + cast(@FromDate as nvarchar(30)) + ''' and ep.enrollment_dt <= ''' + cast(@ThruDate as nvarchar(30)) + ''''
end
else
begin
	if @EnrollmentPeriod_key <> ''
	begin
		if @debug > 1
			print 'Use the Enrollment Period'
		set @enrollStr = '	and gep.enrollmentperiod_key =  ''{' + @EnrollmentPeriod_key + '}'''
		set @rangeStr = @enrollStr
	end
end

if @debug > 1
begin
	print 'range ' + @rangeStr
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
drop table #Productivity
create table #Productivity (
	group_key	uniqueidentifier,
	company		varchar(60),
	InternalDivision_nm	varchar(60),
	group_nm	varchar(60),
	group_id	varchar(30),
	enrollfromdt	datetime,
	enrollthrudt	datetime,
	user_key	uniqueidentifier,
	first_nm	varchar(60),
	last_nm		varchar(60),
	enroller	varchar(30),
	numemp		int,
	empseen		int,
	prods		int,
	volemps		int,
	volprods	int
)
end
-- gather the productivity information

-- get the group and enroller information we will gather productivity for
set @cmdStr = '
insert into #Productivity (group_key,company,InternalDivision_nm,
	group_nm,group_id,enrollfromdt,enrollthrudt,user_key,first_nm,
	last_nm,enroller,numemp,empseen,prods,volemps,volprods)
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
	inner join msc_user mu on   ge.user_key = mu.user_key'
if len(@grpStr) > 0 
	set @cmdStr = @cmdStr + ' where grp.group_key in ( ' + @grpStr + ' )'
if len(@divStr) > 0
	set @cmdStr = @cmdStr + '	AND	grp.InternalDivision_key in ( ' + @divStr + ' )'
if len(@enrollStr) > 0
begin
	if len(@grpStr) > 0 
		set @cmdStr = @cmdStr + @enrollStr
	else
		set @cmdStr = @cmdStr + 'where ' + @enrollStr
end
set @cmdStr = @cmdStr + ' ORDER BY Company_nm, Last_nm, First_nm, Enroller_ID'
if @debug < 3
	exec (@cmdStr)
else
	print 'Group info ' + @cmdStr

-- Count the employees in the group
set @cmdStr = '
declare @empgrpid uniqueidentifier,
	@empgrpCt int
declare EmpGrp scroll cursor for
select gep.group_key, count(*) NumEmployees from grp_enrollmentperiod gep
		inner join grp_group grp on gep.group_key = grp.group_key
		inner join emp_employeeenrollmentperiod eep on gep.enrollmentperiod_key = eep.enrollmentperiod_key
		inner join emp_employee emp on eep.person_key = emp.person_key
		inner join emp_person p on p.person_key = emp.person_key
		where p.personstatus_vv = ''ACTIVE'''
if len(@grpStr) > 0
	set @cmdStr = @cmdStr + '			and gep.group_key in ( ' + @grpStr + ' )'
if len(@divStr) > 0
	set @cmdStr = @cmdStr + '	AND	grp.InternalDivision_key in ( ' + @divStr + ' )'
if len(@enrollStr) > 0
	set @cmdStr = @cmdStr + @enrollStr

set @cmdStr = @cmdStr + '		group by gep.group_key
open EmpGrp
fetch first from EmpGrp into @empgrpid, @empgrpCt
while @@fetch_status = 0
begin
	update #Productivity set numemp = @empgrpCt where group_key = @empgrpid 
	fetch next from EmpGrp into @empgrpid, @empgrpCt
end
close EmpGrp
deallocate EmpGrp'
if @debug < 3
	exec (@cmdStr)
else
	print 'Emp Counts group ' + @cmdStr

-- Count the employees seen by the enroller
set @cmdStr = '
declare @seengrpid uniqueidentifier,
	@seenuser uniqueidentifier,
	@seenCt int
declare EmpSeen scroll cursor for
SELECT gep.Group_key, u.user_key, count(distinct cast(e.person_key as varchar(36)))
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
		WHERE ep.EmployeeProductStatus_vv = ''ENROLLED'''
if len(@grpStr) > 0
	set @cmdStr = @cmdStr + '			and gep.group_key in ( ' + @grpStr + ' )'
if len(@divStr) > 0
	set @cmdStr = @cmdStr + '	AND	grp.InternalDivision_key in ( ' + @divStr + ' )'
if len(@rangeStr) > 0
	set @cmdStr = @cmdStr + @rangeStr
set @cmdStr = @cmdStr + ' group by gep.group_key, u.user_key
open EmpSeen
fetch first from EmpSeen into @seengrpid, @seenuser, @seenCt
while @@fetch_status = 0
begin
	update #Productivity set empseen = @seenCt where group_key = @seengrpid and user_key = @seenuser
	fetch next from EmpSeen into @seengrpid, @seenuser, @seenCt
end
close EmpSeen
deallocate EmpSeen'
if @debug < 3
	exec (@cmdStr)
else
	print 'emp counts enroller' + @cmdStr

-- count the employee non-vol products information
set @cmdStr = '
declare @prodgrpid uniqueidentifier,
	@produser uniqueidentifier,
	@prodCt int
declare EmpProd scroll cursor for
SELECT gep.Group_key, u.user_key, Count(*) Products
		FROM EMP_Person p 
		JOIN EMP_Employee e ON e.Person_key = p.Person_key
		-- products that the user has enrolled in
		jOIN EMP_EmployeeProduct ep ON ep.Employee_key = e.Person_key
		join emp_employeeproductenrollment epe on epe.employeeproduct_key = ep.employeeproduct_key
		-- find the enroller of this product
		JOIN EMP_EmployeeEnrollmentPeriod eep ON epe.EnrollmentPeriod_key = eep.EnrollmentPeriod_key
		 and eep.Person_key = e.Person_key
		JOIN	GRP_Enroller ge ON ge.Enroller_key = epe.Enroller_key
		JOIN 	MSC_User u on u.User_key = ge.User_key
		-- Organizational information
		JOIN GRP_EnrollmentPeriod gep ON eep.EnrollmentPeriod_key = gep.EnrollmentPeriod_key
		inner join grp_group grp on gep.group_key = grp.group_key
		JOIN MSC_Organization o ON gep.Group_key = o.Organization_key
		-- Product Information
		JOIN PRD_Customization c ON c.GroupProduct_key = ep.GroupProduct_key
		join grp_groupproduct gp on gp.groupproduct_key = ep.groupproduct_key
		join prd_product prd on prd.product_key = gp.product_key
		WHERE ep.EmployeeProductStatus_vv = ''ENROLLED''
		and prd.VoluntaryProduct_flg <> ''Y'''		 
if len(@grpStr) > 0
	set @cmdStr = @cmdStr + '			and gep.group_key in ( ' + @grpStr + ' )'
if len(@divStr) > 0
	set @cmdStr = @cmdStr + '	AND	grp.InternalDivision_key in ( ' + @divStr + ' )'
if len(@rangeStr) > 0
	set @cmdStr = @cmdStr + @rangeStr
set @cmdStr = @cmdStr + '		 group by gep.group_key, u.user_key

open EmpProd
fetch first from EmpProd into @prodgrpid, @produser, @prodCt
while @@fetch_status = 0
begin
	update #Productivity set prods = @prodCt where group_key = @prodgrpid and user_key = @produser
	fetch next from EmpProd into @prodgrpid, @produser, @prodCt
end
close EmpProd
deallocate EmpProd'
if @debug < 3
	exec (@cmdStr)
else
	print 'emp non vol prods ' + @cmdStr

-- count the employees who have selected vol prods
set @cmdStr = '
declare @volgrpid uniqueidentifier,
	@voluser uniqueidentifier,
	@volCt int
declare VolProd scroll cursor for
SELECT gep.Group_key, u.user_key, count(distinct cast(e.person_key as varchar(36))) as volemps
		FROM EMP_Person p 
		JOIN EMP_Employee e ON e.Person_key = p.Person_key
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
		JOIN MSC_Organization o ON gep.Group_key = o.Organization_key
		-- Product Information
		JOIN PRD_Customization c ON c.GroupProduct_key = ep.GroupProduct_key
		join grp_groupproduct gp on gp.groupproduct_key = ep.groupproduct_key
		join prd_product prd on prd.product_key = gp.product_key
		WHERE ep.EmployeeProductStatus_vv = ''ENROLLED'' 
		and prd.VoluntaryProduct_flg = ''Y'''
if len(@grpStr) > 0
	set @cmdStr = @cmdStr + '			and gep.group_key in ( ' + @grpStr + ' )'
if len(@divStr) > 0
	set @cmdStr = @cmdStr + '	AND	grp.InternalDivision_key in ( ' + @divStr + ' )'
if len(@rangeStr) > 0
	set @cmdStr = @cmdStr + @rangeStr
set @cmdStr = @cmdStr + '		group by gep.group_key, u.user_key

open VolProd
fetch first from VolProd into @volgrpid, @voluser, @volCt
while @@fetch_status = 0
begin
	update #Productivity set volemps = @volCt where group_key = @volgrpid and user_key = @voluser
	fetch next from VolProd into @volgrpid, @voluser, @volCt
end
close VolProd
deallocate VolProd'
if @debug < 3
	exec (@cmdStr)
else
	print 'emp vol prods emp ct ' + @cmdStr



-- count the employee vol products information
set @cmdStr = '
declare @volgrpid uniqueidentifier,
	@voluser uniqueidentifier,
	@volCt int
declare VolProd scroll cursor for
SELECT gep.Group_key, u.user_key, Count(*) NumVolProducts
		FROM EMP_Person p 
		JOIN EMP_Employee e ON e.Person_key = p.Person_key
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
		JOIN MSC_Organization o ON gep.Group_key = o.Organization_key
		-- Product Information
		JOIN PRD_Customization c ON c.GroupProduct_key = ep.GroupProduct_key
		join grp_groupproduct gp on gp.groupproduct_key = ep.groupproduct_key
		join prd_product prd on prd.product_key = gp.product_key
		WHERE ep.EmployeeProductStatus_vv = ''ENROLLED'' 
		and prd.VoluntaryProduct_flg = ''Y'''
if len(@grpStr) > 0
	set @cmdStr = @cmdStr + '			and gep.group_key in ( ' + @grpStr + ' )'
if len(@divStr) > 0
	set @cmdStr = @cmdStr + '	AND	grp.InternalDivision_key in ( ' + @divStr + ' )'
if len(@rangeStr) > 0
	set @cmdStr = @cmdStr + @rangeStr
set @cmdStr = @cmdStr + '		group by gep.group_key, u.user_key

open VolProd
fetch first from VolProd into @volgrpid, @voluser, @volCt
while @@fetch_status = 0
begin
	update #Productivity set volprods = @volCt where group_key = @volgrpid and user_key = @voluser
	fetch next from VolProd into @volgrpid, @voluser, @volCt
end
close VolProd
deallocate VolProd'
if @debug < 3
	exec (@cmdStr)
else
	print 'emp vol prods ' + @cmdStr

if @debug < 3
begin
	select prod.*, go.Logo_bin from #Productivity prod
		inner join grp_group grp on prod.group_key = grp.group_key
		inner JOIN MSC_Organization go ON go.Organization_key = grp.Group_key
end