/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [TPMProcID]
      ,[TPMProcTitle]
      ,[TPMProcFreq], (select tpmfreqfrequency from tpm.TPMFrequency where tpmfreqid = TPMProcFreq) 'Freq'
      ,[TPMProcType], (select tpmtypename from tpm.tpmtype where TPMTypeID = TPMProcType) 'Type'
      ,[TMPProcModelLink], (select eqmodmodelnumber from eqp.EquipmentModelNumber where eqmodid = TMPProcModelLink) 'Model type'
      ,[TPMProcContDocNum]
      ,[TPMPRocNumTM]
      ,[TPMProcEstMin]
      ,[TPMProcLineStatus]
      ,[TPMProcPriority]
      ,[TPMProcPlantAssign]
  FROM [TPM].[TPMProcdure]
  order by [TPMProcID]