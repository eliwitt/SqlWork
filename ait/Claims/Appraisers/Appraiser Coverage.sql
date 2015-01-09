-- list of counties in LA for dropdown
select distinct CountyName from ZipInfo where StateAbbr = 'LA' order by CountyName asc
select zipcode from ZipInfo where CountyName = 'Beauregard'
select distinct app.id, biz.businessname biznam 
	from clm_appriaser app
		join clm_businessentity biz on app.businessentityptr = biz.id
		join clm_appraiserregion reg on app.id = reg.appraiserptr
where reg.zipcode in (select zipcode from ZipInfo where CountyName = 'Iberville')
select distinct app.id, biz.businessname biznam 
	from clm_appriaser app
		join clm_businessentity biz on app.businessentityptr = biz.id
		join clm_appraiserregion reg on app.id = reg.appraiserptr
where reg.zipcode = '70634'