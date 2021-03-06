USE [rTALIS]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetBeneficiaryList]    Script Date: 04/20/2009 11:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jahan Abdul
-- Create date: 4/8/08
-- Description:	Minimize reliance on the Main Form's Beneficiary Navigator,
--				If the user desires
-- =============================================
ALTER PROCEDURE [dbo].[usp_GetBeneficiaryList] 
	-- Add the parameters for the stored procedure here
	@AppealNumber varchar(15) 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Benc.HIC, 
		case 
			when Benc.LastName is null then
				Beni.LastName
			else
				Benc.LastName
		end LastName, 
		case 
			when Benc.FirstName is null then
				Beni.FirstName
			else
				Benc.FirstName
		end FirstName
	FROM BeneficiaryCollections Benc
		INNER JOIN Beneficiaries Beni ON Benc.HIC = Beni.HIC
	WHERE AppealNumber = @AppealNumber
	ORDER BY LastName
END
