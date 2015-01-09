--
-- 


select disid, (SELECT EQP.ProcNumbers.PROCNUMBER fROM EQP.ProcNumbers where PROCID = DISEquip) 'Equip Name', DISEquip,
	(SELECT EQP.ProcNumbers.PROCACTIVE fROM EQP.ProcNumbers where PROCID = DISEquip) 'Equip Active',
	DISOpenDate, DISCloseDate, 
	DISLineNumber, (SELECT  MLCELLNAME FROM wACom.MachineList where MLID = DISLineNumber)'Line',
	(SELECT MLActive FROM wACom.MachineList where MLID = DISLineNumber)'LActive',
	(select AAareaname from wACom.Areas where AAID = (select lisatellite from wAcom.Lines where LIID = DISLineNumber)) 'Area', 
	(select AAActive from wACom.Areas where AAID = (select lisatellite from wAcom.Lines where LIID = DISLineNumber)) 'Area Active',
	DISType, (SELECT WOCName FROM [WO].[WorkOrderCodes] where WOCID = DISType),
	DISOriginator, (select TMFirstName + ' ' + TMLastName from Team.teammembers where TMID = DISOriginator) Originator, 
	DISResponsible, (select RPName from COM.ResponsibleParty where RPID = DISResponsible) 'Responsible Party', 
	DISRequestor, (select TMFirstName + ' ' + TMLastName from Team.teammembers where TMID = DISRequestor) Worker
from wo.WorkOrderMain where DISID in (
66982, 
67389,
66981,
66982,
66983,
66993,
66994,
67596,
67597,
67599,
67600,
67652,
67653,
68292,	
68293,	
68294,	
68295,
68352,
68285,
68429)
select * from wo.WorkOrderMain where DISEquip in (4703, 4704, 4715, 4718, 4728) order by DISOpenDate
select * from eqp.ProcNumbers where PROCID = 4743
SELECT * FROM wACom.MachineList where MLID = 249