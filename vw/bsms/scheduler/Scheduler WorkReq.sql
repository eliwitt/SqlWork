--
-- combine the work requied text from each PM that belong to a schedule.
--
; with schWorkRequired (RowNumber, schKey, theWork, WorkReqComb) as 
(
select 1, sch.schkey, MIN(PMitem.TPMProcTitle) thewrk,
		PMitem.TPMProcProcedure + wAppTPM.RetrieveProcString(PMitem.TPMProcID) as WorkRequired
from Scheduler.ChampsSchedules sch
	join Scheduler.ChampsSchPMGroups schPMs on sch.schKey = schPMs.ChampsSchedule_schKey
	join Scheduler.ChampsSchPMGrpHasPMs HasPMs on schPMs.schPMGrpKey = HasPMs.ChampsSchPMGroups_schPMGrpKey
	join TPM.TPMProcdure PMitem on HasPMs.TPMProcdures_TPMProcID = PMitem.TPMProcID
where sch.schName like 'add%'
group by schKey, PMitem.TPMProcProcedure, PMitem.TPMProcID
union all
select  schReqTxt.RowNumber + 1, sch.schkey, PMitem.TPMProcTitle,
	schReqTxt.WorkReqComb + PMitem.TPMProcProcedure + wAppTPM.RetrieveProcString(PMitem.TPMProcID) as WorkRequired
from Scheduler.ChampsSchedules sch
	join Scheduler.ChampsSchPMGroups schPMs on sch.schKey = schPMs.ChampsSchedule_schKey
	join Scheduler.ChampsSchPMGrpHasPMs HasPMs on schPMs.schPMGrpKey = HasPMs.ChampsSchPMGroups_schPMGrpKey
	join TPM.TPMProcdure PMitem on HasPMs.TPMProcdures_TPMProcID = PMitem.TPMProcID
	join schWorkRequired schReqTxt on schReqTxt.schKey = sch.schKey
where PMitem.TPMProcTitle > schReqTxt.theWork
)
select schMax.maxrow, schMax.schKey, WorkReqComb from schWorkRequired schReq
	inner join Scheduler.ChampsSchedules sch on sch.schKey = schReq.schKey
	inner join (
		select schkey, MAX(rownumber) as maxrow
		from schWorkRequired group by schKey
	) schMax on schReq.RowNumber = schMax.maxrow and schReq.schKey = schMax.schKey


--select * from #schPMData

--
-- Combines the Work required from schedules with mult PMs into one.
-- It converts the cariage return into hex.  Don't know how well that will work.
--
--  Not sure how to use right now but have it
--
--select Distinct schkey, 
--	(Select ''+ Kids.schWorkReq 
--			from #schPMData Kids
--			where Kids.schKey = Parent.schKey
--			order by Kids.schKey
--			for XML path('')) 'WorkList', 
--(Select sum(cKids.schPMEst) from #schPMData cKids where cKids.schKey = Parent.schKey) PMEst
--from #schPMData Parent