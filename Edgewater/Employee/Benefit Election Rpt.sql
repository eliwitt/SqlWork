--  Old method
declare @Emp_key 	nvarchar(1000)
set @Emp_key = 'C4C1872A-3EAB-41E6-B2E7-007CA1FE95F0'

SELECT	Cast(e.Person_key as varchar(40)) Employee_key,
		RTrim(e.First_nm) + IsNull('  ' + e.MiddleInitial_nm, '') + ' ' + e.Last_nm Full_nm,
		IsNull(e.ssn_txt, '         ') ssn_txt,
		e.AddressLine1_txt,
		e.AddressLine2_txt,
		e.City_txt,
		state_cd State,
		e.PostalCode_txt,
		g.Company_nm,
		o.Organization_nm Group_nm,
		etv.Location_Long_nm location,
		IsNull(ep.EmployeeStartCost_amt, 0) EmployeePriorYearlyCost_amt,
		IsNull(ep.EmployeeYearlyCost_amt, 0) EmployeeYearlyCost_amt,
		IsNull(ep.EmployerYearlyCost_amt, 0) EmployerYearlyCost_amt,
		IsNull(ep.DeductionsPerYear_val, 1) DeductionsPerYear_val,
		cz.ProductDisplay_nm + ' ' + Coalesce(planid.Answer_txt, ep.CoverageLevel_txt, '') Product_nm,
		c.OrganizationShort_nm Carrier_nm,
		gtv.Short_nm Benefit,
		lep.PlanYearFrom_dt,
		lep.PlanYearThru_dt,
		mc.Coverage_nm TypeContract,
		ep.EmployeeProductStatus_vv,
		usr.First_nm + ' ' + usr.Last_nm Enroller,
		rs.Signature_bin Employee_Signature,
		rs.Signed_dttm EmpDateSigned,
		CASE COALESCE(ep.EmployeeProductStatus_vv, '')
			WHEN 'WAIVED' THEN 'Coverage Waived'
			WHEN '' THEN NULL
			ELSE
				CASE ep.PreTax_Flg
					WHEN 'Y' THEN 'Pre-Tax Elections'
					ELSE	'Post-Tax Elections'
				END
		END Grouping
 FROM		v_EmployeePerson e
 JOIN		v_LatestEnrollmentPeriod lep ON e.Group_key = lep.Group_key
 JOIN		EMP_EmployeeEnrollmentPeriod ee	ON ee.Person_key = e.Person_key AND ee.EnrollmentPeriod_key = lep.EnrollmentPeriod_key
 JOIN		MSC_Organization o ON o.Organization_key = lep.PrimaryGroup_key
 JOIN		GRP_Group g ON g.Group_key = o.Organization_key
 LEFT JOIN	EMP_EmployeeProduct ep ON ep.employee_key = e.person_key
			AND (ep.EmployeeProductStatus_vv = 'ENROLLED' OR ep.EmployeeProductStatus_vv = 'WAIVED')
 LEFT JOIN	EMP_EmployeeProductData planid ON planid.EmployeeProduct_key = ep.EmployeeProduct_key
		AND planid.Answer_key = 'E2395B16-C217-4D8A-9F53-594BAE4BD8C6'
 LEFT JOIN	GRP_GroupProduct gp ON gp.GroupProduct_key = ep.GroupProduct_key
 LEFT JOIN	PRD_Customization cz ON cz.GroupProduct_key = gp.GroupProduct_key
 LEFT JOIN	PRD_Product pr ON gp.Product_key = pr.Product_key
 LEFT JOIN	MSC_Organization c ON pr.Carrier_key = c.Organization_key
 LEFT JOIN	GRP_GroupTableValue gtv ON gp.BenefitType_key = gtv.GroupTableValue_key
 LEFT JOIN	v_EmployeeTableValue etv ON e.Person_key = etv.Person_key
 LEFT JOIN	GRP_Enroller enr ON enr.Enroller_key = ee.Enroller_key
 LEFT JOIN	MSC_User usr ON usr.user_key = enr.user_key
 LEFT JOIN	EMP_ReportSignature rs ON rs.EnrollmentPeriod_key = ee.EnrollmentPeriod_key
			AND rs.Person_key = ee.Person_key AND rs.enroller_key IS NULL
			AND rs.Report_key = 'C110A714-BBFF-4BCC-B2BD-F9ABABCEBB6D'
 LEFT JOIN	MSC_Coverage mc ON ep.Coverage_key = mc.Coverage_key
 WHERE e.Person_key in ('' + @Emp_key + '')
 Order By e.Last_nm asc, e.First_nm asc, e.MiddleInitial_nm asc, grouping desc