-- Prod Summary Productivity
-- Total Employees Seen
declare @FromDate datetime, @ThruDate datetime,
@Division_key nvarchar(50),
@Group_key nvarchar(50)
set @FromDate = '11-09-2006'
set @ThruDate = '04-01-2007'
set @Division_key = 'ALL'
set @Group_key = 'ALL'
SELECT 	Count(Distinct Cast(ee.Employee_key as varchar(36))) TotalEmployeesSeen
FROM	v_EmployeeEnroller ee
JOIN	EMP_Employee e 				ON e.Person_key = ee.Employee_key
JOIN	v_ReportingGroup rg 		ON rg.IncludedGroup_key = e.Group_key
JOIN	GRP_Group g         		ON g.Group_key = rg.IncludedGroup_key
JOIN	GRP_EnrollmentPeriod ep		ON ep.Group_key = rg.PrimaryGroup_key
WHERE	ep.EnrollFrom_dt >= @FromDate
		AND	ep.EnrollThru_dt <= @ThruDate
		AND	rg.ReportingGroup_key = IsNull(NullIf(@Group_key, 'ALL'), rg.ReportingGroup_key)
		AND	(g.InternalDivision_key = NullIf(@Division_key, 'ALL') OR NullIf(@Division_key, 'ALL') is Null)