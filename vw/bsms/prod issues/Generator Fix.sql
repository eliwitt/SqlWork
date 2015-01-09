	SELECT 
			PN.PROCID,
			PN.PROCARG,
			PN.PROCMODEL, pn.PROCACTIVE, 
			pn.PROCARG, lines.LIID, lines.LIActive,
			TPR.TPMProcID,
			(TPR.TPMProcProcedure + wAppTPM.RetrieveProcString(TPR.TPMProcID)),
			PN.PROCASSIGNTO,
			TPR.TPMPRocEstMin
		FROM EQP.ProcNumbers as PN
		left join wACom.Lines Lines on pn.PROCARG = Lines.LIID
		JOIN TPM.TPMProcdure AS TPR ON TPR.TMPProcModelLink = PN.PROCMODEL
		join TPM.TPMFrequency Freq on tpr.TPMProcFreq = Freq.TPMFreqID
		WHERE tpr.TPMProcID = 47