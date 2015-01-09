-- looking for the question that was asked of the emp
-- this key came from the employeeproductdata table

-- because the answer_identifier_nm has the "." in the value and
-- the time_period_flg = "Y" and we have a timeperiod_key this answer/question
-- is treated special in the code which can be misleading
select * from ans_answer
where answer_key = '{48765C4E-3078-4844-BD47-D34D9D774ED8}'

select * from ans_answer
where answer_key = '{FB36A2A0-D644-48F7-A551-01CD0D659A38}'

select * from ans_answer
where answer_key = '{60873CD3-C1B3-4ABC-ADAA-7795B43DEF9D}'