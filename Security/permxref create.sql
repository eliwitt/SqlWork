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
--  the following permisions are for lite users
--
--  here are the permisions for admin
insert into edg_tbl_perm_xref values(3,164)
insert into edg_tbl_perm_xref values(3,165)
--  here are the permisions for accounting  
insert into edg_tbl_perm_xref values(3,156)
insert into edg_tbl_perm_xref values(3,157)
insert into edg_tbl_perm_xref values(3,158)
insert into edg_tbl_perm_xref values(3,159)
insert into edg_tbl_perm_xref values(3,160)
insert into edg_tbl_perm_xref values(3,161)

close Permisions
deallocate Permisions
select * from edg_tbl_perm_xref
--drop table edg_tbl_perm_xref