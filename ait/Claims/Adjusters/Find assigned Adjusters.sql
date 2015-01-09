select MAX(ClaimNumber) as ClaimNumber, ClaimPTR
from CLM_AdjusterAssignments
group by ClaimPTR
having COUNT(*) > 2

select * from CLM_AdjusterAssignments where ClaimPTR in (361, 6003, 4526) order by ClaimPTR

--SELECT ID, PolicyNumber, mast.ClaimNumber, DateOfLoss, LossType, DateStamp 
--FROM clm_claimmaster mast where (mast.disabled is null or mast.disabled = 0)
--  and claimloaded = 1  and EmployeePTR = 2998700
--SELECT ID, PolicyNumber, mast.ClaimNumber, DateOfLoss, LossType, DateStamp 
--FROM clm_adjusterassignments adjusters
--    join clm_claimmaster mast on mast.id = adjusters.claimptr 
--where (mast.disabled is null or mast.disabled = 0)
--  and adjusters.claimloaded = 1  and adjusters.EmployeePTR = 2998700 order by PolicyNumber