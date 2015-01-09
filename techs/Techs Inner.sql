declare @thismarket as char(4), @intstoreid as int, @Subscriber as int
--  market
--select @thismarket = 'PHX '
--  parent or non-parent
--select @intSubscriberId = 3402
--  child 3404 3403 3405 3406 3407 3408 3409 3410 3411 3412 3413 3414 3415
select @Subscriber = 3404

SELECT Tech.UserId, Tech.FirstName,
	Tech.LastName, Tech.TechId, Tech.SubscriberId
FROM   edg_tbl_ParentShopRelations as family
	inner join edg_tbl_Technicians as Tech on family.childshopId = Tech.SubscriberId
	inner join edg_tbl_market as market on Tech.MarketId = market.MarketId
WHERE  family.ChildShopId = @Subscriber
ORDER BY Tech.LastName