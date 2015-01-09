USE [BSMS]
GO

/****** Object:  StoredProcedure [wAppEQP].[EqpSearch]    Script Date: 03/15/2013 13:45:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		J. Steve Witt
-- Create date: 3/8/2012
-- Description:	Given the Equipment number gather some information to display on the search screen.
-- =============================================
CREATE PROCEDURE [wAppEQP].[EqpSearch]
@Procid int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
select distinct PROCNUMBER, procasset, procmodel, Equip.EQSerialNumber, PROCARG, ModelNu.EQModModelNumber,
		PROCASSIGNTO, tm.TMFirstName + ' ' + tm.TMLastName 'AssignTo', 
		substring((Select ','+cast(Proc1.TPMProcID as nvarchar(6)) [text()] 
			from tpm.TPMProcdure Proc1
			where PROCMODEL = Proc1.TMPProcModelLink
			order by Proc1.TPMProcID
			for XML path('')),2,1000) 'ProcList'
	from EQP.ProcNumbers PN
		left outer join team.teammembers TM on PROCASSIGNTO = tm.TMID
		left outer join EQP.EquipmentModelNumber ModelNu on PROCMODEL = ModelNu.EQModID
		left outer join wACom.MachineList ML on PROCARG = ml.MLID
		left outer join eqp.Equipment Equip on PROCASSET = EQTID
	where PROCID = @Procid
END

GO

