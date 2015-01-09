-- list the proceures by plant or all of them
--
exec [wAppTPM].[ProcedureFetch] 

-- list procedures view
Select TPMProcPlantAssign, TPMProcID, TPMFreqFrequency, TPMProcTitle, EQModModelNumber 
FROM wAppTPM.wAppTPMProcedure
ORDER BY TPMProcTitle

select TPMProcPlantAssign, TPMProcID, TPMFreqFrequency, TPMProcTitle, EQModModelNumber
 from TPM.TPMProcdure pro
 join TPM.TPMFrequency freq on pro.TPMProcFreq = freq.TPMFreqID
  LEFT OUTER JOIN EQP.EquipmentModelNumber ON pro.TMPProcModelLink = EQP.EquipmentModelNumber.EQModID
 
 select * from TPM.TPMProcdure
 select * from TPM.TPMFrequency 