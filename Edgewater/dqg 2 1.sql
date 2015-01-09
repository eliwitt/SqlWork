-- 2.1 Questions per Prod with trans with or without Jumps
select product_nm, productshort_nm, ans.phase_type_vv, question_entity_vv, answer_identifier_nm, ans.defaultsequence_num, ans.pagebreakbefore_flg, 
ans.referenceid_nm, ans.question_txt, ans.pagebreakbefore_flg, aq.answer_seq, answer_txt, sequenceoverride_flg, disabled_flg,
questionusagejump_key, ans2.defaultsequence_num, jump_type, productTransaction_nm
from ans_questionusage ans
inner join prd_product p
on p.product_key = ans.product_key
inner join ans_answer a
on a.answer_key = ans.answer_key
inner join prd_questionusagetransaction pq
on pq.QuestionUsage_key = ans.questionusage_key
inner join prd_producttransaction pt 
on pt.producttransaction_key = pq.producttransaction_key
Left join ANS_QuestionUsageSequence aq
on aq.QuestionUsage_key = ans.QuestionUsage_key
left join ans_answervalue av
on av.AnswerValue_key = aq.AnswerValue_key
left join ANS_QuestionUsage ans2
on ans2.QuestionUsage_key = aq.questionusagejump_key
where product_nm like 'Accident Guard%'
order by product_nm, ans.phase_type_vv, ans.defaultsequence_num
