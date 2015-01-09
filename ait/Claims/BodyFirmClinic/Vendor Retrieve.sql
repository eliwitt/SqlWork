select 1 vendortype, clinic.id enitytid, clinic.clinictypeid entitytypeid, 
 biz.businessname, biz.federaltaxid, biz.contact_personptr,
 addr.addressline1, addr.addressline2, addr.phonenumber, addr.zipinfoptr,
 zi.CityName + ', ' + zi.StateAbbr locnam, zi.zipcode, 
 conperson.firstname, conperson.middlename, conperson.lastname, conperson.suffixid,
 conperson.titleid, conperson.workphone, conperson.emailaddress, medpro.medicalprotypeid protypeid 
from clm_medicalclinic clinic 
       join clm_businessentity biz on clinic.businessEntityPtr = biz.id 
       join clm_address addr on biz.addressPTR = addr.id
       join ZipInfo zi on addr.zipinfoptr = zi.id 
       join clm_person conperson on biz.contact_personptr = conperson.id 
       join clm_medicalprofessional medpro on conperson.id = medpro.personalinfo_personptr 
where clinic.disabled = 0 or clinic.disabled is null
union
select 2 vendortype, firm.id, firm.Firmtypeid, biz.businessname, biz.federaltaxid, biz.contact_personptr,
 addr.addressline1, addr.addressline2, addr.phonenumber, addr.zipinfoptr,
 zi.CityName + ', ' + zi.StateAbbr locnam, zi.zipcode,
 conperson.firstname, conperson.middlename, conperson.lastname, conperson.suffixid,
 conperson.titleid, conperson.workphone, conperson.emailaddress, attpro.attorneytypeid
from clm_lawFirm Firm 
       join clm_businessentity biz on Firm.businessEntityPtr = biz.id 
       join clm_address addr on biz.addressPTR = addr.id
       join ZipInfo zi on addr.zipinfoptr = zi.id 
       join clm_person conperson on biz.contact_personptr = conperson.id 
       join clm_attorney attpro on conperson.id = attpro.personalinfo_personptr
where Firm.disabled = 0 or Firm.disabled is null
union
select 3 vendortype, shop.id, shop.bodyshoptypeid, biz.businessname, biz.federaltaxid, biz.contact_personptr,
 addr.addressline1, addr.addressline2, addr.phonenumber, addr.zipinfoptr,
 zi.CityName + ', ' + zi.StateAbbr locnam, zi.zipcode,
 conperson.firstname, conperson.middlename, conperson.lastname, conperson.suffixid, 
 conperson.titleid, conperson.workphone, conperson.emailaddress, 0
from clm_BodyShop shop 
       join clm_businessentity biz on shop.businessEntityPtr = biz.id 
       join clm_address addr on biz.addressPTR = addr.id 
       join ZipInfo zi on addr.zipinfoptr = zi.id 
       join clm_person conperson on biz.contact_personptr = conperson.id
where shop.disabled = 0 or shop.disabled is null
union
select 4 vendortype, vendor.id, vendor.vendortypeptr, biz.businessname, biz.federaltaxid, biz.contact_personptr,
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