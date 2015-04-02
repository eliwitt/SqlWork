--
-- cross join acts like an inner with the where clause is used
SELECT * FROM train.Product P CROSS JOIN train.SalesItem S
WHERE P.ID = S.ProductID;

SELECT * FROM train.Product P INNER JOIN train.SalesItem S
ON P.ID = S.ProductID;
