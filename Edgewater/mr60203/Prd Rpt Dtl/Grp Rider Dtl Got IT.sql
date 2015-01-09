SELECT rprd.Group_key, rprd.user_key, rprd.product_key, rprd.parent,
	rprd.product_nm, rprd.rider_flg, rprd.VoluntaryProduct_flg,
	totemps, rprd.numprods, rprd.TotalSubmittedPremium
from (
	-- products that the group employees bought
	select e.group_key, u.user_key, prd.product_key, prd.product_key as parent, prd.product_nm, 
		prd.rider_flg, prd.VoluntaryProduct_flg, 
		count(distinct cast(e.person_key as varchar(36))) as numprods,
		SUM( Case
			When(IsNull(EmployeeYearlyCost_amt, 0) + IsNull(EmployerYearlyCost_amt, 0)) - 
				(IsNull(EmployeeStartCost_amt, 0)  + IsNull(EmployerStartCost_amt, 0)) <= 0 
				Then 0
			Else (IsNull(EmployeeYearlyCost_amt, 0) + IsNull(EmployerYearlyCost_amt, 0)) - 
				 (IsNull(EmployeeStartCost_amt, 0)  + IsNull(EmployerStartCost_amt, 0)) 
		END ) TotalSubmittedPremium
	from emp_person p
		JOIN EMP_Employee e ON e.Person_key = p.Person_key
		join EMP_EmployeeProduct ep ON ep.Employee_key = e.Person_key
		join emp_employeeproductenrollment epe on epe.employeeproduct_key = ep.employeeproduct_key
		-- find the enroller of this product
		JOIN EMP_EmployeeEnrollmentPeriod eep ON epe.EnrollmentPeriod_key = eep.EnrollmentPeriod_key
		 	and eep.Person_key = e.Person_key
		JOIN	GRP_Enroller ge ON ge.Enroller_key = epe.Enroller_key
		JOIN 	MSC_User u on u.User_key = ge.User_key
		-- Organizational information
		JOIN GRP_EnrollmentPeriod gep ON eep.EnrollmentPeriod_key = gep.EnrollmentPeriod_key
		inner join grp_group grp on gep.group_key = grp.group_key
		-- Product Information
		JOIN PRD_Customization c ON c.GroupProduct_key = ep.GroupProduct_key
		join grp_groupproduct gp on gp.groupproduct_key = ep.groupproduct_key
		join prd_product prd on prd.product_key = gp.product_key
	where ep.EmployeeProductStatus_vv = 'ENROLLED'
		and e.group_key in ( '{b2c6840d-0c98-4c17-880c-4f2122a69bbf}' )
	group by e.group_key, u.user_key, prd.product_key, prd.product_nm, prd.rider_flg, prd.VoluntaryProduct_flg
	union
	-- riders that the group employees bought
	select e.group_key, u.user_key, prd.product_key, rider.product_key as parent, prd.product_nm, 
		prd.rider_flg, prd.VoluntaryProduct_flg, 
		count(distinct cast(e.person_key as varchar(36))) as numprods,
		SUM( Case
			When(IsNull(epr.EmployeeYearlyCost_amt, 0) + IsNull(epr.EmployerYearlyCost_amt, 0)) - 
				(IsNull(EmployeeStartCost_amt, 0)  + IsNull(EmployerStartCost_amt, 0)) <= 0 
				Then 0
			Else (IsNull(epr.EmployeeYearlyCost_amt, 0) + IsNull(epr.EmployerYearlyCost_amt, 0)) - 
				 (IsNull(EmployeeStartCost_amt, 0)  + IsNull(EmployerStartCost_amt, 0)) 
		END ) TotalSubmittedPremium
	from emp_person p
		JOIN EMP_Employee e ON e.Person_key = p.Person_key
		join EMP_EmployeeProduct ep ON ep.Employee_key = e.Person_key
		join emp_productrider epr on ep.employeeproduct_key = epr.employeeproduct_key
		join emp_employeeproductenrollment epe on epe.employeeproduct_key = ep.employeeproduct_key
		-- find the enroller of this product
		JOIN EMP_EmployeeEnrollmentPeriod eep ON epe.EnrollmentPeriod_key = eep.EnrollmentPeriod_key
		 	and eep.Person_key = e.Person_key
		JOIN	GRP_Enroller ge ON ge.Enroller_key = epe.Enroller_key
		JOIN 	MSC_User u on u.User_key = ge.User_key
		-- Organizational information
		JOIN GRP_EnrollmentPeriod gep ON eep.EnrollmentPeriod_key = gep.EnrollmentPeriod_key
		inner join grp_group grp on gep.group_key = grp.group_key
		-- Rider Information
		JOIN PRD_Customization c ON c.GroupProduct_key = ep.GroupProduct_key
		join grp_groupproduct gp on gp.groupproduct_key = ep.groupproduct_key
		join prd_product prd on prd.product_key = epr.rider_key
		join prd_rider rider on rider.rider_key = prd.product_key
	where ep.EmployeeProductStatus_vv = 'ENROLLED'
		and e.group_key in ( '{b2c6840d-0c98-4c17-880c-4f2122a69bbf}' )
	group by e.group_key, u.user_key, prd.product_key, rider.product_key, prd.product_nm, prd.rider_flg, prd.VoluntaryProduct_flg
	) rprd 
	join (
	SELECT gep.Group_key, u.user_key, count(distinct cast(e.person_key as varchar(36))) as totemps
	FROM EMP_Employee e
		-- products that the user has enrolled in
		JOIN EMP_EmployeeProduct ep ON ep.Employee_key = e.Person_key
		join emp_employeeproductenrollment epe on epe.employeeproduct_key = ep.employeeproduct_key
		-- find the enroller of this product
		JOIN EMP_EmployeeEnrollmentPeriod eep ON epe.EnrollmentPeriod_key = eep.EnrollmentPeriod_key
		 and eep.Person_key = e.Person_key
		JOIN	GRP_Enroller ge ON ge.Enroller_key = epe.Enroller_key
		JOIN 	MSC_User u on u.User_key = ge.User_key
		-- Organizational information
		JOIN GRP_EnrollmentPeriod gep ON eep.EnrollmentPeriod_key = gep.EnrollmentPeriod_key
		inner join grp_group grp on gep.group_key = grp.group_key
	WHERE ep.EmployeeProductStatus_vv = 'ENROLLED'
			and gep.group_key in ( '{b2c6840d-0c98-4c17-880c-4f2122a69bbf}' ) 
	group by gep.group_key, u.user_key
	) totemps on totemps.group_key = rprd.group_key and totemps.user_key = rprd.user_key
order by rprd.Group_key, rprd.user_key,	rprd.parent, rprd.rider_flg