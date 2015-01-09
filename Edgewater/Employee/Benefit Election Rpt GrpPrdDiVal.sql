declare @Group_key 	nvarchar(1000)
set @Group_key = '09964FA8-54A7-449D-9206-25DB336C7CCA'

select prddi.dimension_key from grp_groupproduct grpprd
	join prd_dimension prddi on prddi.product_key = grpprd.product_key
where grpprd.groupproduct_key = @Group_key and
	prddi.answer_key = '3F83256C-7D80-455C-ABF1-9FF3148AE6F9'

select * from  grp_groupproductdimension 
where dimension_key = ( 
	select prddi.dimension_key from grp_groupproduct grpprd
		join prd_dimension prddi on prddi.product_key = grpprd.product_key
	where grpprd.groupproduct_key = @Group_key and
		prddi.answer_key = '3F83256C-7D80-455C-ABF1-9FF3148AE6F9'
	) 
and groupproduct_key = @Group_key

select * from grp_groupproductdimensionvalue
where groupproductdimension_key = (
select groupproductdimension_key from  grp_groupproductdimension 
where dimension_key = ( 
	select prddi.dimension_key from grp_groupproduct grpprd
		join prd_dimension prddi on prddi.product_key = grpprd.product_key
	where grpprd.groupproduct_key = @Group_key and
		prddi.answer_key = '3F83256C-7D80-455C-ABF1-9FF3148AE6F9'
	) 
and groupproduct_key = @Group_key
)