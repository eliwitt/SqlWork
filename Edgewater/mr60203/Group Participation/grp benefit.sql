select distinct ed.person_key,e.group_key, etv.*, gtv.* from
	emp_employee e
	join emp_employeedata ed on e.person_key = ed.person_key
	join emp_employeetablevalue etv on ed.person_key = etv.person_key
	join grp_grouptablevalue gtv on etv.grouptablevalue_key = gtv.grouptablevalue_key
	where gtv.grouptablevalue_key in (
	select answerreference_key
from ans_answervalue
where answer_key = (select answer_key
from ans_answer
where answer_id = '54') and
group_key = '{eb23735d-336c-42cb-a26e-bcefc35534cc}'
)
and e.group_key = '{eb23735d-336c-42cb-a26e-bcefc35534cc}'
order by ed.person_key,etv.person_key