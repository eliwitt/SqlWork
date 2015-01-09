declare @cmdStr nvarchar(1000),
	@orgStr nvarchar(4000),
	@commas int,
	@guidnu int,
	@gPart nvarchar(36),
	@FromDate	smalldatetime,
	@ThruDate	smalldatetime,
	@Group_key nvarchar(1000)
set @orgStr = ''
set @cmdStr = 'select * from grp_group' 
set @ThruDate = '06/30/2007'
set @FromDate = '01/01/2005'
set @Group_key = '818b16ff-161e-4bf5-8d17-355d64510f7f,4b676ae6-34ea-466e-b3ac-2949c654a621'
--set @Group_key = '4b676ae6-34ea-466e-b3ac-2949c654a621'
--set @Group_key = 'All'
if @Group_key <> 'All'
begin
	set @cmdStr = @cmdStr + ' where group_key in ('
	while (charindex(',',@Group_key)>0)
	begin
		print ltrim(rtrim(substring(@Group_key, 1,charindex(',',@Group_key)-1)))
		if len(@orgStr) > 0
			set @orgStr = @orgStr + ',''{' + ltrim(rtrim(substring(@Group_key, 1,charindex(',',@Group_key)-1))) + '}'''
		else
			set @orgStr = @orgStr + '''{' + ltrim(rtrim(substring(@Group_key, 1,charindex(',',@Group_key)-1))) + '}'''
		set @Group_key = substring(@Group_key,charindex(',',@Group_key) + 1,len(@Group_key))
	end
	print @Group_key
	if len(@orgStr) > 0
		set @orgStr = @orgStr + ',''{' + @group_key + '}'''
	else
		set @orgStr = @orgStr + '''{' + @Group_key + '}'''
	set @cmdStr = @cmdStr + @orgStr + ')'
end
print @cmdStr
exec(@cmdStr)