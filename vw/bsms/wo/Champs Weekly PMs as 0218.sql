select pn.PROCID, pn.PROCNUMBER 'Equip Name',
pn.PROCMODEL, (SELECT EQModDescription FROM EQP.EquipmentModelNumber where EQModID = pn.PROCMODEL)'ModDescription',
pn.PROCARG, (SELECT  MLCELLNAME FROM wACom.MachineList where MLID = pn.PROCARG)'MLCELLNAME',
ml.MLID, ml.MLPlantID,
PN.PROCMONTHGROUP, PN.PROCBIMONTHGROUP, PN.PROCQUARTGROUP, PN.PROCSEMIGROUP, PN.PROCANUALGROUP,
PN.PROCTWOYRGRUP, PN.PROCTHREEYRGROUP, PN.PROCFOURYRGROUP, PN.PROCEIGHTYRGROUP,
		tpr.TPMProcID, tpr.TPMProcFreq, freq.TPMFreqFrequency, Freq.TPMFreqDueModifier
from eqp.ProcNumbers pn 
			join wACom.MachineList ON pn.PROCARG = wACom.MachineList.MLID
			join wACom.Lines ON wACom.Lines.LIID = wACom.MachineList.MLLINEID 
			join wACom.Areas ON wACom.Lines.LISatellite = wACom.Areas.AAID 	
	JOIN TPM.TPMProcdure AS TPR ON TPR.TMPProcModelLink = PN.PROCMODEL
	join TPM.TPMFrequency Freq on tpr.TPMProcFreq = Freq.TPMFreqID
	join wacom.MachineList ml on pn.PROCARG = ml.MLID
		WHERE (PROCACTIVE = 1 and wACom.MachineList.MLActive = 1 and  LIActive = 1  and AAActive = 1) and
		tpr.TPMProcFreq = 4