-- the group override text
select 'From the Grp Cost area' source,displayoverride_txt from grp_groupproductdimensionvalue 
where dimensionvalue_key = (
select distinct dival.dimensionvalue_key from prd_dimensionvalue dival,
	ans_answervalue ans
where dimensionvalue_key = (select dimensionvalue_x_key from prd_costtablevalue where costtablevalue_key = '1E8FD62F-E5A6-4C29-870A-EC64BA792386')
or dimensionvalue_key = (select dimensionvalue_y_key from prd_costtablevalue where costtablevalue_key = '1E8FD62F-E5A6-4C29-870A-EC64BA792386')
 and dival.answervalue_key = ans.answervalue_key and ans.answer_key = '3F83256C-7D80-455C-ABF1-9FF3148AE6F9'
) and displayoverride_txt is not null

--  the product override text
select distinct 'From the Prd Cost area' source, dival.override_txt from prd_dimensionvalue dival,
	ans_answervalue ans
where dimensionvalue_key = (select dimensionvalue_x_key from prd_costtablevalue where costtablevalue_key = '1E8FD62F-E5A6-4C29-870A-EC64BA792386')
or dimensionvalue_key = (select dimensionvalue_y_key from prd_costtablevalue where costtablevalue_key = '1E8FD62F-E5A6-4C29-870A-EC64BA792386')
 and dival.answervalue_key = '3F83256C-7D80-455C-ABF1-9FF3148AE6F9'

-- the coverage text
select 'From the Coverage area' source,coverage_nm from msc_coverage cover, emp_employeeproduct emp
where emp.employee_key = 'C4C1872A-3EAB-41E6-B2E7-007CA1FE95F0' 
and emp.coverage_key = cover.coverage_key