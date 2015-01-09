DECLARE @mineTable TABLE 
(
	mineNumber  Integer,
	idCol Integer
)

INSERT INTO @mineTable (mineNumber) SELECT (data) FROM wACom.Split('345,123,678',',')

select * from @mineTable

SELECT * FROM wAppEQP.EqpEdit
	--WHERE EQPlant = @Plant and MLID IN (SELECT machineNumber FROM @machineTable )
	WHERE EQPlant = @Plant and MLID IN (SELECT (data) FROM wACom.Split(@Cell,',') ) AND EQModID IN (SELECT (data) FROM wACom.Split(@Model,','))