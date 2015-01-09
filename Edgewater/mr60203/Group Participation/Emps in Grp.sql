-- this query shows all employees in the group regardless of the enrollment or 
-- other parameters that might limit an employee appearance.
SELECT o.Organization_nm, 
	p.First_nm, 
	p.Last_nm,
	p.persontype_vv, ep.EmployeeProductStatus_vv
FROM EMP_Person p 
	JOIN EMP_Employee e 
		ON e.Person_key = p.Person_key
	JOIN MSC_Organization o 
		ON e.Group_key = o.Organization_key
		-- products that the user has enrolled in
		jOIN EMP_EmployeeProduct ep ON ep.Employee_key = e.Person_key
WHERE o.organization_nm like 'Pure%'