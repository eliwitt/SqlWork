exec edg_sp_QBSave 3436,0,'c:\\data\\sql\\QuickBooks','Asset Test','COGS','Parts test','Labor test'
select * from edg_tbl_subscribers
select * from edg_tbl_Permisions
	where [User_id] in (select UserId from  edg_tbl_users where subscriberid = 3436) and
	Permission_ID in ( select id from edg_tbl_Permision_definitions where Tag = 'edgQBInvoice')