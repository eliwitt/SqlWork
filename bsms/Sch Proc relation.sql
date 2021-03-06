--
-- look at the GS for a specified date
--
SELECT gs.GSID, gs.GSMonthGroup, tpmnu.PROCID, tpmnu.PROCNUMBER, tpmnu.PROCMODEL, tpmnu.PROCWEEKGROUP
  FROM [BSMS].[TPM].[GrandSchedule] gs
  join eqp.procnumbers tpmnu  on gs.GSMonthGroup = tpmnu.PROCWEEKGROUP
  where GSCWMonDate = '2012-10-08'
--
--
declare @datepass date;
select @datepass=cast(GETDATE() as date)
select top 1 GSMonthGroup from [TPM].[GrandSchedule] where GSCWMonDate <= @datepass order by GSCWMonDate desc
 --
 --  the grand schedule for week 10/08
 --
 select * from tpm.GrandSchedule where GSCWMonDate = '2012-10-15'
 --
 -- the model # that needs 2 be scheduled
 --
 select * from eqp.EquipmentModelNumber where EQModID = 703
 -- the procedure for model # 703
 select * from tpm.TPMProcdure where TMPProcModelLink = 703
 --
 -- what is the freq of the procedures
 --
 select * from tpm.TPMFrequency where TPMFreqID in (4, 7)