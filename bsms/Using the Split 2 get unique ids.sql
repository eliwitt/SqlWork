--
-- how to use the split to get unique IDsfrom user input
--

-- first version 
--
select distinct CONVERT(int, Data) as ProcID 
into #Procs
from wACom.Split('123,456,789,123',',')

SELECT * FROM #Procs

-- second with Common Table Expression (CTE)
; with CTEProc as 
	(
	select distinct CONVERT(int, Data) as ProcID
	from wACom.Split('123,456,789,123',',')
	)
select * from CTEProc