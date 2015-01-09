--
--   This is the main select from [wAppTPM].[TPMAutoGenerator] it currently 
--   does not check to see if the equipment that is ready to have a PM created
--   is really active or not.  I checked the equipment itself but the line could have been 
--   de-activated.  Should add this check to the autogenerator so de-actives do not generate.
--   
	SELECT 
			PN.PROCID,
			PN.PROCARG,
			PN.PROCMODEL,
			Type = 3,
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
		WHERE (PROCACTIVE = 1 and MLActive = 1 and  LIActive = 1  and AAActive = 1)
		order by pn.procid