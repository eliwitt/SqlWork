-- Payroll Deduction problem double rows are being returned.
--
SELECT		Cast(e.Person_key as varchar(40)) Employee_key, 
			e.Employee_ID, 
			RTrim(e.First_nm) + IsNull('  ' + e.MiddleInitial_nm, '')  + ' ' + e.Last_nm Full_nm, 
			IsNull(e.ssn_txt, '         ') ssn_txt, 
			e.AddressLine1_txt,
			e.AddressLine2_txt, 
			e.City_txt,
			state_cd State,
			e.PostalCode_txt, 
			g.Company_nm, 
			etv.Department_Long_nm department, 
			ep.PreTax_flg, 
			Cast(IsNull(ep.EmployeeYearlyCost_amt, 0) as money) EmployeeYearlyCost_amt, 
			IsNull(ep.DeductionsPerYear_val, 1) DeductionsPerYear_val, 
			IsNull(ep.EmployeeStartCost_amt,0) EmployeeStartCost_amt, 
			ep.DeductionEffective_dt, 
			cz.ProductDisplay_nm + ' ' + Coalesce(planid.Answer_txt, ep.CoverageLevel_txt, '') Product_nm, 
			c.OrganizationShort_nm Carrier_nm, 
			gtv.Short_nm Benefit, 
			lep.PlanYearFrom_dt, 
			lep.PlanYearThru_dt, 
			rs.Signature_bin Employee_Signature, 
			rs.Signed_dttm EmpDateSigned, 
			mc.Coverage_nm TypeContract,
			ep.EmployeeProductStatus_vv, 
			usr.First_nm + ' ' + usr.Last_nm Enroller, 
			pr.ProductType_vv, 
			disclaimer 
FROM		v_EmployeePerson e 
JOIN		v_LatestEnrollmentPeriod lep ON e.Group_key = lep.Group_key 
JOIN		EMP_EmployeeEnrollmentPeriod ee	ON ee.Person_key = e.Person_key AND ee.EnrollmentPeriod_key = lep.EnrollmentPeriod_key 
JOIN		MSC_Organization o ON o.Organization_key = lep.PrimaryGroup_key 
JOIN		GRP_Group g ON g.Group_key = o.Organization_key 
LEFT JOIN  	EMP_EmployeeProduct ep ON e.Person_key = ep.Employee_key 
LEFT JOIN	GRP_GroupProduct gp ON gp.GroupProduct_key = ep.GroupProduct_key 
LEFT JOIN	PRD_Customization cz ON	gp.GroupProduct_key = cz.GroupProduct_key 
LEFT JOIN	PRD_Product pr ON gp.Product_key = pr.Product_key 
LEFT JOIN	MSC_Organization c ON pr.Carrier_key = c.Organization_key 
LEFT JOIN	GRP_GroupTableValue gtv ON gp.BenefitType_key = gtv.GroupTableValue_key 
LEFT JOIN	v_EmployeeTableValue etv ON etv.Person_key = e.Person_key 
LEFT JOIN 	EMP_EmployeeProductData display ON display.EmployeeProduct_key = ep.EmployeeProduct_key 
			AND display.Answer_key = 'CA815913-D3AA-4F82-9D6B-85C6519B9101' 
LEFT JOIN	EMP_EmployeeProductData planid ON planid.EmployeeProduct_key = ep.EmployeeProduct_key 
			AND	planid.Answer_key = 'E2395B16-C217-4D8A-9F53-594BAE4BD8C6' 
LEFT JOIN	GRP_Enroller enr ON	enr.Enroller_key = ee.Enroller_key 
LEFT JOIN	MSC_User usr ON usr.user_key = enr.user_key 
LEFT JOIN	EMP_ReportSignature rs ON rs.EnrollmentPeriod_key = ee.EnrollmentPeriod_key 
			AND rs.Person_key = ee.Person_key AND rs.enroller_key IS NULL 
			AND rs.Report_key = 'BBBBF791-B2D1-44E3-9D6A-EF1B5C298EF6' 
LEFT JOIN	MSC_Coverage mc ON ep.Coverage_key = mc.Coverage_key 
CROSS JOIN (SELECT Parameter_desc disclaimer FROM MSC_Parameter WHERE Parameter_cd = 'PD_DISCLAIMER') disc 
WHERE		(ep.EmployeeProductStatus_vv = 'ENROLLED' 
			OR ep.EmployeeProductStatus_vv = 'EXPIRED' 
			OR ep.EmployeeProductStatus_vv = 'WAIVED' 
			OR ep.EmployeeProductStatus_vv IS NULL) 
			AND display.Answer_txt = 'Y' 
			AND	e.Person_key in ('30fb7812-338e-46dd-bff5-74cb3bc6c35c') 
ORDER BY	e.Last_nm, e.First_nm, e.MiddleInitial_nm