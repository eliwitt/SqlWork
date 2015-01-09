--
-- script build the preliminary WO results
--
-- things to pass in 
--
--	theprocessdate the date to create the WO
--  projdate the date to create the WO for plus one
--  debug to track a problem
--		0 = off
--		1 = general
--		2 = in sections
--		3 = detail
--
--	due date mod ????????????????
--
declare @wasteoftime nvarchar(max), @debug int = 0, @projDate datetime,
	@theprocessdate datetime, @theDuedate datetime
set @debug = 0
set @projDate = Convert(Date,DateAdd(Day, 8, GETDATE()))
set @theprocessdate = Convert(Date,DateAdd(Day, 7, GETDATE()))
set @theDuedate = Convert(Date,DateAdd(Day, 7, @theprocessdate))
--
-- determine if we have a lock out date
--
if exists(select schLockID from Scheduler.Lockout where schLockDate = @theprocessdate)
begin
	if (@debug > 0)
		select 'Lockout date found no processing'
	-- using the new log table enter that we will not create WOs for X date
	set @wasteoftime = 'Lockout date found no WOs created for ' + cast(@theprocessdate as nvarchar(20))
	exec wACom.LogIt 99999, 'Scheduler Script', 'None', @wasteoftime
	return
end
--
-- seven days from now
--
if (@debug > 2)
begin
	select @theprocessdate, @projDate
	
	select * from Scheduler.Lockout where schLockDate = @theprocessdate
	
	select top(100) DateAdd(Day, schLastScheduledFreq, schLastScheduledDT) WODate, @projDate TargetDate, 
	schKey, schName, schLastScheduledDT, schLastScheduledFreq, schPMGrpKey, schPMName, schProcGrpKey, schProcName
		from Scheduler.ChampsSchedules sch
			join Scheduler.ChampsSchPMGroups schPMs on sch.schKey = schPMs.ChampsSchedule_schKey
			join Scheduler.ChampsSchProcGroups schProcs on sch.schKey = schProcs.ChampsSchedule_schKey
		where schActive = 1 and schSinceLastScheduledInd = 1 and schLastScheduledFreq > 0
		and DateAdd(Day, schLastScheduledFreq, schLastScheduledDT) < @projDate
end
--============================ 2 dos  ===========================================
--  collect the schedule data from
--		ProcGroup table--Scheduler.ChampsSchPMGroups  procedure data
--		EquipGroup table--Scheduler.ChampsSchProcGroups equipment data
--
--  insert the wos for lastscheduled with an open date of projDate and a due date of + 7
--
--  set the lastscheduled date to current day
--
--===============================================================================
--
-- using the last date scheduled method insert the new WOs and update the sch date
--
--
-- gather the schedule data for procedures used to create the WOs
--
IF object_id('TempDB..#schPMData') IS NOT NULL
 DROP TABLE #schPMData;

create table #schPMData (schKey int, schPMProcID int, schPMEst decimal(18,0), schPMTitle nvarchar(255), schWorkReq nvarchar(max) )
--
--builds the list of PMs for the WOs
--
insert into #schPMData 
	select sch.schkey, PMitem.TPMProcID, PMitem.TPMProcEstMin, PMitem.TPMProcTitle, 
		PMitem.TPMProcProcedure + wAppTPM.RetrieveProcString(PMitem.TPMProcID) as WorkRequired
	from Scheduler.ChampsSchedules sch
		join Scheduler.ChampsSchPMGroups schPMs on sch.schKey = schPMs.ChampsSchedule_schKey
		join Scheduler.ChampsSchPMGrpHasPMs HasPMs on schPMs.schPMGrpKey = HasPMs.ChampsSchPMGroups_schPMGrpKey
		join TPM.TPMProcdure PMitem on HasPMs.TPMProcdures_TPMProcID = PMitem.TPMProcID
	where schActive = 1 and schSinceLastScheduledInd = 1 and schLastScheduledFreq > 0
		and DateAdd(Day, schLastScheduledFreq, schLastScheduledDT) < @projDate
-- +++++++++++++++++  don't forget to concate the workreq for multiple PMs and sum the est
if (@debug > 2)
	select * from #schPMData
	
--
-- gather the schedule data for the equipment used to create the WOs
--
IF object_id('TempDB..#schProcData') IS NOT NULL
 DROP TABLE #schProcData;

create table #schProcData (schKey int, schProcID int, schProcNu nvarchar(255), schProcarg int, schProcmodel int, schAssignTo int, schProcassignto int )

