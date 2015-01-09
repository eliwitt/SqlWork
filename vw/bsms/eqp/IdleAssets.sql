SELECT  * FROM wAppEQP.EqpEdit 
order by EQTID

SELECT     EQP.Equipment.EQNote, EQP.Equipment.EQTModelLink, EQP.Equipment.EQTIDold, 
		EQP.Equipment.EQTPrintNumber, EQP.Equipment.EQInService, 
        EQP.Equipment.EQTID, EQP.Equipment.EQServiceDate, EQP.Equipment.EQSerialNumber, 
        EQP.EquipmentModelNumber.EQModModelNumber, EQP.EquipmentModelNumber.EQModDescription, 
        EQP.ProcNumbers.PROCARG, wACom.MachineList.MLCELLNAME, wACom.Lines.LILineName, 
        EQP.ProcNumbers.PROCNUMBER, EQP.Equipment.EQPlant, wACom.MachineList.MLID, 
        wACom.Lines.LIID, EQP.EquipmentModelNumber.EQModID, Team.wAPlants.PNID, 
        EQP.ProcNumbers.PROCID, EQP.Equipment.EQTDescription, EQP.Equipment.EQTIdleLocation
FROM wACom.Lines 
	LEFT OUTER JOIN Team.wAPlants 
		ON wACom.Lines.LIPlant = Team.wAPlants.PNID 
	RIGHT OUTER JOIN wACom.MachineList 
		ON wACom.Lines.LIID = wACom.MachineList.MLLINEID 
	RIGHT OUTER JOIN EQP.ProcNumbers 
		ON wACom.MachineList.MLID = EQP.ProcNumbers.PROCARG 
	RIGHT OUTER JOIN EQP.Equipment 
		ON EQP.ProcNumbers.PROCASSET = EQP.Equipment.EQTID 
	LEFT OUTER JOIN EQP.EquipmentModelNumber 
		ON EQP.Equipment.EQTModelLink = EQP.EquipmentModelNumber.EQModID