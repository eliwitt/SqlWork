SELECT     AppealNumber, COUNT(*)
FROM         dbo.BeneficiaryCollections
GROUP BY AppealNumber
HAVING      (COUNT(*) > 1)
ORDER BY count(*) DESC