-- ProductDetail from the Product Report Detail
declare @FromDate datetime, @ThruDate datetime,
@Division_key nvarchar(50),
@Group_key nvarchar(50)
set @FromDate = '11-01-2006'
set @ThruDate = '04-30-2007'
set @Division_key = 'ALL'
set @Group_key = '{13fca7ff-f87a-4501-91f0-cae1c9f56be2}'

Declare @Enrollment TABLE
(
 Employee_key uniqueIdentifier, 
 Group_key uniqueIdentifier,
 EnrollmentPeriod_key uniqueIdentifier,
 Enroller_key uniqueIdentifier,
 User_key uniqueIdentifier
)
INSERT INTO @Enrollment(Employee_key, Group_key, EnrollmentPeriod_key, Enroller_key, User_key)

SELECT 	Distinct ee.Employee_key, 
		rg.ReportingGroup_key GroupKey, 
		ee.EnrollmentPeriod_key, 
		ee.Enroller_key, 
		ee.User_key
FROM	v_EmployeeEnroller ee
JOIN	EMP_Employee e 			ON e.Person_key = ee.Employee_key
join	EMP_EmployeeProduct ep		on e.Person_key = ep.Employee_key
JOIN	EMP_EmployeeProductEnrollment epe ON epe.EmployeeProduct_key = ep.EmployeeProduct_key
JOIN	EMP_EmployeeEnrollmentPeriod eep ON eep.Person_key = e.Person_key AND eep.EnrollmentPeriod_key = epe.EnrollmentPeriod_key
JOIN	v_ReportingGroup rg 		ON rg.IncludedGroup_key = e.Group_key
JOIN	GRP_Group g         		ON g.Group_key = e.Group_key
JOIN	GRP_EnrollmentPeriod gep		ON gep.Group_key = rg.PrimaryGroup_key
WHERE	gep.EnrollFrom_dt >= @FromDate
		AND	gep.EnrollThru_dt <= @ThruDate
		AND ep.EmployeeProductStatus_vv = 'ENROLLED'
		AND eep.EnrollmentStatus_vv = 'ENROLLED'
		AND	rg.ReportingGroup_key = IsNull(NullIf(@Group_key, 'ALL'), rg.ReportingGroup_key)
		AND	(g.InternalDivision_key = NullIf(@Division_key, 'ALL') OR NullIf(@Division_key, 'ALL') is Null)
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