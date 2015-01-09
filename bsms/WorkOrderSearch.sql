USE [BSMS]
GO

/****** Object:  StoredProcedure [wAppWorkOrder].[WorkOrderSearch]    Script Date: 03/15/2013 13:43:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		J. Steve Witt
-- Create date: 3/8/2013
-- Description:	Given the different user supplied filters provide a list 
-- of WOs that sadistifies the critreia.
-- =============================================
CREATE PROCEDURE [wAppWorkOrder].[WorkOrderSearch] 
	@Plant int = 0,
	@DtType int = 0,
	@FromDt date,
	@ToDt date,
	@woOC int = 0,
	@wotype int = 0,
	@OwnerSearch nVarchar(max) = '',
	@AreaSearch int = 0,
	@LineSearch int = 0,
	@MLSearch int = 0,
	@EquipSearch int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
DECLARE 
	@OwnerString nVarChar(max)

SET @OwnerString = '%' + @OwnerSearch + '%';
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
select disid, DISEquip, ml.MLPlantID 'Shop', Shift.STShiftName 'Shift',
	TM.TMFirstName + ' ' + TM.TMLastName 'Assignto', Areas.AAareaname 'Area',
	Lines.LILineName 'Line', MLCELLNAME 'CELL', PROCNUMBER 'Equipment Nr', 
	proctbl.TPMProcTitle, DISCloseDate, DISDueDate, WOCName
from wo.WorkOrderMain WOMain
	left outer join wACom.MachineList ML on DISLineNumber = ml.MLID
	left outer join wACom.Lines Lines on ML.MLLINEID = Lines.LIID
	left outer join wACom.Areas Areas on Lines.LISatellite = Areas.AAID
	left outer join EQP.ProcNumbers ProcNu on DISEquip = ProcNu.PROCID
	left outer join [WO].[WorkOrderCodes] WOCodes on DISType = WOCID
	left outer join Team.teammembers TM on DISRequestor = TM.TMID
	left outer join Team.ShiftTable Shift on tm.TMNShift = Shift.STID
	left outer join tpm.TPMProcdure ProcTbl on DISTPMNumber = ProcTbl.TPMProcID
where ml.MLPlantID = @Plant
	and
		((@DtType = 0) or 
			(@DtType = 1 and DISOpenDate between @FromDt and @ToDt) or
			(@DtType = 2 and DISCloseDate between @FromDt and @ToDt) or
			(@DtType = 3 and DISDueDate between @FromDt and @ToDt)
		)
	and
		((@woOC = 0) or (@woOC = 1 and DISCloseDate is not null) or (@woOC = 2 and DISCloseDate is null))
	and 
		((@wotype = 0) or (@wotype > 0 and DISType = @wotype))
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
order by disid		
END

GO

