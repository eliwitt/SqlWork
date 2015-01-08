USE [VPI_Online]
GO

/****** Object:  StoredProcedure [dbo].[getContacts]    Script Date: 10/09/2012 11:01:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- ===============================================================
-- Author:		Vidhya Balasubramanian
-- Create date: 10/25/2011
-- Description:	Gets contacts data.
-- ===============================================================

ALTER PROCEDURE [dbo].[getContacts]
	
AS

SELECT c.*, cr.custrefs FROM [dbo].Contacts c
left outer join [dbo].ContactCustRefs cr
	on cr.contactid = c.contactid
ORDER BY lastName

GO

