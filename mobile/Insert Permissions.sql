-- verify the menu order before running the inserts
select *
from
dbo.edg_tbl_Permision_Definitions
order by Menu_Order

--  Modify the menu order 50, 51, 52, and 53
--  to allow the following four items to show up at the
--  of the generated list on the User rights screen.

insert edg_tbl_Permision_Definitions (Tag,Description,Active,Subscriber_Type,Menu_Type,Menu_Order)
	values('edgMain1','Mobile Security',1,1,1,50)
insert edg_tbl_Permision_Definitions (Tag,Description,Active,Subscriber_Type,Menu_Type,Menu_Order)
	values('edgCreateRO','Create RO',1,1,2,51)
insert edg_tbl_Permision_Definitions (Tag,Description,Active,Subscriber_Type,Menu_Type,Menu_Order)
	values('mobileListRO','Lookup RO',1,1,2,52)
insert edg_tbl_Permision_Definitions (Tag,Description,Active,Subscriber_Type,Menu_Type,Menu_Order)
	values('edgMobileFMake','NAGS Lookup',1,1,2,53)