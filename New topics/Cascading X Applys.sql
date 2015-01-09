--
-- from SQL Central Cascading (CROSS) Apply
--
--drop table #EmailAddress
CREATE TABLE #EmailAddress
        (
        EmployeeID INT IDENTITY(1,1),
        EmailAddress VARCHAR(128)
        )
;
 INSERT INTO #EmailAddress
        (EmailAddress)
 SELECT '<mmooney@gmail.com>;mmoney@gmail.com' UNION ALL
 SELECT '<chrisgardener@yahoo.com>)''[chrisgardener@comcast.net)]' UNION ALL
 SELECT '"natan@hotmail.com'':>"natan@hotmail.com?''' UNION ALL
 SELECT '"jennifer@walmart.com}'';jennifer@fedex.com' UNION ALL
 SELECT '''<jennifer.juniper@fedex.com>;"jennifer.juniper@fedex.com"'''
;
-- example one using a function to split the string
SELECT  ea.EmployeeID, ea.EmailAddress,
        Domain1 = MAX(CASE
                      WHEN ca.ItemNumber = 2
                      THEN LEFT(ca.Item,CHARINDEX('.',ca.Item,1)-1)
                      ELSE ''
                      END),
        Domain2 = MAX(CASE
                      WHEN ca.ItemNumber = 3
                      THEN LEFT(ca.Item,CHARINDEX('.',ca.Item,1)-1)
                      ELSE ''
                      END)
FROM    #EmailAddress ea
CROSS APPLY dbo.DelimitedSplit8K (ea.EmailAddress, '@') ca
WHERE   ca.ItemNumber IN (2,3)
GROUP BY ea.EmployeeID, ea.EmailAddress
HAVING COUNT(*) = 2;
-- cross apply example one
SELECT  EmployeeID, EmailAddress,
        SUBSTRING(EmailAddress,x1.p1,20)
FROM    #EmailAddress
CROSS APPLY(SELECT p1 = CHARINDEX('@',EmailAddress,1)) x1;
-- cross apply example two
SELECT  EmployeeID, EmailAddress,
        Domain1  = SUBSTRING(EmailAddress, x1.p1, x1.p2-x1.p1),
        Domain2 = SUBSTRING(EmailAddress, x2.p1, x2.p2-x2.p1)
FROM    #EmailAddress
CROSS APPLY(SELECT
        p1 = 1+CHARINDEX('@',EmailAddress,1),
        p2 = CHARINDEX('.',EmailAddress,CHARINDEX('@',EmailAddress,1))
        ) x1
CROSS APPLY(SELECT
        p1 = 1+CHARINDEX('@',EmailAddress, x1.p1),
        p2 = CHARINDEX('.',EmailAddress,CHARINDEX('@',EmailAddress, x1.p1))
        ) x2;