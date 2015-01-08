
CREATE TABLE #t1 (MyString VARCHAR(8000), Pattern VARCHAR(50))

INSERT INTO #t1 
 -- Retrieve file names with full path 
 SELECT 'c:\abc.txt###d:\test\abc1s2.xls**e:\def.exe**', '%[a-zA-Z0-9:\.]%' 
 -- Retrieve drive letter (e.g., c:) and file name without path 
 UNION ALL 
 SELECT '***c:\mypath\test\abc.txt***', '%[a-zA-Z0-9:\.]%' 
 -- Retrieve drive letter (e.g., c:) and file name without path 
 UNION ALL 
 SELECT 'c:\abc.txt###d:\test\abc1s2.xls**e:\def.exe**', '%[a-zA-Z0-9.^:]%'

SELECT MyString, ItemNumber, Item
 FROM #t1
   CROSS APPLY PatternSplitLoop(MyString, Pattern) 
 WHERE Item LIKE Pattern

DROP TABLE #t1