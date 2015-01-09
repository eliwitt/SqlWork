declare @debug int
--
set @debug = null
-- start of script
--
print 'Begin the insert '
-- begin the process by starting a transaction
begin transaction
--
--  now using the given level insert the new user rights
--
declare @Client varchar(10),
	@Company varchar(70),
	@Nom1 varchar(70), 
	@Nom2 varchar(70),
	@Nom3 varchar(70),
	@Prov varchar(70),
	@Postal varchar(70),
	@TelNu varchar(70)
--  loop through the shop's rights and assign them to the user
--
declare Clients scroll cursor for
select ClientId, [Name], Nom1, Nom2, Nom3, Prov, Postal, TelNu from belron_clients
open Clients
fetch first from Clients into @Client, @Company, @Nom1, @Nom2, @Nom3, @Prov, @Postal, @TelNu
while @@fetch_status = 0
	begin
		if @debug is not null
		begin
			print 'Process ' + cast(@Client as varchar(6))
		end
		if exists (select vCustid from edg_tbl_subscribers where vCustId = @Client)
		begin
			print 'Skip ' + @Client
		end
		else
		begin
			print 'Insert ' + @Client + ' ' + @Company
			insert edg_tbl_Subscribers 
				( SubscriberType, 
				SubscriberLevel, 
				Company, 
				Address,
				Address2,
				City,
				State,
				ZIP,
				Country,
				Phone,
				AuctionFaxNotice,
				AuctionParticipant,
				VCustId) 
			values(1, 0, @Company, @Nom1, @Nom2, @Nom3, @Prov, @Postal, 'CAN', @TelNu, 0, 0, @Client)
		end

		fetch next from Clients into @Client, @Company, @Nom1, @Nom2, @Nom3, @Prov, @Postal, @TelNu
end
close Clients
deallocate Clients
commit
if @debug is not null
begin
	print 'You have successfully reset inserted the clients'
end
