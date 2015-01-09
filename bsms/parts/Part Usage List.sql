SELECT     SP.UsageList.ULID, SP.UsageList.ULSPLink, SP.UsageList.ULSPQtyUsed, SP.UsageList.ULSPQtyNeeded, SP.UsageList.ULSPNotes, SP.UsageList.USWearType, 
                      SP.WearTypes.WTID, SP.WearTypes.WTDescription, SP.WearTypes.WTDisplay, SP.UsageTypes.UTID, SP.UsageTypes.UTName, SP.UsageTypes.UTDisplay, 
                      SP.UsageList.ULTableLink, SP.UsageList.ULListType, SP.UsageList.ULDate, SP.SPMaster2.SP2VWNumber, SP.SPMaster2.SP2ShortSAPDescr,
                      woproc.PROCNUMBER, woMach.MLPlantID, dtproc.PROCNUMBER, dtMach.MLPlantID
FROM         SP.UsageList 
				LEFT OUTER JOIN SP.SPMaster2 ON SP.UsageList.ULSPLink = SP.SPMaster2.SP2ID 
				LEFT OUTER JOIN SP.UsageTypes ON SP.UsageList.ULListType = SP.UsageTypes.UTID 
				LEFT OUTER JOIN SP.WearTypes ON SP.UsageList.USWearType = SP.WearTypes.WTID
				left outer join wo.WorkOrderMain on sp.UsageList.ULTableLink = wo.WorkOrderMain.DISID
				left outer join EQP.ProcNumbers woproc ON wo.WorkOrderMain.DISEquip = woproc.PROCID
				left outer join wacom.MachineList woMach on  wo.WorkOrderMain.DISLineNumber = woMach.MLID
				left outer join dt.DTMainTable on sp.UsageList.ULTableLink = dt.DTMainTable.dtid
				left outer join  EQP.ProcNumbers dtproc ON DT.DTMainTable.DTRobot = dtproc.PROCID
				left outer join wacom.MachineList dtMach on  DT.DTMainTable.DTLine = dtMach.MLID
order by ULDate
--where womach.MLPlantID = 1 and dtMach.MLPlantID = 1
                      
                      
select * from dt.DTMainTable                      