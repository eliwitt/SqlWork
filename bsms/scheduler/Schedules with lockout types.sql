declare @wasteoftime nvarchar(max), @debug int = 3, @projDate datetime,
	@theprocessdate datetime, @theDuedate datetime, @dayofweek int
set @theprocessdate = Convert(Date,DateAdd(Day, 7,'07/21/2013'))
--set @theprocessdate = Convert(Date,DateAdd(Day, 7, GETDATE()))
set @projDate = Convert(Date,DateAdd(Day, 1, @theprocessdate))
set @theDuedate = Convert(Date,DateAdd(Day, 7, @theprocessdate))
set @dayofweek = Datepart(WEEKDAY, @theprocessdate)
--
-- seven days from now
--
if (@debug > 2)
begin
	select @theprocessdate procDT, @projDate projDT,  @theDuedate DueDT, @dayofweek
	
	select * from Scheduler.Lockout where schLockDate = @theprocessdate
end
--
-- Build the schtable that is used to create our WOs
--
IF object_id('TempDB..#schData') IS NOT NULL
 DROP TABLE #schData;

create table #schData (schKey int, schDescrip nvarchar(255), schAssignedTo int, schSinceLastScheduledInd smallint, schLastScheduledFreq int, 
	schLastScheduledDT datetime, schSinceLastCompleteInd smallint, schLastCompletedFreq int, schLastCompletedT datetime )
insert into #schData
	select schkey,schDescription,schAssignedTo,schSinceLastScheduledInd, schLastScheduledFreq, schLastScheduledDT,
	schSinceLastCompleteInd, schLastCompletedFreq, schLastCompletedT
	from Scheduler.ChampsSchedules
	where schActive = 1 and 
	(schSinceLastScheduledInd = 1 and (schLastScheduledFreq > 0 and DateAdd(Day, schLastScheduledFreq, schLastScheduledDT) < @projDate) or
	(schSinceLastCompleteInd = 1 and schLastCompletedFreq > 0 and DateAdd(Day, schLastCompletedFreq, schLastCompletedT) < @projDate)) and
	((@dayofweek = 1 and schValidSun = 1) or (@dayofweek = 2 and schValidMon = 1) or (@dayofweek = 3 and schValidTue = 1) or
	(@dayofweek = 4 and schValidWed = 1) or (@dayofweek = 5 and schValidThru = 1) or (@dayofweek = 6 and schValidFri = 1) or
	(@dayofweek = 7 and schValidSat = 1))

select * from #schData

update Scheduler.ChampsSchedules set schLastScheduledDT = @theprocessdate
	where schlocktype = 1 and schKey in (select schkey from #schData where schPlant in (select schLockPlant from Scheduler.Lockout where schLockDate = @theprocessdate))

select * from Scheduler.ChampsSchedules
--drop table #schData