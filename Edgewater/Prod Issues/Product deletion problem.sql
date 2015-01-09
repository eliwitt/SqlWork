--  employee record that was not deleted and the caused the product not to delete 
--   Davis Vision 2
Select * 
from PRD_Product
where product_nm like 'Davis Vision%'
--
--
select * from 
emp_completedtransaction
where producttransaction_key in (select producttransaction_key from prd_producttransaction
where product_key = '{6CA92AA9-D5E1-411E-9340-0DDE27A661E9}')

select * from emp_employeeproductenrollment
where employeeproductenrollment_key = '{56C1E0F7-99A2-44C0-99DE-E2CF479C7E5C}'