declare @cmdStr		nvarchar(4000),
	@Group_key 	nvarchar(1000),
	@Grp_key	nvarchar(1000),
	@orgStr		nvarchar(4000),
	@EnrollmentPeriod_key nvarchar(1000)
set @orgStr = ''
--
-- group  -------------------------------------------------
--
set @Group_key = 'ALL'
--	Ace 818b16ff-161e-4bf5-8d17-355d64510f7f
--set @Group_key = '818b16ff-161e-4bf5-8d17-355d64510f7f'
--	Chatt Chamber dd973c8a-1884-49fd-8e79-6bf5a83a3bb2
--	Hermitage Medical Associates 4b676ae6-34ea-466e-b3ac-2949c654a621
set @Group_key = '818b16ff-161e-4bf5-8d17-355d64510f7f,4b676ae6-34ea-466e-b3ac-2949c654a621'
--
-- add the selected groups
if @Group_key = 'ALL'
    goto All_grps
set @Grp_key = @Group_key
while (charindex(',',@Grp_key)>0)
begin

  if len(@orgStr) > 0
	set @orgStr = @orgStr + ',''{' + ltrim(rtrim(substring(@Grp_key, 1,charindex(',',@Grp_key)-1))) + '}'''
  else
	set @orgStr = @orgStr + '''{' + ltrim(rtrim(substring(@Grp_key, 1,charindex(',',@Grp_key)-1))) + '}'''
  set @Grp_key = substring(@Grp_key,charindex(',',@Grp_key) + 1,len(@Grp_key))
end

 if len(@orgStr) > 0
	set @orgStr = @orgStr + ',''{' + @Grp_key + '}'''
else
	set @orgStr = @orgStr + '''{' + @Grp_key + '}'''
set @orgStr = 'WHERE ep.Group_key in (' + @orgStr + ')'

ALL_grps:
--	Ace FA05C718-5C66-49D2-A67D-2984F18DF5A2
--set @EnrollmentPeriod_key = '''{FA05C718-5C66-49D2-A67D-2984F18DF5A2}'''
--	Chatt Chamber 8b1acbc0-ac07-4383-8271-379001be7097
--set @EnrollmentPeriod = '''{8b1acbc0-ac07-4383-8271-379001be7097}'''
--	Hermitage Medical Associates 878387af-f666-4e6c-bd5a-b9b90e401c62
--set @EnrollmentPeriod = '''{878387af-f666-4e6c-bd5a-b9b90e401c62}'''
--

if @EnrollmentPeriod_key <> ''
begin
	set @cmdStr = '	SELECT *  FROM	GRP_EnrollmentPeriod ep WHERE	ep.EnrollmentPeriod_key = ' + @EnrollmentPeriod_key
end
else
begin
	set @cmdStr = 'SELECT max(cast(EnrollmentPeriod_key as nvarchar(60))) as EnrollmentPeriod_key,ep.Group_key, g.Company_nm, EnrollFrom_dt, EnrollThru_dt 
	FROM	GRP_EnrollmentPeriod ep
		join grp_group g
		on g.Group_key = ep.Group_key ' + @orgStr +
	' group by ep.Group_key, g.Company_nm, EnrollFrom_dt, EnrollThru_dt
	order by g.Company_nm'
end
print @cmdStr
exec(@cmdStr)