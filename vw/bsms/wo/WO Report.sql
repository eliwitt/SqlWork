--
-- this is something I worked on 
--
select disid, DISOpenDate, DISDueDate, DISCloseDate,
	(SELECT WOCName FROM [WO].[WorkOrderCodes] where WOCID = DISType) 'WOCName',
	(SELECT EQP.ProcNumbers.PROCNUMBER fROM EQP.ProcNumbers where PROCID = DISEquip) 'PROCNUMBER',
	(select TPMProcTitle from TPM.TPMProcdure where TPMProcID = DISTPMNumber) 'TPMProcTitle',
	(select Myname from wACom.TeamListDrop where TMID = DISOriginator) 'Myname',
	(select Myname from wACom.TeamListDropMirror where TMID = DISRequestor) 'RespName', 
	DISLineNumber, (SELECT MLCELLNAME FROM wACom.MachineList where MLID = DISLineNumber) 'MLCELLNAME',
	DISWorkRequired, DISNumberAss, DISManHours, DISWorkAccomp,
	(SELECT COUNT(*) AS TMActual FROM WO.WorkOrderUtilization where WODISID = DISID ) 'TMActual',	
	(SELECT SUM(WOUMin) AS TMMins FROM WO.WorkOrderUtilization where WODISID = DISID ) 'TMMins',
	(SELECT MLPlantID FROM wACom.MachineList where MLID = DISLineNumber) 'MLPlantID'
from wo.WorkOrderMain where DISID in (63315)
order by DISResponsible

exec [wAppWorkOrder].[WOPrintFetch] 1

exec [wAppWorkOrder].[WOPrintWOListFetch] 63229