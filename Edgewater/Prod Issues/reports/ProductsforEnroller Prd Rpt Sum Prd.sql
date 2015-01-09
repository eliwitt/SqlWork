-- ProductsforEnroller from the Product Report Summary - Products
declare @Division_key nvarchar(50),
@Group_key uniqueidentifier,
@EnrollmentPeriod_key uniqueidentifier

set @Division_key = 'ALL'
set @Group_key = '{13fca7ff-f87a-4501-91f0-cae1c9f56be2}'
set @EnrollmentPeriod_key = '{3de54140-7921-4a6d-9046-0a13137f0301}'

SELECT	e.Person_key, UPPER(p.Product_nm) Product_nm,
		UPPER(u.First_nm + ' ' + u.Last_nm + ' - ' + u.Enroller_id) Enroller,
		ISNULL(ep.EmployeeYearlyCost_amt, 0) + ISNULL(ep.EmployerYearlyCost_amt, 0) Premium

FROM	EMP_EmployeeProduct ep
JOIN	EMP_Employee e ON ep.Employee_key = e.Person_key
JOIN	v_ReportingGroup rg ON rg.IncludedGroup_key = e.Group_key
JOIN	GRP_Group g ON g.Group_key = e.Group_key
JOIN	GRP_GroupProduct gp ON gp.GroupProduct_key = ep.GroupProduct_key
JOIN	PRD_Product p ON p.Product_key = gp.Product_key
JOIN	EMP_EmployeeProductEnrollment epe ON epe.EmployeeProduct_key = ep.EmployeeProduct_key
JOIN	EMP_EmployeeEnrollmentPeriod eep ON eep.Person_key = e.Person_key AND eep.EnrollmentPeriod_key = epe.EnrollmentPeriod_key
JOIN	GRP_Enroller ge ON ge.EnrollmentPeriod_key = epe.EnrollmentPeriod_key AND ge.Enroller_key = epe.Enroller_key
JOIN	MSC_USER u ON u.User_key = ge.User_key
WHERE	p.VoluntaryProduct_flg = 'Y'
		AND ep.EmployeeProductStatus_vv = 'ENROLLED'
		AND eep.EnrollmentStatus_vv = 'ENROLLED'
		AND	rg.ReportingGroup_key = @Group_key
		AND epe.EnrollmentPeriod_key = @EnrollmentPeriod_key
		AND	(g.InternalDivision_key = Coalesce(NullIf(@Division_key, 'ALL'), g.InternalDivision_key) OR NullIf(@Division_key, 'ALL') is Null)