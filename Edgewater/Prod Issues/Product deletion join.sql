--  this select identifies completed trans that have no emp which
--  causes an error when we attempt to delete the product.

select comp.completedtransaction_key, comp.producttransaction_key,
comp.employeeproductenrollment_key,
enroll.employeeproductenrollment_key, comp.transaction_dttm
from emp_completedtransaction comp
left join emp_employeeproductenrollment enroll
	on comp.employeeproductenrollment_key = enroll.employeeproductenrollment_key
where enroll.employeeproductenrollment_key is null