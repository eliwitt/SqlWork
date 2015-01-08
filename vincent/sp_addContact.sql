USE [VPI_Online]
GO

/****** Object:  StoredProcedure [dbo].[addContact]    Script Date: 10/09/2012 11:05:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Vidhya Balasubramanian
-- Create date: 10/26/2011
-- Description:	Inserts contacts into database.
-- =============================================

ALTER PROCEDURE [dbo].[addContact] 
	@FirstName varchar(50),
	@LastName varchar(50),
	@EmailAddress varchar(50),
	@CompanyID varchar(50),
	@CustomerRefs varchar(255),
	@Password varchar(50),
	@isActive bit,
	@LastLogin datetime,
	@isDaily bit,
	@isWeekly bit
	
AS
BEGIN
	
	INSERT INTO dbo.Contacts
			
			(firstName, lastName, emailaddress, companyid, password, isActive,lastLogin,isDaily,isWeekly)
	VALUES 
			(@FirstName, @LastName, @EmailAddress, @CompanyID, @Password, @isActive,@LastLogin,@isDaily,@isWeekly)	
			
	INSERT INTO dbo.ContactCustRefs (contactid, custrefs)
	VALUES (@@IDENTITY, @CustomerRefs)	
END

GO

