--  EW provided to resolve the product deletion
--  this script costed us 60,000 thanks EW!!!

SELECT DISTINCT c.ProductDisplay_nm FROM EMP_CompletedTransaction ct
JOIN PRD_ProductTransaction pt ON ct.ProductTransaction_key = pt.ProductTransaction_key
JOIN PRD_Product p ON pt.Product_key = p.Product_key
JOIN GRP_GroupProduct gp ON gp.Product_key = p.Product_key
JOIN MSC_Organization o ON gp.Group_key = o.Organization_key
JOIN PRD_Customization c ON c.GroupProduct_key = gp.GroupProduct_key
WHERE o.organization_nm like 'Jamie%Kitchen' AND c.ProductDisplay_nm = 'Davis Vision 2'