insert into #schProcData
	select sch.schKey, PROCID, procnumber, PROCARG, PROCMODEL, schAssignedTo, PROCASSIGNTO
	from Scheduler.ChampsSchedules sch
		join Scheduler.ChampsSchProcGroups schProcs on sch.schKey = schProcs.ChampsSchedule_schKey
		join Scheduler.ChampsSchProcGrpHasProcs HasProcs on schProcs.schProcGrpKey = HasProcs.ChampsSchProcGroups_schProcGrpKey
		join EQP.ProcNumbers Procitem on HasProcs.ProcNumbers_PROCID = Procitem.PROCID
	where schActive = 1 and schSinceLastScheduledInd = 1 and schLastScheduledFreq > 0
		and DateAdd(Day, schLastScheduledFreq, schLastScheduledDT) < @projDate
		and PROCACTIVE = 1
	order by sch.schKey, PROCID	

if (@debug > 2)
	select * from #schProcData
--
--  insert the WO data for schedules using the date last schedule field
--  for each sch used set the last scheduled date
--
BEGIN TRY
    select ProcData.schKey, schProcID, schProcarg, schProcmodel, 
		3 as type,
		@theprocessdate as opendate, @theDuedate as duedate,
		schPMProcID, schWorkReq,
		case 
			when schAssignTo > 0 then schAssignTo
			else schProcassignto
		end as assignedto,
		schpmest,
		@theDuedate as schdate
		from #schProcData ProcData
		inner join #schPMData PMData on ProcData.schKey = PMData.schKey
		
	--update Scheduler.ChampsSchedules set schLastScheduledDT = @theprocessdate
	--where schkey in (select schkey from #schPMData)
END TRY
BEGIN CATCH
	-- using the new log table enter that we will not create WOs for X date
	set @wasteoftime = cast(ERROR_NUMBER() as nvarchar(20)) + '==' + ERROR_MESSAGE()
	exec wACom.LogIt 99999, 'Scheduler Script', 'None', @wasteoftime
	return
END CATCH;

-- notes: do we have multiple WO for each Pm on the schdule or one WO with
-- all PM data somehow summarized on it.
-- the following was an atempt to summarize the est time.
--select schKey, SUM(schpmest) from #schPMData group by schKey order by schKey


-- Check the all schedules with a lastcompleted frequency
--
-- for each schedule check that all of the WOs for it have been completed
--
--select DateAdd(Day, schLastCompletedFreq, schLastCompleteDT) WODate, @projDate Today, 
--* from Scheduler.ChampsSchedules
--where schActive = 1 and schSinceLastCompleteInd = 1 and schLastCompletedFreq > 0
--and DateAdd(Day, schLastCompletedFreq, schLastCompletedT) < @projDate
--============================== 2 dos  =========================================
-- check the WOs and find the ones with a schid of each from above
-- if they are all closed then check the lastcompleted and freq to see if they 
-- are due within the projdate

-- insert the WOs for the lastcompleted with an open date of projDate and a due date of X

-- set the lastscheduled date to projdate
-- set the lastCompleted date to projDate
--==================================================================================

--  test the trigger for lastcompleted
--
--select * from Scheduler.ChampsSchedules where schKey = 2908
--select * from wo.WorkOrderMain where DISID in (98570, 98569, 98565, 98562)
--select * from .wACom.ChampsLog
--update wo.WorkOrderMain set DISCloseDate = '06/27/2013', Disclosedby = 330 where DISID = 67356
--update wo.WorkOrderMain set disschid = 2908 where DISID in (98570, 98569, 98565, 98562)

--  misc tables to review while we build
--select * from tpm.tpmprocdure



--print 'Lockout date found no WOs created for ' + cast(Convert(Date,DateAdd(Day, 7, GETDATE())) as nvarchar(20)) + cast(getdate() as nvarchar(30))
--declare @wasteoftime nvarchar(max)
--set @wasteoftime = 'Lockout date found no WOs created for ' + cast(Convert(Date,DateAdd(Day, 7, GETDATE())) as nvarchar(20))
--exec wACom.LogIt 99999, 'Scheduler Script', 'None', @wasteoftime

--select DISID, DISSchID, DISCloseDate from wo.WorkOrderMain
-- where ((DISSchID <> null) or (DISSchID <> 0))
--select DISID, DISSchID, DISCloseDate from wo.WorkOrderMain
--where DISID = 67356