

CREATE TABLE #t1 (MyString VARCHAR(8000), Pattern VARCHAR(50))

INSERT INTO #t1 
 -- Unsupported patterns return the whole string 
 SELECT 'abc0031001abacass532466aa43', '%[0-9][0-9][0-9][0-9]%'

SELECT MyString, ItemNumber, Item, [Matched]
 FROM #t1 
  CROSS APPLY PatternSplitLoop(MyString, Pattern)

DROP TABLE #t1