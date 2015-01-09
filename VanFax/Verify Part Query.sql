select * from Belron_Products Where ProdRef like '%DW%998%'
union 
select prod.* from Belron_Products prod,
 	parts_xref where cpartnum like 'DW%998%' and cxrefnum = ltrim(ProdRef)

select * from parts_xref where cpartnum like 'DW%998%'

select * from belron_products where ltrim(ProdRef) like 'KIT2%'

select * from belron_products order by ProdRef