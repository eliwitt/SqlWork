--====================================================================
--
-- name search
--
SELECT mast.ID, PolicyNumber, mast.ClaimNumber, DateOfLoss, LossType, DateStamp, person.firstname + ' ' + person.lastname as NameFound 
FROM clm_claimmaster mast 
	join clm_vehiclepassenger pass on mast.id = pass.claimmasterptr
	      join clm_involvedparty involved on  pass.involvedpartyptr = involved.id
		  join clm_person person on involved.personptr = person.id
where (mast.disabled is null or mast.disabled = 0) and person.firstname like 'william%'
union
SELECT mast.ID, PolicyNumber, mast.ClaimNumber, DateOfLoss, LossType, DateStamp, person.firstname + ' ' + person.lastname as NameFound 
FROM clm_claimmaster mast 
	join clm_otherproperty prop on mast.id = prop.claimmasterptr
	join clm_involvedparty party on prop.involvedpartyptr = party.id 
	join clm_person person on party.personptr = person.id 
where (mast.disabled is null or mast.disabled = 0) and person.firstname like 'william%'
--
--  myUnionNameSql
--
--union SELECT mast.ID, PolicyNumber, mast.ClaimNumber, DateOfLoss, LossType, DateStamp,
--	 firstname + ' ' + lastname as NameFound
--FROM clm_adjusterassignments adjusters
--	join clm_claimmaster mast on mast.id = adjusters.claimptr
--	join clm_vehiclepassenger pass on mast.id = pass.claimmasterptr 
--	join clm_involvedparty involved on  pass.involvedpartyptr = involved.id 
--	join clm_person person on involved.personptr = person.id 
-- where person.firstname like 'william%' and (mast.disabled is null or mast.disabled = 0)
-- union
--SELECT mast.ID, PolicyNumber, mast.ClaimNumber, DateOfLoss, LossType, DateStamp, others.firstname + ' ' + others.lastname as NameFound 
--FROM clm_adjusterassignments adjusters
--	join clm_claimmaster mast on mast.id = adjusters.claimptr
--	join clm_otherproperty prop on mast.id = prop.claimmasterptr
--	join clm_involvedparty party on prop.involvedpartyptr = party.id 
--	join clm_person others on party.personptr = others.id 
--where others.firstname like 'william%' and (mast.disabled is null or mast.disabled = 0) 
--
-- order by
--
 --order by DateOfLoss desc

 order by PolicyNumber

 --order by DateStamp desc
 --
 --
-- SELECT mast.ID, PolicyNumber, mast.ClaimNumber, DateOfLoss, LossType, DateStamp,
--	case when person.FirstName is null then
--		others.firstname + ' ' + others.lastname
--		else
--       person.firstname + ' ' + person.lastname end as NameFound 
--FROM clm_claimmaster mast 
--	join (clm_vehiclepassenger pass 
--	      join clm_involvedparty involved on  pass.involvedpartyptr = involved.id
--		  join clm_person person on involved.personptr = person.id) on mast.id = pass.claimmasterptr
--	join (clm_otherproperty prop 
--			join clm_involvedparty party on prop.involvedpartyptr = party.id 
--			join clm_person others on party.personptr = others.id) on mast.id = prop.claimmasterptr
--where person.firstname like 'william%' and others.firstname like 'william%' and (mast.disabled is null or mast.disabled = 0) 
--order by PolicyNumber