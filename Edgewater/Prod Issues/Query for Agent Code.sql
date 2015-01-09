--select * from ans_answer where answer_id = 1193  -- 4B0AF737-0C97-4052-931E-DB92C662B942

--select * from ans_questionusage where answer_key = '{4B0AF737-0C97-4052-931E-DB92C662B942}'

select * from prd_questionusagetransaction where questionusage_key in (
select questionusage_key from ans_questionusage where answer_key = '{4B0AF737-0C97-4052-931E-DB92C662B942}'
)

select * from prd_product prod
	join prd_producttransaction prdtran on prod.product_key = prdtran.product_key
	join prd_questionusagetransaction qtran on prdtran.producttransaction_key = qtran.producttransaction_key
	join ans_questionusage quse on qtran.questionusage_key = quse.questionusage_key
where quse.answer_key <> '{4B0AF737-0C97-4052-931E-DB92C662B942}'
order by prod.product_nm