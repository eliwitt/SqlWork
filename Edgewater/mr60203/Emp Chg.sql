declare @cmdStr nvarchar(1000),
	@orgStr nvarchar(4000),
	@FromDate	smalldatetime,
	@ThruDate	smalldatetime,
	@Division_key	nvarchar(1000),
	@Group_key nvarchar(1000)
set @ThruDate = '06/30/2007'
set @FromDate = '01/01/2005'
set @Group_key = '''{818b16ff-161e-4bf5-8d17-355d64510f7f}'',''{4b676ae6-34ea-466e-b3ac-2949c654a621}'''
--set @Group_key = 'ALL'
set @Division_key = 'ALL'
--print @Group_key
set @cmdStr = 'SELECT 	Count(Distinct Cast(ee.Employee_key as varchar(36))) TotalEmployeesSeen
FROM	v_EmployeeEnroller ee
JOIN	EMP_Employee e 				ON e.Person_key = ee.Employee_key
JOIN	v_ReportingGroup rg 		ON rg.IncludedGroup_key = e.Group_key
JOIN	GRP_Group g         		ON g.Group_key = rg.IncludedGroup_key
JOIN	GRP_EnrollmentPeriod ep		ON ep.Group_key = rg.PrimaryGroup_key
WHERE	ep.EnrollFrom_dt >= ''' + cast(@FromDate as nvarchar(30)) + '''	AND	ep.EnrollThru_dt <= ''' + cast(@ThruDate as nvarchar(30)) + ''''
if @Group_key <> 'ALL'
	set @cmdStr = @cmdStr + ' AND	rg.ReportingGroup_key in (' + @Group_key + ')'
if @Division_key <> 'ALL'
	set @cmdStr = @cmdStr + ' AND	g.InternalDivision_key = ''{' + @Division_key + '}'''
print @cmdStr
exec(@cmdStr)
