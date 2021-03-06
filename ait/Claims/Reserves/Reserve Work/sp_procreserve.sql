/****** Object:  StoredProcedure [dbo].[sp_procreserve]    Script Date: 09/02/2010 10:38:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		J. Steve Witt
-- Create date: 9/1/2010
-- Description:	Process the reserve
-- =============================================
CREATE PROCEDURE [dbo].[sp_procreserve] 
	@CMastPtr	int,
	@EntityPtr	int,
	@ResType	int,
	@ReOpen		int,
	@PolicyNu	varchar(16), 
	@AccDt		Datetime, 
	@OurVeh		int, 
	@OurDrv		int
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
declare @Debug          int, 
      @MyKey            int, 
      @ReserveID        int,
      @Result           int,
	  @ResAmt			money,
      @trapped          int,
      @ErrorMsg         varchar(255)

set @Debug = 0
set @Result = 0
set @ResAmt = 0
set @MyKey = 0
set @ReserveID = 0
begin transaction
if exists(select id from CLM_Reserve where ClaimNumber = @CMastPtr and EntityNumber = @EntityPtr and CoverageID = @ResType)
begin

      if @Debug = 1 print 'Reopen the reserve'
      update CLM_Reserve 
            set ClosedOn = null, ReserveOpen = @ReOpen, OpenedOn = GetDate()
            where ClaimNumber = @CMastPtr and EntityNumber = @EntityPtr and CoverageID = @ResType and forcedclosed = 0

      if (@@error <> 0)
      begin
            set @trapped = 10
            set @ErrorMsg = 'Error attempting to update the clm_reserve row '
            goto Error_Handler
      end
end
else
begin

    if @Debug = 1 print 'Insert the reserve'
    select @MyKey=Max(ID) from CLM_Reserve
    if (@MyKey is null)
    Begin
          set @MyKey=0
    end

    set @ReserveID=@MyKey+1
	exec @Result = sp_IsCoverageActive @PolicyNu, @AccDt, @OurVeh, @OurDrv, @ResType
	if (@Result > 0)
    begin
		exec @ResAmt = sp_GetReserveAmount @ResType, @PolicyNu, @AccDt, @OurVeh
		if @Debug = 1 print 'The amount we would use is ' + cast(@ResAmt as nvarchar(8))
		insert into CLM_Reserve
			values(@ReserveID, @CMastPtr, @AccDt, @EntityPtr, @ResType, 
				@ResAmt, @ReOpen, 0, GetDate(), GetDate(), null, null, 0)

		if (@@error <> 0)
        begin
			set @trapped = 20
            set @ErrorMsg = 'Error attempting to insert the clm_reserve row '
            goto Error_Handler
        end
    end
end
commit transaction
return

--
-- bottom of the script
--
Error_Handler:

if @Debug > 5
      print 'In the Error Handler'

IF @ErrorMsg IS NOT NULL
BEGIN
      SELECT @ErrorMsg = 'Claim Update script procreserve: ' + @ErrorMsg + '  ' + convert(varchar(10), @trapped)
      -- Using "with log" inserts a message into the event log
       RAISERROR(@ErrorMsg, 11, 1) with log 
      --    RAISERROR(@ErrorMsg, 11, 1)
      --return 21
END

if @trapped > 9
      rollback

END
