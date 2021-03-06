USE [ClaimsSchema_0616]
GO
/****** Object:  StoredProcedure [dbo].[sp_propertyreserve]    Script Date: 09/02/2010 10:38:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:        J. Steve Witt
-- Create date: 5/24/2010
-- Description:   Process the reserves for the properties
-- =============================================
ALTER PROCEDURE [dbo].[sp_propertyreserve] 
      @CMastPtr int,
      @Owner    int,
      @ProType  int 
AS

BEGIN
      -- SET NOCOUNT ON added to prevent extra result sets from
      -- interfering with SELECT statements.
      SET NOCOUNT ON;
declare @Debug      int, 
    @MyKey          int, 
    @OwnerEntity    int,
	@OwnerInjured	int,
	@PropEntity		int,
    @PolicyNu       varchar(16),
    @ReserveID      int,
    @AccDt          Datetime,
    @ReOpen         int, 
    @ResType        int,
    @LossType       int,
    @OurVeh         int,
    @OurDrv         int,
    @Result         int,
	@ResAmt			money,    
    @trapped        int,
    @ErrorMsg       varchar(255)

set @Debug = 0
set @OurDrv = 0
set @OurVeh = 0
set @ResType = 0
set @Result = 0
set @ResAmt = 0
-- get the policy number, and DOL from the claim's master row
select @PolicyNu=PolicyNumber, @AccDt=DateOfLoss, @LossType = LossType from CLM_ClaimMaster where id = @CMastPtr
if @Debug>1 print cast(@PolicyNu as nvarchar(10)) + ' ' + cast(@LossType as nvarchar(2))
if @Debug>1 print @AccDt
-- get the owner entitynumber, wheather he was injured and the property entitynumber
select @OwnerEntity=owner.EntityNumber, @OwnerInjured=owner.injured, @PropEntity=Prop.EntityNumber
	from clm_otherproperty Prop
	left join clm_involvedparty [owner] on Prop.involvedpartyptr = owner.id
where Prop.claimmasterptr = @CMastPtr and owner.id = @Owner
if @Debug>1 print 'Entity ' + cast(@OwnerEntity as nvarchar(2))
if @Debug>1 print @OwnerInjured
if @Debug>1 print @PropEntity
-- Does the goauto driver have the LIBI coverage for the reserve
select @OurDrv = OurDriverIndex, @OurVeh=OurVehicleIndex from clm_claimvehicle where claimmasterptr =  @CMastPtr and VehicleNumber = 1
-- is the policy active?
exec @ReOpen = sp_IsPolicyActive @PolicyNu, @AccDt
if @@ERROR > 0 return @@ERROR
if @Debug=1 print @ReOpen
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
exec sp_procreserve @CMastPtr, @OwnerEntity, @ResType, @ReOpen, @PolicyNu, @AccDt, @OurVeh, @OurDrv
if @@ERROR > 0 return @@ERROR

CheckProp:
if @Debug > 1 print 'check the property'
--
-- the property gets LIPD
set @ResType = 1
--
-- check LIPD coverage
--
exec sp_procreserve @CMastPtr, @PropEntity, @ResType, @ReOpen, @PolicyNu, @AccDt, @OurVeh, @OurDrv
if @@ERROR > 0 return @@ERROR

ReserveEnd:
if exists(select id from clm_reserve where claimnumber = @CMastPtr and ReserveOpen = 1)
begin	
	update clm_claimmaster set ReservesClosed = 0 where id = @CMastPtr
end 
else
begin
	update clm_claimmaster set ReservesClosed = 1 where id = @CMastPtr
end

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

END