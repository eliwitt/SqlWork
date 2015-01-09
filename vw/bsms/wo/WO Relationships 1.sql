--
-- lets view a piece of equipments history
--
select * from team.wAPlants
select * from eqp.equipment where EQTModelLink = 853
select * from eqp.EquipmentModelNumber where EQModID = 853
select * from eqp.ProcNumbers where PROCID = 11666
select * from wo.WorkOrderMain where ((DISDueDate >= '11/04/2012') AND (DISDueDate < '11/11/2012'))
select * from wo.WorkOrderMain where DISCloseDate > '01/14/2013'
SELECT * FROM wACom.MachineList where MLID = 696
select * from wACom.Lines where LIID = 19
select * from tpm.TPMProcdure where TPMProcFreq = 4
select * from TPM.TPMFrequency
SELECT * FROM [WO].[WorkOrderCodes]
select * from wo.WorkOrderMain where DISTPMNumber in (select TPMProcID from tpm.TPMProcdure where TPMProcFreq = 4)
--
--  relationships on the create the WO screen
--  will use this to map the new form creation to.
--
-- wos paint  73800,73795,73888,73801  dup? WO 72848  Equip 10908
select disid, 
	(SELECT EQP.ProcNumbers.PROCNUMBER fROM EQP.ProcNumbers where PROCID = DISEquip) 'Equip Name', 
	DISEquip,DISOpenDate, DISCloseDate, DISSchedDate disclosedincomplete, 
	(SELECT  MLPlantID FROM wACom.MachineList where MLID = DISLineNumber)'Shop',
	DISLineNumber, 
	(SELECT  MLCELLNAME FROM wACom.MachineList where MLID = DISLineNumber)'MLCELLNAME',
	(SELECT MLActive FROM wACom.MachineList where MLID = DISLineNumber)'LActive', 
	DISTPMNumber, distype, (SELECT WOCName FROM [WO].[WorkOrderCodes] where WOCID = DISType),
	DISOriginator, (select TMFirstName + ' ' + TMLastName from Team.teammembers where TMID = DISOriginator) Originator, 
	DISResponsible, (select RPName from COM.ResponsibleParty where RPID = DISResponsible) 'RespName', 
	DISRequestor, (select TMFirstName + ' ' + TMLastName from Team.teammembers where TMID = DISRequestor) 'MyName'
from wo.WorkOrderMain 
where DISEquip = 10908
order by DISResponsible
--AND DISType = 3 AND DISCloseDate IS NULL
--ORDER BY DISOpenDate
