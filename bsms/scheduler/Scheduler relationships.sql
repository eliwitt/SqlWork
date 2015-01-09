--
-- build the schedules using the existing data
--
--
--select * from Team.wAPlants
--  Has the plant id, PNCode(AS|PT|BY|IN), and PNCost
select distinct tpr.TPMProcPlantAssign, tpr.TPMProcID, tpr.TPMProcTitle, 
	plt.PNCode, freq.TPMFreqFrequency, freq.TPMFreqDueModifier,
	case when pn.PROCASSIGNTO is null then 0 else pn.PROCASSIGNTO end
from tpm.TPMProcdure tpr
	left join tpm.TPMFrequency freq on tpr.TPMProcFreq = freq.TPMFreqID
	left join Team.wAPlants plt on tpr.TPMProcPlantAssign = plt.PNID
	left join EQP.ProcNumbers pn on tpr.TMPProcModelLink = pn.PROCMODEL
where plt.PNName = 'Bodyweld'
--select * from tpm.TPMFrequency
--select * from tpm.TPMProcdure
--  Has the tpmfreqduemodifier
-- bodyweld has a good one 12
-- Infrastructure has 1077 and 1078
--
select * from EQP.ProcNumbers PN
	join tpm.TPMProcdure tpr on tpr.TMPProcModelLink = pn.PROCMODEL
	where tpr.TPMProcID = 12 order by procnumber -- TPMProcPlantAssign = (select pnid from Team.wAPlants where PNName = 'Bodyweld')
	
select * from Scheduler.ChampsSchedules
select * from Scheduler.ChampsSchPMGroups -- where schPMGrpKey = 2908
select * from Scheduler.ChampsSchPMGrpHasPMs -- where ChampsSchPMGroups_schPMGrpKey = 2908
-- find duplicates rows this is the group id key 2908
--SELECT ChampsSchPMGroups_schPMGrpKey
--FROM Scheduler.ChampsSchPMGrpHasPMs
--GROUP BY ChampsSchPMGroups_schPMGrpKey
--HAVING COUNT(*) > 1

select * from Scheduler.ChampsSchProcGroups
select * from Scheduler.ChampsSchProcGrpHasProcs
SELECT TOP 20000 [schKey], schName + ', Description: ' + isnull(schDescription,''), schDescription  FROM [Scheduler].[ChampsSchedules] where schPlant = 1 order by schName desc
--
-- retrieve the PMs for a specific sch id
--
select sch.schKey, sch.schPlant, sch.schName, schDescription, schPMDescription, 
	HasPMs.ChampsSchPMGroups_schPMGrpKey, HasPMs.TPMProcdures_TPMProcID,
	PMitem.TMPProcModelLink, PMitem.TPMProcEstMin, PMitem.TPMProcTitle
from Scheduler.ChampsSchedules sch
	join Scheduler.ChampsSchPMGroups schPMs on sch.schKey = schPMs.ChampsSchedule_schKey
	join Scheduler.ChampsSchPMGrpHasPMs HasPMs on schPMs.schPMGrpKey = HasPMs.ChampsSchPMGroups_schPMGrpKey
	join TPM.TPMProcdure PMitem on HasPMs.TPMProcdures_TPMProcID = PMitem.TPMProcID
	where sch.schKey = 2008
--where sch.schName like 'SCHBW12%'	  where sch.schKey = 2008
--update Scheduler.ChampsSchedules set schPlant = 1 where schKey = 2907
--
-- retrieve the locations for a specific sch id
--
select sch.schKey, sch.schName, schProcs.schProcGrpKey, schDescription, schProcDescription, Procitem.procnumber
from Scheduler.ChampsSchedules sch
	join Scheduler.ChampsSchProcGroups schProcs on sch.schKey = schProcs.ChampsSchedule_schKey
	join Scheduler.ChampsSchProcGrpHasProcs HasProcs on schProcs.schProcGrpKey = HasProcs.ChampsSchProcGroups_schProcGrpKey
	join EQP.ProcNumbers Procitem on HasProcs.ProcNumbers_PROCID = Procitem.PROCID
where sch.schName = 'SCHBW2'
order by Procitem.procnumber

-- ================  delete the tables ======================
--delete Scheduler.ChampsSchProcGrpHasProcs
--delete Scheduler.ChampsSchProcGroups
--delete Scheduler.ChampsSchPMGrpHasPMs
--delete Scheduler.ChampsSchPMGroups
--delete Scheduler.ChampsSchedules


-- in case we need to add an order column to the procedure relatioship table.  
-- it appears that was done in the task to procedure process.
--
	--SELECT * FROM wAppTPM.TPMTaskAssemblyView
	--WHERE TPMTAProcedureID = 435
	--ORDER BY TPMTAOrder
	
	--select disschid from wo.WorkOrderMain where DISSchID = 2908 and DISCloseDate is null
--select DateAdd(Day, schLastCompletedFreq, schLastCompleteDT) WODate, @projDate Today, 
--* from Scheduler.ChampsSchedules
--where schActive = 1 and schSinceLastCompleteInd = 1 and schLastCompletedFreq > 0
--and DateAdd(Day, schLastCompletedFreq, schLastCompletedT) < @projDate

--  ===================== test the trigger for lastcompleted  ====================================
--
--select * from Scheduler.ChampsSchedules where schKey > 2899
--select * from wo.WorkOrderMain where DISID in (67356, 98570, 98569, 98565, 98562)
--select disid, disschid, DISCloseDate from wo.WorkOrderMain where DISSchID = 2908 where DISCloseDate <> null
--select * from .wACom.ChampsLog
--update wo.WorkOrderMain set DISCloseDate = '05/01/2013', Disclosedby = 330 where DISID = 98570
--update wo.WorkOrderMain set disschid = 2908 where DISID in (67356, 98570, 98569, 98565, 98562)
-- ==========================================  testing queries ==============================================
-- set the last scheduled and completed dates to 5/27 to start 
--update Scheduler.ChampsSchedules set schLastScheduledDT = '05/27/2013'
--select DISID, DISSchID, DISTPMNumber, DISEquip, DISRequestor, DISOpenDate, DISDueDate from wo.WorkOrderMain where DISOpenDate > '05/27/2013' and DISType = 3  -- check WO for future type 3  none