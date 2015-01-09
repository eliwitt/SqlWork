declare @curUser int

declare Permisions scroll cursor for
select distinct user_id from edg_tbl_permisions
open Permisions
fetch first from Permisions into @curUser
while @@fetch_status = 0
	begin
--	print convert(char(5),@curUser) + ' will be set '
	insert into edg_tbl_permisions values(@curUser,175,1)
	fetch next from Permisions into @curUser
end

close Permisions
deallocate Permisions

insert into edg_tbl_perm_xref values(0,175)
insert into edg_tbl_perm_xref values(1,175)