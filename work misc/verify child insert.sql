--  Verify entries
declare @parent int
declare @newId int
select @parent = 3402
select @newId = 3412
select *
from
edg_tbl_subscribers
where
subscriberid = @newId

select *
from
edg_tbl_parentshoprelations
where
ParentShopId = @parent and
ChildShopId = @newId

select *
from
edg_tbl_PrivatePartsProfile
where
subscriberid = @newId
