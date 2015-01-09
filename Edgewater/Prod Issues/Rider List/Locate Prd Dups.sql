-- Find the dup keys
select * from prd_customization prd1
join(
	select product_key, count(cast(product_key as varchar(36))) as dupCt
	from prd_customization
	group by product_key
	having count(cast(product_key as varchar(36))) > 1
) prd2 on prd1.product_key = prd2.product_key
