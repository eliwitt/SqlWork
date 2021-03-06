USE [rTALIS]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetAccessPermissions]    Script Date: 01/27/2009 16:10:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jahan Abdul
-- Create date: 1/23/08
-- Description:	Get user access permissions at application layer
-- =============================================
ALTER PROCEDURE [dbo].[usp_GetAccessPermissions] 
	-- Add the parameters for the stored procedure here
	@UserID varchar(10) 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT QueryAnalyzer, SystemAdministrator,
		Supervisor, AdHocPrinting,
		ImedecsEditor, DecisionEditor, Teamleader, Enabled
	FROM EMPLOYEES
	WHERE EmployeeID = @UserID
END
