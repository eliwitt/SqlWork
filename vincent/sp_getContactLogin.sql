USE [VPI_Online]
GO

/****** Object:  StoredProcedure [dbo].[getContactLogin]    Script Date: 10/09/2012 11:02:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Vidhya Balasubramanian
-- Create date: 10/25/2011
-- Description:	Get the login for contacts
-- =============================================
ALTER PROCEDURE [dbo].[getContactLogin]
	-- Add the parameters for the stored procedure here
	@EmailAddress varchar(250),
	@Password varchar(150)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT c.*, cr.custrefs FROM [dbo].Contacts c
	left outer join [dbo].ContactCustRefs cr
		on cr.contactid = c.contactid
	WHERE EmailAddress=@EmailAddress AND Password=@Password
END

GO

