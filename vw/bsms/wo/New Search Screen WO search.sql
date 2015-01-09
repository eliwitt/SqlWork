-- 
-- search the WOs for the list of filters
--
-- list changes
--
-- 1. change wotype to nVarChar(max)
-- 2. add the (SELECT (data) FROM wACom.Split(@wotype,',') to the where clause
--     select * from wo.WorkOrderCodes   2 Breakdown  6 safety
DECLARE
	@woid int = 0,
	@Plant int = 2,
	@DtType int = 0,
	@FromDt date,
	@ToDt date,
	@woOC int = 0,
	@wotype nVarChar(max) = '',
	@OwnerSearch nVarchar(max) = '',
	@AreaSearch int = 0,
	@LineSearch int = 50,
	@MLSearch int = 0,
	@EquipSearch int = 0,
	@OwnerString nVarChar(max)
set @FromDt = '03/07/2013'
set @ToDt = '03/08/2013'
--
--=====================================================================================
--
-- key
--
--  DtType = 0-Any date, 1=Open, 2=Closed, 3=Due Apply the date range
--
--  woOC = 0-All WOs, 1=Closed, 2=Open  
--
-- woType = PM, Corrective, CI, Emergency, etc.
--
-- OwnerString = Any equipment assigned to the given person
--
-- Areasearch = All WOs for the area
--
-- Linesearch = All WOs for the line
--
-- MLsearch = All WOs for the Cell
--
-- Equipsearch = All WOs for the piece of equipment, really this is the location.
-- 
--======================================================================================
--select * from wo.WorkOrderCodes
--update wo.WorkOrderCodes set WOCName = 'PM' where wocid = 3
--select * from tpm.TPMProcdure PMProc
--	join tpm.TPMFrequency PMFreq on PMProc.TPMProcFreq = PMFreq.TPMFreqID
--
-- select v1
--select disid 'WO ID', ml.MLPlantID 'Shop', 
--	PROCNUMBER 'Equip Name', 
--	DISEquip,DISOpenDate, DISCloseDate, DISSchedDate disclosedincomplete, 
--	Areas.AAID, Areas.AAareaname, Lines.LIID, Lines.LILineName, DISLineNumber, 
--	MLCELLNAME 'CELL', MLActive 'CellActive', 
--	DISTPMNumber, distype, WOCName,
--	DISOriginator, OM.TMFirstName + ' ' + OM.TMLastName Originator, 
--	DISResponsible, RPName 'RespName', 
--  DISRequestor, TM.TMFirstName + ' ' + TM.TMLastName 'MyName'
--	v2
--	Areas.AAID, Lines.LIID, ml.MLID, DISEquip
--
--  date ranges version
--
--  V1
	--and
	--	((@FromDt is null and @ToDt is null) or (DISCloseDate between @FromDt and @ToDt) 
	--		or (DISOpenDate between @FromDt and @ToDt))
--=====================================================================================
--
-- key
--
--  DtType = 0-Any date, 1=Open, 2=Closed, 3=Due Apply the date range
--
--  woOC = 0-All WOs, 1=Closed, 2=Open  
--
-- woType = PM, Corrective, CI, Emergency, etc.
--
-- OwnerString = Any equipment assigned to the given person
--
-- Areasearch = All WOs for the area
--
-- Linesearch = All WOs for the line
--
-- MLsearch = All WOs for the Cell
--
-- Equipsearch = All WOs for the piece of equipment, really this is the location.
-- 
--======================================================================================
--                               Plant         From        to         WO Type   Area  cell
--                                   Type  dates                     OC     owner   line  equip
--exec wAppWorkOrder.WorkOrderSearch 1,  0, '03/07/2013', '03/08/2013', 0,  0, '', 0, 0, 0, 0, 72712
--set @OwnerSearch = 'efaw'
SET @OwnerString = '%' + @OwnerSearch + '%';
--(WOCName <> 'PM') or (WOCName = 'PM' and disduedate < '" + nextMonday + "')
select disid 'WO ID', PROCNUMBER 'Equipment Nr', DISTitle 'Title',
	Lines.LILineName 'Line', MLCELLNAME 'CELL', Areas.AAareaname 'Area',
	TM.TMFirstName + ' ' + TM.TMLastName 'Assign to', 
	DISOpenDate, DISDueDate, DISCloseDate,
	WOCName 'WO Type', DISManHours 'est hrs', PMFreq.TPMFreqFrequency 'PM Type',
	proctbl.TPMProcTitle 'TPM Procedure Title',
	Areas.AAID, Lines.LIID, ml.MLID, DISEquip, DISWorkAccomp, DISRequestor
from wo.WorkOrderMain WOMain
	left outer join wACom.MachineList ML on DISLineNumber = ml.MLID
	left outer join wACom.Lines Lines on ML.MLLINEID = Lines.LIID
	left outer join wACom.Areas Areas on Lines.LISatellite = Areas.AAID
	left outer join EQP.ProcNumbers ProcNu on DISEquip = ProcNu.PROCID
	left outer join [WO].[WorkOrderCodes] WOCodes on DISType = WOCID
	left outer join Team.teammembers TM on DISRequestor = TM.TMID
	left outer join tpm.TPMProcdure ProcTbl on DISTPMNumber = ProcTbl.TPMProcID
	left outer join tpm.TPMFrequency PMFreq on ProcTbl.TPMProcFreq = PMFreq.TPMFreqID
where ((@woid = 0 and ml.MLPlantID = @Plant) or (@woid = DISID)) 
	and
		((@DtType = 0) or 
			(@DtType = 1 and DISOpenDate between @FromDt and @ToDt) or
			(@DtType = 2 and DISCloseDate between @FromDt and @ToDt) or
			(@DtType = 3 and DISDueDate between @FromDt and @ToDt)
		)
	and
		((@woOC = 0) or (@woOC = 1 and DISCloseDate is not null) or (@woOC = 2 and DISCloseDate is null))
	and 
		((@wotype = '') or (DISType in (SELECT (data) FROM wACom.Split(@wotype,','))))
	and
		((@OwnerString = '%%') or (TM.TMFirstName + ' ' + TM.TMLastName like @OwnerString))
	and
		((@AreaSearch = 0) or (Areas.AAID = @AreaSearch))
	and 
		((@LineSearch = 0) or (Lines.LIID = @LineSearch))
	and 
		((@MLSearch = 0) or (ml.MLID = @MLSearch))
	and 
		((@EquipSearch = 0) or (DISEquip = @EquipSearch))
order by disid desc