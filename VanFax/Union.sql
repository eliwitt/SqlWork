select '1' as first, * from Belron_Products 
where ProdRef like '%DW01260%'
union 
select  '2' as first, prod.* from Belron_Products prod, parts_xref 
where cpartnum like 'DW01260%' and cxrefnum = ltrim(ProdRef)
union
select  '3' as first, * from belron_products where prodid in (2503, 2519) order by first,prodid