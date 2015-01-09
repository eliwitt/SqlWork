--  might be able to use the waiverreason to determine when a product is waived
select * from emp_employeeproduct 
where employeeproductstatus_vv = 'WAIVED' and waiverreason_vv is not null