declare @open int
declare @inv int

select @open = Openingid
from edg_tbl_invoice_lineitem 
where lineitemid = 2882

select @inv = InvoiceId
from edg_tbl_invoice_opening
where OpeningId = @open

select @open as 'Open Id', @inv as 'Invoice id', InsuranceId, subscriberid 
from edg_tbl_invoice_master
where invoiceid = @inv