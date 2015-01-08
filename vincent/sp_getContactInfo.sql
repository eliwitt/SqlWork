USE [VPI_Online]
GO

/****** Object:  StoredProcedure [dbo].[getContactInfo]    Script Date: 10/09/2012 11:02:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- ===============================================================
-- Author:		Vidhya Balasubramanina
-- Create date: 10/25/2011
-- Description:	Gets contacts data
-- ===============================================================

ALTER PROCEDURE [dbo].[getContactInfo]
	@EmailId varchar(50)
	
AS

SELECT c.*, cr.custrefs FROM [dbo].Contacts c
left outer join [dbo].ContactCustRefs cr
	on cr.contactid = c.contactid
WHERE emailaddress = @EmailId


GO

