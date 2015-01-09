declare @vehCnt int
if exists(select claimmasterptr, count(vehiclenumber) VehCount from clm_vehiclepassenger 
			group by claimmasterptr having count(vehiclenumber) = 1)
begin
	-- Find the fast track reserves LIPD, COMP, or COLL
	select '1' as skilltype, res.id, res.entitynumber, claimnumber, coverageid, amountpaid, theCar.disabled
		from clm_reserve res
			join (
				select claimmasterptr from clm_claimvehicle where disabled = 0
					group by claimmasterptr having count(entitynumber) = 1) singleVeh 
			on res.claimnumber = singleVeh.claimmasterptr
			join clm_claimvehicle theCar on res.claimnumber = theCar.claimmasterptr and res.entitynumber = theCar.entitynumber
		where res.coverageid in (select id from clm_coverage where [desc] in ('LIPD', 'COMP', 'COLL')) and theCar.disabled = 0
	order by claimnumber
end
if exists(select claimmasterptr, count(vehiclenumber) VehCount from clm_vehiclepassenger 
			group by claimmasterptr having count(vehiclenumber) > 1)
begin
	-- Find the non-fast track reserves LIPD, COMP, or COLL 
		select '2' as skilltype, res.id, res.entitynumber, claimnumber, coverageid, amountpaid, theCar.disabled from clm_reserve res
			join (
				select claimmasterptr from clm_claimvehicle where disabled = 0
					group by claimmasterptr having count(entitynumber) > 1) multiVeh 
			on res.claimnumber = multiVeh.claimmasterptr
			join clm_claimvehicle theCar on res.claimnumber = theCar.claimmasterptr and res.entitynumber = theCar.entitynumber
		where res.coverageid in (select id from clm_coverage where [desc] in ('LIPD', 'COMP', 'COLL')) and theCar.disabled = 0
		order by claimnumber
end
--
-- Litigated????? attorneyptr????
--
select '3' as skilltype, res.id, res.entitynumber, claimnumber, coverageid, amountpaid 
	from clm_reserve res
	join clm_vehiclepassenger vehpass on res.claimnumber = vehpass.claimmasterptr
	join clm_involvedparty party on vehpass.involvedpartyptr = party.id and res.entitynumber = party.entitynumber
where party.attorneyptr > 0 and res.coverageid in (select id from clm_coverage where [desc] in ('LIBI', 'UMBI'))
order by claimnumber
--
--  body injury no rep
--
select '4' as skilltype, res.id, res.entitynumber, claimnumber, coverageid, amountpaid 
	from clm_reserve res
	join clm_vehiclepassenger vehpass on res.claimnumber = vehpass.claimmasterptr
	join clm_involvedparty party on vehpass.involvedpartyptr = party.id and res.entitynumber = party.entitynumber
where party.injured > 0 and party.attorneyptr = 0 
	and res.coverageid in (select id from clm_coverage where [desc] in ('LIBI', 'UMBI'))
order by claimnumber
--
-- body injury rep
--
select '5' as skilltype, res.id, res.entitynumber, claimnumber, coverageid, amountpaid 
	from clm_reserve res
	join clm_vehiclepassenger vehpass on res.claimnumber = vehpass.claimmasterptr
	join clm_involvedparty party on vehpass.involvedpartyptr = party.id and res.entitynumber = party.entitynumber
where party.injured > 0 and party.attorneyptr > 0 
	and res.coverageid in (select id from clm_coverage where [desc] in ('LIBI', 'UMBI'))
order by claimnumber