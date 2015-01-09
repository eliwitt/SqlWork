declare @strID int
insert edg_tbl_Market (ParentShopId, MarketCode, MarketCodeDescription)
values(3402, 3325, 'Testing the Identity function again')
select @strID=@@IDENTITY
print @strID