declare @inid int, @id int
declare @in_sub int, @debug int, @mktcd int
set @debug = 1
set @inid = 2669
set @id = 3418
select @in_sub = SubscriberId
from 
edg_tbl_invoice_master
where 
invoiceid = @inid 
if @debug = 1 
	print 'in sub ' + convert(char(4), @in_sub)
--  Get the subscribers market
select @mktcd  = MarketId
from edg_tbl_market
where MarketCode = (select ChildMarketId
			from 
			edg_tbl_Parentshoprelations
			where
			parentshopid = @id and childshopid = @in_sub)
if @debug = 1 
	print 'the market code ' + convert(char(4), @mktcd)

print 'The techs available to ' + convert(char(4),@id) + ' for the assignment'

select tech.techid, tech.subscriberid, tech.marketid, tech.FirstName, tech.LastName
from edg_tbl_technicians as tech
where 
marketid = @mktcd

print 'The techs available to ' + convert(char(4),@in_sub) + ' for assignment'
select tech.techid, tech.subscriberid, tech.marketid, tech.FirstName, tech.LastName
from edg_tbl_technicians as tech
where 
tech.subscriberid = @in_sub



