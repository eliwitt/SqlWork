select vendor.id, vendor.vendortypeptr, biz.businessname, biz.federaltaxid, biz.contact_personptr,
 addr.addressline1, addr.addressline2, addr.phonenumber, addr.zipinfoptr,
 zi.CityName + ', ' + zi.StateAbbr locnam, zi.zipcode,
 conperson.firstname, conperson.middlename, conperson.lastname, conperson.suffixid, 
 conperson.titleid, conperson.workphone, conperson.emailaddress, 0
from clm_vendor vendor
       join clm_businessentity biz on vendor.bizPtr = biz.id 
       join clm_address addr on biz.addressPTR = addr.id 
       join ZipInfo zi on addr.zipinfoptr = zi.id 
       join clm_person conperson on biz.contact_personptr = conperson.id
where vendor.disabled = 0 or vendor.disabled is null

--update CLM_Vendor set VendorTypePTR = 1 where id = 28