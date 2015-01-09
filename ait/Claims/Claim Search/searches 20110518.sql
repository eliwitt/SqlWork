SELECT mast.ID, PolicyNumber, mast.ClaimNumber, DateOfLoss, LossType, DateStamp, 
person.firstname + ' ' + person.lastname as NameFound 
FROM clm_claimmaster mast 
  	join clm_otherproperty prop on mast.id = prop.claimmasterptr
   	join clm_involvedparty party on prop.involvedpartyptr = party.id
   	join clm_person person on party.personptr = person.id 
where(mast.disabled Is null Or mast.disabled = 0)  and prop.propertydesc like 'barn%'
union
SELECT mast.ID, PolicyNumber, mast.ClaimNumber, DateOfLoss, LossType, DateStamp, 
person.firstname + ' ' + person.lastname as NameFound 
FROM clm_adjusterassignments adjusters
 	join clm_claimmaster mast on mast.id = adjusters.claimptr
  	join clm_otherproperty prop on mast.id = prop.claimmasterptr
   	join clm_involvedparty party on prop.involvedpartyptr = party.id
   	join clm_person person on party.personptr = person.id 
where(mast.disabled Is null Or mast.disabled = 0)  and prop.propertydesc like 'barn%' order by PolicyNumber
--
-- normal search
--
SELECT mast.ID, PolicyNumber, mast.ClaimNumber, DateOfLoss, LossType, DateStamp, 
firstname + ' ' + lastname as NameFound 
FROM clm_claimmaster mast
    join clm_vehiclepassenger pass on mast.id = pass.claimmasterptr
    join clm_involvedparty involved on  pass.involvedpartyptr = involved.id
    join clm_person person on involved.personptr = person.id 
where (mast.disabled is null or mast.disabled = 0) and (pass.disabled is null or pass.disabled = 0)  
	and person.lastname like 'brown%' 
union 
SELECT mast.ID, PolicyNumber, mast.ClaimNumber, DateOfLoss, LossType, DateStamp, 
person.firstname + ' ' + person.lastname as NameFound 
FROM clm_claimmaster mast
 	join clm_otherproperty prop on mast.id = prop.claimmasterptr
 	join clm_involvedparty party on prop.involvedpartyptr = party.id
  	join clm_person person on party.personptr = person.id 
 where(mast.disabled Is null Or mast.disabled = 0) and (prop.disabled is null or prop.disabled = 0)  
 and person.lastname like 'brown%' and person.lastname like 'brown%' 
 union 
 SELECT mast.ID, PolicyNumber, mast.ClaimNumber, DateOfLoss, LossType, DateStamp, 
 firstname + ' ' + lastname as NameFound 
 FROM clm_adjusterassignments adjusters
     join clm_claimmaster mast on mast.id = adjusters.claimptr
     join clm_vehiclepassenger pass on mast.id = pass.claimmasterptr
     join clm_involvedparty involved on  pass.involvedpartyptr = involved.id
     join clm_person person on involved.personptr = person.id 
where (mast.disabled is null or mast.disabled = 0) and (pass.disabled is null or pass.disabled = 0)
 and person.lastname like 'brown%' 
union 
SELECT mast.ID, PolicyNumber, mast.ClaimNumber, DateOfLoss, LossType, DateStamp, 
person.firstname + ' ' + person.lastname as NameFound 
FROM clm_adjusterassignments adjusters
 	join clm_claimmaster mast on mast.id = adjusters.claimptr
  	join clm_otherproperty prop on mast.id = prop.claimmasterptr
   	join clm_involvedparty party on prop.involvedpartyptr = party.id
   	join clm_person person on party.personptr = person.id 
where(mast.disabled Is null Or mast.disabled = 0) and (prop.disabled is null or prop.disabled = 0)
 and person.lastname like 'brown%' 
and person.lastname like 'brown%' order by PolicyNumber