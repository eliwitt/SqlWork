select * from prd_costtablevalue where costtablevalue_key = '1E8FD62F-E5A6-4C29-870A-EC64BA792386'
select * from prd_dimensionvalue 
	where dimensionvalue_key in (select Dimensionvalue_x_key from prd_costtablevalue where costtablevalue_key = '1E8FD62F-E5A6-4C29-870A-EC64BA792386')
	and answervalue_key in (select answervalue_key from ans_answervalue where answer_key = '3f83256c-7d80-455c-abf1-9ff3148ae6f9') 
select * from prd_dimensionvalue
	where dimensionvalue_key in (select Dimensionvalue_y_key from prd_costtablevalue where costtablevalue_key = '1E8FD62F-E5A6-4C29-870A-EC64BA792386')
	and answervalue_key in (select answervalue_key from ans_answervalue where answer_key = '3f83256c-7d80-455c-abf1-9ff3148ae6f9') 

select dimensionvalue_key from prd_dimensionvalue 
	where dimensionvalue_key in (select Dimensionvalue_x_key from prd_costtablevalue where costtablevalue_key = '1E8FD62F-E5A6-4C29-870A-EC64BA792386')
	or dimensionvalue_key in (select Dimensionvalue_y_key from prd_costtablevalue where costtablevalue_key = '1E8FD62F-E5A6-4C29-870A-EC64BA792386')
	and answervalue_key in (select answervalue_key from ans_answervalue where answer_key = '3f83256c-7d80-455c-abf1-9ff3148ae6f9') 
