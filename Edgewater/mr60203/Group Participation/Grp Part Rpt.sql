-- 5.2 This shows records that are moved to the PriorEmployeeProduct table 
--     after the complete enrollment is clicked.  These are the ones that would 
--     show on the benefit detail web report:
SELECT o.Organization_nm,
	org.organizationshort_nm as carrier,
	gep.EnrollmentPeriod_key,
	gep.enrollfrom_dt, gep.enrollthru_dt,
	grpval.short_nm as coverage,
	ep.EmployeeProductStatus_vv, 
	ep.waiverreason_vv,
	count(c.ProductDisplay_nm) selCt
FROM EMP_Person p 
	--  Find out if the person is an employee
	JOIN EMP_Employee e 
		ON e.Person_key = p.Person_key
	--  After the completion button is pressed the data will be located here
	JOIN EMP_PriorEmployeeProduct ep 
		ON ep.Employee_key = e.Person_key
	--  Emp enrollment period data
	JOIN EMP_EmployeeEnrollmentPeriod eep 
		ON eep.Person_key = e.Person_key
	--  Group's enrollment
	JOIN GRP_EnrollmentPeriod gep 
		ON eep.EnrollmentPeriod_key = gep.EnrollmentPeriod_key
	--  Group's Org
	JOIN MSC_Organization o 
		ON gep.Group_key = o.Organization_key
	--  The group's organization data
	JOIN v_ReportingGroup rg
		ON gep.Group_key = rg.IncludedGroup_key
	--  The group's custization of the products
	JOIN PRD_Customization c 
		ON c.GroupProduct_key = ep.GroupProduct_key
	--  locate the group product info
	join grp_groupproduct grpprd
		on grpprd.groupproduct_key = c.GroupProduct_key
	--  retrieve all of the groups products
	join prd_product prod 
		on grpprd.product_key = prod.product_key
	--  for each product get their carrier short name
	join msc_organization org 
		on prod.carrier_key = org.organization_key
	--  for each product get their coverage type
	join grp_grouptablevalue grpval 
		on grpprd.benefittype_key = grpval.grouptablevalue_key
	--  retrieve the employee's prod selection
	left join emp_employeedata ed
		on e.person_key = ed.person_key 
		and 	ed.answer_key in (select answer_key from ans_answer where answer_key = '{31CD3225-9C6A-4DAD-A8A5-3A6820CDF257}')
WHERE rg.ReportingGroup_key in ('{eb23735d-336c-42cb-a26e-bcefc35534cc}')

-- order by ProductDisplay_nm, last_nm
group by o.Organization_nm, org.organizationshort_nm, gep.EnrollmentPeriod_key,
		grpval.short_nm, ep.EmployeeProductStatus_vv, 
		ep.waiverreason_vv,gep.enrollfrom_dt, gep.enrollthru_dt