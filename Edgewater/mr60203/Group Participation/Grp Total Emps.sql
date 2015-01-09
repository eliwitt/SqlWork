-- Multi Groups
declare @cmdStr		nvarchar(4000),
	@orgStr		nvarchar(4000),
	@grpctStr	nvarchar(4000),
	@debug		int,
	@Group_key 	nvarchar(1000),
	@Grp_key	nvarchar(1000),
	@EnrollmentPeriod_key nvarchar(1000),
	@ErrorMsg	varchar(255)
set @cmdStr = ''
set @orgStr = ''
set @grpctStr = ''
set @Grp_key = ''
--
-- group  -------------------------------------------------
--
set @Group_key = 'ALL'
--	Ace 818b16ff-161e-4bf5-8d17-355d64510f7f
--set @Group_key = '818b16ff-161e-4bf5-8d17-355d64510f7f'
--	Chatt Chamber dd973c8a-1884-49fd-8e79-6bf5a83a3bb2
--	Hermitage Medical Associates 4b676ae6-34ea-466e-b3ac-2949c654a621
--set @Group_key = 'dd973c8a-1884-49fd-8e79-6bf5a83a3bb2'
--  Cibo Euro C569C724-C35C-41BF-B951-0D0FCB0D5EBD
--  MARLIN FINANCIAL & LEASING CORP  1062AB2F-2A93-4D29-B45C-115AFC0B3B85
--AMERICAN HOME DESIGN INC  A5099AF6-2493-454C-9818-DA7D139861BF
--
--	Pure Life Water eb23735d-336c-42cb-a26e-bcefc35534cc
--
set @Group_key = 'eb23735d-336c-42cb-a26e-bcefc35534cc'
--
-- enrollment period  ---------------------------------------
--
--	Ace FA05C718-5C66-49D2-A67D-2984F18DF5A2
--set @EnrollmentPeriod = '''{FA05C718-5C66-49D2-A67D-2984F18DF5A2}'''
--	Chatt Chamber 8b1acbc0-ac07-4383-8271-379001be7097
--set @EnrollmentPeriod = '''{8b1acbc0-ac07-4383-8271-379001be7097}'''
--	Hermitage Medical Associates 878387af-f666-4e6c-bd5a-b9b90e401c62
--set @EnrollmentPeriod_key = '8b1acbc0-ac07-4383-8271-379001be7097'
--
--  set @debug to an integer and you will get print statements
--  0 = turn off
--  1 = high level 
--  2 = detail
--  3 = stop after the build of the cmd str
set @debug = 0
-- add the selected groups
if @Group_key = 'ALL'
    goto All_grps
if @debug > 0
	print 'Use specific groups ' + @Group_key
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
set @grpctStr =  @orgStr
set @orgStr = 'WHERE rg.ReportingGroup_key in (' + @orgStr + ')'
if @debug > 1
	print 'Use specific groups for counting ' + @grpctStr + ' and to locate group results ' + @orgStr

ALL_grps:
if @EnrollmentPeriod_key <> ''
begin
	if @debug > 1
		print 'Use the Enrollment Period'
	if len(@orgStr) > 0
		set @orgStr = @orgStr + ' and gep.enrollmentperiod_key =  ''{' + @EnrollmentPeriod_key + '}'''
	else
		set @orgStr = 'where gep.enrollmentperiod_key = ''{' + @EnrollmentPeriod_key + '}'''
end

set @cmdStr = '
SELECT g.Group_key, upper(g.Company_nm) as Company_nm, o.Logo_bin Logo,
upper(ido.Organization_nm) InternalDivision_nm,	upper(o.Organization_nm) Group_nm,
upper(o.OrganizationShort_nm) Group_ID,	gep.enrollfrom_dt, 
gep.enrollthru_dt, upper(org.organizationshort_nm) as carrier,
upper(grpval.short_nm) as coverage, upper(prod.product_nm) as product_nm,
ep.EmployeeProductStatus_vv, ep.waiverreason_vv, empprd.empclass,
IsNull(gep.NumberofEmployees_val, 0) as empEligible, GrpEmp.grpempct,
count(c.ProductDisplay_nm) selCt
FROM EMP_Person p 
--  Find out if the person is an employee
JOIN EMP_Employee e ON e.Person_key = p.Person_key
--  After the completion button is pressed the data will be located here
JOIN EMP_PriorEmployeeProduct ep ON ep.Employee_key = e.Person_key
--  Emp enrollment period data
JOIN EMP_EmployeeEnrollmentPeriod eep ON eep.Person_key = e.Person_key
--  Group''s enrollment
JOIN GRP_EnrollmentPeriod gep ON eep.EnrollmentPeriod_key = gep.EnrollmentPeriod_key
--  Group''s Org
JOIN MSC_Organization o ON gep.Group_key = o.Organization_key
-- Group detailed info
join grp_group g on g.Group_key = o.Organization_key
-- Group Internal division
join msc_organization ido on g.internaldivision_key = ido.organization_key
--  The group''s organization data
JOIN v_ReportingGroup rg ON gep.Group_key = rg.IncludedGroup_key
--  The group''s custization of the products
JOIN PRD_Customization c ON c.GroupProduct_key = ep.GroupProduct_key
--  locate the group product info
join grp_groupproduct grpprd on grpprd.groupproduct_key = c.GroupProduct_key
--  retrieve all of the groups products
join prd_product prod on grpprd.product_key = prod.product_key
--  for each product get their carrier short name
join msc_organization org on prod.carrier_key = org.organization_key
--  for each product get their coverage type
join grp_grouptablevalue grpval on grpprd.benefittype_key = grpval.grouptablevalue_key
--  retrieve the employees prod selection
join (
select distinct ed.person_key, upper(gtv.short_nm) as empclass from
	emp_employee e
	join emp_employeedata ed on e.person_key = ed.person_key
	join emp_employeetablevalue etv on ed.person_key = etv.person_key
	join grp_grouptablevalue gtv on etv.grouptablevalue_key = gtv.grouptablevalue_key
	where gtv.grouptablevalue_key in ( select answerreference_key from ans_answervalue
			where answer_key = (select answer_key from ans_answer
				where answer_id = ''54'') and 
				group_key in (' + @grpctStr + ')
				)
	and e.group_key in (' + @grpctStr + ')
) empprd on e.person_key = empprd.person_key
--  count the employees who have activity in aa products
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
'
+ @orgStr +
'
group by g.Group_key, g.Company_nm, o.Logo_bin, ido.Organization_nm, o.Organization_nm,
o.OrganizationShort_nm, gep.enrollfrom_dt, gep.enrollthru_dt,
org.organizationshort_nm, grpval.short_nm,prod.product_nm, ep.EmployeeProductStatus_vv, 
ep.waiverreason_vv, empprd.empclass, gep.NumberofEmployees_val,
GrpEmp.grpempct
order by g.Group_key, g.Company_nm, o.Logo_bin, ido.Organization_nm, o.Organization_nm,
o.OrganizationShort_nm, gep.enrollfrom_dt, gep.enrollthru_dt,
org.organizationshort_nm, grpval.short_nm,prod.product_nm, ep.EmployeeProductStatus_vv, 
ep.waiverreason_vv
'
if @debug > 1
	print @cmdStr
exec(@cmdStr)