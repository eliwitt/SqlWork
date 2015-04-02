-- the cross join can be used to create test data
--
SELECT ROW_NUMBER() OVER(ORDER BY ProductName DESC) AS ID,
       Product.ProductName 
	   + CAST(SalesItem.ID as varchar(2)) AS ProductName, 
       (Product.Cost / SalesItem.ID) * 100 AS Cost
FROM train.Product CROSS JOIN train.SalesItem;