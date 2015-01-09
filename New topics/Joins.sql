CREATE TABLE TableA
(
  ID INT
, Country VARCHAR(20)
)
;
GO
CREATE TABLE TableB
(
  ID INT
, Country VARCHAR(20)
)
;
GO
INSERT TableA SELECT 1, 'India';
INSERT TableA SELECT 1, 'US';
INSERT TableB SELECT 1, 'India';
INSERT TableB SELECT 1, 'US';
GO
select COUNT(*)
 from TableA 
  join TableB
   on TableA.ID = TableB.ID 
;
select COUNT(*)
 from TableA 
  left join TableB
   on TableA.ID = TableB.ID 
;
select COUNT(*)
 from TableA 
  right join TableB 
   on TableA.ID = TableB.ID 
;
select COUNT(*) 
 from TableA 
  full join TableB 
   on TableA.ID = TableB.ID 
;
select COUNT(*)
 from TableA,TableB
;
GO
DROP TABLE TableA;
DROP TABLE TableB;