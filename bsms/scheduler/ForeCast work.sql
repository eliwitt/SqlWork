--
-- this script will gather the currently open WO in the range
-- and the schedule ones to provide data for a report or other process.
--
-- ------------------------------------------------------
-- variables for this script
-- ------------------------------------------------------
declare @wasteoftime nvarchar(max), @debug int = 3, @theEndDate datetime,
	@theStartDate datetime, @dayofweek int, @theDuedate datetime, @thePlant int
-- --------------------- set the variables ---------------------
set @theStartDate = Convert(Date,DateAdd(Day, 7,'07/25/2013'))
set @theEndDate = Convert(Date,DateAdd(Day, 7, @theStartDate))
set @theDuedate = Convert(Date,DateAdd(Day, 7, @theStartDate))
--set @theDuedate = Convert(Date,DateAdd(Day, 7, @theStartDate))
set @dayofweek = Datepart(WEEKDAY, @theStartDate)
-- ------------- plant ---------------
set @thePlant = 4  -- infrastructure

-- --------------------------------------
-- display the date and blockout info
-- -------------------------------------
if (@debug > 2)
begin
	select @thePlant 'Plant', @theStartDate 'Start of Range', @theEndDate 'End of Range', @dayofweek 'Day of Week'
	select * from Scheduler.Lockout where schLockPlant = @thePlant and schLockDate between @theStartDate and @theEndDate
end
-- ------------------------------------------------------
-- scheduled WO
-- ------------------------------------------------------
--
-- Build the schtable that is used to create our WOs within the given range.
--
IF object_id('TempDB..#foreData') IS NOT NULL
 DROP TABLE #foreData;

create table #foreData (schKey int, schPlant int, schLType int, schDescrip nvarchar(255), schAssignedTo int, schSinceLastScheduledInd smallint, schLastScheduledFreq int, 
	schLastScheduledDT datetime, schSinceLastCompleteInd smallint, schLastCompletedFreq int, 
	schLastCompletedT datetime, schEarly int )
insert into #foreData
	select schkey,schPlant,schLockType, schDescription,schAssignedTo,schSinceLastScheduledInd, schLastScheduledFreq, schLastScheduledDT,
	schSinceLastCompleteInd, schLastCompletedFreq, schLastCompletedT, schEarlyDays
	from Scheduler.ChampsSchedules
	where schPlant = @thePlant and schActive = 1 and 
	((schSinceLastScheduledInd = 1 and ((schLastScheduledDT + isnull(schLastScheduledFreq, 0)) - isnull(schEarlyDays,0)) between @theStartDate and @theEndDate) or
	(schSinceLastCompleteInd = 1 and ((schLastCompletedT + isnull(schLastCompletedFreq, 0)) - isnull(schEarlyDays, 0)) between @theStartDate and @theEndDate)) and	
	((@dayofweek = 1 and schValidSun = 1) or (@dayofweek = 2 and schValidMon = 1) or (@dayofweek = 3 and schValidTue = 1) or
	(@dayofweek = 4 and schValidWed = 1) or (@dayofweek = 5 and schValidThru = 1) or (@dayofweek = 6 and schValidFri = 1) or
	(@dayofweek = 7 and schValidSat = 1))
-- ----------------------------------------------------------------------
--
-- Collect the block out dates
-- match these dates against the foreData sch with the same date.
-- if there is a match then 
--		if the locktype 0 
--			bump the sch date by 1 day
--		else 
--			bump the sch to the next cycled date
--		has the above action caused the sch to go out of the range
--			if yes then remove the sch from the foreDat
--
IF object_id('TempDB..#blockData') IS NOT NULL
 DROP TABLE #blockData;
 
 insert into #blockData 
-- ----------------------  test review the results so far  --------------------------------------
select * from #foreData	
declare @blockdays int
select @blockdays = COUNT(*) from Scheduler.Lockout where schLockPlant = @thePlant and schLockDate between @theStartDate and @theEndDate
update #foreData set schLastScheduledDT = DateAdd(Day, @blockdays, schLastScheduledDT)
from #foreData
	join Scheduler.Lockout BlockDts on #foreData.schPlant = BlockDts.schLockPlant and
		schLockDate between @theStartDate and @theEndDate
	where schLType = 0
	
select * from #foreData		
--select DISID, DISSchID, DISTitle, DISEquip, DISLineNumber, DISIntHold, DISType, DISDownResponsible, 
--	DISOpenDate, DISDueDate, DISTPMNumber, DISWorkRequired, DISRequestor, DISManHours, DISNumberAss 
--from wo.WorkOrderMain 
--where ((DISCloseDate is null) and (DISDueDate between @theStartDate and @theE ndDate))
--
select * from Scheduler.Lockout
select * from Scheduler.ChampsSchedules where schPlant = 4
