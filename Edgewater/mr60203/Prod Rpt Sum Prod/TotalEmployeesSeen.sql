-- TotalEmployeesSeen
--
declare @cmdStr nvarchar(1000), 
	@orgStr nvarchar(1000), 
	@TailStr nvarchar(1000), 
	@FromDate	smalldatetime,
	@ThruDate	smalldatetime,
	@Division_key	nvarchar(1000),
	@Group_key 	nvarchar(1000),
	@EnrollmentPeriod_key nvarchar(1000),
	@Grp_key nvarchar(1000)
set @TailStr = ' where '
set @orgStr = ''

set @ThruDate = ''
set @FromDate = ''
set @ThruDate = '06/30/2007'
set @FromDate = '01/01/2005'
--
-- group  -------------------------------------------------
--
set @Group_key = 'ALL'
--	Ace 818b16ff-161e-4bf5-8d17-355d64510f7f
--set @Group_key = '''{818b16ff-161e-4bf5-8d17-355d64510f7f}'''
--	Chatt Chamber dd973c8a-1884-49fd-8e79-6bf5a83a3bb2
--	Hermitage Medical Associates 4b676ae6-34ea-466e-b3ac-2949c654a621
set @Group_key = '4b676ae6-34ea-466e-b3ac-2949c654a621,dd973c8a-1884-49fd-8e79-6bf5a83a3bb2'
--
-- enrollment period  ---------------------------------------
--
--	Ace FA05C718-5C66-49D2-A67D-2984F18DF5A2
--set @EnrollmentPeriod = '''{FA05C718-5C66-49D2-A67D-2984F18DF5A2}'''
--	Chatt Chamber 8b1acbc0-ac07-4383-8271-379001be7097
--set @EnrollmentPeriod = '''{8b1acbc0-ac07-4383-8271-379001be7097}'''
--	Hermitage Medical Associates 878387af-f666-4e6c-bd5a-b9b90e401c62
--set @EnrollmentPeriod = '''{878387af-f666-4e6c-bd5a-b9b90e401c62}'''
--
--  division  -----------------------------------------------
--set @Division_key = '''{E2BB4AAB-78D4-4919-9F79-415BC7BEBFEB}'''
set @Division_key = 'ALL'

set @cmdStr = 'SELECT 	rg.ReportingGroup_key, Count(Distinct Cast(ee.Employee_key as varchar(36))) TotalEmployeesSeen
FROM	v_EmployeeEnroller ee
JOIN	EMP_Employee e 				ON e.Person_key = ee.Employee_key
JOIN	v_ReportingGroup rg 		ON rg.IncludedGroup_key = e.Group_key
JOIN	GRP_Group g         		ON g.Group_key = rg.IncludedGroup_key
JOIN	GRP_EnrollmentPeriod ep		ON ep.Group_key = rg.PrimaryGroup_key
'
if @FromDate <> '' and @ThruDate <> ''
begin
	set @TailStr = @TailStr + ' ep.EnrollFrom_dt > ''' + cast(@FromDate as nvarchar(30)) + ''' and ep.EnrollThru_dt < ''' + cast(@ThruDate as nvarchar(30)) + ''''
	goto Grp_Div_Chk
end
if @EnrollmentPeriod_key <> ''
begin
	set @TailStr = @TailStr + ' ep.enrollmentperiod_key = ''{' + @EnrollmentPeriod_key + '}'''
end
goto Grp_Div_Chk

Grp_Div_Chk:
set @Grp_key = @Group_key
if @Grp_key <> 'ALL'
begin
	if len(@TailStr) > 7
		set @TailStr = @TailStr + ' and rg.ReportingGroup_key in ('
	else
		set @TailStr = @TailStr + ' rg.ReportingGroup_key in ('
	while (charindex(',',@Grp_key)>0)
	begin
		print ltrim(rtrim(substring(@Grp_key, 1,charindex(',',@Grp_key)-1)))
		if len(@orgStr) > 0
			set @orgStr = @orgStr + ',''{' + ltrim(rtrim(substring(@Grp_key, 1,charindex(',',@Grp_key)-1))) + '}'''
		else
			set @orgStr = @orgStr + '''{' + ltrim(rtrim(substring(@Grp_key, 1,charindex(',',@Group_key)-1))) + '}'''
		set @Grp_key = substring(@Grp_key,charindex(',',@Grp_key) + 1,len(@Grp_key))
	end
	--print @Grp_key
	if len(@orgStr) > 0
		set @orgStr = @orgStr + ',''{' + @Grp_key + '}'''
	else
		set @orgStr = @orgStr + '''{' + @Grp_key + '}'''
	set @TailStr = @TailStr + @orgStr + ')'
end
if @Division_key = ''
    goto Start_cmd
if @Division_key <> 'ALL'
	if len(@TailStr) > 7
		set @TailStr = @TailStr + ' AND	g.InternalDivision_key = ' + @Division_key 
	else
		set @TailStr = @TailStr + ' g.InternalDivision_key in ( ' + @Division_key + ')'

Start_cmd:
if @TailStr = ' where '
begin
       print @cmdStr
       exec(@cmdStr + ' group by rg.ReportingGroup_key')
end 
else
begin
       print @cmdStr + @TailStr
       exec(@cmdStr + @TailStr + ' group by rg.ReportingGroup_key')
end