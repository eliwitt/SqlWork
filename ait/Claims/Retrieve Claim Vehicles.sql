declare @myPolicy nvarchar(16),
	@myIndx int,
	@vehDesc nvarchar(60),
	@AccDt Datetime,
	@ClaimID int,
	@vin nvarchar(60)
set @ClaimID = 187
select @myPolicy=PolicyNumber, @AccDt=DateOfLoss from CLM_ClaimMaster where id = @ClaimID
create table #myCars
(
	id int,
	vehDesc nvarchar(60),
	vin nvarchar(60)
)
insert into #myCars(id, vehDesc, vin) exec GoAutoProd.dbo.Sp_Claims_GetVehicleList @myPolicy
-- the following is a collection of the policy's vehicles
declare myVehcursor cursor for
select id, vehDesc, vin from #myCars
open myVehcursor

fetch next from myVehcursor into @myIndx, @vehDesc, @vin
while (@@fetch_status = 0)
begin
      select @myIndx Id, @vehDesc [Desc], @vin Vin
	  select GoAutoProd.dbo.F_Claims_IsPolicyActive(@myPolicy, @AccDt) PolicyInForce,
			GoAutoProd.dbo.F_Claims_IsCoverageActive(@myPolicy, @AccDt, @myIndx, 1, 4) Coverage
      fetch next from myVehcursor into @myIndx, @vehDesc, @vin
end
close myVehcursor
deallocate myVehcursor
drop table #myCars