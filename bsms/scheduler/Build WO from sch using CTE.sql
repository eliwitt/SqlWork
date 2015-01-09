--
-- gather the schedule data to create the WOs
--
IF object_id('TempDB..#schPMData') IS NOT NULL
 DROP TABLE #schPMData;

create table #schPMData (schKey int, schProcID int, schPMEst decimal(18,0), schPMTitle nvarchar(255), schWorkReq nvarchar(max) )
--
--builds the list of PMs for the WOs
--
insert into #schPMData 
	select sch.schkey, PMitem.TPMProcID, PMitem.TPMProcEstMin, PMitem.TPMProcTitle, 
		PMitem.TPMProcProcedure + wAppTPM.RetrieveProcString(PMitem.TPMProcID) as WorkRequired
	from Scheduler.ChampsSchedules sch
		join Scheduler.ChampsSchPMGroups schPMs on sch.schKey = schPMs.ChampsSchedule_schKey
		join Scheduler.ChampsSchPMGrpHasPMs HasPMs on schPMs.schPMGrpKey = HasPMs.ChampsSchPMGroups_schPMGrpKey
		join TPM.TPMProcdure PMitem on HasPMs.TPMProcdures_TPMProcID = PMitem.TPMProcID
	where sch.schName like 'add%'

select * from #schPMData

--
-- Combines the Work required from schedules with mult PMs into one.
--  Not sure how to use right now but have it
select Distinct schkey, 
	(Select ''+ Kids.schWorkReq 
			from #schPMData Kids
			where Kids.schKey = Parent.schKey
			order by Kids.schKey
			for XML path('')) 'WorkList', 
(Select sum(cKids.schPMEst) from #schPMData cKids where cKids.schKey = Parent.schKey) PMEst
from #schPMData Parent

; with schEquipment as
(
select sch.schkey, sch.schAssignedTo, Procitem.PROCID, Procitem.PROCARG, Procitem.PROCMODEL, Procitem.PROCASSIGNTO
from Scheduler.ChampsSchedules sch
	join Scheduler.ChampsSchProcGroups schProcs on sch.schKey = schProcs.ChampsSchedule_schKey
	join Scheduler.ChampsSchProcGrpHasProcs HasProcs on schProcs.schProcGrpKey = HasProcs.ChampsSchProcGroups_schProcGrpKey
	join EQP.ProcNumbers Procitem on HasProcs.ProcNumbers_PROCID = Procitem.PROCID
where sch.schName like 'add%'

)
select * from schEquipment order by schkey

--============================= the list =============================
			--PN.PROCID,			l
			--PN.PROCARG,			l
			--PN.PROCMODEL,			l
			--Type = 3,
			--OPENDATE = @DatePass,
			--case Freq.TPMFreqDueModifier
			--	when 0 then DATEADD(DAY,6,@DatePass)
			--	else DATEADD(DAY,Freq.TPMFreqDueModifier,@DatePass)
			--end DUEDATE,
			--TPR.TPMProcID,		X
			--(TPR.TPMProcProcedure + wAppTPM.RetrieveProcString(TPR.TPMProcID)),
			--PN.PROCASSIGNTO,		l
			--TPR.TPMPRocEstMin,	X
			--case Freq.TPMFreqDueModifier
			--	when 0 then DATEADD(DAY,6,@DatePass)
			--	else DATEADD(DAY,Freq.TPMFreqDueModifier,@DatePass)
			--end SchDATE
--====================================================================
--; with schData as 
--(
--select sch.schkey, 'P' schType, sch.schName, schDescription, schPMDescription, schPMs.schPMGrpKey, PMitem.TMPProcModelLink, PMitem.TPMProcEstMin, PMitem.TPMProcTitle
--from Scheduler.ChampsSchedules sch
--	join Scheduler.ChampsSchPMGroups schPMs on sch.schKey = schPMs.ChampsSchedule_schKey
--	join Scheduler.ChampsSchPMGrpHasPMs HasPMs on schPMs.schPMGrpKey = HasPMs.ChampsSchPMGroups_schPMGrpKey
--	join TPM.TPMProcdure PMitem on HasPMs.TPMProcdures_TPMProcID = PMitem.TPMProcID
--where sch.schName like 'add%'
--union all
--select sch.schkey, 'L', sch.schName,schDescription,schProcDescription, schProcs.schProcGrpKey, null, null, Procitem.procnumber
--from Scheduler.ChampsSchedules sch
--	join Scheduler.ChampsSchProcGroups schProcs on sch.schKey = schProcs.ChampsSchedule_schKey
--	join Scheduler.ChampsSchProcGrpHasProcs HasProcs on schProcs.schProcGrpKey = HasProcs.ChampsSchProcGroups_schProcGrpKey
--	join EQP.ProcNumbers Procitem on HasProcs.ProcNumbers_PROCID = Procitem.PROCID
--where sch.schName like 'add%'

--)
--select * from schData order by schkey asc, schType desc