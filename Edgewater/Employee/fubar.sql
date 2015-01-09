-- coverage
select * from msc_coverage
-- typecontract
select * from ans_answer where answer_key = '3f83256c-7d80-455c-abf1-9ff3148ae6f9'
select * from ans_answervalue where answer_key = '3f83256c-7d80-455c-abf1-9ff3148ae6f9'
-- typecontractrider
select * from ans_answer where answer_key = 'AB543113-2CEA-4591-9BCF-83E2C37DA8B8'
select * from ans_answervalue where answer_key = 'AB543113-2CEA-4591-9BCF-83E2C37DA8B8'
-- employeeproductdata
select * from emp_employeeproductdata
where Answer_txt in ( select cast(answerreference_key as nvarchar(36)) from ans_answervalue where answer_key = '3f83256c-7d80-455c-abf1-9ff3148ae6f9')