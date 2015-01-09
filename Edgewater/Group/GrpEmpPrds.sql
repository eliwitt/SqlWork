-- This script will process the all employees in the given group
-- we copy the same logic for the benefit election because we need the type contract.
--
-- script variables
declare @debug		int, 
	@OrgName	varchar(4000)
-- initialize the variables
-- EmployeesList is the variable used by the reports so we will comment this out once 
-- the script is copied into the report
set @OrgName = ''
set @OrgName = 'US Fence%'
--
--  set @debug to an integer and you will get print statements
--  0 = turn off
--  1 = high level 
--  2 = detail
--  3 = stop after the build of the cmd str
set @debug = 2

-- check the existance of the temp table
if object_id('tempdb..#EmpEnroll') is not null
	drop table #EmpEnroll

SELECT dbo_EMP_Person.Last_nm, dbo_EMP_Person.First_nm, dbo_EMP_Person.MiddleInitial_nm, dbo_EMP_Person.SSN_txt, dbo_EMP_Employee.Employee_ID, dbo_EMP_Person.AddressLine1_txt, dbo_EMP_Person.AddressLine2_txt, dbo_EMP_Person.City_txt, dbo_EMP_Person.PostalCode_txt, dbo_EMP_Person.HomePhone_txt, dbo_EMP_EmployeeProduct.DeductionsPerYear_val, dbo_EMP_EmployeeProduct.PreTax_flg, dbo_PRD_Product.Product_nm, dbo_MSC_Organization_1.Organization_nm, dbo_PRD_Customization.ProductDisplay_nm, dbo_EMP_EmployeeProduct.CoverageBenefit_txt, dbo_EMP_EmployeeProduct.EmployeeYearlyProductCost_amt, ([EmployeeYearlyProductCost_amt]/[DeductionsPerYear_val]) AS Expr1, dbo_EMP_EmployeeProduct.EmployerYearlyProductCost_amt, [EmployerYearlyProductCost_amt]/[DeductionsPerYear_val] AS Expr2, dbo_EMP_EmployeeEnrollmentPeriod.EnrollmentStatus_vv, dbo_EMP_EmployeeProduct.EmployeeProductStatus_vv
FROM (dbo_MSC_Organization AS dbo_MSC_Organization_1 INNER JOIN (dbo_PRD_Product INNER JOIN ((dbo_EMP_EmployeeProduct INNER JOIN ((((dbo_GRP_Group INNER JOIN dbo_EMP_Employee ON dbo_GRP_Group.Group_key = dbo_EMP_Employee.Group_key) INNER JOIN dbo_EMP_Person ON dbo_EMP_Employee.Person_key = dbo_EMP_Person.Person_key) INNER JOIN dbo_MSC_Organization ON dbo_GRP_Group.Group_key = dbo_MSC_Organization.Organization_key) INNER JOIN dbo_EMP_EmployeeEnrollmentPeriod ON (dbo_EMP_Employee.Person_key = dbo_EMP_EmployeeEnrollmentPeriod.Person_key) AND (dbo_EMP_Person.Person_key = dbo_EMP_EmployeeEnrollmentPeriod.Person_key)) ON dbo_EMP_EmployeeProduct.Employee_key = dbo_EMP_Employee.Person_key) INNER JOIN dbo_GRP_GroupProduct ON (dbo_EMP_EmployeeProduct.GroupProduct_key = dbo_GRP_GroupProduct.GroupProduct_key) AND (dbo_GRP_Group.Group_key = dbo_GRP_GroupProduct.Group_key)) ON dbo_PRD_Product.Product_key = dbo_GRP_GroupProduct.Product_key) ON dbo_MSC_Organization_1.Organization_key = dbo_PRD_Product.Carrier_key) INNER JOIN dbo_PRD_Customization ON dbo_GRP_GroupProduct.GroupProduct_key = dbo_PRD_Customization.GroupProduct_key
WHERE (((dbo_EMP_EmployeeProduct.EmployeeProductStatus_vv)="ENROLLED") AND ((dbo_MSC_Organization.Organization_nm) Like @OrgName))
ORDER BY dbo_EMP_Person.Last_nm, dbo_EMP_Person.First_nm;