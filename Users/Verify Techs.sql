declare @id as int, @kid as int
set @id = 3402
set @kid = 3406
print 'The markets for ' + convert(char,@id)
select MarketId, ParentShopId, MarketCode, MarketCodeDescription
from edg_tbl_market
where ParentShopId = @id

print convert(char(4),@id) + 's family'
select *
	from 
	edg_tbl_Parentshoprelations
	where
	parentshopid = @id and
	not (childshopid = @id)

print 'The techs available to ' + convert(char(4),@id) + ' for the assignment'

select tech.techid, tech.subscriberid, tech.marketid, tech.FirstName, tech.LastName
from edg_tbl_technicians as tech
	inner join edg_tbl_market as market on market.marketid = tech.marketid
where 
market.marketcode in (select distinct ChildMarketId
		from 
		edg_tbl_Parentshoprelations
		where
		parentshopid = @id and
		childshopid = @kid) and
market.parentshopid = @id

print 'The techs available to ' + convert(char(4),@kid) + ' for assignment'
select tech.techid, tech.subscriberid, tech.marketid, tech.FirstName, tech.LastName
from edg_tbl_technicians as tech
	inner join edg_tbl_market as market on market.marketid = tech.marketid
where 
tech.subscriberid = @kid and
market.marketcode in (select distinct ChildMarketId
		from 
		edg_tbl_Parentshoprelations
		where
		childshopid = @kid) and 
market.parentshopid = @id
