
CREATE TABLE #t1 (MyString VARCHAR(8000), Pattern VARCHAR(50))

INSERT INTO #t1 -- Check that degenerate cases are handled properly  SELECT NULL, '%[0-9]%'
 -- Returns NULL for Item (any pattern)
 UNION ALL
 SELECT 'ABC', '%[0-9]%'
 -- Returns the single unmatched pattern
 UNION ALL
 SELECT '123', '%[0-9]%'
 -- Returns the single matched pattern
 -- Split out the numeric components of a string 
 UNION ALL
 SELECT '1234ABC123456XYZ1234567890ADS', '%[0-9]%' 

SELECT MyString
     , ItemNumber
     , Item
     , Matched 
 FROM #t1 
  OUTER APPLY PatternSplitLoop(MyString, Pattern) 
  --WHERE Matched = 1

DROP TABLE #t1