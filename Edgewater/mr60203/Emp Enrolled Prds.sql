-- 5.1 This query displays the products along with the status of those products for 
--     a given employee within a specific group:esig.enroller_key enroller.first_nm + ' ' + enroller.last_nm as [Enroller]
SELECT o.Organization_nm, 
p.First_nm + ' ' + p.Last_nm as [Emp Name], u.first_nm + ' ' + u.last_nm as [Enroller],
c.ProductDisplay_nm, prd.voluntaryproduct_flg,
ep.EmployeeProductStatus_vv
FROM EMP_Person p 
JOIN EMP_Employee e ON e.Person_key = p.Person_key
-- products that the user has enrolled in
JOIN EMP_EmployeeProduct ep ON ep.Employee_key = e.Person_key
join emp_employeeproductenrollment epe on epe.employeeproduct_key = ep.employeeproduct_key
-- find the enroller of this product
JOIN EMP_EmployeeEnrollmentPeriod eep ON epe.EnrollmentPeriod_key = eep.EnrollmentPeriod_key
 and eep.Person_key = e.Person_key
JOIN	GRP_Enroller ge 
ON	ge.Enroller_key = epe.Enroller_key
JOIN 	MSC_User u on u.User_key = ge.User_key
-- Organizational information
JOIN GRP_EnrollmentPeriod gep ON eep.EnrollmentPeriod_key = gep.EnrollmentPeriod_key
JOIN MSC_Organization o ON gep.Group_key = o.Organization_key
-- Product Information
JOIN PRD_Customization c ON c.GroupProduct_key = ep.GroupProduct_key
join grp_groupproduct gp on gp.groupproduct_key = ep.groupproduct_key
join prd_product prd on prd.product_key = gp.product_key
WHERE 
o.organization_nm = 'Chattanooga Chamber' and ep.EmployeeProductStatus_vv = 'ENROLLED'
order by organization_nm, enroller, c.ProductDisplay_nm