-- US   verify the menu order before running the inserts
select *
from
dbo.edg_tbl_Permision_Definitions
order by Menu_Order

--  Modify the menu order field
--  to allow the following item(s) to show up in the
--  order on the User rights screen.

insert edg_tbl_Permision_Definitions (Tag,Description,Active,Subscriber_Type,Menu_Type,Menu_Order)
	values('edgROCodes2','RO Codes',1,1,2,50)

insert edg_tbl_Permision_Definitions (Tag,Description,Active,Subscriber_Type,Menu_Type,Menu_Order)
	values('edgInvCodes2','Invoice Codes',1,1,2,52)

insert edg_tbl_Permision_Definitions (Tag,Description,Active,Subscriber_Type,Menu_Type,Menu_Order)
	values('edgQBSetup','QuickBooks Setup',1,1,2,635)

insert edg_tbl_Permision_Definitions (Tag,Description,Active,Subscriber_Type,Menu_Type,Menu_Order)
	values('edgAContact2','Agent Contact',1,1,2,23)

update edg_tbl_permision_definitions set tag='ediPendA2' where id = 86

-- Canadian live

select * from edg_tbl_permision_definitions order by menu_order

insert edg_tbl_Permision_Definitions (id,Tag,Description,Active,Subscriber_Type,Menu_Type,Menu_Order)
	values(175,'edgConvertToRO2','Convert Quote to RO',1,1,2,9)