-- production summary productivity
-- Production summary ds
declare @FromDate datetime, @ThruDate datetime,
@Division_key nvarchar(50),
@Group_key nvarchar(50)
set @FromDate = '11-09-2006'
set @ThruDate = '04-01-2007'
set @Division_key = 'ALL'
set @Group_key = '13FCA7FF-F87A-4501-91F0-CAE1C9F56BE2'

Declare @Enrollment TABLE
(
 Employee_key uniqueIdentifier, 
 Group_key uniqueIdentifier,
 EnrollmentPeriod_key uniqueIdentifier,
 Enroller_key uniqueIdentifier,
 User_key uniqueIdentifier
)

INSERT INTO @Enrollment(Employee_key, Group_key, EnrollmentPeriod_key, Enroller_key, User_key)

SELECT 	Distinct 
		ee.Employee_key, 
		emp.Group_key, 
		ee.EnrollmentPeriod_key, 
		ee.Enroller_key, 
		ee.User_key
FROM	v_EmployeeEnroller ee
JOIN	emp_employee emp 		ON ee.employee_key = emp.person_key
JOIN	v_ReportingGroup rg 	ON rg.IncludedGroup_key = emp.Group_key
JOIN	GRP_Group g 			ON g.Group_key = rg.IncludedGroup_key
JOIN	GRP_EnrollmentPeriod ep	ON ep.Group_key = rg.PrimaryGroup_key
WHERE	
		ep.EnrollFrom_dt >= @FromDate
		AND	ep.EnrollThru_dt <= @ThruDate
		AND	rg.ReportingGroup_key = IsNull(NullIf(@Group_key, 'ALL'), rg.ReportingGroup_key)
		AND	(g.InternalDivision_key = NullIf(@Division_key, 'ALL') OR NullIf(@Division_key, 'ALL') is Null)


SELECT 	EmpEnrGrp.User_key, 
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
			SELECT 	u.User_key, u.First_nm, u.Last_nm, u.Enroller_ID, Count(*)NumEmployees
			FROM 	EMP_Employee e 
			JOIN 	EMP_Person p 			ON e.Person_key = p.Person_key
			JOIN 	GRP_Group g 			ON e.Group_key = g.Group_key
			JOIN 	GRP_EnrollmentPeriod ep ON g.PrimaryGroup_key = ep.Group_key
			JOIN	GRP_Enroller enr 		ON ep.EnrollmentPeriod_key = enr.EnrollmentPeriod_key 
			JOIN	MSC_User u 				ON u.User_key = enr.User_key
			WHERE	p.PersonStatus_vv = 'ACTIVE' 
					AND enr.EnrollmentPeriod_key in (SELECT DISTINCT EnrollmentPeriod_key from @Enrollment)
			GROUP BY u.User_key, u.First_nm, u.Last_nm, u.Enroller_ID
		) EmpEnrGrp 
LEFT JOIN
		--Number of Groups Per Enroller--
		(	
			SELECT	User_key, Count(*) NumGroups
			FROM 	GRP_Group g
			JOIN 	GRP_EnrollmentPeriod gep ON g.Group_key = gep.Group_key
			JOIN 	GRP_Enroller ge 		 ON ge.EnrollmentPeriod_key = gep.EnrollmentPeriod_key
			WHERE 	gep.EnrollmentPeriod_key in (Select Distinct EnrollmentPeriod_key from @Enrollment)
			GROUP BY User_key
		)EnrGrp 
		ON EmpEnrGrp.User_key = EnrGrp.User_key
LEFT JOIN
		--Number of Employees Seen for this enroller--
		(
			SELECT	User_key, Count(Cast(Employee_key as varchar(36))) Employees_Seen 
			FROM 	@Enrollment 
			Group By User_key
		) EmpSeen 
		ON EmpSeen.User_key = EnrGrp.User_key
LEFT JOIN	
		-- Number of Voluntary Products Enrolled --
		(
			SELECT 	User_key, Count(*) VolProductsEnrolled
	        FROM 	@Enrollment enr
			JOIN	EMP_EmployeeProduct epr 			ON epr.Employee_key = enr.Employee_key
			JOIN 	GRP_GroupProduct gp 				ON gp.GroupProduct_key = epr.groupproduct_key
			JOIN 	PRD_Product p 						ON p.Product_key = gp.Product_key
			JOIN	EMP_EmployeeProductEnrollment epe 	ON epe.EmployeeProduct_key = epr.EmployeeProduct_key
			WHERE 	EmployeeProductStatus_vv = 'ENROLLED' AND p.VoluntaryProduct_flg = 'Y' AND epe.Enroller_key = enr.Enroller_key
			GROUP BY user_key
		) VolProductsEnrolled
	ON EmpEnrGrp.User_key = VolProductsEnrolled.User_key
LEFT JOIN
		-- Number of Non Voluntary Products Enrolled --
		(
			SELECT User_key, Count(*) Products
	        FROM 	@Enrollment enr
			JOIN	EMP_EmployeeProduct epr 			ON epr.Employee_key = enr.Employee_key
			JOIN 	GRP_GroupProduct gp 				ON gp.GroupProduct_key = epr.groupproduct_key
			JOIN 	PRD_Product p 						ON p.Product_key = gp.Product_key
			JOIN	EMP_EmployeeProductEnrollment epe 	ON epe.EmployeeProduct_key = epr.EmployeeProduct_key
			WHERE 	EmployeeProductStatus_vv = 'ENROLLED' AND p.VoluntaryProduct_flg <> 'Y' AND epe.Enroller_key = enr.Enroller_key
			GROUP BY user_key
		)  Products
		ON EmpEnrGrp.User_key = Products.User_key
LEFT JOIN
		-- of employees who purchased non voluntary products --
		(
			SELECT User_key, Count(Distinct Cast(enr.Employee_key as varchar(50))) VolProducts
			FROM 	@Enrollment enr
			JOIN	EMP_EmployeeProduct epr ON epr.Employee_key = enr.Employee_key
			JOIN 	GRP_GroupProduct gp 	ON gp.GroupProduct_key = epr.groupproduct_key
			JOIN 	PRD_Product p 			ON p.Product_key = gp.Product_key
			JOIN	EMP_EmployeeProductEnrollment epe 	ON epe.EmployeeProduct_key = epr.EmployeeProduct_key
			WHERE 	EmployeeProductStatus_vv = 'ENROLLED' AND p.VoluntaryProduct_flg = 'Y' AND epe.Enroller_key = enr.Enroller_key
			GROUP BY user_key
		) VolProducts
ON EmpEnrGrp.User_key = VolProducts.User_key
ORDER BY Last_nm, First_nm, Enroller_ID