--  Retrieve everything using the emp_key
declare @Emp_key 	nvarchar(1000),
	@typepull	nvarchar(1000),
	@Benefit	nvarchar(4000)
set @Emp_key = 'C4C1872A-3EAB-41E6-B2E7-007CA1FE95F0'

if exists(select dimensionvalue_key from grp_groupproductdimensionvalue 
	where dimensionvalue_key = (
		select distinct dival.dimensionvalue_key from prd_dimensionvalue dival,
			ans_answervalue ans
		where dimensionvalue_key = (select dimensionvalue_x_key from prd_costtablevalue where costtablevalue_key = '1E8FD62F-E5A6-4C29-870A-EC64BA792386')
		or dimensionvalue_key = (select dimensionvalue_y_key from prd_costtablevalue where costtablevalue_key = '1E8FD62F-E5A6-4C29-870A-EC64BA792386')
		 and dival.answervalue_key = ans.answervalue_key and ans.answer_key = '3F83256C-7D80-455C-ABF1-9FF3148AE6F9'
	)) 
begin
	-- the group override text
	set @typepull = 'select displayoverride_txt typecontract from grp_groupproductdimensionvalue 
			where dimensionvalue_key = (
				select distinct dival.dimensionvalue_key from prd_dimensionvalue dival,
					ans_answervalue ans
				where dimensionvalue_key = (select dimensionvalue_x_key from prd_costtablevalue where costtablevalue_key = ep.costtablevalue_key)
					or dimensionvalue_key = (select dimensionvalue_y_key from prd_costtablevalue where costtablevalue_key = ep.costtable_key)
				 and dival.answervalue_key = ans.answervalue_key and ans.answer_key = ''3F83256C-7D80-455C-ABF1-9FF3148AE6F9''
		) and displayoverride_txt is not null
		'
end
else
begin
	if exists(select coverage_nm from msc_coverage cover, emp_employeeproduct emp
		where emp.employee_key = 'C4C1872A-3EAB-41E6-B2E7-007CA1FE95F0' 
		and emp.coverage_key = cover.coverage_key)
	begin
		-- the coverage text
		set @typepull = 'select coverage_nm typecontract from msc_coverage cover, emp_employeeproduct emp
			where emp.coverage_key = cover.coverage_key
		'
	end
end
print @typepull
-- check the x dimension
set @Benefit = '
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
			WHEN ''WAIVED'' THEN ''Coverage Waived''
			WHEN '''' THEN NULL
			ELSE
				CASE ep.PreTax_Flg
					WHEN ''Y'' THEN ''Pre-Tax Elections''
					ELSE	''Post-Tax Elections''
				END
		END Grouping
 FROM		v_EmployeePerson e
 JOIN		v_LatestEnrollmentPeriod lep ON e.Group_key = lep.Group_key
 JOIN		EMP_EmployeeEnrollmentPeriod ee	ON ee.Person_key = e.Person_key AND ee.EnrollmentPeriod_key = lep.EnrollmentPeriod_key
 JOIN		MSC_Organization o ON o.Organization_key = lep.PrimaryGroup_key
 JOIN		GRP_Group g ON g.Group_key = o.Organization_key
 LEFT JOIN	EMP_EmployeeProduct ep ON ep.employee_key = e.person_key
			AND (ep.EmployeeProductStatus_vv = ''ENROLLED'' OR ep.EmployeeProductStatus_vv = ''WAIVED'')
 LEFT JOIN	EMP_EmployeeProductData planid ON planid.EmployeeProduct_key = ep.EmployeeProduct_key
		AND planid.Answer_key = ''E2395B16-C217-4D8A-9F53-594BAE4BD8C6''
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
			AND rs.Report_key = ''C110A714-BBFF-4BCC-B2BD-F9ABABCEBB6D''
 WHERE e.Person_key in (' + @Emp_key + ')
 Order By e.Last_nm asc, e.First_nm asc, e.MiddleInitial_nm asc, grouping desc
'
