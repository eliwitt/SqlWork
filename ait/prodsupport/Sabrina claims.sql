select * from clm_claimmaster mast 
where employeeptr = 66436 and claimloaded = 1 and (mast.disabled is null or mast.disabled = 0)

SELECT ID, PolicyNumber, mast.ClaimNumber, DateOfLoss, LossType, DateStamp 
FROM clm_claimmaster mast 
where claimloaded = 1  and EmployeePTR = 66436 and (mast.disabled is null or mast.disabled = 0)  
union 
SELECT ID, PolicyNumber, mast.ClaimNumber, DateOfLoss, LossType, DateStamp 
FROM clm_adjusterassignments adjusters 
join clm_claimmaster mast on mast.id = adjusters.claimptr  
where adjusters.claimloaded = 1  and adjusters.EmployeePTR = 66436 and (mast.disabled is null or mast.disabled = 0)  
order by PolicyNumber