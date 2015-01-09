-- 5.1 This query displays the products along with the status of those products for 
--     a given employee within a specific group:
SELECT o.Organization_nm, 
p.First_nm + ' ' + p.Last_nm as [Emp Name],
c.ProductDisplay_nm, 
ep.EmployeeProductStatus_vv
FROM EMP_Person p 
JOIN EMP_Employee e ON e.Person_key = p.Person_key
JOIN EMP_EmployeeProduct ep ON ep.Employee_key = e.Person_key
JOIN EMP_EmployeeEnrollmentPeriod eep ON eep.Person_key = e.Person_key
JOIN GRP_EnrollmentPeriod gep ON eep.EnrollmentPeriod_key = gep.EnrollmentPeriod_key
JOIN MSC_Organization o ON gep.Group_key = o.Organization_key
JOIN PRD_Customization c ON c.GroupProduct_key = ep.GroupProduct_key
WHERE p.Last_nm = 'McCrary' AND p.First_nm = 'Terry' AND 
o.organization_nm like 'Kelso Oil Company%'
