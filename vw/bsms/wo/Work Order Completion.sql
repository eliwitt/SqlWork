select disid, 
	(SELECT EQP.ProcNumbers.PROCNUMBER fROM EQP.ProcNumbers where PROCID = DISEquip) 'Equip Name', 
	DISEquip,DISOpenDate, DISCloseDate, DISLineNumber, 
	(SELECT  MLCELLNAME FROM wACom.MachineList where MLID = DISLineNumber)'MLCELLNAME',
	(SELECT MLActive FROM wACom.MachineList where MLID = DISLineNumber)'LActive', 
	DISType, (SELECT WOCName FROM [WO].[WorkOrderCodes] where WOCID = DISType),
	DISTPMNumber,(select TPMProcTitle from tpm.TPMProcdure where TPMProcID = DISTPMNumber) 'Procedure title',
	DISOriginator, (select TMFirstName + ' ' + TMLastName from Team.teammembers where TMID = DISOriginator) Originator, 
	DISResponsible, (select RPName from COM.ResponsibleParty where RPID = DISResponsible) 'RespName', 
	DISRequestor, (select TMFirstName + ' ' + TMLastName from Team.teammembers where TMID = DISRequestor) 'RequestorName'
from wo.WorkOrderMain where DISid in (78349)

exec [wAppWorkOrder].[WorkOrderUtilizationFetch] 78259
exec[wAppWorkOrder].[woUtilizationView] '02/10/2013', '02/26/2013', 1
exec [wAppWorkOrder].[WOCompletionReport] 1, '02/10/2013', '02/26/2013'
select * from wo.WorkOrderMain where DISID = 78349
select * from WO.WorkOrderUtilization where WODISID = 78349
                --WO.WorkOrderUtilization ON WO.WorkOrderMain.DISID = WO.WorkOrderUtilization.WODISID RIGHT OUTER JOIN
                --      Team.teammembers ON WO.WorkOrderUtilization.WOUTMID = Team.teammembers.TMID