declare @appPtr int
set @appPtr = 12
select * from clm_businessentity where id in (select businessentityptr from clm_appriaser where id = @appPtr)
select * from clm_person where id in (select Contact_PersonPTR from clm_businessentity where id in (select businessentityptr from clm_appriaser where id = @appPtr))
select * from clm_address where id in (select AddressPTR from clm_businessentity where id in (select businessentityptr from clm_appriaser where id = @appPtr))
select * from zipinfo where id in (select zipinfoptr from clm_address where id in (select AddressPTR from clm_businessentity where id in (select businessentityptr from clm_appriaser where id = @appPtr)))

select app.id, per.FirstName + ' ' + per.MiddleName + ' ' + per.LastName ContactName, 
	biz.businessname, bizaddr.addressline1, bizCSZ.Cityname + ',' + bizCSZ.StateAbbr + ' ' + bizCSZ.Zipcode CSZ, 
	bizaddr.phonenumber, per.emailaddress
	from clm_appriaser app
	join clm_businessentity biz on app.businessentityptr = biz.id
	join clm_person per on biz.contact_PersonPTR = per.id
	join clm_address bizaddr on biz.AddressPTR = bizaddr.id
	join zipinfo bizCSZ on bizaddr.zipinfoptr = bizCSZ.id

select app.id, biz.businessname 
	from clm_appriaser app
	join clm_businessentity biz on app.businessentityptr = biz.id
