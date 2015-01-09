set ROWCOUNT 5
select * 
from 
edg_tbl_Invoice_Master
order by InvoiceId desc
select *
from
edg_tbl_Users
where
Subscriberid = 3402