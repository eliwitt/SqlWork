--  Locate emps for the given ogran key
select * from emp_employee where group_key = 'BFDA5A01-D230-491D-B16B-BEE54968A39B'
--  Locate emp with a last nm of ????
select * from emp_person where last_nm like 'McCrary'
select * from emp_employee where person_key = '{76AB91F0-E8DB-4E99-B58C-E5183482B0D5}'