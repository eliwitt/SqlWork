	DECLARE @DatePass date;
DECLARE @failedOver bit;


--SET @DatePass = CAST(GETDATE() AS Date)
SET @DatePass = '2013-01-07'

-- Get the Schedule structrure from the Grand Schedule and Load it.

DECLARE	@MG		INT	= (SELECT TOP 1 GSMonthGroup FROM TPM.GrandSchedule WHERE GSCWMonDate <= @DatePass	ORDER BY GSCWMonDate DESC),
		@BMG	INT	= (SELECT TOP 1 GSBiMonthGroup FROM TPM.GrandSchedule WHERE GSCWMonDate <= @DatePass	ORDER BY GSCWMonDate DESC),
		@QG		INT	= (SELECT TOP 1 GSQuarterlyGroup FROM TPM.GrandSchedule WHERE GSCWMonDate <= @DatePass	ORDER BY GSCWMonDate DESC),
		@SAG	INT	= (SELECT TOP 1 GSSemiAnGroup FROM TPM.GrandSchedule WHERE GSCWMonDate <= @DatePass	ORDER BY GSCWMonDate DESC),
		@AG		INT	= (SELECT TOP 1 GSAnGroup FROM TPM.GrandSchedule WHERE GSCWMonDate <= @DatePass	ORDER BY GSCWMonDate DESC),
		@TYG	INT	= (SELECT TOP 1 GSTwoYearGroup FROM TPM.GrandSchedule WHERE GSCWMonDate <= @DatePass	ORDER BY GSCWMonDate DESC),
		@THYG	INT	= (SELECT TOP 1 GSThreeYearGroup FROM TPM.GrandSchedule WHERE GSCWMonDate <= @DatePass	ORDER BY GSCWMonDate DESC),
		@FYG	INT	= (SELECT TOP 1 GSFourYearGroup FROM TPM.GrandSchedule WHERE GSCWMonDate <= @DatePass	ORDER BY GSCWMonDate DESC),
		@EYG	INT	= (SELECT TOP 1 GSEightYearGroup FROM TPM.GrandSchedule WHERE GSCWMonDate <= @DatePass	ORDER BY GSCWMonDate DESC);

	SELECT 
			PN.PROCID,
			PN.PROCMODEL, pn.PROCACTIVE, lines.LIPlant,
			pn.PROCARG, lines.LIID, lines.LIActive, pn.PROCMONTHGROUP,
			OPENDATE = @DatePass,
			DUEDATE = DATEADD(DAY,6,@DatePass),
			TPR.TPMProcFreq,
			case Freq.TPMFreqDueModifier
				when 0 then DATEADD(DAY,6,@DatePass)
				else DATEADD(DAY,Freq.TPMFreqDueModifier,@DatePass)
			end newdate, 
			TPR.TPMProcID,
			(TPR.TPMProcProcedure + wAppTPM.RetrieveProcString(TPR.TPMProcID)),
			PN.PROCASSIGNTO,
			TPR.TPMPRocEstMin
		FROM EQP.ProcNumbers as PN
			join wACom.MachineList ON pn.PROCARG = wACom.MachineList.MLID
			join wACom.Lines ON wACom.Lines.LIID = wACom.MachineList.MLLINEID 
			join wACom.Areas ON wACom.Lines.LISatellite = wACom.Areas.AAID 
		JOIN TPM.TPMProcdure AS TPR ON TPR.TMPProcModelLink = PN.PROCMODEL
		join TPM.TPMFrequency Freq on tpr.TPMProcFreq = Freq.TPMFreqID
		WHERE (PROCACTIVE = 1 and MLActive = 1 and  LIActive = 1  and AAActive = 1) and 
		(
			(
				(PN.PROCMONTHGROUP		= @MG	AND TPR.TPMProcFreq = 6)
					OR
				(PN.PROCBIMONTHGROUP	= @BMG	AND TPR.TPMProcFreq = 5) 
					OR
				(PN.PROCQUARTGROUP		= @QG	AND TPR.TPMProcFreq = 7)
					OR
				(PN.PROCSEMIGROUP		= @QG	AND TPR.TPMProcFreq = 8)
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
			
			--AND PN.PROCID NOT IN (SELECT * FROM wAppTPM.CheckTPMExists(TPR.TPMProcID))
			--AND PN.PROCID NOT IN (	SELECT DISEquip 
			--						FROM WO.WorkOrderMain
			--						WHERE DISCloseDate Is Null
			--						AND
			--						DISTPMNumber = TPR.TPMProcID)
		) order by PROCID