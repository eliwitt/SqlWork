--
-- area
SELECT * FROM wACom.Areas WHERE AAPLant = 1 AND AAActive = 1
--
-- line
	SELECT * FROM wACom.Lines
	WHERE LIPlant = 1 AND LIActive = 1
	ORDER BY LILineName
--
-- machine
	SELECT * FROM wACom.MachineListDropView
	WHERE MLPlantID = 1 AND MLActive = 1
	ORDER BY MLCELLNAME
--
--  reactivate lines 
--update wACom.Lines set LIActive = 0 where LIID in (114, 122, 124, 125, 134, 135)
select * from wo.WorkOrderMain 
where DISLineNumber in (12, 126, 127, 128, 129, 130, 131, 132, 133)
and DISCloseDate is null

exec [wACom].[LineDrop] 1