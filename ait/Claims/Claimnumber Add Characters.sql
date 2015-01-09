-- find all of the dup rows
--
select max(id) id, policynumber, cast(convert(nvarchar(8), dateofloss, 112) as datetime) from clm_claimmaster
group by policynumber, dateofloss
having count(*) > 1
--
-- find dup for a specific policy number
--

select max(id), policynumber from clm_claimmaster
where policynumber = '2003-2' and 
cast(convert(nvarchar(8), dateofloss, 112) as datetime) = '2010-05-22'
group by policynumber, datepart(dayofyear, dateofloss)
having count(*) > 1

select count(id) from clm_claimmaster
			where policynumber = '2003-2' and 
			cast(convert(nvarchar(8), dateofloss, 112) as datetime) = '2010-05-22'
			group by policynumber, datepart(dayofyear, dateofloss)
--
-- look at a specific row
--
select id, policynumber, convert(nvarchar(8), dateofloss, 112), claimnumber from clm_claimmaster where policynumber = '2003-2' and 
cast(convert(nvarchar(8), dateofloss, 112) as datetime) = '2010-05-27'
--exec sp_fileclaim '2003-2', 1550, 1234, '2010-05-22 03:03:00', 1, 0, null, null, null, null, null
--exec sp_updateclaimmaster 310, '10416', null
--
-- update 99s claimnumber to B
-- 
--update clm_claimmaster set claimnumber = '2003-2-05-26-2010' where id = 102
declare @policy varchar(8), @dol datetime, @maxId int, @newClaimnumber varchar(18), 
	@maxClaimnumber varchar(30), @nuchar int, @rowct int, @theChar varchar(1),
	@newChar varChar(1)
set @policy = '2003-2'
set @dol = '2010-05-27 05:05:00'
select max(id) id from clm_claimmaster
where policynumber = '2003-2' and 
cast(convert(nvarchar(8), dateofloss, 112) as datetime) = cast(convert(nvarchar(8), @dol, 112) as datetime)


--
--  I need to count the rows and use that to set claimnumber
--
select @rowct = count(id) from clm_claimmaster
			where policynumber = @policy and 
			cast(convert(nvarchar(8), dateofloss, 112) as datetime) = cast(convert(nvarchar(8), @DOL, 112) as datetime)
			group by policynumber, datepart(dayofyear, dateofloss)
select @rowct
--  find the dups
if (@rowct is null)
begin
	set @newClaimnumber = convert(nvarchar(8),@policy) + '-' + convert(varchar(10), @DOL, 110)
end
else
begin
	if (@rowct = 1)
	begin
		set @newClaimnumber = convert(nvarchar(8),@policy) + '-' + convert(varchar(10), @DOL, 110) + 'B'
	end
	else
	begin
		select @maxId=max(id) from clm_claimmaster
				where policynumber = @Policy and 
				cast(convert(nvarchar(8), dateofloss, 112) as datetime) = cast(convert(nvarchar(8), @DOL, 112) as datetime)
		select @maxId
		select @maxClaimnumber=claimnumber from clm_claimmaster where id = @maxId
		--
		-- the claimnumber is the policy number + dol so we should be able to get the last charactor
		--
		if len(@maxClaimnumber) = len(@Policy) + 11 set @theChar = 'A' 
		else
		select @theChar = substring(@maxClaimnumber, len(@Policy) + 12, 1)
		if @theChar = 'Z' set @newChar = ''
		else begin
			set @newChar = Char(ascii(@theChar) + 1)
		end
		set @newClaimnumber = convert(nvarchar(8),@policy) + '-' + convert(varchar(10), @DOL, 110) + @newChar
	end
end
select @newClaimnumber