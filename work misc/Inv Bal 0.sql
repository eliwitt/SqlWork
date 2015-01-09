select * from edg_tbl_invoice_master
where invoicestatus = 3 and balance = 0 and 
subscriberid in (select childshopid from edg_tbl_parentshoprelations
	where parentshopid = 3442)