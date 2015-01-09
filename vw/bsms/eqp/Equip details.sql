--
-- Lets find the equipment asset information shall we
--
select * from EQP.ProcNumbers where PROCNumber = '1A01-BA3-APM40R'
--update EQP.ProcNumbers set procmodel = 1141 where procid = 12969
--
-- proc ids 
--	2,4068-has multiple PMs
--	12957-has none
--
--exec wAppEQP.EqpSearch 4068
select distinct PROCNUMBER, procasset, procmodel, Equip.EQSerialNumber, PROCARG, ModelNu.EQModModelNumber,
		PROCASSIGNTO, tm.TMFirstName + ' ' + tm.TMLastName 'AssignTo', 
		substring((Select ','+cast(Proc1.TPMProcID as nvarchar(6)) [text()] 
			from tpm.TPMProcdure Proc1
			where PROCMODEL = Proc1.TMPProcModelLink
			order by Proc1.TPMProcID
			for XML path('')),2,1000) 'ProcList'
	from EQP.ProcNumbers PN
		left outer join team.teammembers TM on PROCASSIGNTO = tm.TMID
		left outer join EQP.EquipmentModelNumber ModelNu on PROCMODEL = ModelNu.EQModID
		left outer join wACom.MachineList ML on PROCARG = ml.MLID
		left outer join eqp.Equipment Equip on PROCASSET = EQTID
	where PROCID = 12969
	
select DISID, 
substring((Select ','+cast(Kids.DISID as nvarchar(6)) [text()] 
			from WO.WorkOrderMain Kids
			where Kids.DISParentID = Parent.DISID
			order by Kids.DISID
			for XML path('')),2,1000) 'ProcList', 
(Select count(cKids.DISID) from WO.WorkOrderMain cKids where cKids.DISParentID = Parent.DISID) NuOfKids
from WO.WorkOrderMain Parent where DISID = 107196
--
-- sep tables in this relationship	
--	
--select * from EQP.EquipmentModelNumber where EQModID in (1252, 1251)
--select * from EQP.ProcNumbers where PROCMODEL = 680
--select * from tpm.TPMProcdure where TMPProcModelLink in (1251, 1252)

-- possible alternate col combiningw
--
--declare @s varchar(8000)
--select @s = coalesce(@s + ', ' + col, col) from tbl


--original
--
--select distinct PROCNUMBER, procasset, procmodel, Equip.EQSerialNumber, PROCARG, ModelNu.EQModModelNumber,
--		PROCASSIGNTO, tm.TMFirstName + ' ' + tm.TMLastName 'AssignTo', procnu.TPMProcTitle
--	from EQP.ProcNumbers PN
--		left outer join team.teammembers TM on PROCASSIGNTO = tm.TMID
--		left outer join EQP.EquipmentModelNumber ModelNu on PROCMODEL = ModelNu.EQModID
--		left outer join tpm.TPMProcdure ProcNu on PROCMODEL = procnu.TMPProcModelLink
--		left outer join wACom.MachineList ML on PROCARG = ml.MLID
--		left outer join eqp.Equipment Equip on PROCASSET = EQTID
--	where PROCID = 4068