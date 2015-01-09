declare @plant int
set @plant = 1
IF object_id('TempDB..#schTPMData') IS NOT NULL
 DROP TABLE #schTPMData;

create table #schTPMData (schPlant int, schpncode nchar(10), schTPMKey int, schDescrip nvarchar(max), 
	schShift nvarchar(max),schTPMPeriod int, schProcId int, schProcnu nvarchar(max))
insert into #schTPMData
select procnu.TPMProcPlantAssign, plt.PNCode, procnu.TPMProcID, procnu.TPMProcTitle, 
		case when tm.STShiftName is null then 'Unassigned' else tm.STShiftName end, 
		freq.TPMFreqPeriod, procid, PROCNUMBER
	from EQP.ProcNumbers PN
		left outer join Team.TeamMemberEditView TM on PROCASSIGNTO = tm.TMID
		left outer join EQP.EquipmentModelNumber ModelNu on PROCMODEL = ModelNu.EQModID
		left outer join wACom.MachineList ML on PROCARG = ml.MLID
		join wACom.Lines ON wACom.Lines.LIID = ML.MLLINEID 
		join wACom.Areas ON wACom.Lines.LISatellite = wACom.Areas.AAID 				
		left outer join tpm.TPMProcdure ProcNu on PROCMODEL = procnu.TMPProcModelLink
		left join tpm.TPMFrequency freq on ProcNu.TPMProcFreq = freq.TPMFreqID
		left join Team.wAPlants plt on ml.MLPlantID = plt.PNID
where ml.MLPlantID = @plant and procnu.TPMProcID is not null
	and (PROCACTIVE = 1 and MLActive = 1 and  LIActive = 1  and AAActive = 1)	
order by TPMProcID, STShiftName, PROCID

--select * from #schTPMData

insert into Scheduler.ChampsSchedules 
select distinct RTRIM(schpncode) + cast(schTPMKey as nvarchar(10)) as schname, schDescrip + '--' + schShift, schPlant,
	0, 0, 0, (select MAX(disopendate) from wo.WorkOrderMain where DISTPMNumber = schTPMKey),
	(select MAX(DISCLOSEdate) from wo.WorkOrderMain where DISTPMNumber = schTPMKey), 1, schTPMPeriod,
	0,0,0,0,1, 1, 1, 1, 1, 1, 1,99999, getdate()
from #schTPMData order by schname

--select * from Scheduler.ChampsSchedules where schPlant = 1 order by schname
--select SUBSTRING(schDescription,CHARINDEX('Maintenance ',schDescription, 0)+12,10) from Scheduler.ChampsSchedules where schKey = 4193
--select distinct schPlant, schTPMKey, schDescrip, schShift, schTPMPeriod from #schTPMData
--select schProcId, schProcnu from #schTPMData 
--group by schPlant, schTPMKey, schDescrip, schShift, schTPMPeriod, schProcId, schProcnu
	-- ==================================================
	-- insert the pm and proc groups information and the 
	-- relationship information
	-- ==================================================
	--
	-- pm tables first
	--
insert into Scheduler.ChampsSchPMGroups 
select SUBSTRING(schDescription,CHARINDEX('--',schDescription, 0)+2,20),
schdescription, 99999, getdate(), schKey from Scheduler.ChampsSchedules where schPlant = @plant
	
--select * from Scheduler.ChampsSchPMGroups where ChampsSchedule_schKey in (select schKey from Scheduler.ChampsSchedules where schPlant = 1)	
	
insert into Scheduler.ChampsSchPMGrpHasPMs 
select schPMGrpKey, CAST(substring(schname, 3,10) as int) from Scheduler.ChampsSchPMGroups GRPs
	join Scheduler.ChampsSchedules Sch on GRPs.ChampsSchedule_schKey = Sch.schKey
where Sch.schPlant = @plant

	--
	-- proc table last
	--	
insert into Scheduler.ChampsSchProcGroups 
select SUBSTRING(schDescription,CHARINDEX('--',schDescription, 0)+2,20),
schdescription, 99999, getdate(), schKey from Scheduler.ChampsSchedules where schPlant = @plant



--select * from Scheduler.ChampsSchProcGroups where ChampsSchedule_schKey in (select schKey from Scheduler.ChampsSchedules where schPlant = 1)
--select * from Scheduler.ChampsSchProcGrpHasProcs
--select * from #schTPMData where schTPMKey = 1 and schShift = ''
insert into Scheduler.ChampsSchProcGrpHasProcs
select distinct schProcGrpKey, equipData.schProcId
	from Scheduler.ChampsSchedules sch
	left join Scheduler.ChampsSchProcGroups Grp on sch.schKey = Grp.ChampsSchedule_schKey
	left join (
	select schDescrip + '--' + schShift as EqDesc, schProcId from #schTPMData
	) equipData on sch.schDescription = equipData.EqDesc
where sch.schPlant = @plant

--select distinct 'SCH' + cast(schTPMKey as nvarchar(10)), 'SCH--' + schDescrip + '--' + schShift, schPlant,
--	0, 0, 0, (select MAX(disopendate) from wo.WorkOrderMain where DISTPMNumber = schTPMKey),
--	(select MAX(DISCLOSEdate) from wo.WorkOrderMain where DISTPMNumber = schTPMKey), 1, schTPMPeriod,
--	0,0,0,0,0,0,0,0,0,0,0,99999, getdate()
--from #schTPMData
-- -------------------------------------------------------
-- Insert the equipment 8792
-- -------------------------------------------------------
--insert into Scheduler.ChampsSchProcGrpHasProcs values (@newProcGrpId, @locid)