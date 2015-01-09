-- Group Participation finder
select org.organizationshort_nm as carrier, grpval.short_nm as Coverage 
from grp_groupproduct grpprd
	--  retrieve all of the groups products
	join prd_product prod 
		on grpprd.product_key = prod.product_key
	--  for each product get their carrier short name
	join msc_organization org 
		on prod.carrier_key = org.organization_key
	--  for each product get their coverage type
	join grp_grouptablevalue grpval 
		on grpprd.benefittype_key = grpval.grouptablevalue_key
where group_key = '{4b676ae6-34ea-466e-b3ac-2949c654a621}'
order by org.organizationshort_nm