declare @thismarket as char(4), @intstoreid as int, @intSubscriberId as int
--  market
select @thismarket = 'PHX '
--  parent or non-parent
select @intSubscriberId = 3402
--  child 3404 3403 3405 3406 3407 3408 3409 3410 3411 3412 3413 3414 3415
select @intstoreid = 3403

-- thismarket  = 0
-- storeid
if (@thismarket = '') 
	begin
	if (@intstoreid > 0)
		begin
		select 'select one'
		SELECT edg_tbl_ParentShopRelations.ChildShopId, edg_tbl_Subscribers.Company, edg_tbl_Technicians.UserId, edg_tbl_Technicians.FirstName,
			edg_tbl_Technicians.LastName, edg_tbl_Technicians.TechId, edg_tbl_Technicians.SubscriberId, edg_tbl_ParentShopRelations.ParentShopId,edg_tbl_ParentShopRelations.ChildMarketId
		FROM   edg_tbl_ParentShopRelations LEFT OUTER JOIN 
			edg_tbl_Subscribers ON edg_tbl_ParentShopRelations.ChildShopId = edg_tbl_Subscribers.SubscriberId RIGHT OUTER JOIN
			edg_tbl_Technicians ON edg_tbl_Subscribers.SubscriberId = edg_tbl_Technicians.SubscriberId 
		WHERE  (edg_tbl_ParentShopRelations.ParentShopId = @intSubscriberId ) AND (edg_tbl_ParentShopRelations.ChildShopId = @intStoreId)
		ORDER BY edg_tbl_Technicians.LastName
		end
--
	else
	begin
		select 'select two'
		SELECT edg_tbl_ParentShopRelations.ChildShopId, edg_tbl_Subscribers.Company, edg_tbl_Technicians.UserId, edg_tbl_Technicians.FirstName,
			edg_tbl_Technicians.LastName, edg_tbl_Technicians.TechId, edg_tbl_Technicians.SubscriberId, edg_tbl_ParentShopRelations.ParentShopId, edg_tbl_ParentShopRelations.ChildMarketId
		FROM   edg_tbl_ParentShopRelations LEFT OUTER JOIN
			edg_tbl_Subscribers ON edg_tbl_ParentShopRelations.ChildShopId = edg_tbl_Subscribers.SubscriberId RIGHT OUTER JOIN
			edg_tbl_Technicians ON edg_tbl_Subscribers.SubscriberId = edg_tbl_Technicians.SubscriberId
		WHERE  (edg_tbl_ParentShopRelations.ParentShopId = @intSubscriberId)
		ORDER BY edg_tbl_Technicians.LastName
	end
	end
else
	begin
	if (@intStoreId>0)
		begin
		select 'select three'
		SELECT edg_tbl_ParentShopRelations.ChildShopId, edg_tbl_Subscribers.Company, edg_tbl_Technicians.UserId, edg_tbl_Technicians.FirstName,
			edg_tbl_Technicians.LastName, edg_tbl_Technicians.TechId, edg_tbl_Technicians.SubscriberId, edg_tbl_ParentShopRelations.ParentShopId,edg_tbl_ParentShopRelations.ChildMarketId
		FROM   edg_tbl_ParentShopRelations LEFT OUTER JOIN
			edg_tbl_Subscribers ON edg_tbl_ParentShopRelations.ChildShopId = edg_tbl_Subscribers.SubscriberId RIGHT OUTER JOIN
			edg_tbl_Technicians ON edg_tbl_Subscribers.SubscriberId = edg_tbl_Technicians.SubscriberId
		WHERE  (edg_tbl_ParentShopRelations.ParentShopId = @intSubscriberId ) AND (edg_tbl_ParentShopRelations.ChildShopId =@intStoreId ) AND (edg_tbl_ParentShopRelations.ChildMarketId=@thismarket)
		ORDER BY edg_tbl_Technicians.LastName
	end
	else
		begin
		select 'select four'
		SELECT edg_tbl_ParentShopRelations.ChildShopId, edg_tbl_Subscribers.Company, edg_tbl_Technicians.UserId, edg_tbl_Technicians.FirstName,
			edg_tbl_Technicians.LastName, edg_tbl_Technicians.TechId, edg_tbl_Technicians.SubscriberId, edg_tbl_ParentShopRelations.ParentShopId,edg_tbl_ParentShopRelations.ChildMarketId
		FROM   edg_tbl_ParentShopRelations LEFT OUTER JOIN
			edg_tbl_Subscribers ON edg_tbl_ParentShopRelations.ChildShopId = edg_tbl_Subscribers.SubscriberId RIGHT OUTER JOIN
			edg_tbl_Technicians ON edg_tbl_Subscribers.SubscriberId = edg_tbl_Technicians.SubscriberId
		WHERE  (edg_tbl_ParentShopRelations.ParentShopId = @intSubscriberId) AND (edg_tbl_ParentShopRelations.ChildMarketId=@thismarket)
		ORDER BY edg_tbl_Technicians.LastName
	end
end

