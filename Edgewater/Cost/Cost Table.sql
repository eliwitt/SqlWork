-- Find the rows and columns for the cost table
--  BCBST_ PPO
--  cd1698d0-1e73-4542-9a11-42da824efc96
--  1-8-13, Prior Credit
--  f1a1a359-d852-47db-8af3-c4efd01e29e6
--  CancerCare Elite
--  99d40791-6f68-4bd1-814f-c18b37b53ad6
--  BCBST_High Deductible -- D955E69C-4206-40CE-9972-AA74BBF3A6EA
--  e8357a6e-a75f-43c8-af88-aa6f6ff7ac6c
--
select CostTable_nm, 
(select distinct count(*)
from prd_costtablevalue
where costtable_key = '{f1a1a359-d852-47db-8af3-c4efd01e29e6}'
group by dimensionvalue_x_key) as X, 
(select distinct count(*)
from prd_costtablevalue
where costtable_key = '{f1a1a359-d852-47db-8af3-c4efd01e29e6}'
group by dimensionvalue_y_key) as Y
from prd_costtable
where costtable_key = '{f1a1a359-d852-47db-8af3-c4efd01e29e6}'
