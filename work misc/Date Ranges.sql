declare @wkDay int, @nbDays int
declare @lastMon datetime, @nextMon datetime
select @lastMon = '2004-04-24'
select @wkDay = datepart(weekday,getdate())
select @nbDays = (7 - @wkDay + 2)
--select ' From ', @wkDay, ' there are ', @nextMon, ' days to nextMon'
select @nextMon = dateadd(day,@nbDays,getdate())
--select dateadd(day,@nbDays,getdate()), ' Next Monday '
select datediff(week,@lastMon,Getdate()), 'Currently'
select datediff(week,@lastMon,@nextMon), 'Last week'
select dateadd(day,7,'2004-05-17')