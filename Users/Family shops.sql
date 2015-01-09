--select sub.subscriberid, case when fam.childshopid is null then 'No' else 'Yes' end as Family from edg_tbl_subscribers sub
--	left outer join edg_tbl_parentshoprelations fam on sub.subscriberid = fam.childshopid
--
--  this script will print all of the canadian users
--
print 'This list contains all subscribers and their users for ' + @@SERVERNAME
print ' '
declare @subid int,
	@type int,
	@Co nvarchar(50),
	@Fam nvarchar(5),
	@uid int,
	@Name nvarchar(20),
	@Pass nvarchar(20)
--  Cursor for all of the subscribers
declare SubCursor scroll cursor for
select sub.subscriberid, sub.SubscriberType, sub.Company,
case when fam.childshopid is null then 'No' else convert(char(5),fam.Parentshopid) end as Family 
from edg_tbl_subscribers sub
	left outer join edg_tbl_parentshoprelations fam 
on sub.subscriberid = fam.childshopid
--
open SubCursor
fetch first from SubCursor into @subid, @type, @Co, @Fam
while @@fetch_status = 0
	begin
	print convert(char(5),@subid) + 
		' (' + 
		case @type 
			when 1 then 'Shop' 
			when 2 then 'Ins' 
			when 3 then 'Agency' 
			when 4 then 'Parent'
		end + 
		') ' + 
		@Co +
		' [In a family? ' + @Fam + ']'
	-- Cursor for all of the users
	declare UsrCursor scroll cursor for
	select UserId, UserName, [Password]
	from 
	edg_tbl_users
	where subscriberid = @subid
	open UsrCursor
	print '-------------------------------------------------------------------'
	print ' '
	fetch first from UsrCursor into @uid, @Name, @Pass
	while @@fetch_status = 0
		begin
		print convert(char(5), @uid) + ' ' + rtrim(@Name) + ' '+ @Pass
		fetch next from UsrCursor into @uid, @Name, @Pass
	end
	close UsrCursor
	deallocate UsrCursor
	print ' '
	print ' '
	fetch next from SubCursor into @subid, @type, @Co, @Fam
end
close SubCursor
deallocate SubCursor