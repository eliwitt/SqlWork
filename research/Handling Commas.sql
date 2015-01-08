CREATE TABLE #header
(
ProductID INT
, productname VARCHAR(200)
)
;
go
INSERT #header SELECT 1, 'Windsheild'
INSERT #header SELECT 2, 'Wipers'
INSERT #header SELECT 3, 'Wiper Motor'
INSERT #header SELECT 4, 'Spray Nozzle'
-- this query will produce the string correctly
SELECT ColorCommaDelimitedList = STUFF(( SELECT ', ' + productname AS [text()] FROM ( SELECT DISTINCT productname FROM #header ) x FOR XML PATH('') ), 1, 1, '');

SELECT ', ' + productname FROM #header AS h FOR XML PATH('')
SELECT productname + ', ' FROM #header AS h FOR XML PATH('')
SELECT SUBSTRING( (SELECT ', ' + productname FROM #header AS h FOR XML PATH('')), 2, 100)
drop table #header