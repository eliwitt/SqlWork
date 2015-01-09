SELECT * FROM ANS_QuestionUsage 
WHERE Product_key = '8eaf372e-644a-4894-b60a-02ec86661ce4'

select * from ans_questionusagesequence 
where questionusage_key in (SELECT questionusage_key FROM ANS_QuestionUsage 
WHERE Product_key = '8eaf372e-644a-4894-b60a-02ec86661ce4')

/*
update ans_questionusagesequence set questionusagejump_key = null
where questionusagesequence_key = '{513585AC-C04A-488C-87F3-A1C208A680DA}'

select * from prd_product where product_key = '8eaf372e-644a-4894-b60a-02ec86661ce4'

select * from prd_questionusagetransaction where questionusage_key = '725ACEF2-882B-49CE-8518-08E4D7F57390'

select * from prd_producttransaction where product_key = '8eaf372e-644a-4894-b60a-02ec86661ce4'

select * from prd_producttransaction where producttransaction_key in (
	select producttransaction_key 
	from prd_questionusagetransaction where questionusage_key = '725ACEF2-882B-49CE-8518-08E4D7F57390')
*/