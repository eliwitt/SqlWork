declare @myVnu                int,
      @AccDt            datetime,
	  @ClaimNumber			  varchar(20),
	  @LossType     int,
      @myEnu                  int, 
      @myPer                  int,
	  @myOwner				  int,
	  @debug		int,
      @myInjured        int
set @debug = 0
-- policy 30390
--set @CMastPtr = 15
--update CLM_ClaimMaster set LossType = 1 where ID = @CMastPtr
--select * from clm_losstypes
--select * from CLM_Coverage
--
-- for now I will get this from the claimmaster it will be passed as a variable
--
select @LossType = LossType, @AccDt = DateOfLoss from CLM_ClaimMaster where id = @CMastPtr
if @LossType < 3
	goto SetAFNAF
if @LossType = 3 or @LossType = 4 or @LossType = 5 
	goto SetNON
if @LossType = 6 
	goto SetHit
if @LossType = 7
	goto SetTow	
SetAFNAF:
if @debug = 1 print 'Set the loss types of 1 and 2'
--
-- for loss type 1 and 2 open lipd(1), libi(2)(If injured), coll(4), umbi(8)(If injured), umpd(9), med(7)(If injured)
--
update CLM_Reserve set ReserveOpen = 1, ClosedOn = null, forcedclosed = 0 
	where ClaimNumber = @CMastPtr and CoverageID in (1, 4, 9)
--
-- open injured people
--
update CLM_Reserve set ReserveOpen = 1, ClosedOn = null, forcedclosed = 0 
	from clm_reserve res
		join CLM_VehiclePassenger vehpass on res.ClaimNumber = vehpass.ClaimMasterPTR
		join clm_involvedparty ent on vehpass.involvedpartyptr = ent.id and res.EntityNumber = ent.EntityNumber
	where ClaimNumber = @CMastPtr and CoverageID in (2, 7, 8) and ent.Injured = 1
--
-- open injured property owners
--
update CLM_Reserve set ReserveOpen = 1, ClosedOn = null, forcedclosed = 0 
		from clm_reserve res
			join CLM_OtherProperty other on res.ClaimNumber = other.ClaimMasterPTR
			join clm_involvedparty ent on other.involvedpartyptr = ent.id and res.EntityNumber = ent.EntityNumber
		where ClaimNumber = @CMastPtr and CoverageID = 2 and ent.Injured = 1
--
-----------------  close 3 and 5/6??? ---------------------
--
update CLM_Reserve 
     set ClosedOn = GetDate(), ReserveOpen = 0
      where ClaimNumber = @CMastPtr and CoverageID = 3
goto CallClaimReserves
SetNON:
if @debug = 1 print 'Set the loss types of 3, 4, and 5'
--
-- for loss type 3, 4, 5 open comp(3)
--
update CLM_Reserve set ReserveOpen = 1, ClosedOn = null, forcedclosed = 0 where ClaimNumber = @CMastPtr and CoverageID = 3
--
-----------------  close 1, 2, 4, 7, 8, 9 and 5/6??? ---------------------
--
update CLM_Reserve 
     set ClosedOn = GetDate(), ReserveOpen = 0
      where ClaimNumber = @CMastPtr and CoverageID in (1, 2, 4, 7, 8, 9)
goto CallClaimReserves
SetHit:
if @debug = 1 print 'Set the loss types of 6'
--
-- for loss type 6 coll(4)
--
update CLM_Reserve set ReserveOpen = 1, ClosedOn = null, forcedclosed = 0 where ClaimNumber = @CMastPtr and CoverageID = 4
--
-----------------  close 1, 2, 3, 7, 8, 9 and 5/6??? ---------------------
--
update CLM_Reserve 
     set ClosedOn = GetDate(), ReserveOpen = 0
      where ClaimNumber = @CMastPtr and CoverageID in (1, 2, 3, 7, 8, 9)
goto CallClaimReserves
SetTow:
if @debug = 1 print 'Set the loss types of 7'
--
-- for loss type 7 towing(5)
--
update CLM_Reserve set ReserveOpen = 1, ClosedOn = null, forcedclosed = 0 where ClaimNumber = @CMastPtr and CoverageID = 5
--
-----------------  close 1, 2, 3, 7, 8, 9 and 5/6??? ---------------------
--
update CLM_Reserve 
     set ClosedOn = GetDate(), ReserveOpen = 0
      where ClaimNumber = @CMastPtr and CoverageID in (1, 2, 3, 4, 7, 8, 9)
--------------------  close all  --------------------------
goto CallClaimReserves
CallClaimReserves:
exec sp_claimreserves @CMastPtr, @AccDt