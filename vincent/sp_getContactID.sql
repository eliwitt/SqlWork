USE [VPI_Online]
GO

/****** Object:  StoredProcedure [dbo].[getContactID]    Script Date: 10/09/2012 11:03:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- ===============================================================
-- Author:		Vidhya Balasubramanina
-- Create date: 10/25/2011
-- Description:	Gets contacts data
-- ===============================================================

ALTER PROCEDURE [dbo].[getContactID]
	@ContactId int
	
AS

SELECT c.*, cr.custrefs FROM [dbo].Contacts c
left outer join [dbo].ContactCustRefs cr
	on cr.contactid = c.contactid
WHERE c.contactid = @ContactId

GO

