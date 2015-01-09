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
declare @wasteoftime nvarchar(max), @debug int = 3, @projDate datetime,
	@theprocessdate datetime, @theDuedate datetime, @dayofweek int
set @theprocessdate = Convert(Date,DateAdd(Day, 7,'07/17/2013'))
--set @theprocessdate = Convert(Date,DateAdd(Day, 7, GETDATE()))
set @projDate = Convert(Date,DateAdd(Day, 1, @theprocessdate))
set @theDuedate = Convert(Date,DateAdd(Day, 7, @theprocessdate))
set @dayofweek = Datepart(WEEKDAY, @theprocessdate)
--
-- seven days from now
--
if (@debug > 2)
begin
	select @theprocessdate, @projDate, @theDuedate, @dayofweek
	
	select * from Scheduler.Lockout where schLockDate = @theprocessdate
end
--
-- Build the schtable that is used to create our WOs
--
IF object_id('TempDB..#schData') IS NOT NULL
 DROP TABLE #schData;

create table #schData (schKey int, schDescrip nvarchar(255), schAssignedTo int, schSinceLastScheduledInd smallint, schLastScheduledFreq int, 
	schLastScheduledDT datetime, schSinceLastCompleteInd smallint, schLastCompletedFreq int, 
	schLastCompletedT datetime )
insert into #schData
	select schkey,schDescription,schAssignedTo,schSinceLastScheduledInd, schLastScheduledFreq, schLastScheduledDT,
	schSinceLastCompleteInd, schLastCompletedFreq, schLastCompletedT
	from Scheduler.ChampsSchedules
	where schActive = 1 and 
	((@dayofweek = 1 and schValidSun = 1) or (@dayofweek = 2 and schValidMon = 1) or (@dayofweek = 3 and schValidTue = 1) or
	(@dayofweek = 4 and schValidWed = 1) or (@dayofweek = 5 and schValidThru = 1) or (@dayofweek = 6 and schValidFri = 1) or
	(@dayofweek = 7 and schValidSat = 1))
--=============================2 dos ===========================================
--
-- for each plant look up their lockout date
-- if one exists set the each schedule for the plant and remove them from the schData
--
--
-- determine if we have a lockout date
--
if exists(select schLockID from Scheduler.Lockout where schLockDate = @theprocessdate)
begin
	if (@debug > 0)
		select 'Lockout date found no processing for any plant with that date.'
	-- using the new log table enter that we will not create WOs for X date
	set @wasteoftime = 'Lockout date found no WOs created for plants with lockout on ' + cast(@theprocessdate as nvarchar(20))
	exec wACom.LogIt 99999, 'Scheduler Script', 'None', @wasteoftime
