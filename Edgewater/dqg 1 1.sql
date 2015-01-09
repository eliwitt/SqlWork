--  1.1  docs per prod
select p.product_nm, a.document_key, a.document_nm , originalfilename_nm,
c.documentusage_key
from doc_document a
join doc_documentusage c
on a.document_key = c.document_Key
join prd_product p
on p.product_key = c.product_key
where OriginalFilename_nm like '%Replacement%'
or (document_nm like 'Lost%')
order by document_nm;
