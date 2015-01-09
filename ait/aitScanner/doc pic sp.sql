-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
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
CREATE PROCEDURE sp_doc_proc 
	-- Add the parameters for the stored procedure here
	@docbar nchar(11), 
	@docimage Image
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
if exists(select imageDocID from docpics where imageDocID = @docbar)
	begin
	update docpics set imagePic = @docimage where imageDocID = @docbar
	end
else
	begin
	insert into docpics (imageDocID, imagePic) values (@docbar, @docimage)
	end
END
GO
