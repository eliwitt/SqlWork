--  retrieve the permissions based a subscriber
--
select count(*) from edg_tbl_subscribers 
	inner join edg_tbl_perm_xref on SubscriberLevel = lev
	inner join edg_tbl_permision_Definitions on pdef = [id]
where subscriberid = 3411
--
select [id], [Description] from edg_tbl_subscribers 
	inner join edg_tbl_perm_xref on SubscriberLevel = lev
	inner join edg_tbl_permision_Definitions on pdef = [id]
where subscriberid = 3411 order by [id]
