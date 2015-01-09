select e_name, e_ina01, 
itmv02_e_name, i.itmv02_value
from chaaedmn1.site_accp.dbo.element he
	inner join chaaedmn1.site_accp.dbo.item_mv_custom02 i  
		on he.e_name = i.itmv02_e_name 
where he.e_ina01 like 'HOLDER,%' aND 
left(i.itmv02_value,3) = 'tva'