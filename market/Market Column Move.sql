create procedure dbo.edg_sp_MarkColMove(
	@id int)
AS

set nocount on

declare @i int,
	@j int,
	@dt smalldatetime,
	@Select bit,
	@AM nvarchar(10),
	@PM nvarchar(10),
	@Proc_Name char(255),
	@ErrorMsg varchar(255)

-- Remove the temp tables
if exists(select table_name from information_schema.tables
	where table_name = '#DtRges')
	begin
	drop table #DtRges
end
if exists(select table_name from information_schema.tables
	where table_name = '#Daily')
	begin
	drop table #Daily
end
if exists(select table_name from information_schema.tables
	where table_name = '#NtRges')
	begin
	drop table #NtRges
end
if exists(select table_name from information_schema.tables
	where table_name = '#NewDaily')
	begin
	drop table #NewDaily
end
--  DtRges is a one-dimensional array that holds
--  the dates from the marketing record
--
create table #DtRges
(
	idx int not null primary key,
	tMWDt smalldatetime
)
--  Daily info is a two-dimensional array that will hold
--  each weeks daily info and will be used in the shifting
--  of the weeks
create table #Daily
(
	idx1 int not null,
	idx2 int not null,
	tSelect   bit,
	tAM  nvarchar(10),
	tPM  nvarchar(10),
	primary key(idx1, idx2)
)

-- Now we need to load the info from the marketing table
--

set @i = 1
while @i <= 5
begin
	if (@i = 1)
	begin
		select @dt=(select MkWk1 from edg_tbl_market where MarketId = @id)
		if @@rowcount = 0 
			begin
			set @ErrorMsg = 'Error retrieving Market Record for ' + @id
			goto Error_Handler
		end
	end
	if (@i = 2)
	begin
		select @dt=(select MkWk2 from edg_tbl_market where MarketId = 20)
	end
	if (@i = 3)
	begin
		select @dt=(select MkWk3 from edg_tbl_market where MarketId = 20)
	end
	if (@i = 4)
	begin
		select @dt=(select MkWk4 from edg_tbl_market where MarketId = 20)
	end
	if (@i = 5)
	begin
		select @dt=(select MkWk5 from edg_tbl_market where MarketId = 20)
	end	
	insert into #DtRges values(@i, @dt)
	set @i = @i + 1
end

select * from #DtRges

