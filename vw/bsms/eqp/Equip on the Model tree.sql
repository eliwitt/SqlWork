--
-- top level of the tree
--
--	SELECT * FROM EQP.ModelGroupOne
--		WHERE MGOneActive = 1
--
exec [wAppEQP].[ModelGroupOneFetch]
--
-- second level of the tree
--
--	SELECT * FROM EQP.ModelGroupTwo
--		WHERE MGTwoActive = 1
exec [wAppEQP].[ModelGroupTwoFetch] 
--
-- retrieve the level 3 of the tree
--
--	SELECT * FROM EQP.ModelGroupThree
--		WHERE MGThreeActive = 1
--
exec [wAppEQP].[ModelGroupThreeFetch]
--
--
-- ModelNumberFetch
-- SELECT * FROM wAppEqp.ModelView order by EQModModelNumber
--
exec [wAppEQP].[ModelNumberFetch]
--
-- PorcNumberFetch call the following
--
	--SELECT * FROM wAppEQP.PROCVIEW
	--WHERE PROCACTIVE = 1
--
exec [wAppEQP].[ProcNumberFetch]

-- second level of the tree
--
	SELECT * FROM EQP.ModelGroupTwo
		WHERE MGTwoOneLink = 2
	SELECT * FROM EQP.ModelGroupThree
		WHERE MGThreeTwoLink = 7
	select * from EQP.EquipmentModelNumber
		where EQModGroupLink = 137

-- look at the model 
select * from EQP.EquipmentModelNumber
		where eqmodid = 746
select * from EQP.EquipmentModelNumber where EQModModelNumber like 'Z-ATS%'
-- i had to set 
--update EQP.EquipmentModelNumber set eqmodgrouplink = 40 where eqmodid = 1263

select * from wACom.lines where LILineName like 'Spare%'
--update wACom.lines set LIActive = 0 where LIID in (139, 140)
select * from wACom.machinelist where MLCELLNAME like 'Spare%'
select * from wACom.lines where LISatellite = 28
--
-- for some reason the lines under Misc Equip for paint where marked in-active
-- so at the request of Bob Parker I reset them.
--
--update wACom.lines set LIActive = 1 where LIID in (select liid from wACom.lines where LISatellite = 28)
select * from wACom.Areas
--update wACom.Areas set aaactive = 1 where aaid = 1 and aaplant = 1


SELECT     wACom.MachineList.MLCELLNAME, wACom.MachineList.MLPlantID, wACom.MachineList.MLLINEID, EquipmentModelNumber_1.EQModModelNumber, 
                      EquipmentModelNumber_1.EQModManID, EquipmentModelNumber_1.EQModDescription, EquipmentModelNumber_1.EQModVendorID, 
                      EquipmentModelNumber_1.EQModOrderNumber, EquipmentModelNumber_1.EQModImageOne, EquipmentModelNumber_1.EQModID, wACom.MachineList.MLID, 
                      EQP.ProcNumbers.PROCNUMBER, EQP.ProcNumbers.PROCNAME, EQP.ProcNumbers.PROCASSET, EQP.ProcNumbers.PROCARG, EQP.ProcNumbers.PROCMODEL, 
                      EQP.ProcNumbers.PROCQUARTGROUP, EQP.ProcNumbers.PROCSEMIGROUP, EQP.ProcNumbers.PROCANUALGROUP, EQP.ProcNumbers.PROCMONTHGROUP, 
                      EQP.ProcNumbers.PROCWEEKGROUP, EQP.ProcNumbers.PROCID, EQP.ProcNumbers.PROCBIMONTHGROUP, EQP.ProcNumbers.PROCTWOYRGRUP, 
                      EQP.ProcNumbers.PROCEIGHTYRGROUP, EQP.ProcNumbers.PROCFOURYRGROUP, EQP.ProcNumbers.PROCTHREEYRGROUP, EQP.ProcNumbers.PROCASSIGNTO, 
                      wACom.TeamListDrop.Myname, EQP.ProcNumbers.PROCIPLINK, wACom.Lines.LILineName, wACom.Lines.LISatellite, wACom.Lines.LIID, wACom.Areas.AAareaname, 
                      wACom.Areas.AAID, wACom.Areas.AAPlant, EQP.ProcNumbers.PROCACTIVE, EQP.Equipment.EQNote, EQP.Equipment.EQTID, EQP.Equipment.EQTPrintNumber, 
                      EQP.Equipment.EQInService, EQP.Equipment.EQServiceDate, EQP.Equipment.EQSerialNumber, EQP.Equipment.EQTModelLink, 
                      EQP.EquipmentModelNumber.EQModModelNumber AS AssetModNumber, EQP.EquipmentModelNumber.EQModDescription AS AssetDescription, 
                      EQP.ProcNumbers.PROCASSETASSIGNABLE, EQP.IPTable.IPTIPText, wACom.MachineList.MLActive, wACom.Lines.LIActive,	wACom.Areas.AAActive
FROM         EQP.Equipment LEFT OUTER JOIN
                      EQP.EquipmentModelNumber ON EQP.Equipment.EQTModelLink = EQP.EquipmentModelNumber.EQModID RIGHT OUTER JOIN
                      EQP.IPTable RIGHT OUTER JOIN
                      EQP.ProcNumbers ON EQP.IPTable.IPTID = EQP.ProcNumbers.PROCIPLINK ON EQP.Equipment.EQTID = EQP.ProcNumbers.PROCASSET LEFT OUTER JOIN
                      wACom.TeamListDrop ON EQP.ProcNumbers.PROCASSIGNTO = wACom.TeamListDrop.TMID LEFT OUTER JOIN
                      EQP.EquipmentModelNumber AS EquipmentModelNumber_1 ON EQP.ProcNumbers.PROCMODEL = EquipmentModelNumber_1.EQModID LEFT OUTER JOIN
                      wACom.Lines LEFT OUTER JOIN
                      wACom.Areas ON wACom.Lines.LISatellite = wACom.Areas.AAID RIGHT OUTER JOIN
                      wACom.MachineList ON wACom.Lines.LIID = wACom.MachineList.MLLINEID ON EQP.ProcNumbers.PROCARG = wACom.MachineList.MLID
where (wACom.MachineList.MLActive = 1 and  wACom.Lines.LIActive = 1  and wACom.Areas.AAActive = 1)