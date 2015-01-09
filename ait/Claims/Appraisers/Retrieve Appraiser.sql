select businessname, federaltaxid, addressline1, addressline2, zipper.zipcode, phonenumber, 
	firstname, lastname, cellphone, workphone
from clm_businessentity biz 
	join clm_address bizaddr on biz.addressptr = bizaddr.id
	join zipinfo zipper on bizaddr.zipinfoptr = zipper.id
	join clm_person contact on biz.contact_personptr = contact.id
where biz.id = 31