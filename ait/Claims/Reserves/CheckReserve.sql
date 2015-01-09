-- is the policy active
select @IsPolicyInForce = dbo..F_Claims_IsPolicyActive(@PolicyNumber,@ClaimDate)
-- do we have an active coverage
set @Covered = 0
select @OurVeh=OurVehicle from CLM_ClaimVehicle where ClaimMasterPTR = @ClaimID and VehicleNu = 1
@Covered = F_Claims_IsCoverageActive(@PolicyNu, @AccDt, @OurVeh, 1)
if @VehNu > 1 && @Covered = 0 
	goto NoReserve
-- does the policy cover LIPD?
set @ReOpen = 0
select @MyKey=Max(ID) from CLM_Reserve
if (@MyKey is null)
Begin
	set @MyKey=0
end
set @ReserveID=@MyKey+1
/*
if (F_Claims_IsCoverageActive(@PolicyNu, @AccDt, @OurVeh, 1) = 1) 
begin
      @ReOpen = 1
end
insert into CLM_Reserve
	values(@ReserveID, @ClaimID, @AccDt, @NextEntity, 1, 
			F_Claims_GetReserveAmount(1), @ReOpen, 0, GetDate(), GetDate())
*/
insert into CLM_Reserve
	values(@ReserveID, @ClaimID, @AccDt, @NextEntity, 1, 
			100, @ReOpen, 0, GetDate(), GetDate(), null)
if @VehNu > 1 
	goto NoReserve
-- does the policy cover COLL?
set @ReOpen = 0
select @MyKey=Max(ID) from CLM_Reserve
if (@MyKey is null)
Begin
	set @MyKey=0
end
set @ReserveID=@MyKey+1
/*
if (F_Claims_IsCoverageActive(@PolicyNu, @AccDt, @OurVeh, 4) = 1) 
begin
      @ReOpen = 1
end
insert into CLM_Reserve
	values(@ReserveID, @ClaimID, @AccDt, @NextEntity, 4, 
			F_Claims_GetReserveAmount(4), @ReOpen, 0, GetDate(), GetDate())
*/
insert into CLM_Reserve
	values(@ReserveID, @ClaimID, @AccDt, @NextEntity, 4, 
			100, @ReOpen, 0, GetDate(), GetDate(), null)
-- does the policy cover Towing?
set @ReOpen = 0
select @MyKey=Max(ID) from CLM_Reserve
if (@MyKey is null)
Begin
	set @MyKey=0
end
set @ReserveID=@MyKey+1
/*
if (F_Claims_IsCoverageActive(@PolicyNu, @AccDt, @OurVeh, 5) = 1) 
begin
      @ReOpen = 1
end
insert into CLM_Reserve
	values(@ReserveID, @ClaimID, @AccDt, @NextEntity, 5, 
			F_Claims_GetReserveAmount(5), @ReOpen, 0, GetDate(), GetDate())
*/
insert into CLM_Reserve
	values(@ReserveID, @ClaimID, @AccDt, @NextEntity, 5, 
			100, @ReOpen, 0, GetDate(), GetDate(), null)
-- does the policy cover Rental?
set @ReOpen = 0
select @MyKey=Max(ID) from CLM_Reserve
if (@MyKey is null)
Begin
	set @MyKey=0
end
set @ReserveID=@MyKey+1
/*
if (F_Claims_IsCoverageActive(@PolicyNu, @AccDt, @OurVeh, 6) = 1) 
begin
      @ReOpen = 1
end
insert into CLM_Reserve
	values(@ReserveID, @ClaimID, @AccDt, @NextEntity, 6, 
			F_Claims_GetReserveAmount(6), @ReOpen, 0, GetDate(), GetDate())
*/
insert into CLM_Reserve
	values(@ReserveID, @ClaimID, @AccDt, @NextEntity, 6, 
			100, @ReOpen, 0, GetDate(), GetDate(), null)
NoReserve: