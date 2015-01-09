--
--  relationships on the create the WO screen
--  will use this to map the new form creation to.
--
select disid, 
	DISEquip,DISOpenDate, DISCloseDate, DISDueDate, disclosedincomplete,
	DISType, (SELECT WOCName FROM [WO].[WorkOrderCodes] where WOCID = DISType),
	DISTPMNumber
from wo.WorkOrderMain where DISequip in (3895, 3896) and DISType = 3
--order by DISResponsible
--AND DISType = 3 AND DISCloseDate IS NULL
--ORDER BY DISOpenDate

select * from TPM.TPMProcdure

-- search wo's for text string
select womain.DISID, womain.DISCloseDate, pmnumber.PROCNUMBER, 
	modelnu.EQModDescription, womain.DISWorkAccomp
from wo.WorkOrderMain womain
	left join eqp.ProcNumbers pmnumber on womain.DISEquip = pmnumber.PROCID
	left join EQP.EquipmentModelNumber modelnu on pmnumber.PROCMODEL = modelnu.EQModID
where DISCloseDate is not null
	and DISWorkAccomp like '%Robot%'
select * from wo.WorkOrderMain where DISEquip = 12881
-- where DISEquip in (select procid from eqp.ProcNumbers where PROCNUMBER = '1B12-4510-RB01')
--
-- search for wo created/open on a date
--select DISOpenDate, DISDueDate, womain.DISID, womain.DISEquip, pn.PROCID, pn.PROCMODEL, 
--	tpmproc.TPMProcFreq, freq.TPMFreqFrequency
--from wo.WorkOrderMain womain
--	left join eqp.ProcNumbers pn on womain.DISEquip = pn.PROCID
--	left join tpm.TPMProcdure tpmproc on pn.PROCMODEL = tpmproc.TMPProcModelLink
--	left join tpm.TPMFrequency freq on tpmproc.TPMProcFreq = freq.TPMFreqID
--where DISOpenDate = '11/05/2012' order by womain.DISID
--select * from tpm.TPMFrequency
--select * from eqp.ProcNumbers where PROCID = 1511
--select * from tpm.GrandSchedule where GSCWMonDate = '11/05/2012'
declare @DatePass date
set @DatePass = '11/05/2012'
--
--
DECLARE	@MG		INT	= (SELECT TOP 1 GSMonthGroup FROM TPM.GrandSchedule WHERE GSCWMonDate <= @DatePass	ORDER BY GSCWMonDate DESC),
		@BMG	INT	= (SELECT TOP 1 GSBiMonthGroup FROM TPM.GrandSchedule WHERE GSCWMonDate <= @DatePass	ORDER BY GSCWMonDate DESC),
		@QG		INT	= (SELECT TOP 1 GSQuarterlyGroup FROM TPM.GrandSchedule WHERE GSCWMonDate <= @DatePass	ORDER BY GSCWMonDate DESC),
		@SAG	INT	= (SELECT TOP 1 GSSemiAnGroup FROM TPM.GrandSchedule WHERE GSCWMonDate <= @DatePass	ORDER BY GSCWMonDate DESC),
		@AG		INT	= (SELECT TOP 1 GSAnGroup FROM TPM.GrandSchedule WHERE GSCWMonDate <= @DatePass	ORDER BY GSCWMonDate DESC),
		@TYG	INT	= (SELECT TOP 1 GSTwoYearGroup FROM TPM.GrandSchedule WHERE GSCWMonDate <= @DatePass	ORDER BY GSCWMonDate DESC),
		@THYG	INT	= (SELECT TOP 1 GSThreeYearGroup FROM TPM.GrandSchedule WHERE GSCWMonDate <= @DatePass	ORDER BY GSCWMonDate DESC),
		@FYG	INT	= (SELECT TOP 1 GSFourYearGroup FROM TPM.GrandSchedule WHERE GSCWMonDate <= @DatePass	ORDER BY GSCWMonDate DESC),
		@EYG	INT	= (SELECT TOP 1 GSEightYearGroup FROM TPM.GrandSchedule WHERE GSCWMonDate <= @DatePass	ORDER BY GSCWMonDate DESC);
