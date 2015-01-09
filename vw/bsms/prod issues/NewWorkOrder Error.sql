exec [wAppWorkOrder].[WOMainFetch] 1
select * from wACom.MachineList

--
--  the following is an example of the relationship between the line and machine tables
--  A problem could happen where if you only read the machine table you do not know if
--  the line that this machine is in is active.  This happened in the old NewWorkOrder app
--
	SELECT * FROM wACom.MachineListDropView
	WHERE MLPlantID = 1 AND MLActive = 1
	ORDER BY MLCELLNAME
	
	SELECT * FROM wACom.Lines
	WHERE LIPlant = 1 AND LIActive = 1
	ORDER BY LILineName