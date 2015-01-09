--==================================================================
--
-- this script builds the schedule data from the existing PM data
-- in an effort to cut down on the test to create this data manually.
--
--=================================================================
--
-- Mapping list
--
--=========	ChampsSchedules ==============
--
--		schName = 'SCH' + PNCode + tpmprocid
--		schDescription = 'SCH--' + tpmfreqfrequency + '--' + tpmproctitle
--		schActive = 1
--		schPlant = tpmprocplantassign
--      schShutDown = 0
--		schLastScheduledDT = getdate()
--		schLastCompletedDT = getdate()
--		schSinceLastScheduledInd = 1  0 = off 1 = on
--		schLastScheduledFreq = tpmfreqduemodifier
--		schSinceLastCompleteInd = 0  0 = off 1 = on
--		schLastCompetedFreq = 0
--		schAssignedTo = procassignto
--		schValidMon = 1
--		schValidTue = 1
--		schValidWed = 1
--		schValidThru = 1
--		schValidFri = 1
--		schValidSat = 1
--		schValidSun = 1
--		schUptId = 0
--		schUptDT = getdate()
--=============================================
--=========	ChampsSchPMGroups =================
--
--		schPMName = 'GRP' + tpmprocid
--		schPMDescription = 'GRP--' + tpmproctitle
--		ChampsSchedule_schKey = the identity of the schedule just created.
--=============================================
--=========	ChampsSchPMGrpHasPMs =================
--		ChampsSchPMGroups_schPMGrpKey = the identity of the grp just added.
--		TPMProcdures_TPMProcID = tpmprocid
--=============================================
--=========	ChampsSchProcGroups =================
--		schProcName = 'PROC--PMID' + tpmprocid
--		schProcDescription = 'PROC--' + tpmproctitle
--		ChampsSchedule_schKey = the identity of the schedule just created.
--=============================================
--=========	ChampsSchProcGrpHasProcs =================
--		ChampsSchProcGroups_schProcGrpKey = the identity of the grp just added.
--		ProcNumbers_PROCID = procid
--=============================================
declare @Plant int, @Procid int, 
	@proctitle nvarchar(255), @pncode nchar(10),
	@FreqFrequency nvarchar(255), 
	@FreqPeriod int, @assignedto int,
	@newSchID int, @newPMGrpId int, @newProcGrpId int, @locid int,
	@woLastSchDt datetime, @woLastCompDt datetime
	
-- declare the cursor
declare pmcursor cursor local
for select tpr.TPMProcPlantAssign, tpr.TPMProcID, tpr.TPMProcTitle, 
	plt.PNCode, freq.TPMFreqFrequency, freq.TPMFreqPeriod,
	0 assignedto
from tpm.TPMProcdure tpr
	left join tpm.TPMFrequency freq on tpr.TPMProcFreq = freq.TPMFreqID
	left join Team.wAPlants plt on tpr.TPMProcPlantAssign = plt.PNID
--where plt.PNName = 'Infrastructure'
-- open it
open pmcursor
-- fetch a row
fetch next from pmcursor into @Plant, @Procid, @proctitle, @pncode,
	@FreqFrequency, @FreqPeriod, @assignedto
-- loop until there are no more
while(@@FETCH_STATUS = 0)
begin
	-- using the the pm nu get the greatest date for last sch and last comp
	select @woLastSchDt = MAX(disopendate), @woLastCompDt = MAX(DISCLOSEdate) from wo.WorkOrderMain where DISTPMNumber = @Procid
	-- insert into ChampsSchedules
	insert into Scheduler.ChampsSchedules values (
		'SCH' + RTRIM(@pncode) + cast(@Procid as nvarchar(10)),
		'SCH--' + @FreqFrequency + '--' + @proctitle,
		@Plant, 0, 0, 0, @woLastSchDt, @woLastCompDt,
		1, @FreqPeriod, 0, 0, @assignedto, 
		1, 1, 1, 1, 1, 1, 1, 99999, getdate())
	-- get the id of the row just inserted
	select @newSchID=@@IDENTITY
	-- ==================================================
	-- insert the pm and proc groups information and the 
	-- relationship information
	-- ==================================================
	--
	-- pm tables first
	--
	insert into Scheduler.ChampsSchPMGroups values ('PMGRP' + cast(@Procid as nvarchar(10)),
		'PMGRP--' + @proctitle, 99999, getdate(), @newSchID)
	select @newPMGrpId=@@IDENTITY
	insert into Scheduler.ChampsSchPMGrpHasPMs values (@newPMGrpId, @Procid)
	--
	-- proc table last
	--	
	insert into Scheduler.ChampsSchProcGroups values ('LOC--PMID' + cast(@Procid as nvarchar(10)),
		'LOCGRP--' + @proctitle, 99999, getdate(), @newSchID)
	select @newProcGrpId=@@IDENTITY	
	-- =================================================
	-- loop thru all of the locations and add the relationship
	-- =================================================
	declare procCursor cursor local
	for select procid from EQP.ProcNumbers PN
	join tpm.TPMProcdure tpr on tpr.TMPProcModelLink = pn.PROCMODEL
	where tpr.TPMProcID = @Procid
	open procCursor
	fetch next from procCursor into @locid
	while(@@FETCH_STATUS = 0)
	begin
		-- insert into wacom.t2errors
		insert into Scheduler.ChampsSchProcGrpHasProcs values (@newProcGrpId, @locid)
		
		-- end of table two loop
		fetch next from procCursor into @locid
	end
	close procCursor
	deallocate procCursor
	
	-- end of ChampsSchedules table loop
	fetch next from pmcursor into @Plant, @Procid, @proctitle, @pncode,
	@FreqFrequency, @FreqPeriod, @assignedto
end
-- close the cursor
close pmcursor
-- deallocate it
deallocate pmcursor 