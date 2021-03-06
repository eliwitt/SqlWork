USE [ClaimsSchema_0616]
GO
/****** Object:  StoredProcedure [dbo].[sp_IsPolicyActive]    Script Date: 09/02/2010 10:36:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		J. Steve Witt
-- Create date: 08/26/2010
-- Description:	Dynamic call to the Goauto function
-- =============================================
CREATE PROCEDURE [dbo].[sp_IsPolicyActive] 
      @PolicyId		nvarchar(60),
      @Dol			datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
declare @Debug          int, 
	  @ReOpen           int,
	  @Domain			sysname,
	  @myState			nvarchar(4000),
      @ErrorMsg         varchar(255)
set @Debug = 0
set @ReOpen = 0
--
-- define the results table from the dynamic sql
CREATE TABLE #ctr
( DyRsult int )
-- 
-- retrieve the domain value from the table
select @Domain=[value] from clm_sysvalues where [key] = 'domain'
if @Debug=1 print 'Domain ' + @Domain
--
-- build the statement GoAutoProd.dbo.F_Claims_IsPolicyActive(@PolicyNu,@AccDt) using the variables
select @myState = 'insert #ctr values(' + @Domain + 'F_Claims_IsPolicyActive(''' + @PolicyId + ''', ''' + cast(@Dol as nvarchar(25)) + '''))'
if @Debug=1 print @myState
--
-- is the policy active?
exec(@myState)
IF @@ERROR = 0
BEGIN
     SELECT    @ReOpen = DyRsult
     FROM #ctr

     DROP TABLE #ctr
END
ELSE
BEGIN
     DROP TABLE #ctr
	 RAISERROR('Error with call to function F_Claims_IsPolicyActive.', 16, 1)
	return
END
if @Debug=1 print @ReOpen
return @ReOpen
END
