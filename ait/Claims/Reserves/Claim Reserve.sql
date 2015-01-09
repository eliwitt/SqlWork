declare @ClaimPtr int,
	@myVnu			int,
	@myEnu			int, 
	@myPer			int,
	@myInjured		int
set @ClaimPtr = 1
-- close any reserve for the claim
update CLM_Reserve 
	set ClosedOn = GetDate(), ReserveOpen = 0
	where ClaimNumber = @ClaimPtr
-- The following statements could delete the unused rows from the old claim
delete from clm_reserve where id in (
	select id from clm_reserve where claimnumber = @ClaimPtr and (AmountPaid = 0 or AmountPaid is null)
)
-- the following is a collection of claim's vehicles
declare myVehcursor cursor for
select distinct cv.VehicleNumber, cv.Entitynumber 
	from clm_vehiclepassenger vp 
		join clm_claimvehicle cv on vp.claimmasterptr = cv.claimmasterptr and vp.vehiclenumber = cv.vehiclenumber
	where vp.claimmasterptr = @ClaimPtr
open myVehcursor
fetch next from myVehcursor into @myVnu, @myEnu
while (@@fetch_status = 0)
begin
	exec sp_bulkreserve @ClaimPtr, @myVnu, @myEnu
	fetch next from myVehcursor into @myVnu, @myEnu
end
close myVehcursor
deallocate myVehcursor
-- the following is a collection of the claim's people
declare myPercursor cursor for
select ip.id, ip.injured
	from clm_vehiclepassenger vp
		join clm_involvedparty ip on vp.involvedpartyptr = ip.id
	where claimmasterptr = @ClaimPtr and disabled = 0
open myPercursor
fetch next from myPercursor into @myPer, @myInjured
while (@@fetch_status = 0)
begin
	if @myInjured = 1
		exec sp_personreserve @ClaimPtr,@myPer, 2
	fetch next from myPercursor into @myPer, @myInjured
end
close myPercursor
deallocate myPercursor
/* this backs up the clm_reserve table
CREATE TABLE [dbo].[clm_reservebk](
	[id] [int] NOT NULL,
	[ClaimNumber] [int] NOT NULL,
	[ClaimDateTime] [datetime] NULL,
	[EntityNumber] [int] NOT NULL,
	[CoverageID] [int] NOT NULL,
	[InitialReserveAmount] [money] NOT NULL CONSTRAINT [DF_clm_reservebk_InitialReserveAmount]  DEFAULT ((0)),
	[ReserveOpen] [tinyint] NULL,
	[ReserveAdjusterClosed] [tinyint] NULL,
	[CreatedOn] [datetime] NULL,
	[OpenedOn] [datetime] NULL,
	[ClosedOn] [datetime] NULL,
	[AmountPaid] [money] NULL
) ON [PRIMARY]

insert into clm_reservebk select * from clm_reserve
*/