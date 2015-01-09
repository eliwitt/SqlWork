SELECT ID, PolicyNumber, mast.ClaimNumber, DateOfLoss, LossType 
FROM clm_claimmaster mast 
where claimloaded = 1  and EmployeePTR = 148026 
	and contactedall is null and (mast.disabled is null or mast.disabled = 0) 
union
SELECT ID, PolicyNumber, mast.ClaimNumber, DateOfLoss, LossType 
FROM clm_adjusterassignments adjusters
	join clm_claimmaster mast on mast.id = adjusters.claimptr
where adjusters.claimloaded = 1  and adjusters.EmployeePTR = 148026 
	and contactedall is null and (mast.disabled is null or mast.disabled = 0) 
order by PolicyNumber

SELECT mast.ID, PolicyNumber, mast.ClaimNumber, DateOfLoss, 
LossType,  firstname + ' ' + lastname as NameFound 
FROM clm_claimmaster mast 
join clm_vehiclepassenger pass on mast.id = pass.claimmasterptr 
join clm_involvedparty involved on  pass.involvedpartyptr = involved.id 
join clm_person person on involved.personptr = person.id  
where person.firstname like 'Pamela%' and person.lastname like 'Ross%' and EmployeePTR = 148026 and contactedall is null and (mast.disabled is null or mast.disabled = 0) 
union
SELECT mast.ID, PolicyNumber, mast.ClaimNumber, DateOfLoss, 
LossType,  firstname + ' ' + lastname as NameFound 
FROM clm_adjusterassignments adjusters
join clm_claimmaster mast on mast.id = adjusters.claimptr
join clm_vehiclepassenger pass on mast.id = pass.claimmasterptr 
join clm_involvedparty involved on  pass.involvedpartyptr = involved.id 
join clm_person person on involved.personptr = person.id  
where person.firstname like 'Pamela%' and person.lastname like 'Ross%' and adjusters.EmployeePTR = 148026 and contactedall is null and (mast.disabled is null or mast.disabled = 0) 
order by PolicyNumber