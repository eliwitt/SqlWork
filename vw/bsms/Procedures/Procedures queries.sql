-- list the proceures by plant or all of them
--
exec [wAppTPM].[ProcedureFetch] 

-- list procedures
Select TPMProcPlantAssign, TPMProcID, TPMFreqFrequency, TPMProcTitle, EQModModelNumber FROM wAppTPM.wAppTPMProcedure
ORDER BY TPMProcTitle