--select * from clm_claimmaster
select * from clm_claimvehicle where claimmasterptr = 75
--select * from clm_person where id in (select personptr from clm_involvedparty)
--select * from clm_person where id in (55,72)
select invpart.id, invpart.entitynumber, person.firstname, person.lastname from clm_involvedparty invpart
	left join clm_person person on invpart.personptr = person.id
	where invpart.id in (select involvedpartyptr from clm_vehiclepassenger where claimmasterptr = 75 and ((disabled is null) or (disabled = 0)) )
select * from clm_otherproperty where claimmasterptr = 75
--select * from clm_vehiclepassenger where claimmasterptr = 75
--select * from clm_address where id = (select addressptr from clm_involvedparty where id = 32)
--select * from clm_vehiclepassenger where involvedpartyptr = 32