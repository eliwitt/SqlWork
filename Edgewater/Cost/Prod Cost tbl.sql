-- using the prod key found all of the cost tables
-- used by this prod
--
-- bcbst high deduct D955E69C-4206-40CE-9972-AA74BBF3A6EA
-- vgtl 93c4c978-e053-4e22-b136-44ab72a51eb1
-- BCBST Group Short Term Disability f027810e-ca6d-4e80-9ef8-500904183cd5
-- BCBST Dental e5c915bd-e109-4ff0-8e04-95ea7e23bbe7
-- Critical Illness-Missouri 8112428f-036b-4d77-bfaa-498cbeb5c22b
-- Universal Life-VA 6fc67529-f59f-478d-9bcd-e9c1965836c9
-- Dependent Care (note 0) a7c062a4-2aa7-41f2-92e6-9f1cb9faa07f
-- VIP_VA e283308b-d829-4d90-b502-a0f0d6f49ddb
-- VIP_GI 6ec37f1a-1f46-41b5-aa29-c8f0f47b2187
-- VIP_OK 5ce46b26-7bcc-444c-a578-abf289257cb3
-- VIP2_GI 8091afbc-3e89-40bc-bd4e-d50bd4392d34
--
select prod.product_nm, cost.costtable_nm, 
(select distinct count(*)
from prd_costtablevalue
where costtable_key = cost.costtable_key
group by dimensionvalue_x_key) as X, 
(select distinct count(*)
from prd_costtablevalue
where costtable_key = cost.costtable_key
group by dimensionvalue_y_key) as Y,
cost.costtable_key
from prd_product prod
	inner join prd_costtableset cset
		on prod.product_key = cset.product_key
	inner join prd_costtable cost
		on cset.costtableset_key = cost.costtableset_key
where prod.product_key = '{8091afbc-3e89-40bc-bd4e-d50bd4392d34}'