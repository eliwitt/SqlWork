select * from clm_claimmaster where id = 38
select * from clm_claimvehicle where claimmasterptr = 38
select * from clm_vehiclepassenger where claimmasterptr = 38
select * from clm_otherproperty where claimmasterptr = 38
select * from clm_involvedparty where id in (56)
select * from clm_person where id in (94)
select * from clm_reserve where claimnumber = 38