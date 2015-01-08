USE [VPI_Online]
GO

/****** Object:  StoredProcedure [dbo].[updContactCustRefs]    Script Date: 10/09/2012 10:59:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Flynn Williford
-- Create date: 10/02/2012
-- Description:	Updates a contact's Customer References
-- =============================================
CREATE PROCEDURE [dbo].[updContactCustRefs] 
	@ContactId int,
	@CustomerRefs varchar(255)
AS
BEGIN
	UPDATE [dbo].ContactCustRefs
	SET custrefs = @CustomerRefs
	WHERE contactid = @ContactId
END

GO

