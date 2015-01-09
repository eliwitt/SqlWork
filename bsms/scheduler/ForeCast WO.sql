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


-- --------------------  skip for now  -------------------------------
-- determine if we have a lockout date in the range and 
--
-- when a sch has a block out copy it to schBlock and check if the using lock type
-- will produce a WO in the range then include it.
--
--delete #foreData where schPlant in (select schLockPlant from Scheduler.Lockout where schLockDate = @theStartDate)
--
-- ----------------------------------------
-- WOs that are currently open in this range
-- ----------------------------------------
--
select DISID, DISSchID, DISTitle, DISEquip, DISLineNumber, DISIntHold, DISType, DISDownResponsible, 
	DISOpenDate, DISDueDate, DISTPMNumber, DISWorkRequired, DISRequestor, DISManHours, DISNumberAss 
from wo.WorkOrderMain 
where ((DISCloseDate is null) and (DISDueDate between @theStartDate and @theEndDate))
union
-- ----------------------------------------------------------
-- WO for last schedule Schedules
-- ----------------------------------------------------------
select 0, sch.schkey, sch.schDescrip, Procitem.PROCID, Procitem.PROCARG, Procitem.PROCMODEL, 3, 4, @theStartDate, @theDuedate,
	PMitem.TPMProcID, PMitem.TPMProcProcedure + wAppTPM.RetrieveProcString(PMitem.TPMProcID) as WorkRequired,
	case 
		when schAssignedTo > 0 then schAssignedTo
		else PROCASSIGNTO
	end,
	PMitem.TPMProcEstMin, PMitem.TPMPRocNumTM
from #foreData sch
	join Scheduler.ChampsSchPMGroups schPMs on sch.schKey = schPMs.ChampsSchedule_schKey
	join Scheduler.ChampsSchPMGrpHasPMs HasPMs on schPMs.schPMGrpKey = HasPMs.ChampsSchPMGroups_schPMGrpKey
	join TPM.TPMProcdure PMitem on HasPMs.TPMProcdures_TPMProcID = PMitem.TPMProcID
	join Scheduler.ChampsSchProcGroups schProcs on sch.schKey = schProcs.ChampsSchedule_schKey
	join Scheduler.ChampsSchProcGrpHasProcs HasProcs on schProcs.schProcGrpKey = HasProcs.ChampsSchProcGroups_schProcGrpKey
	join EQP.ProcNumbers Procitem on HasProcs.ProcNumbers_PROCID = Procitem.PROCID
	join wACom.MachineList ON Procitem.PROCARG = wACom.MachineList.MLID
	join wACom.Lines ON wACom.Lines.LIID = wACom.MachineList.MLLINEID 
	join wACom.Areas ON wACom.Lines.LISatellite = wACom.Areas.AAID 		
where schSinceLastScheduledInd = 1 
	and (PROCACTIVE = 1 and MLActive = 1 and  LIActive = 1  and AAActive = 1)
-- ----------------------------------------------
-- WO for last completed Schedules
-- ----------------------------------------------
union
select 1, sch.schkey, sch.schDescrip, Procitem.PROCID, Procitem.PROCARG, Procitem.PROCMODEL, 3, 4, @theStartDate, @theDuedate,
	PMitem.TPMProcID, PMitem.TPMProcProcedure + wAppTPM.RetrieveProcString(PMitem.TPMProcID) as WorkRequired,
	case 
		when schAssignedTo > 0 then schAssignedTo
		else PROCASSIGNTO
	end,
	PMitem.TPMProcEstMin, PMitem.TPMPRocNumTM
from #foreData sch
	join Scheduler.ChampsSchPMGroups schPMs on sch.schKey = schPMs.ChampsSchedule_schKey
	join Scheduler.ChampsSchPMGrpHasPMs HasPMs on schPMs.schPMGrpKey = HasPMs.ChampsSchPMGroups_schPMGrpKey
	join TPM.TPMProcdure PMitem on HasPMs.TPMProcdures_TPMProcID = PMitem.TPMProcID
	join Scheduler.ChampsSchProcGroups schProcs on sch.schKey = schProcs.ChampsSchedule_schKey
	join Scheduler.ChampsSchProcGrpHasProcs HasProcs on schProcs.schProcGrpKey = HasProcs.ChampsSchProcGroups_schProcGrpKey
	join EQP.ProcNumbers Procitem on HasProcs.ProcNumbers_PROCID = Procitem.PROCID
	join wACom.MachineList ON Procitem.PROCARG = wACom.MachineList.MLID
	join wACom.Lines ON wACom.Lines.LIID = wACom.MachineList.MLLINEID 
	join wACom.Areas ON wACom.Lines.LISatellite = wACom.Areas.AAID 	
where schSinceLastCompleteInd = 1 
	and schKey not in (select disschid from wo.WorkOrderMain where DISSchID = schKey and DISCloseDate is null )
	and (PROCACTIVE = 1 and MLActive = 1 and  LIActive = 1  and AAActive = 1)
order by disid, DISOpenDate, DISDueDate