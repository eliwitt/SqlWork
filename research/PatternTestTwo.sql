

CREATE TABLE #t1 (MyString VARCHAR(8000))

DECLARE @Pattern VARCHAR(50) = '%[0-9]%'

INSERT INTO #t1 SELECT '1234ABC123456XYZ1234567890ADS'

;WITH ReplaceDigits AS 
( 
  SELECT MyString, ItemNumber
        ,Item=CASE WHEN LEN(Item) >= 6 AND [Matched] = 1            
                   THEN REPLICATE('x', LEN(Item)) 
                   ELSE Item 
              END
   FROM #t1 
    CROSS APPLY PatternSplitLoop(MyString, @Pattern)
)
SELECT ( SELECT '' + Item
 FROM ReplaceDigits b
 WHERE a.MyString = b.Mystring  
 ORDER BY ItemNumber  
 FOR XML PATH('')
)
 FROM ReplaceDigits a
 GROUP BY MyString

DROP TABLE #t1

-- Returns: 1234ABCxxxxxxXYZxxxxxxxxxxADS