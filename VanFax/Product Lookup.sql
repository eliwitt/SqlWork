declare @sub int,
	@ware1 int,
	@ware2 int,
	@prof int
set @sub = 3404
-- get the ware house information
--
select @ware1 = custware, @ware2 = custdepot, @prof = profid from belron_clients, edg_tbl_subscribers
where clientid = vcustid and subscriberid = @sub


--  get the qty and price for the client based on their profid
--	
select sum(p.Qty) as PQty, sum(s.Qty) as SQty, belprice.Price
	from Belron_InvQty p, Belron_InvQty s, Belron_Pricing belprice
where (p.ProdRef like 'AS1S%' and p.ProdId = 1001 and p.ware = @ware1) and 
	(s.ProdRef like 'AS1S%' and s.ProdId = 1001 and s.ware = @ware2) and
	(belprice.price_pro = @prof and belprice.ProdId = 1001 and 
	belprice.ProdRef like '%AS1S')
group by belPrice.Price

