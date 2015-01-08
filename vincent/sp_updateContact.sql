USE [VPI_Online]
GO

/****** Object:  StoredProcedure [dbo].[updateContact]    Script Date: 10/09/2012 11:00:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =========================================================
-- Create date: 10/26/2011
-- Description:	Updates contacts data in database.
-- =========================================================

ALTER PROCEDURE [dbo].[updateContact] 
	@ContactId int,
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
UPDATE dbo.Contacts 
SET		
	firstName = @FirstName,
	lastLogin = @LastLogin,
	lastName= @LastName,
	emailaddress = @EmailAddress,
	companyid = @CompanyID,
	password=@Password,
	isActive = @isActive,
	isDaily=@isDaily,
	isWeekly = @isWeekly
WHERE
	contactid = @ContactId

UPDATE dbo.ContactCustRefs
SET
	custrefs = @CustomerRefs
WHERE
	contactid = @ContactId

IF @@ROWCOUNT = 0
	INSERT INTO dbo.ContactCustRefs (contactid, custrefs)
	VALUES (@ContactId, @CustomerRefs)


GO

