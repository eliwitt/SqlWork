USE [ClaimsSchema]
GO
/****** Object:  StoredProcedure [dbo].[sp_bulkreserve]    Script Date: 06/02/2010 11:33:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================

-- Author:        J. Steve Witt

-- Create date: 4/29/2010

-- Description:   Given the claim, vehicle, and veh entity numbers in the reserve

-- =============================================

ALTER PROCEDURE [dbo].[sp_bulkreserve] 

      @ClaimID int,

      @VehNu      int, 

      @MyEntity   int

AS

BEGIN

      -- SET NOCOUNT ON added to prevent extra result sets from

      -- interfering with SELECT statements.

      SET NOCOUNT ON;

declare 

      @PolicyNu         varchar(16),

      @AccDt                  Datetime,

      @LossType         int,

      @OurVeh                 int,

      @OurDrv                 int,

      @ReOpen                 int,

      @ReserveID        int,

      @ResType          int,

      @MyKey                  int, 
	  @NeedATow			int,

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

if @LossType > 2

begin

      exec sp_nonreserves @ClaimID, @VehNu, @MyEntity

      goto NoCommit

end

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

-- is this an Not At Fault NAF claim

--

if @LossType = 2

      goto NAFCk

--

-- our vehicle does not get this coverage

--

if @VehNu = 1 

      goto SkipLIPD

-- does the policy have LIPD coverage

if exists(select id from CLM_Reserve where ClaimNumber = @ClaimID and EntityNumber = @MyEntity and CoverageID = 1)

begin

      if @Debug = 1 print 'Reopen the reserve'

      update CLM_Reserve 

            set ClosedOn = null, ReserveOpen = @ReOpen, OpenedOn = GetDate()

            where ClaimNumber = @ClaimID and EntityNumber = @MyEntity and CoverageID = 1 and forcedclosed = 0

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

      if (GoAutoProd.dbo.F_Claims_IsCoverageActive(@PolicyNu, @AccDt, @OurVeh, @OurDrv, 1) > 0) 

      begin

            if @Debug=1 Print 'Insert LIPD with reserves'

          insert into CLM_Reserve

                  values(@ReserveID, @ClaimID, @AccDt, @MyEntity, 1, 

                        GoAutoProd.dbo.F_Claims_GetReserveAmount(1), @ReOpen, 0, GetDate(), GetDate(), null, null, 0)

            if (@@error <> 0)

            begin

                  set @trapped = 15

                  set @ErrorMsg = 'Error attempting to insert the clm_Reserve row '

                  goto Error_Handler

            end

      end

end

--

SkipLIPD:

--

-- check for other coverage the policy might cover only for our vehicle

--

if @VehNu > 1 

      goto NoReserve

--

-- does the policy cover COLL?

--

if exists(select id from CLM_Reserve where ClaimNumber = @ClaimID and EntityNumber = @MyEntity and CoverageID = 4)

begin

      if @Debug = 1 print 'Reopen the reserve'

      update CLM_Reserve 

            set ClosedOn = null, ReserveOpen = @ReOpen, OpenedOn = GetDate()

            where ClaimNumber = @ClaimID and EntityNumber = @MyEntity and CoverageID = 4 and forcedclosed = 0

      if (@@error <> 0)

      begin

            set @trapped = 40

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

      if (GoAutoProd.dbo.F_Claims_IsCoverageActive(@PolicyNu, @AccDt, @OurVeh, @OurDrv, 4) > 0) 

      begin

            if @Debug=1 Print 'Insert COLL with reserves'

            insert into CLM_Reserve

                  values(@ReserveID, @ClaimID, @AccDt, @MyEntity, 4, 

                        GoAutoProd.dbo.F_Claims_GetReserveAmount(4), @ReOpen, 0, GetDate(), GetDate(), null, null, 0)

            if (@@error <> 0)

            begin

                  set @trapped = 45

                  set @ErrorMsg = 'Error attempting to insert the clm_Reserve row '

                  goto Error_Handler

            end

      end

end

--

-- does the policy cover Towing?

--

if exists(select id from CLM_Reserve where ClaimNumber = @ClaimID and EntityNumber = @MyEntity and CoverageID = 5)

begin

      if @Debug = 1 print 'Reopen the reserve'

      update CLM_Reserve 

            set ClosedOn = null, ReserveOpen = @ReOpen, OpenedOn = GetDate()

            where ClaimNumber = @ClaimID and EntityNumber = @MyEntity and CoverageID = 5 and forcedclosed = 0

      if (@@error <> 0)

      begin

            set @trapped = 50

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

      if (GoAutoProd.dbo.F_Claims_IsCoverageActive(@PolicyNu, @AccDt, @OurVeh, @OurDrv, 5) > 0) 

      begin

            if @Debug=1 Print 'Insert Towing with reserves'

            insert into CLM_Reserve

                  values(@ReserveID, @ClaimID, @AccDt, @MyEntity, 5, 

                        GoAutoProd.dbo.F_Claims_GetReserveAmount(5), @ReOpen, 0, GetDate(), GetDate(), null, null, 0)

            if (@@error <> 0)

            begin

                  set @trapped = 55

                  set @ErrorMsg = 'Error attempting to insert the clm_Reserve row '

                  goto Error_Handler

            end

      end

end

--

-- does the policy cover Rental?

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

                        GoAutoProd.dbo.F_Claims_GetReserveAmount(6), @ReOpen, 0, GetDate(), GetDate(), null, null, 0)

            if (@@error <> 0)

            begin

                  set @trapped = 65

                  set @ErrorMsg = 'Error attempting to insert the clm_Reserve row '

                  goto Error_Handler

            end

      end

end

--

-- bottom of the AF reserves

--

goto NoReserve

--

-- For NAF check for the UMPD coverage

--

NAFCk:

--

-- only the GoAuto vehicle gets UMPD

--

if @VehNu > 1 

      goto NoReserve

--

-- check that the claim has a vehicle that did not have liability

--

set @ClaimLia = 0

select @ClaimLia=Liability from clm_claimvehicle where claimmasterptr = @ClaimID and Liability = 1

if @ClaimLia = 0

begin

      -- give Coll if there is no liability

      set @ReOpen = 1

      set @ResType = 4

end

else

begin

      set @ReOpen = 1

      set @ResType = 9

end

--

-- get the next id from the reserve table

--

select @MyKey=Max(ID) from CLM_Reserve

if (@MyKey is null)

Begin

      set @MyKey=0

end

set @ReserveID=@MyKey+1

--

-- does the policy cover UMPD or Coll?

--

if exists(select id from CLM_Reserve where ClaimNumber = @ClaimID and EntityNumber = @MyEntity and CoverageID = @ResType)

begin

      if @Debug = 1 print 'Reopen the reserve'

      update CLM_Reserve 

            set ClosedOn = null, ReserveOpen = @ReOpen, OpenedOn = GetDate()

            where ClaimNumber = @ClaimID and EntityNumber = @MyEntity and CoverageID = @ResType and forcedclosed = 0

      if (@@error <> 0)

      begin

            set @trapped = 90

            set @ErrorMsg = 'Error attempting to update the clm_reserve row '

            goto Error_Handler

      end

end

else

begin

      if (GoAutoProd.dbo.F_Claims_IsCoverageActive(@PolicyNu, @AccDt, @OurVeh, @OurDrv, @ResType) > 0) 

      begin

            if @Debug=1 Print 'Insert UMPD/Coll with reserves'

            insert into CLM_Reserve

                  values(@ReserveID, @ClaimID, @AccDt, @MyEntity, @ResType, 

                        GoAutoProd.dbo.F_Claims_GetReserveAmount(@ResType), @ReOpen, 0, GetDate(), GetDate(), null, null, 0)

            if (@@error <> 0)

            begin

                  set @trapped = 95

                  set @ErrorMsg = 'Error attempting to insert the clm_Reserve row '

                  goto Error_Handler

            end

      end

end
--

-- does the policy cover Towing?

--

if exists(select id from CLM_Reserve where ClaimNumber = @ClaimID and EntityNumber = @MyEntity and CoverageID = 5)

begin

      if @Debug = 1 print 'Reopen the reserve'

      update CLM_Reserve 

            set ClosedOn = null, ReserveOpen = @ReOpen, OpenedOn = GetDate()

            where ClaimNumber = @ClaimID and EntityNumber = @MyEntity and CoverageID = 5 and forcedclosed = 0

      if (@@error <> 0)

      begin

            set @trapped = 50

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

      if (GoAutoProd.dbo.F_Claims_IsCoverageActive(@PolicyNu, @AccDt, @OurVeh, @OurDrv, 5) > 0) 

      begin

            if @Debug=1 Print 'Insert Towing with reserves'

            insert into CLM_Reserve

                  values(@ReserveID, @ClaimID, @AccDt, @MyEntity, 5, 

                        GoAutoProd.dbo.F_Claims_GetReserveAmount(5), @ReOpen, 0, GetDate(), GetDate(), null, null, 0)

            if (@@error <> 0)

            begin

                  set @trapped = 55

                  set @ErrorMsg = 'Error attempting to insert the clm_Reserve row '

                  goto Error_Handler

            end

      end

end

--

-- does the policy cover Rental?

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

                        GoAutoProd.dbo.F_Claims_GetReserveAmount(6), @ReOpen, 0, GetDate(), GetDate(), null, null, 0)

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

NoCommit:

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

