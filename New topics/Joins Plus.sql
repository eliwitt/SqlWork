--
-- This script can be used to test using a tmp table 
--
--  Using joins you can filter out not coniditions
--
Select 'A' AS CustomerName,'03-12-10' AS CalledOn,'No Response' AS CustomerResponse INTO #TMP
UNION
Select 'A' AS CustomerName,'02-15-11' AS CalledOn,'Busy Call later' AS CustomerResponse
UNION
Select 'B' AS CustomerName,'03-12-10' AS CalledOn,'Interested Call later' AS CustomerResponse
UNION
Select 'A' AS CustomerName,'10-14-11' AS CalledOn,'No Response' AS CustomerResponse
UNION
Select 'C ' AS CustomerName,'03-12-10' AS CalledOn,'No Response' AS CustomerResponse
UNION
Select 'B' AS CustomerName,'04-29-11' AS CalledOn,'No Response' AS CustomerResponse
UNION
Select 'A' AS CustomerName,'02-14-12' AS CalledOn,'Interested Call later' AS CustomerResponse
UNION
Select 'B' AS CustomerName,'05-01-11' AS CalledOn,'No Response' AS CustomerResponse
UNION
Select 'C' AS CustomerName,'01-05-12' AS CalledOn,'Not Interested' AS CustomerResponse
UNION
Select 'B' AS CustomerName,'10-14-11' AS CalledOn,'Sale' AS CustomerResponse
go
SELECT T.CustomerName,T.CustomerResponse,T.CalledOn
 FROM #TMP T
  LEFT OUTER JOIN (SELECT CustomerName 
                    FROM #TMP 
                    WHERE CustomerResponse = 'Not Interested'
                  ) Q
   ON Q.CustomerName = T.CustomerName
 INNER JOIN (SELECT CustomerName,
                    MAX(CONVERT(DATE,CalledOn)) AS MaxCalledOn 
              FROM #TMP 
              GROUP BY CustomerName
            )Q2
  ON Q2.CustomerName = T.CustomerName
 WHERE Q.CustomerName IS NULL
 AND T.CalledOn = Q2.MaxCalledOn
 go