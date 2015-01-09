USE [BSMS]
GO

/****** Object:  StoredProcedure [wAppParts].[PartsSearch]    Script Date: 03/15/2013 13:45:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		J. Steve Witt
-- Create date: 3/8/2013
-- Description:	Given the equipment number gather all parts that
-- have be recorded in all of the WOs associated with this equipment.
-- =============================================
CREATE PROCEDURE [wAppParts].[PartsSearch]
@equipnu int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
if (@equipnu = 0)

	select null 'Z Number', null 'Manufacturer Number', null 'Description'
else
	select distinct sp2vwnumber 'Z Number', sp2mfgid 'Manufacturer Number', sp2shortsapdescr 'Description'
	from sp.UsageList UL
	left outer join sp.SPMaster2 on ULSPLink = sp2id
	where ULTableLink in (select disid from wo.WorkOrderMain where DISEquip = @equipnu) and ULListType = 1
END

GO

