--SELECT ID, PolicyNumber, mast.ClaimNumber, DateOfLoss, LossType, DateStamp 
--FROM clm_claimmaster mast where (mast.disabled is null or mast.disabled = 0)  
--and EmployeePTR = 2935838
--union SELECT ID, PolicyNumber, mast.ClaimNumber, DateOfLoss, LossType, DateStamp, adjusters.ClaimLoaded
--FROM clm_adjusterassignments adjusters
--    join clm_claimmaster mast on mast.id = adjusters.claimptr 
--where (mast.disabled is null or mast.disabled = 0)  and adjusters.EmployeePTR = 2935838 
--order by PolicyNumber

--update clm_adjusterassignments set claimloaded = 0 where employeeptr = 2935838 and claimptr = 5887
--select * from CLM_AdjusterAssignments where EmployeePTR = 2935838 and ClaimLoaded = 1 order by ClaimNumber

SELECT ID, PolicyNumber, mast.ClaimNumber, DateOfLoss, LossType, DateStamp 
FROM clm_claimmaster mast 
where (mast.disabled is null or mast.disabled = 0)  and claimloaded = 1  and EmployeePTR = 2998700
union SELECT ID, PolicyNumber, mast.ClaimNumber, DateOfLoss, LossType, DateStamp 
FROM clm_adjusterassignments adjusters
    join clm_claimmaster mast on mast.id = adjusters.claimptr 
where (mast.disabled is null or mast.disabled = 0)  
and adjusters.claimloaded = 1  and adjusters.EmployeePTR = 2998700 order by PolicyNumber

--SELECT mast.ID, PolicyNumber, mast.ClaimNumber, DateOfLoss, LossType, DateStamp, 
--	person.firstname + ' ' + person.lastname as NameFound 
--FROM clm_claimmaster mast
-- 	join clm_otherproperty prop on mast.id = prop.claimmasterptr
--  	join clm_involvedparty party on prop.involvedpartyptr = party.id
--   	join clm_person person on party.personptr = person.id 
--where(mast.disabled Is null Or mast.disabled = 0) and (prop.disabled is null or prop.disabled = 0)  
--	and prop.propertydesc like 'Barn%' 
--union 
--SELECT mast.ID, PolicyNumber, mast.ClaimNumber, DateOfLoss, LossType, DateStamp, 
--	person.firstname + ' ' + person.lastname as NameFound 
--FROM clm_adjusterassignments adjusters
-- 	join clm_claimmaster mast on mast.id = adjusters.claimptr
--  	join clm_otherproperty prop on mast.id = prop.claimmasterptr
--   	join clm_involvedparty party on prop.involvedpartyptr = party.id
-- 	join clm_person person on party.personptr = person.id 
-- where(mast.disabled Is null Or mast.disabled = 0)  
-- and prop.propertydesc like 'Barn%' 
-- order by PolicyNumber