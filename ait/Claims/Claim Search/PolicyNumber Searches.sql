SELECT ID, PolicyNumber, mast.ClaimNumber, DateOfLoss, LossType, DateStamp, 
mast.EmployeePTR, claimloaded
FROM clm_claimmaster mast
where LossType = 1  and EmployeePTR = 66436 and (mast.disabled is null or mast.disabled = 0)
--
-- myUnionSql
--
union SELECT ID, PolicyNumber, mast.ClaimNumber, DateOfLoss, LossType, DateStamp, 
adjusters.EmployeePTR, adjusters.claimloaded
FROM clm_adjusterassignments adjusters
join clm_claimmaster mast on mast.id = adjusters.claimptr
--
-- default where
--
where LossType = 1 and adjusters.EmployeePTR = 66436 and  (mast.disabled is null or mast.disabled = 0) 
order by PolicyNumber
go
--
-- default where
--
--where EmployeePTR = 66436 and (mast.disabled is null or mast.disabled = 0)
--where adjusters.EmployeePTR = 66436 and (mast.disabled is null or mast.disabled = 0) 
--=======================================================
--  my claims unchecked
--where (mast.disabled is null or mast.disabled = 0)
--where (mast.disabled is null or mast.disabled = 0) 
--=====================================================
-- my new claims
-- where claimloaded = 1  and EmployeePTR = 66436 and (mast.disabled is null or mast.disabled = 0) 
-- where adjusters.claimloaded = 1  and adjusters.EmployeePTR = 66436 and (mast.disabled is null or mast.disabled = 0)
--=====================================================
-- policynumber
--  where PolicyNumber = '10037-2'  and EmployeePTR = 66436 and (mast.disabled is null or mast.disabled = 0) 
-- where PolicyNumber = '10037-2'  and adjusters.EmployeePTR = 66436 and (mast.disabled is null or mast.disabled = 0)
--======================================================
-- loss type
--where LossType = 1  and EmployeePTR = 66436 and (mast.disabled is null or mast.disabled = 0)
--where LossType = 1 and adjusters.EmployeePTR = 66436 and  (mast.disabled is null or mast.disabled = 0) 