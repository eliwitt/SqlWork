-- This query gave me a list of the employees and their 
-- products with the employee enroller assignment
SELECT GRP_Group.internaldivision_key, MSC_Organization.Organization_nm, EMP_Person.Last_nm, 
EMP_Person.First_nm, EMP_EmployeeEnrollmentPeriod.EnrollmentStatus_vv,
EMP_EmployeeProduct.EmployeeProductStatus_vv, PRD_Product.Product_nm,
MSC_User.Last_nm

FROM MSC_User 
INNER JOIN ((PRD_Product 
INNER JOIN ((EMP_EmployeeProduct 
INNER JOIN ((((GRP_Group 
INNER JOIN EMP_Employee 
	ON GRP_Group.Group_key = EMP_Employee.Group_key) 
INNER JOIN EMP_Person 
	ON EMP_Employee.Person_key = EMP_Person.Person_key) 
INNER JOIN MSC_Organization 
	ON GRP_Group.Group_key = MSC_Organization.Organization_key) 
INNER JOIN EMP_EmployeeEnrollmentPeriod 
	ON (EMP_Person.Person_key = EMP_EmployeeEnrollmentPeriod.Person_key) 
	AND (EMP_Employee.Person_key = EMP_EmployeeEnrollmentPeriod.Person_key)) 
	ON EMP_EmployeeProduct.Employee_key = EMP_Employee.Person_key) 
INNER JOIN GRP_GroupProduct 
	ON (GRP_Group.Group_key = GRP_GroupProduct.Group_key) 
	AND (EMP_EmployeeProduct.GroupProduct_key = GRP_GroupProduct.GroupProduct_key)) 
	ON PRD_Product.Product_key = GRP_GroupProduct.Product_key) 
INNER JOIN GRP_Enroller 
	ON EMP_EmployeeEnrollmentPeriod.Enroller_key = GRP_Enroller.Enroller_key) 
	ON MSC_User.User_key = GRP_Enroller.User_key

WHERE (((MSC_Organization.Organization_nm) Like 'Boe-Tel%'))

ORDER BY EMP_Person.Last_nm, EMP_Person.First_nm

