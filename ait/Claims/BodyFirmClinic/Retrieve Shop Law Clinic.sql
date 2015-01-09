select shop.id, biz.businessname
from clm_bodyshop shop
	join clm_businessentity biz on shop.businessentityptr = biz.id
union
select law.id, biz.businessname
from clm_lawfirm law
	join clm_businessentity biz on law.businessentityptr = biz.id
union
select clinic.id, biz.businessname
from clm_medicalclinic clinic
	join clm_businessentity biz on clinic.businessentityptr = biz.id