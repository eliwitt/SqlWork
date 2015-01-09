-- 5.3 This displays who signed the documents for all the products for a given employee :
 
SELECT p.First_nm + ' ' + p.Last_nm AS 'Employee', p2.First_nm + ' ' + p2.Last_nm AS 'Owner', p1.First_nm + ' ' + p1.Last_nm AS 'Signer', 
c.ProductDisplay_nm,  d.Document_nm, ds.signed_dttm, ep.EmployeeProductStatus_vv  
FROM DOC_Document d
JOIN EMP_DocumentSignature ds ON ds.Document_key = d.Document_key
JOIN EMP_Person p1 ON ds.Person_key = p1.Person_key
JOIN EMP_EmployeeProduct ep ON ds.EmployeeProduct_key = ep.EmployeeProduct_key
JOIN emp_Person p2 ON ep.ProductOwner_key = p2.Person_key
JOIN EMP_Person p ON ep.Employee_key = p.Person_key
JOIN EMP_Employee e ON e.Person_key = p.Person_key
JOIN EMP_EmployeeEnrollmentPeriod eep ON eep.Person_key = e.Person_key
JOIN GRP_EnrollmentPeriod gep ON eep.EnrollmentPeriod_key = gep.EnrollmentPeriod_key
JOIN MSC_Organization o ON gep.Group_key = o.Organization_key
JOIN PRD_Customization c ON c.GroupProduct_key = ep.GroupProduct_key
WHERE ds.Person_key IS NOT NULL  
AND p.Last_nm = 'Brewer' AND p.First_nm = 'Dustin' AND 
o.organization_nm like 'Kelso Oil Company%' 
ORDER BY d.Document_nm
