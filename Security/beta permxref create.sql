declare @curPerm int
create table edg_tbl_perm_xref(lev int, pdef int)
declare Permisions scroll cursor for
select [id] from edg_tbl_permision_definitions
open Permisions
fetch first from Permisions into @curPerm
while @@fetch_status = 0
	begin
	insert into edg_tbl_perm_xref values(0,@curPerm)
	insert into edg_tbl_perm_xref values(1,@curPerm)
--	insert into edg_tbl_perm_xref values(2,@curPerm)
	fetch next from Permisions into @curPerm
end

close Permisions
deallocate Permisions
select * from edg_tbl_perm_xref
--drop table edg_tbl_perm_xref