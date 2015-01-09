select * 
from ans_answer 
where answer_key = '{31CD3225-9C6A-4DAD-A8A5-3A6820CDF257}'

select *
from ans_answervalue
where answer_key = (select answer_key
from ans_answer
where answer_id = '54') and
group_key = '{95E7EE5C-A2B0-4BB5-9F73-CA57D6D90ABE}'