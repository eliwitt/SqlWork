select ProdRef, sum(Qty) from Belron_InvQty
where ProdRef like '13%' 
and ProdId = 2676
group by ProdRef

select * from Belron_InvQty
where ProdRef like '%AS1S%'

select * from Belron_InvQty