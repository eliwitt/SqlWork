declare @Group_key uniqueidentifier,
	@EnrollmentPeriod_key uniqueidentifier,
	@PreTax_flg nvarchar(10),
	@ChangeType nvarchar(10),
	@Department_key varchar(50),
	@Carrier_key varchar(50)

set @Group_key = 'dd973c8a-1884-49fd-8e79-6bf5a83a3bb2'
set @EnrollmentPeriod_key = '8b1acbc0-ac07-4383-8271-379001be7097'
set @PreTax_flg = 'ALL'
set @ChangeType = 'ALL'
set @Department_key = 'ALL'
set @Carrier_key = 'ALL'

Select 1 grouping, * from
(SELECT	DISTINCT UPPER(gc.Group_ID) Group_ID,
		UPPER(Department) Department,
		pers.Person_key,
		IsNull(pers.SSN_txt, '000000000') SSN_txt,
		UPPER(pers.Employee_ID) Employee_ID,
		Cast(pers.Person_key as varchar(40)) emp,
		UPPER(pers.Last_nm) Last_nm,
		UPPER(pers.First_nm) First_nm,
		UPPER(gtv.Short_nm) Benefit,
		UPPER(c.OrganizationShort_nm) Carrier_nm,
		UPPER(cz.ProductDisplay_nm) Product_nm,
		UPPER(IsNull(PlanName, '---')) as BenefitPlan,
		CASE MC.CoverageShort_nm
		WHEN 'Spouse/Dep' THEN 'E'
		WHEN 'Emp' THEN 'C'
		WHEN 'Spouse' THEN 'F'
		WHEN 'Dep' THEN 'G'
		WHEN 'Emp/Spouse/Dep' THEN 'A'
		WHEN 'Emp/Dep' THEN 'D'
		WHEN 'Emp/Spouse' THEN 'B'
		END TypeContract,
		Case eep.EmployeeProductStatus_vv
			WHEN 'WAIVED' Then ''
			ELSE eep.CoverageEffective_dt
		END CoverageEffective_dt,
		UPPER(eep.EmployeeProductStatus_vv) EmployeeProductStatus_vv,
		CASE eep.EmployeeProductStatus_vv
			WHEN 'WAIVED' THEN 'N/A'
			ELSE eep.PreTax_flg
		END PreTax_flg,
		empprod.employeeproduct_key,
		IsNull(eep.DeductionsPerYear_val, 0) DeductionsPerYear_val,
		eep.EmployeeYearlyCost_amt,
		eep.EmployerYearlyCost_amt,

		IsNull(eep.EmployeeYearlyCost_amt, 0) / IsNull(eep.DeductionsPerYear_val, 1)  EECostPerDeduction,
		IsNull(eep.EmployerYearlyCost_amt, 0) / IsNull(eep.DeductionsPerYear_val, 1)  
ERCostPerDeduction,
		IsNull(eep.EmployeesTARTCost_amt, 0) / IsNull(eep.DeductionsPerYear_val, 1)  PriorEECostPerDeduction,
		eep.EmployeeStartCost_amt PriorEmployeeYearlyCost_amt,
		eep.EmployerStartCost_amt PriorEmployerYearlyCost_amt,
	(IsNull(eep.EmployeeStartCost_amt, 0) + IsNull(eep.EmployerStartCost_amt, 0)) PriorYearlyCost,
		UPPER(u.Enroller_ID) Enroller_ID,
		UPPER(RTrim(u.Last_nm) + ', ' + u.First_nm) Emp_Name,
	CASE WHEN 	Round(IsNull(eep.EmployeeYearlyCost_amt, 0),2) + Round(IsNull(eep.EmployerYearlyCost_amt, 0),2) =  Round(IsNull(eep.EmployeeStartCost_amt, 0),2) + Round(IsNull(eep.EmployerStartCost_amt, 0), 2)
			THEN ''
	ELSE
		CASE WHEN IsNull(eep.EmployeeYearlyCost_amt, 0) + IsNull(eep.EmployerYearlyCost_amt, 0) >  IsNull(eep.EmployeeStartCost_amt, 0) + IsNull(eep.EmployerStartCost_amt, 0) 
		THEN
			CASE WHEN IsNull(eep.EmployeeStartCost_amt, 0) + IsNull(eep.EmployerStartCost_amt, 0) = 0
				THEN 'ADD'
			ELSE	'INCREASE'
			END
		ELSE
			CASE WHEN IsNull(eep.EmployeeYearlyCost_amt, 0) + IsNull(eep.EmployerYearlyCost_amt, 0) = 0
				THEN 'DROP'
			ELSE	'DECREASE'
			END
		END
END Change
FROM 	v_EmployeePerson pers
JOIN		GRP_Group g
	ON	g.Group_key = pers.Group_key
JOIN		v_ReportingGroup rg 
	ON	g.Group_key = rg.IncludedGroup_key
JOIN		MSC_Organization go
	ON	g.Group_key = go.Organization_key
JOIN		GRP_EnrollmentPeriod gep
	ON	gep.Group_key = rg.PrimaryGroup_key
JOIN		EMP_PriorEmployeeProduct eep	
	ON	pers.Person_key = eep.Employee_key
		and gep.enrollmentperiod_key = eep.enrollmentperiod_key
JOIN		EMP_EmployeeProduct empProd
	ON	empProd.GroupProduct_key = eep.GroupProduct_key
	AND	empProd.ProductOwner_key = eep.ProductOwner_key
	AND	empProd.Employee_key = eep.Employee_key
JOIN		EMP_EmployeeEnrollmentPeriod EmpEnr 
		ON EmpEnr.Person_key = eep.Employee_key
		AND empEnr.EnrollmentPeriod_key = eep.EnrollmentPeriod_key
JOIN		GRP_GroupProduct gp
	ON	eep.GroupProduct_key = gp.GroupProduct_key
JOIN		PRD_Product p
	ON	gp.Product_key = p.Product_key
JOIN		PRD_Customization cz
	ON	gp.GroupProduct_key = cz.GroupProduct_key
JOIN		MSC_Organization c 
	ON	c.Organization_key = p.Carrier_key
		AND c.OrganizationType_vv = 'CARRIER'
JOIN		GRP_GroupTableType gtt
	ON	gtt.Group_key = rg.PrimaryGroup_key
	AND	TableType_vv = 'BENEFITTYPE'
JOIN		GRP_GroupTableValue gtv
	ON	gp.BenefitType_key = gtv.GroupTableValue_key
	AND	gtt.GroupTableType_key = gtv.GroupTableType_key
LEFT JOIN	EMP_EmployeeProductEnrollment epe
	ON	empProd.EmployeeProduct_key = epe.EmployeeProduct_key
	AND	epe.EnrollmentPeriod_key = eep.EnrollmentPeriod_key
LEFT JOIN	(Select	Person_key,
						gtv.GroupTableValue_key Department_key,
						Long_nm Department
					From		GRP_GroupTableValue gtv
					JOIN		GRP_GroupTableType gtt
					ON	gtv.GroupTableType_key = gtt.GroupTableType_key
					JOIN		EMP_EmployeeTableValue etv
					ON	etv.GroupTableValue_key = gtv.GroupTableValue_key
					WHERE	gtt.TableType_vv = 'DEPARTMENT'
					) dep
			ON dep.Person_key = eep.Employee_key
LEFT	JOIN		MSC_Coverage mc
	ON	eep.Coverage_key = mc.Coverage_key
LEFT JOIN	GRP_Enroller ge
	ON	ge.Enroller_key = epe.Enroller_key
LEFT JOIN		MSC_User u
	ON	ge.User_key = u.User_key
LEFT JOIN GRP_GroupCarrier gc on c.Organization_key = gc.Organization_key
	AND	gc.Group_key = g.Group_key
LEFT JOIN	v_Plan pl
	ON	pl.GroupProduct_key = eep.GroupProduct_key
		AND eep.CostTableValue_key = pl.CostTableValue_key

		WHERE 	c.OrganizationType_vv = 'CARRIER'
		AND	EmpEnr.EnrollmentStatus_vv = 'ENROLLED'
		AND (eep.EmployeeProductStatus_vv = 'ENROLLED' or eep.EmployeeProductStatus_vv = 'WAIVED')
		AND 	rg.ReportingGroup_key = @Group_key
		AND	(eep.PreTax_flg = IsNull(NullIf(@PreTax_flg, 'ALL'), eep.PreTax_flg)
			or NullIf(@PreTax_flg, 'ALL') is Null)
		AND	p.Carrier_key = IsNull(NullIf(@Carrier_key, 'ALL'), p.Carrier_key)	
		AND	(dep.Department_key = IsNull(NullIf(@Department_key, 'ALL'), dep.Department_key)
			or NullIf(@Department_key, 'ALL') is Null)
		AND	eep.EnrollmentPeriod_key = @EnrollmentPeriod_key) T1

Where Change = IsNull(NullIf(@ChangeType, 'ALL'), Change)