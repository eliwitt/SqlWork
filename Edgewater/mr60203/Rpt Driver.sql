declare @cmdStr nvarchar(1000),
	@orgStr nvarchar(4000),
	@debug	int,
	@FromDate	smalldatetime,
	@ThruDate	smalldatetime,
	@Division_key	nvarchar(1000),
	@Group_key nvarchar(1000)
set @ThruDate = '06/30/2007'
set @FromDate = '01/01/2005'
set @Group_key = '{818b16ff-161e-4bf5-8d17-355d64510f7f}'
--set @Group_key = '{4b676ae6-34ea-466e-b3ac-2949c654a621}'
--set @Division_key = '{E2BB4AAB-78D4-4919-9F79-415BC7BEBFEB}'
--set @Group_key = 'ALL'
set @Division_key = 'ALL'
set @debug = 1
-------------------------------------------------------------------

if @Group_key <> 'ALL'
	goto Group_Script
if @Division_key <> 'ALL'
	goto Div_Script

-- Retrieve all rows for the Groups and divisions
if @debug = 1
	print 'Get them ALL'

--
--  Use what date?
--

goto End_Of_Script
--
-- the following will retrieve the group data
--
Group_Script:
if @Division_key <> 'ALL'
	goto Div_Script
if @debug = 1
	print 'In the Group process'

--
--  Use what date?
--

goto End_Of_Script
--
-- get the divisions
--
Div_Script:
if @Group_key <> 'ALL'
	goto Get_Both
if @debug = 1
	print 'In the Div process'

--
--  Use what date?
--

goto End_Of_Script
--
-- retrieve both a group and a div
--
Get_Both:
if @debug = 1
	print 'In the Get_Both process'

--
--  Use what date?
--

goto End_Of_Script
--
-- The temp table has been populated and now will be used
--
End_Of_Script:

/*
SELECT  distinct u.Last_nm, 
		u.First_nm,
		u.Enroller_ID,
		EnrollmentType_vv,
		AccountType_vv,
		go.Organization_nm GroupName,
		go.OrganizationShort_nm GroupID,
		Benefit.Short_nm Benefit,
		Carrier.OrganizationShort_nm Carrier,
		ProductDisplay_nm, gp.GroupProduct_key,
		VoluntaryProduct_flg,
		IsNull(TotalSubmittedPremium, 0) TotalSubmittedPremium,
		IsNull(Products, 0) NumProducts,
		IsNull(Employees_Seen, 0) Employees_Seen ,
		IsNull(Enroller_Employees_Seen, 0) Enroller_Employees_Seen
from	@Enrollment e
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
			FROM 		@Enrollment e
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
			From	@Enrollment e
			Group By e.User_key, e.Group_key
		) Emp_Seen ON e.User_key = Emp_Seen.User_key AND e.Group_key = Emp_Seen.Group_key
LEFT JOIN
		(
			Select 	User_key, Count(Cast(Employee_key as varchar(36))) Enroller_Employees_Seen
			from 	@Enrollment
			Group by User_key
		) Enroller_Emp_Seen
		On	 e.User_key = Enroller_Emp_Seen.User_key

WHERE 		gp.ConfigurationStatus_vv = 'ACTIVE' OR IsNull(Products, 0) > 0
Order By 	u.Last_nm, u.First_nm, u.Enroller_ID, go.OrganizationShort_nm
*/