

CREATE TABLE #t1 (MyString VARCHAR(8000), Pattern VARCHAR(50))

INSERT INTO #t1 
 -- Split out the non-numeric components of a string
 SELECT 'cbv736456XYZ543534534545XLS', '%[^0-9]%' 
    -- Retrieve [Tuples] regardless of bracketing characters 
 UNION ALL 
 SELECT '[001][0021][00043]', '%[0-9]%' 
 -- Retrieve only the alphabetic [Tuples] 
 UNION ALL 
 SELECT '<001><AAA><00043>', '%[A-Z]%' 
 -- Retrieve binary strings 
 UNION ALL 
 SELECT '01010101A011001B01900C', '%[0-1]%' 
 -- Retrieve hexadecimal strings 
 UNION ALL 
 SELECT '01ABXX02AYY0005ABCZZ', '%[0-9A-F]%' 
 -- Retrieve words and remove spaces & punctuation between them (from A. Machanic blog) 
 UNION ALL 
 SELECT 'The quick-brown  fox jumped! over the lazy dog.', '%[a-zA-Z]%' 
 -- Retrieve masked credit card numbers 
 UNION ALL 
 SELECT 'Dwain532500010044****Charley432800245431****', '%[0-9*]%'

SELECT MyString, ItemNumber, Item 
 FROM #t1 
  CROSS APPLY PatternSplitLoop(MyString, Pattern) 
 WHERE [Matched] = 1

DROP TABLE #t1