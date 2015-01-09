USE [BSMS_test]
GO

/****** Object:  StoredProcedure [wAppEQP].[EquipTree]    Script Date: 05/16/2013 13:28:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		J. Steve Witt
-- Create date: 05/13/2013
-- Description:	Build the treeview for the given Plant/Shop
-- =============================================
CREATE PROCEDURE [wAppEQP].[EquipTree]
@Plant as Integer = 0
AS
BEGIN
	SET NOCOUNT ON;
select Plant.PNID, Plant.PNName, AAID, AAareaname, LIID, LILineName, MLID, MLCELLNAME, 
	PROCID, PROCNUMBER, PROCASSET, PROCASSETASSIGNABLE
from wACom.Areas Area
	left join wACom.Lines Line on Area.AAID = Line.LISatellite and LIActive = 1
	left join wACom.MachineList ML on LIID = ml.MLLINEID and MLActive = 1
	left join EQP.ProcNumbers ProcNu on ml.MLID = ProcNu.PROCARG and PROCACTIVE = 1
	left join Team.wAPlants Plant on Area.AAPlant = Plant.PNID
where AAPlant = @Plant and AAActive = 1 
order by AAareaname, LILineName, MLCELLNAME, PROCNUMBER
END

GO

