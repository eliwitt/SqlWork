USE [SteveTest]
GO

/****** Object:  StoredProcedure [dbo].[pReThrowErrorWithLogging]    Script Date: 04/01/2013 15:14:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/****************************************************************************
DESCRIPTION: Re-raises the error to be caught in the calling process.
Logs the error if @logError = 1
****************************************************************************/

CREATE PROCEDURE [dbo].[pReThrowErrorWithLogging] 
  @ProcedureName VARCHAR(500),
  @logError BIT = 0,
  @Debug BIT = 0
AS

BEGIN

SET NOCOUNT ON

DECLARE @ErrorNumber INT = ERROR_NUMBER()
DECLARE @ErrorSeverity INT = ERROR_SEVERITY()
DECLARE @ErrorState INT = ERROR_STATE()
DECLARE @ErrorLine INT = ERROR_LINE()
DECLARE @ErrorProcedureName SYSNAME = ERROR_PROCEDURE()
DECLARE @ErrorMessage NVARCHAR(MAX) = ERROR_MESSAGE()
DECLARE @FullErrorMessage NVARCHAR(MAX)

SET @ErrorProcedureName = ISNULL(@ErrorProcedureName, @ProcedureName)

IF @Debug = 1
 PRINT N'ErrorNumber = '
  + CONVERT(NVARCHAR(10), @ErrorNumber)
  + N'ErrorSeverity = '
  + CONVERT(NVARCHAR(10), @ErrorSeverity)
  + N'ErrorState = '
  + CONVERT(NVARCHAR(10), @ErrorState)
  + N'ErrorLine = '
  + CONVERT(NVARCHAR(10), @ErrorLine)
  + N'ErrorProcedure = '
  + @ErrorProcedureName
  + N'ErrorMessage = '
  + @ErrorMessage + N'
 '
;

IF( @logError = 1 )
 BEGIN
  BEGIN TRY
   IF NOT EXISTS (SELECT 1
                    FROM sys.tables
                    WHERE name = 'SPErrorLog'
                  AND type IN ( N'U' ))
    BEGIN
     -- You can truncate this table periodically
     CREATE TABLE [SPErrorLog]
     (
      [ErrorLogID] [INT] IDENTITY(1, 1) NOT NULL,
      [ErrorTime] [DATETIME] NOT NULL CONSTRAINT [DF_ErrorLog_ErrorTime] DEFAULT (getdate()),
      [UserName] [VARCHAR](500),
      [SPID] [INT],
      [ErrorNumber] [INT],
      [ErrorSeverity] [INT],
      [ErrorState] [INT],
      [ErrorProcedure] [NVARCHAR](400),
      [ErrorLine] [INT],
      [ErrorMessage] [NVARCHAR](4000),
      CONSTRAINT [PK_ErrorLog_ErrorLogID] PRIMARY KEY CLUSTERED ( [ErrorLogID] ASC )
      )
    END

   INSERT INTO [SPErrorLog]
     (ErrorTime,
      UserName,
      SPID,
      ErrorNumber,
      ErrorSeverity,
      ErrorState,
      ErrorProcedure,
      ErrorLine,  
      ErrorMessage
      )
     VALUES ( GETDATE(),
              SYSTEM_USER,
              @@SPID,
              @ErrorNumber,
              @ErrorSeverity,
              @ErrorState,
              @ErrorProcedureName,
              @ErrorLine,
              LEFT(@ErrorMessage, 4000) 
            );
   END TRY
  BEGIN CATCH
   -- Do nothing, just re-throw the error.
  END CATCH

END

SET @FullErrorMessage = N'Unexpected error ocurred in Procedure: %s Line Number: %i Error Number: %i Severity: %i State: %i '
+ @ErrorMessage
RAISERROR (@FullErrorMessage,16,@ErrorState,@ErrorProcedureName,@ErrorLine,@ErrorNumber,@ErrorSeverity,@ErrorState)

RETURN @ErrorNumber

END

GO

