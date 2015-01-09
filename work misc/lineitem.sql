exec edg_sp_findinvoicerecord 2646

select * 
from edg_tbl_invoice_lineitem as LI
right outer join edg_tbl_invoice_opening as IO on
IO.OpeningId = LI.Openingid
where IO.InvoiceId = 2646

select * from edg_tbl_oa_cash where subscriberid = 3405
