USE [BSMS]
GO

/****** Object:  StoredProcedure [wAppTPM].[ProcedureFetchAll]    Script Date: 03/27/2013 11:45:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		J. Steve Witt
-- Create date: 02/27/2013
-- Description:	Gather all of the procedures passed in 
-- =============================================
CREATE PROCEDURE [wAppTPM].[ProcedureFetchAll]
@ProcList as nVarChar(max)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	select TPMProcID, TPMProcTitle, TPMProcFreq, TPMProcType,
	TPMProcProcedure + wAppTPM.RetrieveProcString(TPMProcID) + wAppTPM.RetrievePartsString(TPMProcID)as TPMProcProcedure,
	TMPProcModelLink, TPMProcContDocNum, TPMPRocNumTM, TPMProcEstMin, TPMTypeID,
	TPMTypeName, TPMFreqID, TPMFreqFrequency, TPMFreqNotes, TPMFreqPeriod,
	TPMFreqDueModifier, TPMInProduction, TPMProcGroupName, TPMBulkDigital,
	RightCol, EQModModelNumber, EQModDescription, EQModID, TPMAvText,
	TPMProcLineStatus, TPMProcPriority, TPMPRText, TPMProcPlantAssign
	 FROM wAppTPM.wAppTPMProcedure
	WHERE TPMProcID IN (SELECT (data) FROM wACom.Split(@ProcList,',') )
	ORDER BY TPMProcID
END

GO

