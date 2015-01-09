USE [myTempDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_policy_update]    Script Date: 12/08/2009 11:17:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_policy_update]
	@policyptr int,
	@doctype tinyint
AS
BEGIN
	SET NOCOUNT ON;

update policydocuments 
	set scannedback = 1 
	where PolicyPtr = @policyptr and DocTypeID = @doctype
END
