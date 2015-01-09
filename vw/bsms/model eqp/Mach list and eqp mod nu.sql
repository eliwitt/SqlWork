-- by area 
select * from wACom.machinelist where MLCELLNAME like 'LF0112-BLU%'
select * from wACom.MachineListDropView where MLCELLNAME like 'LF0112-BLU%'
-- by model
select * from eqp.EquipmentModelNumber where EQModModelNumber like 'B-CV_CROSS CHAIN%'

select * from EQP.Equipment where EQTModelLink = 717

-- group one
select * from EQP.ModelGroupOne
-- group two
select * from EQP.ModelGroupTwo
-- group three
select * from EQP.ModelGroupThree