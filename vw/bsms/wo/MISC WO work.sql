--
-- misc WO work
--
-- DISID in (82514)  DISID in (93493, 93596)
-- DISClosedIncomplete = '2013-04-01'  or 
select * from wo.WorkOrderMain where DISClosedBy = 30
--update wo.WorkOrderMain set DISCloseDate = null where DISID = 72712
--
--  retrieve the user 
--
SELECT wouti.WODISID, woteam.TMID, woteam.TMFirstName + ' ' + woteam.TMLastName teammember, wouti.WOUMin
FROM WO.WorkOrderUtilization wouti 
		left outer join Team.teammembers woteam ON wouti.WOUTMID = woteam.TMID 
WHERE wouti.WODISID = 72712

exec [wAppWorkOrder].[WOPrintWOListFetch] '72712,72675'
exec [wAppParts].[PartsList] '72712,72675'
exec [wAppTeam].[TeamMemberWOList] '72712,72675'

DECLARE @position int,
	@separator nchar(1) = ',', @WoList nvarchar(max)
declare @parsedString TABLE (string NVARCHAR(MAX))
set @WoList = '103170,103368'
SET @position = 1
SET @WoList = @WoList + @separator

WHILE charindex(@separator,@WoList,@position) <> 0
	BEGIN
         INSERT into @parsedString
         SELECT substring(@WoList, @position, charindex(@separator,@WoList,@position) - @position)
         SET @position = charindex(@separator,@WoList,@position) + 1
    END
      
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
	(SELECT MLPlantID FROM wACom.MachineList where MLID = DISLineNumber) 'MLPlantID',
	(select t1desc from wACom.T1Errors where t1id = diserrorcodet1) EC1Desc, 
	(select t2desc from wACom.T2Errors where t2id = diserrorcodet2) EC2Desc, 
	(select t3desc from wACom.T3Errors where t3id = diserrorcodet3) EC3Desc,
	woteam.TMID, woteam.TMFirstName + ' ' + woteam.TMLastName teammember, wouti.WOUMin,
	UsageWO.SP2VWNumber, UsageWO.SP2ShortSAPDescr, UsageWO.ULSPQtyUsed, UsageWO.ULSPQtyNeeded
from wo.WorkOrderMain 
		left outer join WO.WorkOrderUtilization wouti on wo.WorkOrderMain.disid = wouti.WODISID
		left outer join Team.teammembers woteam ON wouti.WOUTMID = woteam.TMID 
		left outer join wAppParts.UsageListView UsageWO on wo.WorkOrderMain.disid = UsageWO.ULTableLink 
				and UsageWO.ULListType = 1
where DISID in (select * from @parsedString)
ORDER BY DISID