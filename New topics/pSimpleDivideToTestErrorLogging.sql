USE [SteveTest]
GO

/****** Object:  StoredProcedure [dbo].[pSimpleDivideToTestErrorLogging]    Script Date: 04/01/2013 15:16:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*****************************************************************************************************
Object: [dbo].[pSimpleDivideToTestErrorLogging]
Description: Simple division sp to test pReThrowError with logging 
******************************************************************************************************/
CREATE PROCEDURE [dbo].[pSimpleDivideToTestErrorLogging]
  @Numerator INT
, @Denominator INT 
, @LogError BIT = 0 
, @Debug BIT = 0 

AS
BEGIN

SET NOCOUNT ON

DECLARE @Result INT
DECLARE @SPName NVARCHAR(392) = DB_NAME() + '.' + SCHEMA_NAME() + '.' + OBJECT_NAME(@@PROCID)

IF @Debug = 1 
 PRINT ': START OF ' + @SPName
 BEGIN TRY 
  SELECT @Numerator * 1.0/@Denominator;
  SET @Result = 0 ;
 END TRY
 BEGIN CATCH 
  -- re-raise the error to be caught in the calling process
  EXECUTE @Result = dbo.pReThrowErrorWithLogging @SPName,@LogError, @Debug
 END CATCH;

IF @Debug = 1 
 PRINT ': END OF '+ @SPName

RETURN @Result

END

GO

