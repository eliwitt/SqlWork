USE [ClaimsSchema]
GO
/****** Object:  StoredProcedure [dbo].[sp_propertyreserve]    Script Date: 09/02/2010 10:31:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:        J. Steve Witt
-- Create date: 5/24/2010
-- Description:   Process the reserves for the properties
-- =============================================
CREATE PROCEDURE [dbo].[sp_propertyreserve] 
      @CMastPtr int,
      @Owner    int,
      @ProType  int 
AS

BEGIN
      -- SET NOCOUNT ON added to prevent extra result sets from
      -- interfering with SELECT statements.
      SET NOCOUNT ON;
declare @Debug          int, 
      @MyKey            int, 
      @OwnerEntity      int,
	@OwnerInjured	int,
	@PropEntity		int,
      @PolicyNu         varchar(16),
      @ReserveID        int,
      @AccDt            Datetime,
      @ReOpen           int, 
      @ResType          int,
      @LossType         int,
      @OurVeh           int,
      @OurDrv           int,
      @trapped          int,
      @ErrorMsg         varchar(255)

set @Debug = 0
set @OurDrv = 0
set @OurVeh = 0
-- get the policy number, and DOL from the claim's master row
select @PolicyNu=PolicyNumber, @AccDt=DateOfLoss, @LossType = LossType from CLM_ClaimMaster where id = @CMastPtr
if @Debug>1 print @PolicyNu
if @Debug>1 print @AccDt
-- get the owner entitynumber, wheather he was injured and the property entitynumber
select @OwnerEntity=owner.EntityNumber, @OwnerInjured=owner.injured, @PropEntity=Prop.EntityNumber
	from clm_otherproperty Prop
	left join clm_involvedparty [owner] on Prop.involvedpartyptr = owner.id
where Prop.claimmasterptr = @CMastPtr and owner.id = @Owner
if @Debug>1 print @OwnerEntity
if @Debug>1 print @OwnerInjured
if @Debug>1 print @PropEntity
-- Does the goauto driver have the LIBI coverage for the reserve
select @OurDrv = OurDriverIndex, @OurVeh=OurVehicleIndex from clm_claimvehicle where claimmasterptr =  @CMastPtr and VehicleNumber = 1
-- is the policy active?
select @ReOpen = GoAutoProd.dbo.F_Claims_IsPolicyActive(@PolicyNu,@AccDt)
begin transaction
--
-- a process type of 1 is to close the reserve
--
if @ProType=1
begin
      if @Debug > 1 print 'Close the reserve'
      update CLM_Reserve 
            set ClosedOn = GetDate(), ReserveOpen = 0
            where ClaimNumber = @CMastPtr and EntityNumber = @OwnerEntity 
      if (@@error <> 0)
      begin
            set @trapped = 10
            set @ErrorMsg = 'Error attempting to update the clm_reserve row '
            goto Error_Handler
      end
      goto ReserveEnd
end 
if @LossType > 1
	goto ReserveEnd
if @ReOpen = 0
      goto ReserveEnd
if @Debug > 1 print 'Open the property reserves'
-- the owner is not injured so akip the libi
if @OwnerInjured = 0 
	goto CheckProp

-- if the owner is injured then check if we can give him LIBI
set @ResType = 2

--
-- check LIBI coverage
--
if exists(select id from CLM_Reserve where ClaimNumber = @CMastPtr and EntityNumber = @OwnerEntity and CoverageID = @ResType)
begin
      if @Debug > 1 print 'Reopen the owners reserve'
      update CLM_Reserve 
            set ClosedOn = null, ReserveOpen = @ReOpen, OpenedOn = GetDate()
            where ClaimNumber = @CMastPtr and EntityNumber = @OwnerEntity and CoverageID = @ResType and forcedclosed = 0
      if (@@error <> 0)
      begin
            set @trapped = 20
            set @ErrorMsg = 'Error attempting to update the clm_reserve row '
            goto Error_Handler
      end
end
else
begin
      if @Debug = 1 print 'Insert the owners reserve'
      select @MyKey=Max(ID) from CLM_Reserve
      if (@MyKey is null)
      Begin
            set @MyKey=0
      end
      set @ReserveID=@MyKey+1
      if (GoAutoProd.dbo.F_Claims_IsCoverageActive(@PolicyNu, @AccDt, @OurVeh, @OurDrv, @ResType) > 0) 
      begin
            insert into CLM_Reserve
                  values(@ReserveID, @CMastPtr, @AccDt, @OwnerEntity, @ResType, 
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

CheckProp:
if @Debug > 1 print 'check the property'
--
-- the property gets LIPD
set @ResType = 1
--
-- check LIPD coverage
--
if exists(select id from CLM_Reserve where ClaimNumber = @CMastPtr and EntityNumber = @PropEntity and CoverageID = @ResType)
begin
      if @Debug > 1 print 'Reopen the property reserve'
      update CLM_Reserve 
            set ClosedOn = null, ReserveOpen = @ReOpen, OpenedOn = GetDate()
            where ClaimNumber = @CMastPtr and EntityNumber = @PropEntity and CoverageID = @ResType and forcedclosed = 0
      if (@@error <> 0)
      begin
            set @trapped = 40
            set @ErrorMsg = 'Error attempting to update the clm_reserve row '
            goto Error_Handler
      end
end
else
begin
      if @Debug > 1 print 'Insert the property reserve'
      select @MyKey=Max(ID) from CLM_Reserve
      if (@MyKey is null)
      Begin
            set @MyKey=0
      end
      set @ReserveID=@MyKey+1
      if (GoAutoProd.dbo.F_Claims_IsCoverageActive(@PolicyNu, @AccDt, @OurVeh, @OurDrv, @ResType) > 0) 
      begin
            insert into CLM_Reserve
                  values(@ReserveID, @CMastPtr, @AccDt, @PropEntity, @ResType, 
                        GoAutoProd.dbo.F_Claims_GetReserveAmount(@ResType,@PolicyNu, @AccDt, @OurVeh), 
                        @ReOpen, 0, GetDate(), GetDate(), null, null, 0)
            if (@@error <> 0)
            begin
                  set @trapped = 50
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