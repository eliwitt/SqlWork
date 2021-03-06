USE [ClaimsSchema]
GO
/****** Object:  StoredProcedure [dbo].[sp_nonreserves]    Script Date: 09/02/2010 10:30:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================

-- Author:        J. Steve Witt

-- Create date: 5/11/2010

-- Description:   Process Non-accident reserves

-- =============================================

CREATE PROCEDURE [dbo].[sp_nonreserves] 

      @ClaimID int,

      @VehNu      int, 

      @MyEntity   int

AS

BEGIN

      -- SET NOCOUNT ON added to prevent extra result sets from

      -- interfering with SELECT statements.

      SET NOCOUNT ON;

declare 

      @PolicyNu         nvarchar(8),

      @AccDt                  Datetime,

      @LossType         int,

      @OurVeh                 int,

      @OurDrv                 int,

      @ReOpen                 int,

      @ReserveID        int,

      @ResType          int,

      @MyKey                  int, 

      @ClaimLia   tinyint,

      @Debug                  int,

      @trapped          int,

      @ErrorMsg         varchar(255)

set @Debug = 0

set @OurVeh = 0

set @OurDrv = 0

--

-- get the nextentity, policy number, and DOL from the claim's master row

--

select @PolicyNu=PolicyNumber, @AccDt=DateOfLoss, @LossType = LossType from CLM_ClaimMaster where id = @ClaimID

-- get the GoAuto OurVeh 

select @OurVeh=OurVehicleIndex from CLM_ClaimVehicle where ClaimMasterPTR = @ClaimID and VehicleNumber = 1

select @OurDrv=OurDriverIndex from clm_vehiclepassenger where ClaimMasterPTR = @ClaimID and VehicleNumber = 1

--

-- is the policy active?

--

set @ReOpen = 0

select @ReOpen = GoAutoProd.dbo.F_Claims_IsPolicyActive(@PolicyNu,@AccDt)

if @Debug=1 Print @ReOpen

--

-- begin the trans

--

begin transaction

-- 

-- policy is not enforce

--

if @ReOpen = 0

      goto NoReserve

--

-- what type of claim do we have

--

if @LossType = 6

begin

      set @ResType = 4

end
if @LossType = 7

begin

      set @ResType = 5

end
else

begin

      set @ResType = 3

end

--

-- does the acc type of 3, 4, 5 get Comp while 6 gets Coll 7 is towing only

--

if exists(select id from CLM_Reserve where ClaimNumber = @ClaimID and EntityNumber = @MyEntity and CoverageID = @ResType)

begin

      if @Debug = 1 print 'Reopen the reserve'

      update CLM_Reserve 

            set ClosedOn = null, ReserveOpen = @ReOpen, OpenedOn = GetDate()

            where ClaimNumber = @ClaimID and EntityNumber = @MyEntity and CoverageID = @ResType

      if (@@error <> 0)

      begin

            set @trapped = 10

            set @ErrorMsg = 'Error attempting to update the clm_reserve row '

            goto Error_Handler

      end

end

else

begin

      select @MyKey=Max(ID) from CLM_Reserve

      if (@MyKey is null)

      Begin

            set @MyKey=0

      end

      set @ReserveID=@MyKey+1

      if (GoAutoProd.dbo.F_Claims_IsCoverageActive(@PolicyNu, @AccDt, @OurVeh, @OurDrv, @ResType) > 0) 

      begin

            if @Debug=1 Print 'Insert Comp/Coll with reserves'

            insert into CLM_Reserve

                  values(@ReserveID, @ClaimID, @AccDt, @MyEntity, @ResType, 

                        GoAutoProd.dbo.F_Claims_GetReserveAmount(@ResType, @PolicyNu, @AccDt, @OurVeh), 
                        @ReOpen, 0, GetDate(), GetDate(), null, null, 0)

            if (@@error <> 0)

            begin

                  set @trapped = 15

                  set @ErrorMsg = 'Error attempting to insert the clm_Reserve row '

                  goto Error_Handler

            end

      end

end
--
-- Hit and Other may receive rental
--
if @LossType = 4
	goto Rental
if @LossType = 6
	goto Rental
goto NoReserve
Rental:
--

-- does the policy cover Rental for Acc Type Hit an animal?

--

if exists(select id from CLM_Reserve where ClaimNumber = @ClaimID and EntityNumber = @MyEntity and CoverageID = 6)

begin

      if @Debug = 1 print 'Reopen the reserve'

      update CLM_Reserve 

            set ClosedOn = null, ReserveOpen = @ReOpen, OpenedOn = GetDate()

            where ClaimNumber = @ClaimID and EntityNumber = @MyEntity and CoverageID = 6 and forcedclosed = 0

      if (@@error <> 0)

      begin

            set @trapped = 60

            set @ErrorMsg = 'Error attempting to update the clm_reserve row '

            goto Error_Handler

      end

end

else

begin

      select @MyKey=Max(ID) from CLM_Reserve

      if (@MyKey is null)

      Begin

            set @MyKey=0

      end

      set @ReserveID=@MyKey+1

      if (GoAutoProd.dbo.F_Claims_IsCoverageActive(@PolicyNu, @AccDt, @OurVeh, @OurDrv, 6) > 0) 

      begin

            if @Debug=1 Print 'Insert Rental with reserves'

            insert into CLM_Reserve

                  values(@ReserveID, @ClaimID, @AccDt, @MyEntity, 6, 

                        GoAutoProd.dbo.F_Claims_GetReserveAmount(6,@PolicyNu, @AccDt, @OurVeh), 
                        @ReOpen, 0, GetDate(), GetDate(), null, null, 0)

            if (@@error <> 0)

            begin

                  set @trapped = 65

                  set @ErrorMsg = 'Error attempting to insert the clm_Reserve row '

                  goto Error_Handler

            end

      end

end

--

-- the end of the NAF reserve checks

--

NoReserve:

if @Debug=1 print 'At the end'

commit transaction;

return

--

-- bottom of the script

--

Error_Handler:

if @Debug > 5

      print 'In the Error Handler'

IF @ErrorMsg IS NOT NULL

BEGIN

      SELECT @ErrorMsg = 'Claim Update script insertclaimveh: ' + @ErrorMsg + '  ' + convert(varchar(10), @trapped)

      -- Using "with log" inserts a message into the event log

       RAISERROR(@ErrorMsg, 11, 1) with log 

      --    RAISERROR(@ErrorMsg, 11, 1)

      --return 21

END

rollback

END