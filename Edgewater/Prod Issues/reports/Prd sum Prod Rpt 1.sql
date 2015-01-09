-- Prod summary Productivity
-- Total Applications
declare @FromDate datetime, @ThruDate datetime,
@Division_key nvarchar(50),
@Group_key nvarchar(50)
set @FromDate = '11-09-2006'
set @ThruDate = '04-01-2007'
set @Division_key = 'ALL'
set @Group_key = '{13fca7ff-f87a-4501-91f0-cae1c9f56be2}'
SELECT     COUNT(*) AS TotalApplications
FROM         EMP_EmployeeProduct ep JOIN
                      EMP_Employee e ON ep.Employee_key = e.Person_key JOIN
                      v_ReportingGroup rg ON rg.IncludedGroup_key = e.Group_key JOIN
                      GRP_Group g ON g.Group_key = e.Group_key JOIN
                      GRP_GroupProduct gp ON gp.GroupProduct_key = ep.GroupProduct_key JOIN
                      PRD_Product p ON p.Product_key = gp.Product_key JOIN
                      EMP_EmployeeProductEnrollment epe ON epe.EmployeeProduct_key = ep.EmployeeProduct_key JOIN
                      EMP_EmployeeEnrollmentPeriod eep ON eep.Person_key = e.Person_key AND eep.EnrollmentPeriod_key = epe.EnrollmentPeriod_key JOIN
                      GRP_EnrollmentPeriod gep ON gep.EnrollmentPeriod_key = epe.EnrollmentPeriod_key
WHERE     p.VoluntaryProduct_flg = 'Y' AND ep.EmployeeProductStatus_vv = 'ENROLLED' AND eep.EnrollmentStatus_vv = 'ENROLLED' AND 
                      gep.EnrollFrom_dt >= @FromDate AND gep.EnrollThru_dt <= @ThruDate AND g.InternalDivision_key = COALESCE (NULLIF (@Division_key, 'ALL'), 
                      g.InternalDivision_key) AND rg.ReportingGroup_key = COALESCE (NULLIF (@Group_key, 'ALL'), rg.ReportingGroup_key)