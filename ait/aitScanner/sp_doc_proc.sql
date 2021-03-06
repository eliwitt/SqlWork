USE [myTempDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_doc_proc]    Script Date: 12/18/2009 15:21:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Steve Witt
-- Create date: 11/12/2009
-- Description:	This procedure will insert or modify the 
--              given document's image
-- =============================================
ALTER PROCEDURE [dbo].[sp_doc_proc] 
	-- Add the parameters for the stored procedure here
	@empptr int, @offptr int, @imgType bit,
	@bardata nvarchar(11), 
	@imagepic Image
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
declare @myPolicyPtr int, @mydocType int,
@mydocPtr nvarchar(6)
set @myPolicyPtr = substring(@bardata,1,7)
set @mydocPtr = substring(@bardata,8,4)
select @mydocType =
	case  
		when @mydocPtr = 'DEC' then 2
		when @mydocPtr like 'FC%' then 4
		when @mydocPtr like 'AP%' then 1
		when @mydocPtr = 'UM01' then 6
		else 0
	end
if exists(select ImageBarData from ScannedDocuments
		where EmployeePTR = @empptr
		and OfficePTR = @offptr
		and ImageType = @imgType
		and ImageBarData = @bardata
	)
	begin
	update ScannedDocuments set ImagePic = @imagepic
		where EmployeePTR = @empptr
		and OfficePTR = @offptr
		and ImageType = @imgType
		and ImageBarData = @bardata
	end
else
	begin
	insert into ScannedDocuments (EmployeePTR, OfficePTR, ImageType, ImageBarData, ImagePic, DocType, PolicyPTR, DocDescription) 
		values (@empptr, @offptr, @imgType, @bardata, @imagepic, @mydocType, @myPolicyPtr, '')
	end
if (@imgType = 1)
	begin
	delete from ScannedDocuments where EmployeePTR = @empptr and
		OfficePTR = @offptr and ImageType = 0 and ImageBarData like @bardata + '%'
	end
END
