declare @cmdStr nvarchar(4000), 
	@orgStr nvarchar(1000), 
	@TailStr nvarchar(1000),
	@FromDate	smalldatetime,
	@ThruDate	smalldatetime,
	@Division_key	nvarchar(1000),
	@Group_key 	nvarchar(1000),
	@EnrollmentPeriod_key nvarchar(1000),
	@Grp_key nvarchar(1000)
set @orgStr = ''
--
-- group  -------------------------------------------------
--
set @Group_key = 'ALL'
--	Ace 818b16ff-161e-4bf5-8d17-355d64510f7f
--set @Group_key = '''{818b16ff-161e-4bf5-8d17-355d64510f7f}'''
--	Chatt Chamber dd973c8a-1884-49fd-8e79-6bf5a83a3bb2
--	Hermitage Medical Associates 4b676ae6-34ea-466e-b3ac-2949c654a621
--  	Cibo Euro Cafe c569c724-c35c-41bf-b951-0d0fcb0d5ebd
set @Group_key = 'c569c724-c35c-41bf-b951-0d0fcb0d5ebd,dd973c8a-1884-49fd-8e79-6bf5a83a3bb2'
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
print @orgStr
-- gather the productivity information
set @cmdStr = 'select grp.company_nm, UPPER(mu.first_nm) First_nm, UPPER(mu.last_nm) Last_nm, UPPER(Enroller_ID) Enroller_ID, '
set @cmdStr = @cmdStr + ' NumEmployees, NumEmpSeen, IsNull(Products, 0) Products, IsNull(NumVolProducts, 0) NumVolProducts'
set @cmdStr = @cmdStr + ' from grp_enrollmentperiod gep'
-- enrollers in the group
set @cmdStr = @cmdStr + ' inner join grp_group grp on gep.group_key = grp.group_key'
set @cmdStr = @cmdStr + ' inner join grp_enroller ge on   ge.EnrollmentPeriod_key = gep.EnrollmentPeriod_key'
set @cmdStr = @cmdStr + ' inner join msc_user mu on   ge.user_key = mu.user_key'

-- Count the employees in the group
set @cmdStr = @cmdStr + ' left join ( select ge.group_key, count(*) NumEmployees from grp_enrollmentperiod ge'
set @cmdStr = @cmdStr + ' inner join emp_employeeenrollmentperiod eep on ge.enrollmentperiod_key = eep.enrollmentperiod_key'
set @cmdStr = @cmdStr + ' inner join emp_employee emp on eep.person_key = emp.person_key'
set @cmdStr = @cmdStr + ' inner join emp_person p on p.person_key = emp.person_key'
set @cmdStr = @cmdStr + ' where ge.group_key in ( ' + @orgStr + ' ) and p.personstatus_vv = ''ACTIVE'' '
set @cmdStr = @cmdStr + ' group by ge.group_key'
set @cmdStr = @cmdStr + ' ) NumEmployees on NumEmployees.group_key = grp.group_key'

-- count the employee products information
set @cmdStr = @cmdStr + ' left join ( SELECT gep.Group_key, u.user_key, Count(*) Products'
set @cmdStr = @cmdStr + ' FROM EMP_Person p '
set @cmdStr = @cmdStr + ' JOIN EMP_Employee e ON e.Person_key = p.Person_key'
-- products that the user has enrolled in
set @cmdStr = @cmdStr + ' jOIN EMP_EmployeeProduct ep ON ep.Employee_key = e.Person_key'
set @cmdStr = @cmdStr + ' join emp_employeeproductenrollment epe on epe.employeeproduct_key = ep.employeeproduct_key'
-- find the enroller of this product
set @cmdStr = @cmdStr + ' JOIN EMP_EmployeeEnrollmentPeriod eep ON epe.EnrollmentPeriod_key = eep.EnrollmentPeriod_key'
set @cmdStr = @cmdStr + ' and eep.Person_key = e.Person_key'
set @cmdStr = @cmdStr + ' JOIN	GRP_Enroller ge ON ge.Enroller_key = epe.Enroller_key'
set @cmdStr = @cmdStr + ' JOIN 	MSC_User u on u.User_key = ge.User_key'
-- Organizational information
set @cmdStr = @cmdStr + ' JOIN GRP_EnrollmentPeriod gep ON eep.EnrollmentPeriod_key = gep.EnrollmentPeriod_key'
set @cmdStr = @cmdStr + ' JOIN MSC_Organization o ON gep.Group_key = o.Organization_key'
-- Product Information
set @cmdStr = @cmdStr + ' JOIN PRD_Customization c ON c.GroupProduct_key = ep.GroupProduct_key'
set @cmdStr = @cmdStr + ' join grp_groupproduct gp on gp.groupproduct_key = ep.groupproduct_key'
set @cmdStr = @cmdStr + ' join prd_product prd on prd.product_key = gp.product_key'
set @cmdStr = @cmdStr + ' WHERE gep.group_key in ( ' + @orgStr + ') '
set @cmdStr = @cmdStr + ' and ep.EmployeeProductStatus_vv = ''ENROLLED'''
set @cmdStr = @cmdStr + ' and prd.VoluntaryProduct_flg <> ''Y'''
set @cmdStr = @cmdStr + ' group by gep.group_key, u.user_key'
set @cmdStr = @cmdStr + ' ) Products on Products.Group_key = grp.group_key and Products.user_key = mu.user_key'

