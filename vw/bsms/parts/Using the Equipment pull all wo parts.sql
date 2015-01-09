--
-- Using a single piece of equipment pull all of the parts used from all of the WOs for it
--
select distinct sp2vwnumber 'Z Number', sp2mfgid 'Manufacturer Number', sp2shortsapdescr 'Description'
from sp.UsageList UL
left outer join sp.SPMaster2 on ULSPLink = sp2id
where ULTableLink in (select disid from wo.WorkOrderMain where DISEquip = 10515) and ULListType = 1