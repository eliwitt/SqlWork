-- verify the menu order before running the inserts
select *
from
dbo.edg_tbl_Permision_Definitions
order by Menu_Order

--  Modify the menu order field
--  to allow the following item(s) to show up in the
--  order on the User rights screen.

insert edg_tbl_Permision_Definitions (Tag,Description,Active,Subscriber_Type,Menu_Type,Menu_Order)
	values('edgQBInvoice','QuickBooks',1,1,2,43)
