USE [BSMS]
GO
/****** Object:  StoredProcedure [wAppWorkOrder].[WOPrintWOListFetch]    Script Date: 01/23/2013 11:06:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		J. Steve Witt
-- Create date: 01/23/2013
-- Description:	Retrieves the WOs from the given list
-- =============================================
ALTER PROCEDURE [wAppWorkOrder].[WOPrintWOListFetch]
@WoList nvarchar(max)
AS
BEGIN
--
-- first we will parse the wolist
--
DECLARE @position int,
	@separator nchar(1) = ','
declare @parsedString TABLE (string NVARCHAR(MAX))

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
	(SELECT MLPlantID FROM wACom.MachineList where MLID = DISLineNumber) 'MLPlantID'
from wo.WorkOrderMain where DISID in (select * from @parsedString)	
ORDER BY DISID
     RETURN
END
