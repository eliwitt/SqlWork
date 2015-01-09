select * from ans_answervalue
	where answer_key = (select answer_key from ans_answer where answer_id = '54')
	and group_key = '{eb23735d-336c-42cb-a26e-bcefc35534cc}'