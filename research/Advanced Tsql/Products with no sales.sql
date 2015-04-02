--
-- find products with no sales for the day
--
SELECT S1.SalesDate, ProductName
     , ISNULL(Sum(S2.Qty),0) AS TotalQty
	 , ISNULL(SUM(S2.TotalSalesAmt),0) AS TotalSales
FROM train.Product P
CROSS JOIN  
(
SELECT DISTINCT SalesDate FROM train.SalesItem
  ) S1
LEFT OUTER JOIN 
train.SalesItem S2
ON P.ID = S2.ProductID
AND S1.SalesDate = S2.SalesDate
GROUP BY S1.SalesDate, P.ProductName
ORDER BY S1.SalesDate;