set @i = 1
while @i <= 5
begin
	set @j = 1
	while @j <= 7
	begin
		--   Process the first weeks detailed data
		if (@i = 1)
		begin
			if (@j = 1) 
			begin	
				select @Select=(select MkMon1 from edg_tbl_market where MarketId = 20)
				select @AM=(select MkMonAm1 from edg_tbl_market where MarketId = 20)
				select @PM=(select MkMonPm1 from edg_tbl_market where MarketId = 20)
			end
			if (@j = 2) 
			begin	
				select @Select=(select MkTue1 from edg_tbl_market where MarketId = 20)
				select @AM=(select MkTueAm1 from edg_tbl_market where MarketId = 20)
				select @PM=(select MkTuePm1 from edg_tbl_market where MarketId = 20)
			end
			if (@j = 3) 
			begin	
				select @Select=(select MkWed1 from edg_tbl_market where MarketId = 20)
				select @AM=(select MkWedAm1 from edg_tbl_market where MarketId = 20)
				select @PM=(select MkWedPm1 from edg_tbl_market where MarketId = 20)
			end
			if (@j = 4) 
			begin	
				select @Select=(select MkThu1 from edg_tbl_market where MarketId = 20)
				select @AM=(select MkThuAm1 from edg_tbl_market where MarketId = 20)
				select @PM=(select MkThuPm1 from edg_tbl_market where MarketId = 20)
			end
			if (@j = 5) 
			begin	
				select @Select=(select MkFri1 from edg_tbl_market where MarketId = 20)
				select @AM=(select MkFriAm1 from edg_tbl_market where MarketId = 20)
				select @PM=(select MkFriPm1 from edg_tbl_market where MarketId = 20)
			end
			if (@j = 6) 
			begin	
				select @Select=(select MkSat1 from edg_tbl_market where MarketId = 20)
				select @AM=(select MkSatAm1 from edg_tbl_market where MarketId = 20)
				select @PM=(select MkSatPm1 from edg_tbl_market where MarketId = 20)
			end
			if (@j = 7) 
			begin	
				select @Select=(select MkSun1 from edg_tbl_market where MarketId = 20)
				select @AM=(select MkSunAm1 from edg_tbl_market where MarketId = 20)
				select @PM=(select MkSunPm1 from edg_tbl_market where MarketId = 20)
			end
		end
		--  Retrieve the second weeks data
		if (@i = 2)
		begin
			if (@j = 1) 
			begin	
				select @Select=(select MkMon2 from edg_tbl_market where MarketId = 20)
				select @AM=(select MkMonAm2 from edg_tbl_market where MarketId = 20)
				select @PM=(select MkMonPm2 from edg_tbl_market where MarketId = 20)
			end
			if (@j = 2) 
			begin	
				select @Select=(select MkTue2 from edg_tbl_market where MarketId = 20)
				select @AM=(select MkTueAm2 from edg_tbl_market where MarketId = 20)
				select @PM=(select MkTuePm2 from edg_tbl_market where MarketId = 20)
			end
			if (@j = 3) 
			begin	
				select @Select=(select MkWed2 from edg_tbl_market where MarketId = 20)
				select @AM=(select MkWedAm2 from edg_tbl_market where MarketId = 20)
				select @PM=(select MkWedPm2 from edg_tbl_market where MarketId = 20)
			end
			if (@j = 4) 
			begin	
				select @Select=(select MkThu2 from edg_tbl_market where MarketId = 20)
				select @AM=(select MkThuAm2 from edg_tbl_market where MarketId = 20)
				select @PM=(select MkThuPm2 from edg_tbl_market where MarketId = 20)
			end
			if (@j = 5) 
			begin	
				select @Select=(select MkFri2 from edg_tbl_market where MarketId = 20)
				select @AM=(select MkFriAm2 from edg_tbl_market where MarketId = 20)
				select @PM=(select MkFriPm2 from edg_tbl_market where MarketId = 20)
			end
			if (@j = 6) 
			begin	
				select @Select=(select MkSat2 from edg_tbl_market where MarketId = 20)
				select @AM=(select MkSatAm2 from edg_tbl_market where MarketId = 20)
				select @PM=(select MkSatPm2 from edg_tbl_market where MarketId = 20)
			end
			if (@j = 7) 
			begin	
				select @Select=(select MkSun2 from edg_tbl_market where MarketId = 20)
				select @AM=(select MkSunAm2 from edg_tbl_market where MarketId = 20)
				select @PM=(select MkSunPm2 from edg_tbl_market where MarketId = 20)
			end

		end
		--  Process the third weeks data
		if (@i = 3)
		begin
			if (@j = 1) 
			begin	
				select @Select=(select MkMon3 from edg_tbl_market where MarketId = 20)
				select @AM=(select MkMonAm3 from edg_tbl_market where MarketId = 20)
				select @PM=(select MkMonPm3 from edg_tbl_market where MarketId = 20)
			end
			if (@j = 2) 
			begin	
				select @Select=(select MkTue3 from edg_tbl_market where MarketId = 20)
				select @AM=(select MkTueAm3 from edg_tbl_market where MarketId = 20)
				select @PM=(select MkTuePm3 from edg_tbl_market where MarketId = 20)
			end
			if (@j = 3) 
			begin	
				select @Select=(select MkWed3 from edg_tbl_market where MarketId = 20)
				select @AM=(select MkWedAm3 from edg_tbl_market where MarketId = 20)
				select @PM=(select MkWedPm3 from edg_tbl_market where MarketId = 20)
			end
			if (@j = 4) 
			begin	
				select @Select=(select MkThu3 from edg_tbl_market where MarketId = 20)
				select @AM=(select MkThuAm3 from edg_tbl_market where MarketId = 20)
				select @PM=(select MkThuPm3 from edg_tbl_market where MarketId = 20)
			end
			if (@j = 5) 
			begin	
				select @Select=(select MkFri3 from edg_tbl_market where MarketId = 20)
				select @AM=(select MkFriAm3 from edg_tbl_market where MarketId = 20)
				select @PM=(select MkFriPm3 from edg_tbl_market where MarketId = 20)
			end
			if (@j = 6) 
			begin	
				select @Select=(select MkSat3 from edg_tbl_market where MarketId = 20)
				select @AM=(select MkSatAm3 from edg_tbl_market where MarketId = 20)
				select @PM=(select MkSatPm3 from edg_tbl_market where MarketId = 20)
			end
			if (@j = 7) 
			begin	
				select @Select=(select MkSun3 from edg_tbl_market where MarketId = 20)
				select @AM=(select MkSunAm3 from edg_tbl_market where MarketId = 20)
				select @PM=(select MkSunPm3 from edg_tbl_market where MarketId = 20)
			end

		end
		--  Process the fourth weeks data
		if (@i = 4)
		begin
			if (@j = 1) 
			begin	
				select @Select=(select MkMon4 from edg_tbl_market where MarketId = 20)
				select @AM=(select MkMonAm4 from edg_tbl_market where MarketId = 20)
				select @PM=(select MkMonPm4 from edg_tbl_market where MarketId = 20)
			end
			if (@j = 2) 
			begin	
				select @Select=(select MkTue4 from edg_tbl_market where MarketId = 20)
				select @AM=(select MkTueAm4 from edg_tbl_market where MarketId = 20)
				select @PM=(select MkTuePm4 from edg_tbl_market where MarketId = 20)
			end
			if (@j = 3) 
			begin	
				select @Select=(select MkWed4 from edg_tbl_market where MarketId = 20)
				select @AM=(select MkWedAm4 from edg_tbl_market where MarketId = 20)
				select @PM=(select MkWedPm4 from edg_tbl_market where MarketId = 20)
			end
			if (@j = 4) 
			begin	
				select @Select=(select MkThu4 from edg_tbl_market where MarketId = 20)
				select @AM=(select MkThuAm4 from edg_tbl_market where MarketId = 20)
				select @PM=(select MkThuPm4 from edg_tbl_market where MarketId = 20)
			end
			if (@j = 5) 
			begin	
				select @Select=(select MkFri4 from edg_tbl_market where MarketId = 20)
				select @AM=(select MkFriAm4 from edg_tbl_market where MarketId = 20)
				select @PM=(select MkFriPm4 from edg_tbl_market where MarketId = 20)
			end
			if (@j = 6) 
			begin	
				select @Select=(select MkSat4 from edg_tbl_market where MarketId = 20)
				select @AM=(select MkSatAm4 from edg_tbl_market where MarketId = 20)
				select @PM=(select MkSatPm4 from edg_tbl_market where MarketId = 20)
			end
			if (@j = 7) 
			begin	
				select @Select=(select MkSun4 from edg_tbl_market where MarketId = 20)
				select @AM=(select MkSunAm4 from edg_tbl_market where MarketId = 20)
				select @PM=(select MkSunPm4 from edg_tbl_market where MarketId = 20)
			end

		end
		if (@i = 5)
		begin
			if (@j = 1) 
			begin	
				select @Select=(select MkMon5 from edg_tbl_market where MarketId = 20)
				select @AM=(select MkMonAm5 from edg_tbl_market where MarketId = 20)
				select @PM=(select MkMonPm5 from edg_tbl_market where MarketId = 20)
			end
			if (@j = 2) 
			begin	
				select @Select=(select MkTue5 from edg_tbl_market where MarketId = 20)
				select @AM=(select MkTueAm5 from edg_tbl_market where MarketId = 20)
				select @PM=(select MkTuePm5 from edg_tbl_market where MarketId = 20)
			end
			if (@j = 3) 
			begin	
				select @Select=(select MkWed5 from edg_tbl_market where MarketId = 20)
				select @AM=(select MkWedAm5 from edg_tbl_market where MarketId = 20)
				select @PM=(select MkWedPm5 from edg_tbl_market where MarketId = 20)
			end
			if (@j = 4) 
			begin	
				select @Select=(select MkThu5 from edg_tbl_market where MarketId = 20)
				select @AM=(select MkThuAm5 from edg_tbl_market where MarketId = 20)
				select @PM=(select MkThuPm5 from edg_tbl_market where MarketId = 20)
			end
			if (@j = 5) 
			begin	
				select @Select=(select MkFri5 from edg_tbl_market where MarketId = 20)
				select @AM=(select MkFriAm5 from edg_tbl_market where MarketId = 20)
				select @PM=(select MkFriPm5 from edg_tbl_market where MarketId = 20)
			end
			if (@j = 6) 
			begin	
				select @Select=(select MkSat5 from edg_tbl_market where MarketId = 20)
				select @AM=(select MkSatAm5 from edg_tbl_market where MarketId = 20)
				select @PM=(select MkSatPm5 from edg_tbl_market where MarketId = 20)
			end
			if (@j = 7) 
			begin	
				select @Select=(select MkSun5 from edg_tbl_market where MarketId = 20)
				select @AM=(select MkSunAm5 from edg_tbl_market where MarketId = 20)
				select @PM=(select MkSunPm5 from edg_tbl_market where MarketId = 20)
			end

		end	
		insert into #Daily values(@i, @j, @Select, @AM, @PM)
		set @j = @j + 1
	end
	set @i = @i + 1
