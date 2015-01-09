--select * from dt.T1Code
--select * from dt.T2Code
declare @t1id int, 
	@t1codename nvarchar(255), 
	@t2id int, 
	@t2codename nvarchar(255), 
	@t3codename nvarchar(255),
	@Plant int, 
	@errt1id int, @errt2id int
	
select @Plant=pnid from team.wAPlants where PNName = 'Assembly'
-- declare the cursor
declare err1cursor cursor local
for select t1id, t1codename from dt.T1Code
-- open it
open err1cursor
-- fetch a row
fetch next from err1cursor into @t1id, @t1codename
-- loop until there are no more
while(@@FETCH_STATUS = 0)
begin
	-- insert into wacom.t1errors
	insert into wACom.T1Errors values (@Plant, @t1codename, 0)
	-- get the id of the row just inserted
	select @errt1id=@@IDENTITY
	-- get the @@identy of the row inserted use it for the level2
	declare err2Cursor cursor local
	for select t2id, t2codename from dt.T2Code where t2t1codelink = @t1id
	open err2Cursor
	fetch next from err2Cursor into @t2id, @t2codename
	while(@@FETCH_STATUS = 0)
	begin
		-- insert into wacom.t2errors
		insert into wACom.T2Errors values (@errt1id, @t2codename, 0)
		-- get the id of the row just inserted
		select @errt2id=@@IDENTITY
		
		declare err3Cursor cursor local
		for select t3codename from dt.T3Code where t2codelink = @t2id
		open err3Cursor
		fetch next from err3Cursor into @t3codename
		while(@@FETCH_STATUS = 0)
		begin
			-- insert into wacom.t3errors
			insert into wACom.T3Errors values (@errt2id, @t3codename, 0)
			
			-- end of table three loop
			fetch next from err3Cursor into @t3codename
		end
		close err3Cursor
		deallocate err3Cursor		
		
		-- end of table two loop
		fetch next from err2Cursor into  @t2id, @t2codename
	end
	close err2Cursor
	deallocate err2Cursor
	
	-- end of t1code table loop
	fetch next from err1cursor into @t1id, @t1codename
end
-- close the cursor
close err1cursor
-- deallocate it
deallocate err1cursor 