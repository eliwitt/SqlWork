select    count(*) as Sequences, qu.question_txt, p.product_nm, 
g.company_nm, qu.questionusage_key
from      ans_questionusage qu 
	join      ans_questionusagesequence qus 
		on qu.questionusage_key = qus.questionusage_key
	left join prd_product p 
		on qu.product_key = p.product_key 
	left join grp_group g 
		on qu.group_key = g.group_key 
group by  qu.question_txt, p.product_nm, g.company_nm, qu.questionusage_key
having    count(*) > 54
order by  p.product_nm, g.company_nm, Sequences

