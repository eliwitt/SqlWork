delete ans_questionusagesequence where questionusage_key in  
(  
select qu.questionusage_key   
from   ans_questionusage qu  
join   ans_answer a  
on     qu.answer_key = a.answer_key  
where  qu.product_key is not null  
and    a.tabletype_vv is not null  
)