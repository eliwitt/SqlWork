SELECT * FROM ANS_QuestionUsage WHERE Product_key = '960F2902-97CD-4412-97BE-2607313A9E88'

select * from prd_questionusagetransaction where questionusage_key = '725ACEF2-882B-49CE-8518-08E4D7F57390'

select * from prd_producttransaction where product_key = '960F2902-97CD-4412-97BE-2607313A9E88'

select * from prd_producttransaction where producttransaction_key in (
	select producttransaction_key 
	from prd_questionusagetransaction where questionusage_key = '725ACEF2-882B-49CE-8518-08E4D7F57390')