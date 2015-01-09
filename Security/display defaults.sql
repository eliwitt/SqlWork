declare @lev int
set @lev = 3
print 
	case @lev 
	when 0 then 'Silver' 
	when 1 then  'Gold'
	when 2 then 'Platinum'
	when 3 then 'Lite'
	end
	+ ' users have the following: '
print ' '
select [id], tag, [Description], Active, Subscriber_Type from edg_tbl_permision_definitions def,
	edg_tbl_perm_xref xref
where xref.pdef = def.[id] and xref.lev = @lev
select count(*) as nu_rows from edg_tbl_permision_definitions def,
	edg_tbl_perm_xref xref
where xref.pdef = def.[id] and xref.lev = @lev