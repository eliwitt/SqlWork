declare @myvin as nvarchar(17), 
	@myDate as datetime,
	@mynewvin	nvarchar(10),
		@idfnd		int,
		@debug		int
set @debug = 1
set @idfnd = -1
--  JA3AB36F&6068208 for the ISO file Y060904P.prn
--  mine 5GZCZ534679999999
--set @myvin = '5QZCZ534679999999'
-- Hyun set @myvin = 'KM8SC78D86'
-- Hyun set @myvin = 'KNDMC213G7'
-- 2005 bmw set @myvin = 'WBAFA93885'
-- 2005 bmw set @myvin = '5UXFA13995'
--  set @myvin = 'WDCYR46AA6'
set @myvin = 'JA3AB26F65'
set @myDate = '08/01/2009'
select @idfnd = ID from vinlookup_0510 where vin like @myvin and effective_date < @myDate
if @@Rowcount = 0
	goto FindGen9
goto Leaving
FindGen9:
if @debug = 1 
	select @myvin 
if len(@myvin) < 10
	goto FindGen4
--
-- We could not find the vin using the full ten characters so I try to find it
-- by using the wildcards _ I can found the vins using the ISO input.  Position 9
--
set @mynewvin = substring(@myvin, 1, 8) + '_' + substring(@myvin, 10, 1)
if @debug = 1 
	print @mynewvin + ' ' + cast(@myDate as nvarchar(8))
select @idfnd = ID from vinlookup_0510 where vin like @mynewvin and effective_date < @myDate
if @@Rowcount = 0
	goto FindGen4
goto Leaving
FindGen4:
--
-- We could not find the vin using the full ten char or wild card in pos 9 so I try to find it
-- by using the wildcards _ in position 4 and 9 some of the ISO records come this way.
--
if len(@myvin) < 10 
	begin
		set @mynewvin = substring(@myvin, 1, 3) + '_' + substring(@myvin, 5, len(@myvin)-4)
	end
else
	set @mynewvin = substring(@myvin, 1, 3) + '_' + substring(@myvin, 5, 4) + '_' + substring(@myvin, 10, 1)
if @debug = 1 
	print @mynewvin + ' ' + cast(@myDate as nvarchar(8))
select @idfnd = ID from vinlookup_0510 where vin like @mynewvin and effective_date < @myDate
if @@Rowcount = 0
	goto FindGen5
goto Leaving
FindGen5:
--
-- We could not find the vin using the full ten char or wild card in pos 9 so I try to find it
-- by using the wildcards _ in position 5 and 9 some of the ISO records come this way.
--
if len(@myvin) < 10 
	begin
		set @mynewvin = substring(@myvin, 1, 4) + '_' + substring(@myvin, 6, len(@myvin)-5)
	end
else
	set @mynewvin = substring(@myvin, 1, 4) + '_' + substring(@myvin, 6, 3) + '_' + substring(@myvin, 10, 1)
if @debug = 1 
	print @mynewvin + ' ' + cast(@myDate as nvarchar(8))
select @idfnd = ID from vinlookup_0510 where vin like @mynewvin and effective_date < @myDate
if @@Rowcount = 0
	goto FindGen6
goto Leaving
FindGen6:
--
-- We could not find the vin using the full ten char or wild card in pos 9 so I try to find it
-- by using the wildcards _ in position 6 and 9 some of the ISO records come this way.
--
if len(@myvin) < 10 
	begin
		set @mynewvin = substring(@myvin, 1, 5) + '_' + substring(@myvin, 7, len(@myvin)-6)
	end
else
set @mynewvin = substring(@myvin, 1, 5) + '_' + substring(@myvin, 7, 2) + '_' + substring(@myvin, 10, 1)
if @debug = 1 
	print @mynewvin + ' ' + cast(@myDate as nvarchar(8))
select @idfnd = ID from vinlookup_0510 where vin like @mynewvin and effective_date < @myDate
if @@Rowcount = 0
	goto FindGen7
goto Leaving
FindGen7:
--
-- We could not find the vin using the full ten char or wild card in pos 9 so I try to find it
-- by using the wildcards _ in position 7 and 9 some of the ISO records come this way.
--
if len(@myvin) < 10 
	begin
		set @mynewvin = substring(@myvin, 1, 6) + '_' + substring(@myvin, 8, len(@myvin)-6)
	end
else
set @mynewvin = substring(@myvin, 1, 6) + '_' + substring(@myvin, 8, 1) + '_' + substring(@myvin, 10, 1)
if @debug = 1 
	print @mynewvin + ' ' + cast(@myDate as nvarchar(8))
select @idfnd = ID from vinlookup_0510 where vin like @mynewvin and effective_date < @myDate
if @@Rowcount = 0
	goto FindGen8
goto Leaving
FindGen8:
--
-- We could not find the vin using the full ten char or wild card in pos 9 so I try to find it
-- by using the wildcards _ in position 7 and 9 some of the ISO records come this way.
--
if len(@myvin) < 10 
	begin
		set @mynewvin = substring(@myvin, 1, 7) + '_' + substring(@myvin, 9, len(@myvin)-6)
	end
else
set @mynewvin = substring(@myvin, 1, 7) + '_' + '_' + substring(@myvin, 10, 1)
if @debug = 1 
	print @mynewvin + ' ' + cast(@myDate as nvarchar(8))
select @idfnd = ID from vinlookup_0510 where vin like @mynewvin and effective_date < @myDate
if @@Rowcount = 0
	set @idfnd = -1
Leaving:
--
--  by the time we get here we either have the id or a -1
--
if @debug = 1 
	select @idfnd
select @idfnd