declare @debug		int, 
	@Person_key	varchar(4000)

set @Person_key = 'BC0E259B-453B-4397-8C89-8542B2DF62D1'

SELECT	Cast(ep.Employee_key as varchar(40)) Employee_key, ep.costtablevalue_key, ep.coverage_key, ep.groupproduct_key,
							Cast(ep.EmployeeProduct_key as varchar(40)) EmployeeProduct_key,
							usr.First_nm + ' ' + usr.Last_nm Enroller,
							ep.PreTax_flg,
							IsNull(ep.EmployeeYearlyCost_amt, 0) EmployeeYearlyCost_amt,
							IsNull(ep.EmployerYearlyCost_amt, 0) EmployerYearlyCost_amt,
							IsNull(ep.DeductionsPerYear_val, 1) DeductionsPerYear_val,
							IsNull(ep.EmployeeStartCost_amt, 0) EmployeeStartCost_amt,
							IsNull(ep.EmployerStartCost_amt, 0) EmployerStartCost_amt,
							ep.CoverageEffective_dt,
							ep.DeductionEffective_dt,
							cz.ProductDisplay_nm + ' ' + Coalesce(planid.Answer_txt, ep.CoverageLevel_txt, '') Product_nm,
							c.OrganizationShort_nm Carrier_nm,
							gtv.Short_nm Benefit,
							mc.Coverage_nm TypeContract,
							ep.EmployeeProductStatus_vv,							
							ctv.Premium_amt,
							pr.ProductType_vv
					FROM 	EMP_EmployeeProduct ep
					JOIN		GRP_GroupProduct gp
						ON	gp.GroupProduct_key = ep.GroupProduct_key
					JOIN		PRD_Customization cz
						ON	gp.GroupProduct_key = cz.GroupProduct_key
					JOIN		PRD_Product pr
						ON	gp.Product_key = pr.Product_key
					JOIN		MSC_Organization c --Carrier
						ON	pr.Carrier_key = c.Organization_key
					JOIN		GRP_GroupTableValue gtv
						ON	gp.BenefitType_key = gtv.GroupTableValue_key
					JOIN		EMP_EmployeeProductEnrollment epe
						ON	epe.EmployeeProduct_key = ep.EmployeeProduct_key
					JOIN		EMP_EmployeeEnrollmentPeriod ee
						ON	ee.Person_key = ep.Employee_key
					JOIN		GRP_EnrollmentPeriod gep
						ON	gep.EnrollmentPeriod_key = ee.EnrollmentPeriod_key
					LEFT JOIN EMP_EmployeeProductData display ON display.EmployeeProduct_key = ep.EmployeeProduct_key AND 
						display.Answer_key = 'CA815913-D3AA-4F82-9D6B-85C6519B9101'
					LEFT JOIN EMP_EmployeeProductData planid ON planid.EmployeeProduct_key = ep.EmployeeProduct_key AND 
						planid.Answer_key = 'E2395B16-C217-4D8A-9F53-594BAE4BD8C6'
					LEFT JOIN		GRP_Enroller enr
						ON enr.Enroller_key = ee.Enroller_key
					LEFT JOIN		MSC_USER usr
						ON usr.User_key = enr.User_key
					LEFT JOIN		MSC_Coverage mc
						ON	ep.Coverage_key = mc.Coverage_key
					LEFT JOIN	PRD_CostTableValue ctv
						ON	ctv.CostTableValue_key = ep.CostTableValue_key
					WHERE	(ep.EmployeeProductStatus_vv = 'ENROLLED' or ep.EmployeeProductStatus_vv = 'EXPIRED' or ep.EmployeeProductStatus_vv = 'WAIVED')
						AND   (display.Answer_txt = 'Y')
						AND	ep.Employee_key = @Person_key
						--AND	gep.EnrollmentPeriod_key = @EnrollmentPeriod_key