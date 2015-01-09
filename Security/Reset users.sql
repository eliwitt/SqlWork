Update edg_tbl_users 
	set AccountDisabled = 0
from edg_tbl_users people
	inner join edg_tbl_subscribers acct
		on people.subscriberid = acct.subscriberid
where acct.ExpirationDate <= GETDATE() and AccountDisabled = 1