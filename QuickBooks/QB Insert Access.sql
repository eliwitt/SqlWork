--
--  This script is used to set the default values for the qb
--  access permissions for every user in the database that it is 
--  run in.
--
--  script variables
declare @userid int,
	@permid int,
	@rights int,
	@newid int,
	@cnt int,
	@p int,
	@l int,
	@olduser int
set @cnt = 0
set @p = 1
-- table and cursors
--
-- if the table exists then drop it
if exists(select table_name from information_schema.tables
	where table_name = '#Permid')
	begin
	drop table #Permid
end
--  the table that will hold the permission description ids
--  used to set each users new access
create table #Permid
(
	idx int not null primary key,
	permid int
)
--  define the cursor
declare idcursor cursor for
select id
from
edg_tbl_Permision_definitions
where Tag in ('edgQBInvoice')
-- now loop thru the result set and insert into the temp table
open idcursor

fetch next from idcursor
into @permid

while (@@FETCH_STATUS = 0)
begin
	print 'id ' + convert(char(4), @permid)
	insert into #Permid values(@p, @permid)
	set @p = @p + 1
	fetch next from idcursor
		into @permid
end
print 'There are ' + convert(char(4), @p)
close idcursor
deallocate idcursor

-- Now process each user in the permission table
declare user_perm cursor for
select [User_ID], Permission_ID, Rights
from
edg_tbl_Permisions order by [User_ID], Permission_ID

open user_perm

fetch next from user_perm
into @userid, @permid, @rights
set @olduser = @userid

while (@@FETCH_STATUS = 0)
begin
	if @userid <> @olduser
	   begin
		set @l = 1
		top_of_loop:
		  begin
			select @newid = permid from #Permid where idx = @l
			insert into edg_tbl_Permisions values(@olduser,@newid,0)
			set @l = @l + 1
		  end
		if not (@l >= @p)
			goto top_of_loop
		set @cnt = @cnt + 1
		set @olduser = @userid
	end
	fetch next from user_perm
		into @userid, @permid, @rights
end
print convert(nvarchar(4),@olduser)
set @l = 1
top_of_last:
  begin
	select @newid = permid from #Permid where idx = @l
	insert into edg_tbl_Permisions values(@olduser,@newid,0)
	set @l = @l + 1
  end
if not (@l >= @p)
	goto top_of_last
print ' '
print ' Total ' + convert(nvarchar(4),@cnt)
close user_perm
deallocate user_perm


