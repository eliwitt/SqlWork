USE [BSMS]
GO

/****** Object:  StoredProcedure [wAppEQP].[EqpEditReport]    Script Date: 03/27/2013 11:43:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [wAppEQP].[EqpEditReport]
@Cell as nVarChar(max),
@Line as nVarChar(max),
@Plant as Integer,
@Model as nVarChar(max) 


AS
DECLARE @machineTable TABLE 
(
	machineNumber  Integer,
	idCol Integer
)

INSERT INTO @machineTable (machineNumber) SELECT (data) FROM wACom.Split(@Cell,',')

	SELECT * FROM wAppEQP.EqpEdit
	--WHERE EQPlant = @Plant and MLID IN (SELECT machineNumber FROM @machineTable )
	WHERE EQPlant = @Plant and MLID IN (SELECT (data) FROM wACom.Split(@Cell,',') ) AND EQModID IN (SELECT (data) FROM wACom.Split(@Model,','))
	RETURN

GO

