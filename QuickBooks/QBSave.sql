declare @subid int
set @subid = 3430

select * from  edg_tbl_users
where subscriberid = @subid

select * from edg_tbl_Permision_definitions
order by menu_order

--  reset all accounting rights to off for all store users
--
update edg_tbl_Permisions set rights=0 
where [User_id] in (select UserId from  edg_tbl_users where subscriberid = @subid) and
Permission_ID in ( select id from edg_tbl_Permision_definitions where Tag in ('edgPostPay2','edgAdjustInv2','edgAgeReport2','edgStatPrint2','edgSalesRpt2','edgPayRpt2'))

--  if the QB entry is already in the database then update
--  else insert one for all store users
--
if exists (select * from edg_tbl_Permisions
	where [User_id] in (select UserId from  edg_tbl_users where subscriberid = @subid) and
	Permission_ID in ( select id from edg_tbl_Permision_definitions where Tag = 'edgQBInvoice')
)
begin
	--  update the existing entries for all store users
	--
	update edg_tbl_Permisions set rights=1
	where [User_id] in (select UserId from  edg_tbl_users where subscriberid = @subid) and
	Permission_ID in ( select id from edg_tbl_Permision_definitions where Tag = 'edgQBInvoice')
end
else
begin
	-- insert an entry for all store users
	--
	print 'Did not'
end

