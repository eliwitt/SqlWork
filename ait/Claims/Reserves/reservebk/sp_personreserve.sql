USE [ClaimsSchema]
GO
/****** Object:  StoredProcedure [dbo].[sp_personreserve]    Script Date: 09/02/2010 10:31:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================

-- Author:        J. Steve Witt

-- Create date: 4/16/2010

-- Description:   Either remove or insert the reserve for a person

-- =============================================

CREATE PROCEDURE [dbo].[sp_personreserve] 

      @CMastPtr int,

      @Person           int,

      @ProType    int 

AS

BEGIN

      -- SET NOCOUNT ON added to prevent extra result sets from

      -- interfering with SELECT statements.

      SET NOCOUNT ON;

declare @Debug          int, 

      @MyKey                  int, 

      @PersonEntity           int,

      @PolicyNu         varchar(16),

      @ReserveID        int,

      @AccDt                  Datetime,

      @ReOpen                 int, 

      @ResType          int,

      @LossType         int,
		@LossRole			int,
      @OurVeh                 int,

      @OurGoIdx         int,

      @OurDrv                 int,

      @VehNu                  int,

      @ClaimLia         int,

      @trapped          int,

      @ErrorMsg         varchar(255)

set @Debug = 0

set @OurDrv = 0

set @OurGoIdx = 0

set @OurVeh = 0

-- get the policy number, and DOL from the claim's master row

select @PolicyNu=PolicyNumber, @AccDt=DateOfLoss, @LossType = LossType from CLM_ClaimMaster where id = @CMastPtr

if @Debug=1 print @PolicyNu

if @Debug=1 print @AccDt

-- get the involved parties' entitynumber

select @PersonEntity=EntityNumber, @LossRole=LossRoleid from CLM_InvolvedParty where id = @Person

-- is this person the goauto driver? if so he gets MED not LIBI

-- and what car is he in?

select @OurDrv = OurDriverIndex, @VehNu = VehicleNumber from clm_vehiclepassenger where involvedpartyptr = @Person

-- is the policy active?

select @ReOpen = GoAutoProd.dbo.F_Claims_IsPolicyActive(@PolicyNu,@AccDt)

if @Debug=1 print @PersonEntity

begin transaction

--

-- a process type of 1 is to close the reserve

--

if @ProType=1

begin

      if @Debug = 1 print 'Close the reserve'

      update CLM_Reserve 

            set ClosedOn = GetDate(), ReserveOpen = 0

            where ClaimNumber = @CMastPtr and EntityNumber = @PersonEntity 

      if (@@error <> 0)

      begin

            set @trapped = 10

            set @ErrorMsg = 'Error attempting to update the clm_reserve row '

            goto Error_Handler

      end

      goto ReserveEnd

end 

if @ReOpen = 0

      goto ReserveEnd

--

-- do we have an exitsing row for the given person

--

-- get the GoAuto OurVeh 

select @OurVeh=OurVehicleIndex from CLM_ClaimVehicle where ClaimMasterPTR = @CMastPtr and VehicleNumber = 1

-- get the index for the driver of the goauto vehicle

select @OurGoIdx=OurDriverIndex from clm_vehiclepassenger where ClaimMasterPTR = @CMastPtr and VehicleNumber = 1

-- person is a passenger LIBI
set @resType = 2

if @LossType = 1
begin

	if @LossRole = 1
	begin
		if @OurDrv>0  

		begin

		-- person is the goauto driver MED

		  set @ResType = 7
		end
	end
end

--

-- if the claim is NAF then everyone in the goauto car gets UMBI

--

if @LossType = 2

begin

      --

      -- Only people in the goauto car gets UMBI

      --

      if @VehNu > 1

            goto ReserveEnd

            --

      -- we need to check the other vehicle that caused the injures DID NOT HAVE liability

      --

      set @ClaimLia = 0

      select @ClaimLia=Liability from clm_claimvehicle where claimmasterptr = @CMastPtr and Liability = 1

	-- check the umbi coverage

	if (GoAutoProd.dbo.F_Claims_IsCoverageActive(@PolicyNu, @AccDt, @OurVeh, @OurGoIdx, 8) > 0)
	begin
		if @ClaimLia = 0 
		begin
			set @ResType = 8
		end
		else
		begin
			if (GoAutoProd.dbo.F_Claims_IsCoverageActive(@PolicyNu, @AccDt, @OurVeh, @OurGoIdx, 7) > 0)
			begin
				set @Restype = 7
			end
			else
			begin
				goto ReserveEnd
			end
		end
	end
	else
	begin
		if (GoAutoProd.dbo.F_Claims_IsCoverageActive(@PolicyNu, @AccDt, @OurVeh, @OurGoIdx, 7) > 0)
		begin
			set @Restype = 7
		end
		else
		begin
				goto ReserveEnd
		end
	end

end

--

-- check LIBI, MED, or UMBI(NAF) coverage

--

if exists(select id from CLM_Reserve where ClaimNumber = @CMastPtr and EntityNumber = @PersonEntity and CoverageID = @ResType)

begin

      if @Debug = 1 print 'Reopen the reserve'

      update CLM_Reserve 

            set ClosedOn = null, ReserveOpen = @ReOpen, OpenedOn = GetDate()

            where ClaimNumber = @CMastPtr and EntityNumber = @PersonEntity and CoverageID = @ResType and forcedclosed = 0

      if (@@error <> 0)

      begin

            set @trapped = 20

            set @ErrorMsg = 'Error attempting to update the clm_reserve row '

            goto Error_Handler

      end

      goto ReserveEnd

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

      if (GoAutoProd.dbo.F_Claims_IsCoverageActive(@PolicyNu, @AccDt, @OurVeh, @OurGoIdx, @ResType) > 0) 

      begin

            insert into CLM_Reserve

                  values(@ReserveID, @CMastPtr, @AccDt, @PersonEntity, @ResType, 

                        GoAutoProd.dbo.F_Claims_GetReserveAmount(@ResType,@PolicyNu, @AccDt, @OurVeh), 
                        @ReOpen, 0, GetDate(), GetDate(), null, null, 0)

            if (@@error <> 0)

            begin

                  set @trapped = 30

                  set @ErrorMsg = 'Error attempting to insert the clm_reserve row '

                  goto Error_Handler

            end

      end

end

ReserveEnd:

if exists(select id from clm_reserve where claimnumber = @CMastPtr and ReserveOpen = 1)
begin	
	update clm_claimmaster set ReservesClosed = 0 where id = @CMastPtr
end 
else
begin
	update clm_claimmaster set ReservesClosed = 1 where id = @CMastPtr
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

      SELECT @ErrorMsg = 'Claim Update script personreserve: ' + @ErrorMsg + '  ' + convert(varchar(10), @trapped)

      -- Using "with log" inserts a message into the event log

       RAISERROR(@ErrorMsg, 11, 1) with log 

      --    RAISERROR(@ErrorMsg, 11, 1)

      --return 21

END

if @trapped > 9

      rollback

END