-- count the employee vol products information
set @cmdStr = @cmdStr + ' left join ( SELECT gep.Group_key, u.user_key, Count(*) NumVolProducts'
set @cmdStr = @cmdStr + ' FROM EMP_Person p '
set @cmdStr = @cmdStr + ' JOIN EMP_Employee e ON e.Person_key = p.Person_key'
-- products that the user has enrolled in
set @cmdStr = @cmdStr + ' JOIN EMP_EmployeeProduct ep ON ep.Employee_key = e.Person_key'
set @cmdStr = @cmdStr + ' join emp_employeeproductenrollment epe on epe.employeeproduct_key = ep.employeeproduct_key'
-- find the enroller of this product
set @cmdStr = @cmdStr + ' JOIN EMP_EmployeeEnrollmentPeriod eep ON epe.EnrollmentPeriod_key = eep.EnrollmentPeriod_key'
set @cmdStr = @cmdStr + '  and eep.Person_key = e.Person_key'
set @cmdStr = @cmdStr + ' JOIN	GRP_Enroller ge ON ge.Enroller_key = epe.Enroller_key'
set @cmdStr = @cmdStr + ' JOIN 	MSC_User u on u.User_key = ge.User_key'
-- Organizational information
set @cmdStr = @cmdStr + ' JOIN GRP_EnrollmentPeriod gep ON eep.EnrollmentPeriod_key = gep.EnrollmentPeriod_key'
set @cmdStr = @cmdStr + ' JOIN MSC_Organization o ON gep.Group_key = o.Organization_key'
-- Product Information
set @cmdStr = @cmdStr + ' JOIN PRD_Customization c ON c.GroupProduct_key = ep.GroupProduct_key'
set @cmdStr = @cmdStr + ' join grp_groupproduct gp on gp.groupproduct_key = ep.groupproduct_key'
set @cmdStr = @cmdStr + ' join prd_product prd on prd.product_key = gp.product_key'
set @cmdStr = @cmdStr + ' WHERE gep.group_key in ( ' + @orgStr + ') and ep.EmployeeProductStatus_vv = ''ENROLLED'' and prd.VoluntaryProduct_flg = ''Y'''
set @cmdStr = @cmdStr + ' group by gep.group_key, u.user_key'
set @cmdStr = @cmdStr + ' ) NumVolProducts on NumVolProducts.Group_key = grp.group_key and NumVolProducts.user_key = mu.user_key'

-- count the employees seen
set @cmdStr = @cmdStr + ' left join( SELECT gep.Group_key, u.user_key, count(distinct cast(e.person_key as varchar(36)))'
set @cmdStr = @cmdStr + ' FROM EMP_Employee e'
-- products that the user has enrolled in
set @cmdStr = @cmdStr + ' JOIN EMP_EmployeeProduct ep ON ep.Employee_key = e.Person_key'
set @cmdStr = @cmdStr + ' join emp_employeeproductenrollment epe on epe.employeeproduct_key = ep.employeeproduct_key'
-- find the enroller of this product
set @cmdStr = @cmdStr + ' JOIN EMP_EmployeeEnrollmentPeriod eep ON epe.EnrollmentPeriod_key = eep.EnrollmentPeriod_key'
set @cmdStr = @cmdStr + '  and eep.Person_key = e.Person_key'
set @cmdStr = @cmdStr + ' JOIN	GRP_Enroller ge ON ge.Enroller_key = epe.Enroller_key'
set @cmdStr = @cmdStr + ' JOIN 	MSC_User u on u.User_key = ge.User_key'
-- Organizational information
set @cmdStr = @cmdStr + ' JOIN GRP_EnrollmentPeriod gep ON eep.EnrollmentPeriod_key = gep.EnrollmentPeriod_key'
set @cmdStr = @cmdStr + ' WHERE gep.group_key in (' + @orgStr + ')'
set @cmdStr = @cmdStr + ' and ep.EmployeeProductStatus_vv = ''ENROLLED'''
set @cmdStr = @cmdStr + ' group by gep.group_key, u.user_key order by gep.group_key, u.user_key'
set @cmdStr = @cmdStr + ' ) NumEmpSeen on NumEmpSeen.Group_key = grp.group_key and NumEmpSeen.user_key = mu.user_key'

set @cmdStr = @cmdStr + ' where grp.group_key in ( ' + @orgStr + ' )'
set @cmdStr = @cmdStr + ' ORDER BY Company_nm, Last_nm, First_nm, Enroller_ID'
print 'len ' + cast(len(@cmdStr) as nvarchar(5)) + @cmdStr
declare @tmpcol nvarchar(100)
exec sp_executesql @cmdStr, N'@tmpcol nvarchar(100) OUTPUT', @tmpcol OUTPUT

/*
	-- collect the employee product information
	left join (
		SELECT gep.Group_key, 
			u.user_key, u.first_nm as enFirst_nm, u.last_nm as enLast_nm,
			c.ProductDisplay_nm, prd.voluntaryproduct_flg,
			ep.EmployeeProductStatus_vv
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
		JOIN MSC_Organization o ON gep.Group_key = o.Organization_key
		-- Product Information
		JOIN PRD_Customization c ON c.GroupProduct_key = ep.GroupProduct_key
		join grp_groupproduct gp on gp.groupproduct_key = ep.groupproduct_key
		join prd_product prd on prd.product_key = gp.product_key
		WHERE gep.group_key = '{dd973c8a-1884-49fd-8e79-6bf5a83a3bb2}' 
			and ep.EmployeeProductStatus_vv = 'ENROLLED'
	) EmpPrds on EmpPrds.user_key = mu.user_key
*/