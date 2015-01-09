select userid from edg_tbl_users users
	inner join edg_tbl_subscribers shops
		on users.subscriberid = shops.subscriberid
where shops.subscriberid = 3404