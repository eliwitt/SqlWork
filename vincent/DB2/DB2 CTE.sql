--
--   DB2 CTE   Note: you need sysibm.sysdummy1 for the select statements below to work
--
WITH
People AS (
 SELECT 1 ID, 'Joe'    FirstName, 'Smith'  LastName, 21 Age, 'Male'   Gender from sysibm.sysdummy1
UNION ALL
 SELECT 2 ID, 'John'   FirstName, 'Smit'   LastName, 32 Age, 'Male'   Gender from sysibm.sysdummy1
UNION ALL
 SELECT 3 ID, 'Jo'     FirstName, 'Schmit' LastName, 43 Age, 'Female' Gender from sysibm.sysdummy1
UNION ALL
 SELECT 4 ID, 'Joanne' FirstName, 'Smith'  LastName, 54 Age, 'Female' Gender from sysibm.sysdummy1
UNION ALL
 SELECT 5 ID, 'Juan'   FirstName, 'Smithe' LastName, 65 Age, 'Male'   Genderfrom sysibm.sysdummy1
)
-- select * from People /*  To test the cte results uncomment then add the end comment
,
OldPeople AS (
 SELECT * FROM People WHERE Age > 50
)
-- select * from OldPeople /*
,
Men AS (
 SELECT * FROM People WHERE Gender = 'Male'
)
SELECT
 o.*
FROM
 Men AS m
 INNER JOIN OldPeople AS o
   ON m.ID = o.ID;