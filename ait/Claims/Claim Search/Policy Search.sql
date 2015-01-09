select distinct b.policynumber,o.[Index], rtrim(p.FirstName) + ' ' + rtrim(p.LastName) member, p.emailaddress, p.homephone
FROM Policy b 
	join Operator o on o.PolicyPTR = b.id 
		join person p on p.id = o.PersonInfoPTR 
	join Address a on a.id = b.HomeAddressPTR 
		join zipInfo Z on z.id = a.ZipInfo_ZipInfoPTR 
WHERE p.firstname + ' ' + p.lastname like 'br% Holland%'
 and b.policynumber is not null 
order by b.policynumber, o.[Index] asc
--WHERE p.firstname + ' ' + p.lastname like 'br% Holland%'
-- and b.policynumber is not null 