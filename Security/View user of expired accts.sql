select * from edg_tbl_users people
	inner join edg_tbl_subscribers acct
		on people.subscriberid = acct.subscriberid
where acct.ExpirationDate <= GETDATE()