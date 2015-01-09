-- search wo's for text string
select womain.DISID, womain.DISCloseDate, pmnumber.PROCNUMBER, 
	modelnu.EQModDescription, womain.DISWorkAccomp
from wo.WorkOrderMain womain
	left join eqp.ProcNumbers pmnumber on womain.DISEquip = pmnumber.PROCID
	left join EQP.EquipmentModelNumber modelnu on pmnumber.PROCMODEL = modelnu.EQModID
where DIStype is not null
	and DISWorkAccomp like '%Robot%'
--
--  what wo does a piece of equipment have
--
select womain.*
from eqp.ProcNumbers pmnumber
join wo.WorkOrderMain womain on womain.DISEquip = pmnumber.PROCID
where PROCNUMBER = '1B13-2020-rb09'

select * from wo.WorkOrderMain
where DISEquip in (select procid from eqp.ProcNumbers where PROCNUMBER = '1B12-4510-RB01')
--
-- search for wo created/open on a date
--		use the proc number to locate WOs
select DISOpenDate, DISDueDate, womain.DISID, womain.DISEquip, pn.PROCID, pn.PROCMODEL, 
	tpmproc.TPMProcFreq, freq.TPMFreqFrequency, tpmproc.TPMProcID, tpmproc.TPMProcTitle
from wo.WorkOrderMain womain
	left join eqp.ProcNumbers pn on womain.DISEquip = pn.PROCID
	left join tpm.TPMProcdure tpmproc on pn.PROCMODEL = tpmproc.TMPProcModelLink
	left join tpm.TPMFrequency freq on tpmproc.TPMProcFreq = freq.TPMFreqID
where DISEquip = 10 order by womain.DISID
--where TPMProcFreq = 4 order by womain.DISID
--select * from tpm.TPMFrequency