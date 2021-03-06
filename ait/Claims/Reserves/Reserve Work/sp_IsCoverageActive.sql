USE [ClaimsSchema_0616]
GO
/****** Object:  StoredProcedure [dbo].[sp_IsCoverageActive]    Script Date: 09/02/2010 10:35:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_IsCoverageActive]
   @PolicyNumber varchar(32),
   @PointInTime datetime,
   @OurVehicleIndex int,
   @OurDriverIndex int,
   @CovID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
declare @Debug          int, 
	  @Covered           int,
	  @Domain			sysname,
	  @myState			nvarchar(4000),
      @ErrorMsg         varchar(255)
set @Debug = 0
set @Covered = 0
--
-- define the results table from the dynamic sql
CREATE TABLE #ctr
( DyRsult int )
-- 
-- retrieve the domain value from the table
select @Domain=[value] from clm_sysvalues where [key] = 'domain'
if @Debug=1 print @Domain
--
-- build the statement GoAutoProd.dbo.F_Claims_IsCoverageActive(@PolicyNu, @AccDt, @OurVeh, @OurGoIdx, 7) using the variables
select @myState = 'insert #ctr values(' + @Domain + 'F_Claims_IsCoverageActive(''' + @PolicyNumber + ''', ''' + cast(@PointInTime as nvarchar(25)) + ''','
select @myState = @myState + cast(@OurVehicleIndex as nvarchar(2)) + ', ' + cast(@OurDriverIndex as nvarchar(2)) + ', ' + cast(@CovID as nvarchar(2)) + '))'
if @Debug=1 print @myState
--
-- is the policy active?
exec(@myState)
IF @@ERROR = 0
BEGIN
     SELECT    @Covered = DyRsult
     FROM #ctr

     DROP TABLE #ctr
END
ELSE
BEGIN
     DROP TABLE #ctr
	 RAISERROR('Error with call to function F_Claims_IsCoverageActive.', 16, 1)
	return
END
if @Debug=1 print @Covered
return @Covered
END
