SELECT gep.Group_key, u.user_key, prd.product_nm, prd.rider_flg, prd.VoluntaryProduct_flg
FROM EMP_Person p 
		JOIN EMP_Employee e ON e.Person_key = p.Person_key
		-- products that the user has enrolled in
		jOIN EMP_EmployeeProduct ep ON ep.Employee_key = e.Person_key
		join emp_employeeproductenrollment epe on epe.employeeproduct_key = ep.employeeproduct_key
		-- find the enroller of this product
		JOIN EMP_EmployeeEnrollmentPeriod eep ON epe.EnrollmentPeriod_key = eep.EnrollmentPeriod_key
		 and eep.Person_key = e.Person_key
		JOIN	GRP_Enroller ge ON ge.Enroller_key = epe.Enroller_key
		JOIN 	MSC_User u on u.User_key = ge.User_key
		-- Organizational information
		JOIN GRP_EnrollmentPeriod gep ON eep.EnrollmentPeriod_key = gep.EnrollmentPeriod_key
		inner join grp_group grp on gep.group_key = grp.group_key
		JOIN MSC_Organization o ON gep.Group_key = o.Organization_key
		-- Product Information
		JOIN PRD_Customization c ON c.GroupProduct_key = ep.GroupProduct_key
		join grp_groupproduct gp on gp.group_key = gep.group_key 
			and gp.groupproduct_key = ep.groupproduct_key
		join prd_product prd on prd.product_key = gp.product_key
WHERE ep.EmployeeProductStatus_vv = 'ENROLLED'
			and gep.group_key in ( '{b2c6840d-0c98-4c17-880c-4f2122a69bbf}' )
order by gep.group_key, u.user_key, prd.product_nm