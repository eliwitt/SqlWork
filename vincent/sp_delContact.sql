USE [VPI_Online]
GO
/****** Object:  StoredProcedure [dbo].[delContact]    Script Date: 10/09/2012 10:04:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ===============================================================
-- Author:		Vidhya Balasubramanian
-- Create date: 10/25/2011
-- Description:	deletes contacts data
-- ===============================================================


ALTER PROCEDURE [dbo].[delContact]
	@ContactId int
	
AS

DELETE
FROM Contacts
WHERE contactid = @ContactId

DELETE
FROM ContactCustRefs
WHERE contactid = @ContactId