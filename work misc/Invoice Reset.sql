declare @inv int
set @inv = 2625
--  show the invoice
select invoiceid,SubmittedOn,SubmittedBy,SubmittedVia from edg_tbl_invoice_master
where invoiceid = @inv
--  reset this invoice
update edg_tbl_invoice_master 
	set SubmittedOn = NULL,
	SubmittedBy = 0,
	SubmittedVia = ''
where invoiceid = @inv
--  show the resetted invoice
select invoiceid,SubmittedOn,SubmittedBy,SubmittedVia from edg_tbl_invoice_master
where invoiceid = @inv

