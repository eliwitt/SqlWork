--
-- 
select disid, (SELECT EQP.ProcNumbers.PROCNUMBER fROM EQP.ProcNumbers where PROCID = DISEquip) 'Equip Name', DISEquip,
	(SELECT EQP.ProcNumbers.PROCACTIVE fROM EQP.ProcNumbers where PROCID = DISEquip) 'Equip Active',
	DISOpenDate, DISCloseDate, 
	DISLineNumber, (SELECT  MLPlantID FROM wACom.MachineList where MLID = DISLineNumber)'LPlant',
	(SELECT  MLCELLNAME FROM wACom.MachineList where MLID = DISLineNumber)'Line',
	(SELECT MLActive FROM wACom.MachineList where MLID = DISLineNumber)'LActive',
	(select AAareaname from wACom.Areas where AAID = (select lisatellite from wAcom.Lines where LIID = DISLineNumber)) 'Area', 
	(select AAActive from wACom.Areas where AAID = (select lisatellite from wAcom.Lines where LIID = DISLineNumber)) 'Area Active',
	DISType, (SELECT WOCName FROM [WO].[WorkOrderCodes] where WOCID = DISType),
	DISOriginator, (select TMFirstName + ' ' + TMLastName from Team.teammembers where TMID = DISOriginator) Originator, 
	DISResponsible, (select RPName from COM.ResponsibleParty where RPID = DISResponsible) 'Responsible Party', 
	DISRequestor, (select TMFirstName + ' ' + TMLastName from Team.teammembers where TMID = DISRequestor) Worker
from wo.WorkOrderMain where DISID > 99101
select * from wo.WorkOrderMain where DISEquip in (4703, 4704, 4715, 4718, 4728) order by DISOpenDate
select * from eqp.ProcNumbers where PROCID = 4743
SELECT * FROM wACom.MachineList where MLID = 249
select * from wo.WorkOrderUtilization where WODISID = 69903

	--update Scheduler.ChampsSchedules set schLastScheduledDT = '06/03/2013'
	--from Scheduler.ChampsSchedules 
	--where schActive = 1 and schSinceLastCompleteInd = 1 and schLastCompletedFreq > 0
	--	and DateAdd(Day, schLastCompletedFreq, schLastCompletedT) < '06/04/2013'
select * from Scheduler.ChampsSchedules where schKey = 2061
select * from wo.WorkOrderMain where DISSchID in (2908, 2909)
--update wo.WorkOrderMain set DISCloseDate = '06/28/2013', Disclosedby = 332 where DISID in (104637, 104638)
select * from .wACom.ChampsLog