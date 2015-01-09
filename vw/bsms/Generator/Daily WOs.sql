select pn.PROCID, pn.PROCMODEL, pn.PROCARG, ml.MLID, ml.MLPlantID,
PN.PROCMONTHGROUP, PN.PROCBIMONTHGROUP, PN.PROCQUARTGROUP, PN.PROCSEMIGROUP, PN.PROCANUALGROUP,
PN.PROCTWOYRGRUP, PN.PROCTHREEYRGROUP, PN.PROCFOURYRGROUP, PN.PROCEIGHTYRGROUP,
		tpr.TPMProcID, tpr.TPMProcFreq, freq.TPMFreqFrequency, Freq.TPMFreqDueModifier
from eqp.ProcNumbers pn 
	JOIN TPM.TPMProcdure AS TPR ON TPR.TMPProcModelLink = PN.PROCMODEL
	join TPM.TPMFrequency Freq on tpr.TPMProcFreq = Freq.TPMFreqID
	join wacom.MachineList ml on pn.PROCARG = ml.MLID
			join wACom.Lines ON wACom.Lines.LIID = ml.MLLINEID 
			join wACom.Areas ON wACom.Lines.LISatellite = wACom.Areas.AAID 		
		WHERE (PROCACTIVE = 1 and MLActive = 1 and  LIActive = 1  and AAActive = 1) and
			tpr.TPMProcFreq = 2