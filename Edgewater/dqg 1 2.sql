--  1.2  docs per Prod per trans type
select p.product_nm, d.producttransaction_nm, 
a.document_key, a.document_nm , originalfilename_nm 
from doc_document a
join doc_documentusage c
on a.document_key = c.document_Key
join doc_documenttransaction b
on b.documentusage_key = c.documentusage_Key
join prd_producttransaction d
on d.producttransaction_key = b.producttransaction_key 
join prd_product p
on p.product_key = c.product_key
order by a.document_key