end

--  The array are now loaded with the records information
--
set @i = 1
set @j = 1
while @i <= 5
begin
	select * from #DtRges where idx = @i
	set @j = 1
	while @j <= 7
	begin
		select * from #Daily where idx1 = @i and idx2 = @j
		set @j = @j + 1
	end
	set @i = @i + 1
end

--  Now Remove the first weeks data and add a new week at the 
--  end of the array

--  NtRges is a one-dimensional array that holds
--  the dates for the new week
--
create table #NtRges
(
	ndx int not null primary key,
	nMWD smalldatetime
)
--  Daily info is a two-dimensional array that will hold
--  each weeks daily info and will be used in the shifting
--  of the weeks
create table #NewDaily
(
	ndx1 int not null,
	ndx2 int not null,
	nSelect   bit,
	nAM  nvarchar(10),
	nPM  nvarchar(10),
	primary key(ndx1, ndx2)
)
print ' '
print 'Now the column will be moved'
print ' '
--  Using the arrays from above we will drop the first row
--
declare @k int, @l int
set @k = 1
--set @l = 1
set @i = 2
--set @j = 2
while @i <= 5
begin
	select @dt=tMWDt from #DtRges where idx = @i
	insert into #NtRges values(@k, @dt)
	set @j = 1
	set @l = 1
	while @j <= 7
	begin
		select @Select=tSelect, @AM=tAM, @PM=tPM from #Daily where idx1 = @i and idx2 = @j
		insert into #NewDaily values(@k, @l, @Select, @AM, @PM)
		set @j = @j + 1
		set @l = @l + 1
	end
	set @i = @i + 1
	set @k = @k + 1
end

--  Now print the new array
--
set @i = 1
set @j = 1
while @i <= 4
begin
	select * from #NtRges where ndx = @i
	set @j = 1
	while @j <= 7
	begin
		select * from #NewDaily where ndx1 = @i and ndx2 = @j
		set @j = @j + 1
	end
	set @i = @i + 1
end
-- bottom of the script

Error_Handler:
IF @ErrorMsg IS NOT NULL
     BEGIN
	
	SELECT @Proc_Name = 'edg_sp_MarkColMove' 

	RAISERROR(@ErrorMsg, 11, 1) with log

     END

RETURN 21
