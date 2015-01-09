declare @myClaim int
set @myClaim = 81
select * from clm_claimmaster where id = @myClaim
select owner.EntityNumber OENum, owner.injured OInjured, Prop.EntityNumber PENum
	from clm_otherproperty Prop
	left join clm_involvedparty [owner] on Prop.involvedpartyptr = owner.id
where Prop.claimmasterptr = @myClaim 
select * from clm_otherproperty where claimmasterptr = @myClaim
select * from clm_involvedparty where id in (select involvedpartyptr from clm_otherproperty where claimmasterptr = @myClaim)
select * from clm_claimvehicle where claimmasterptr = @myClaim and vehiclenumber = 1
--delete from clm_otherproperty where id in (1, 2)
--delete from clm_involvedparty where id in (98, 99)
--delete from clm_person where id in (136,137)
--delete from clm_address where id in (172,173)
--update clm_claimmaster set nextentitynumber = 1 where id = 74
--delete from clm_claimvehicle where claimmasterptr = 74
--update clm_claimvehicle set ourvehicleindex = 1 where claimmasterptr = 74 and vehiclenumber = 1
--update clm_involvedparty set injured=0 where id =98
--exec sp_propertyreserve 74, 99, 2
select * from clm_reserve where claimnumber = @myClaim
--exec sp_claimreserves 75, '2010-05-22 02:02:00.000'