select @MG as [Monthly], @BMG BiMon, @QG Quarterly, @SAG SemiQuarter, @AG Anual, @TYG TwoYr, @THYG ThreeYG, @FYG FiveYr, @EYG EightYr

select DISOpenDate, DISDueDate, womain.DISID, womain.DISEquip, pn.PROCID, pn.PROCMODEL,
PN.PROCMONTHGROUP, PN.PROCBIMONTHGROUP, PN.PROCQUARTGROUP, PN.PROCSEMIGROUP, PN.PROCANUALGROUP,
PN.PROCTWOYRGRUP, PN.PROCTHREEYRGROUP, PN.PROCFOURYRGROUP, PN.PROCEIGHTYRGROUP,
		TPR.TPMProcFreq, freq.TPMFreqFrequency, Freq.TPMFreqDueModifier
from wo.WorkOrderMain womain
	join eqp.ProcNumbers pn on womain.DISEquip = pn.PROCID
	JOIN TPM.TPMProcdure AS TPR ON TPR.TMPProcModelLink = PN.PROCMODEL
	join TPM.TPMFrequency Freq on tpr.TPMProcFreq = Freq.TPMFreqID
		WHERE DISOpenDate = @DatePass and
			(
				(PN.PROCMONTHGROUP		= @MG	AND TPR.TPMProcFreq = 6)
					OR
				(PN.PROCBIMONTHGROUP	= @BMG	AND TPR.TPMProcFreq = 5) 
					OR
				(PN.PROCQUARTGROUP		= @QG	AND TPR.TPMProcFreq = 7)
					OR
				(PN.PROCSEMIGROUP		= @sag	AND TPR.TPMProcFreq = 8)
					OR
				(PN.PROCANUALGROUP		= @AG	AND TPR.TPMProcFreq = 9)
					OR
				(PN.PROCTWOYRGRUP		= @TYG	AND TPR.TPMProcFreq = 10) 	
					OR
				(PN.PROCTHREEYRGROUP	= @THYG	AND TPR.TPMProcFreq = 11)
					OR
				(PN.PROCFOURYRGROUP		= @FYG	AND TPR.TPMProcFreq = 13)
					OR
				(PN.PROCEIGHTYRGROUP	= @EYG	AND TPR.TPMProcFreq = 14) 
			)
order by TPR.TPMProcFreq
--
--  frigure the weekly WO
--
select pn.PROCID, pn.PROCMODEL, pn.PROCARG, ml.MLID, ml.MLPlantID,
PN.PROCMONTHGROUP, PN.PROCBIMONTHGROUP, PN.PROCQUARTGROUP, PN.PROCSEMIGROUP, PN.PROCANUALGROUP,
PN.PROCTWOYRGRUP, PN.PROCTHREEYRGROUP, PN.PROCFOURYRGROUP, PN.PROCEIGHTYRGROUP,
		tpr.TPMProcID, tpr.TPMProcFreq, freq.TPMFreqFrequency, Freq.TPMFreqDueModifier
from eqp.ProcNumbers pn 
	JOIN TPM.TPMProcdure AS TPR ON TPR.TMPProcModelLink = PN.PROCMODEL
	join TPM.TPMFrequency Freq on tpr.TPMProcFreq = Freq.TPMFreqID
	join wacom.MachineList ml on pn.PROCARG = ml.MLID
		WHERE tpr.TPMProcFreq = 4 
					AND PN.PROCID NOT IN (	SELECT DISEquip 
									FROM WO.WorkOrderMain
									WHERE DISCloseDate Is Null
									AND
									DISTPMNumber = TPR.TPMProcID)
order by TPR.TPMProcID
exec [wAppTPM].[TPMTestGenerator] '02/11/2013'