end
--
-- set the schedule dates for any schedules with a lockout type of 1 next cycle
-- schedules with a locktype of 0 will be removed but available for the next available day.
-- 
update Scheduler.ChampsSchedules set schLastScheduledDT = @theprocessdate
	where schlocktype = 1 and schKey in (select schkey from #schData where schPlant in (select schLockPlant from Scheduler.Lockout where schLockDate = @theprocessdate))
--	
-- last filter remove the schedules for the given plant lockout
--
delete #schData where schPlant in (select schLockPlant from Scheduler.Lockout where schLockDate = @theprocessdate)

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
BEGIN TRY
	INSERT INTO WO.WorkOrderMain
			(
				DISSchID, DISTitle,
				DISEquip, DISLineNumber, DISIntHold,
				DISType, DISDownResponsible, 
				DISOpenDate, DISDueDate,
				DISTPMNumber, DISWorkRequired,
				DISRequestor,
				DISManHours, DISNumberAss
			)
    select sch.schkey, sch.schDescrip,
		Procitem.PROCID, Procitem.PROCARG, Procitem.PROCMODEL, 
		3, 4,
		@theprocessdate, @theDuedate,
		PMitem.TPMProcID, PMitem.TPMProcProcedure + wAppTPM.RetrieveProcString(PMitem.TPMProcID) as WorkRequired,
		case 
			when schAssignedTo > 0 then schAssignedTo
			else PROCASSIGNTO
		end,
		PMitem.TPMProcEstMin, PMitem.TPMPRocNumTM
	from #schData sch
		join Scheduler.ChampsSchPMGroups schPMs on sch.schKey = schPMs.ChampsSchedule_schKey
		join Scheduler.ChampsSchPMGrpHasPMs HasPMs on schPMs.schPMGrpKey = HasPMs.ChampsSchPMGroups_schPMGrpKey
		join TPM.TPMProcdure PMitem on HasPMs.TPMProcdures_TPMProcID = PMitem.TPMProcID
		join Scheduler.ChampsSchProcGroups schProcs on sch.schKey = schProcs.ChampsSchedule_schKey
		join Scheduler.ChampsSchProcGrpHasProcs HasProcs on schProcs.schProcGrpKey = HasProcs.ChampsSchProcGroups_schProcGrpKey
		join EQP.ProcNumbers Procitem on HasProcs.ProcNumbers_PROCID = Procitem.PROCID
		join wACom.MachineList ON Procitem.PROCARG = wACom.MachineList.MLID
		join wACom.Lines ON wACom.Lines.LIID = wACom.MachineList.MLLINEID 
		join wACom.Areas ON wACom.Lines.LISatellite = wACom.Areas.AAID 		
	where schSinceLastScheduledInd = 1 and schLastScheduledFreq > 0
		and DateAdd(Day, schLastScheduledFreq, schLastScheduledDT) < @projDate
		and (PROCACTIVE = 1 and MLActive = 1 and  LIActive = 1  and AAActive = 1)
	order by sch.schKey, PROCID	
END TRY
BEGIN CATCH
	-- using the new log table enter the error
	set @wasteoftime = cast(ERROR_NUMBER() as nvarchar(20)) + '==' + ERROR_MESSAGE()
	exec wACom.LogIt 99999, 'Scheduler LastSch', 'None', @wasteoftime
	return
END CATCH;
-- ==================================================================================
-- Check the all schedules with a lastcompleted frequency
--============================== 2 dos  =========================================
-- check the WOs and find the ones with a schid of each from above
-- gather the active schedules with a lastcompleted and freq less than the projdate 
-- all WOs for this schedule have been completed

-- insert the WOs for the lastcompleted with an open date of projDate and a due date of X

-- set the lastscheduled date to projdate
-- set the lastCompleted date to projDate  do not need to the trigger handles this
--==================================================================================
BEGIN TRY
	INSERT INTO WO.WorkOrderMain
			(
				DISSchID, DISTitle,
				DISEquip, DISLineNumber, DISIntHold,
				DISType, DISDownResponsible, 
				DISOpenDate, DISDueDate,
				DISTPMNumber, DISWorkRequired,
				DISRequestor,
				DISManHours, DISNumberAss
			)
    select sch.schkey, sch.schDescrip,
		Procitem.PROCID, Procitem.PROCARG, Procitem.PROCMODEL, 
		3, 4,
		@theprocessdate, @theDuedate,
		PMitem.TPMProcID, PMitem.TPMProcProcedure + wAppTPM.RetrieveProcString(PMitem.TPMProcID) as WorkRequired,
		case 
			when schAssignedTo > 0 then schAssignedTo
			else PROCASSIGNTO
		end,
		PMitem.TPMProcEstMin, PMitem.TPMPRocNumTM
	from #schData sch
		join Scheduler.ChampsSchPMGroups schPMs on sch.schKey = schPMs.ChampsSchedule_schKey
		join Scheduler.ChampsSchPMGrpHasPMs HasPMs on schPMs.schPMGrpKey = HasPMs.ChampsSchPMGroups_schPMGrpKey
		join TPM.TPMProcdure PMitem on HasPMs.TPMProcdures_TPMProcID = PMitem.TPMProcID
		join Scheduler.ChampsSchProcGroups schProcs on sch.schKey = schProcs.ChampsSchedule_schKey
		join Scheduler.ChampsSchProcGrpHasProcs HasProcs on schProcs.schProcGrpKey = HasProcs.ChampsSchProcGroups_schProcGrpKey
		join EQP.ProcNumbers Procitem on HasProcs.ProcNumbers_PROCID = Procitem.PROCID
		join wACom.MachineList ON Procitem.PROCARG = wACom.MachineList.MLID
		join wACom.Lines ON wACom.Lines.LIID = wACom.MachineList.MLLINEID 
		join wACom.Areas ON wACom.Lines.LISatellite = wACom.Areas.AAID 	
	where schSinceLastCompleteInd = 1 and schLastCompletedFreq > 0
		and DateAdd(Day, schLastCompletedFreq, schLastCompletedT) < @projDate
		and schKey not in (select disschid from wo.WorkOrderMain where DISSchID = schKey and DISCloseDate is null )
		and (PROCACTIVE = 1 and MLActive = 1 and  LIActive = 1  and AAActive = 1)
	order by sch.schKey, PROCID	
END TRY
BEGIN CATCH
	-- using the new log table enter the error
	set @wasteoftime = cast(ERROR_NUMBER() as nvarchar(20)) + '==' + ERROR_MESSAGE()
	exec wACom.LogIt 99999, 'Scheduler LastComp', 'None', @wasteoftime
	return
END CATCH;

BEGIN TRY
	--
	-- for every WO just created get the parts from the PM and insert them into sp.UsageList
	-- remember that the completed date is set when the WOs are complete
	--
	insert into sp.UsageList (ULListType, ULTableLink, ULSPLink, ULSPQtyUsed, ULSPQtyNeeded, 
		ULSPNotes, USWearType, ULDate)
		select 1, disid, PMParts.TPSPartLink, 0, PMParts.TPSQty, PartsMast.SP2ShortSAPDescr, null, DISOpenDate
		from wo.WorkOrderMain WOMain
		join sp.TPMPartLink PMParts on WOMain.DISTPMNumber = PMParts.TPSTPMProcedure
		join sp.SPMaster2 PartsMast on PMParts.TPSPartLink = PartsMast.SP2ID
		where DISOpenDate = @theprocessdate and DISType = 3
		order by disid	
END TRY
BEGIN CATCH
	-- using the new log table enter the error
	set @wasteoftime = cast(ERROR_NUMBER() as nvarchar(20)) + '==' + ERROR_MESSAGE()
	exec wACom.LogIt 99999, 'Scheduler Parts', 'None', @wasteoftime
	return
END CATCH;

BEGIN TRY
	--
	-- for all of the schedules we just created a WO for set the date
	-- remember that the completed date is set when the WOs are complete
	--
	update Scheduler.ChampsSchedules set schLastScheduledDT = @theprocessdate
	where schKey in (select distinct DISSchID from wo.WorkOrderMain where DISOpenDate = @theprocessdate and DISType = 3)
END TRY
BEGIN CATCH
	-- using the new log table enter the error
	set @wasteoftime = cast(ERROR_NUMBER() as nvarchar(20)) + '==' + ERROR_MESSAGE()
	exec wACom.LogIt 99999, 'Scheduler UptSch', 'None', @wasteoftime
	return
END CATCH;


if (@debug > 2)
begin
	-- show the schedules used for this date
	select schkey, schActive,schAssignedTo,schSinceLastScheduledInd, schLastScheduledFreq, schLastScheduledDT,
	schSinceLastCompleteInd, schLastCompletedFreq, schLastCompletedT, 
	schValidSun, schValidMon, schValidTue, schValidWed, schValidThru, schValidFri, schValidSat
	from Scheduler.ChampsSchedules
	where schkey in (select distinct DISSchID from wo.WorkOrderMain where DISOpenDate = @theprocessdate and DISType = 3) 

	-- show the wos created from the schedules
	select DISID, DISSchID, DISTPMNumber, DISEquip, DISRequestor, DISOpenDate, DISDueDate 
	from wo.WorkOrderMain where DISOpenDate = @theprocessdate and DISType = 3 order by DISSchID
	
	--show the parts added
	select * from sp.UsageList where ULDate = @theprocessdate
end