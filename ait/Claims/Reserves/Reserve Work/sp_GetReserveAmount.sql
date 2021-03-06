USE [ClaimsSchema_0616]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetReserveAmount]    Script Date: 09/02/2010 10:34:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		J. Steve Witt
-- Create date: 9/1/2010
-- Description:	Call the function in the ploicy database using a dynamic domain
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetReserveAmount]
   @ResType int,
   @PolicyNumber varchar(32),
   @PointInTime datetime,
   @OurVehicleIndex int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
declare @Debug          int, 
	  @ResAmt           money,
	  @Domain			sysname,
	  @myState			nvarchar(4000),
      @ErrorMsg         varchar(255)
set @Debug = 0
set @ResAmt = 0    -- Insert statements for procedure here
--
-- define the results table from the dynamic sql
CREATE TABLE #ctr
( DyRsult int )
-- 
-- retrieve the domain value from the table
select @Domain=[value] from clm_sysvalues where [key] = 'domain'
if @Debug=1 print @Domain
--
-- build the statement GoAutoProd.dbo.F_Claims_GetReserveAmount(@ResType,@PolicyNu, @AccDt, @OurVeh) using the variables
select @myState = 'insert #ctr values(' + @Domain + 'F_Claims_GetReserveAmount(''' + cast(@ResType as nvarchar(1)) + ''', ''' + @PolicyNumber + ''', ''' + cast(@PointInTime as nvarchar(25)) + ''','
select @myState = @myState + cast(@OurVehicleIndex as nvarchar(2)) + '))'
if @Debug=1 print @myState
--
-- is the policy active?
exec(@myState)
IF @@ERROR = 0
BEGIN
     SELECT    @ResAmt = DyRsult
     FROM #ctr

     DROP TABLE #ctr
END
ELSE
BEGIN
     DROP TABLE #ctr
	 RAISERROR('Error with call to function F_Claims_GetReserveAmount.', 16, 1)
	return
END
if @Debug=1 print @ResAmt
return @ResAmt
END
