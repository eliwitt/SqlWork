--
-- workorder master
select * from wo.WorkOrderMain where DISID = 63724
--
-- SAP Master
select * from sp.SPMaster2 where SP2ID in (4715, 4719, 3100)
--
-- Parts Usage note Workorders are ULListType 1
SELECT * FROM [SP].[UsageList] where ULTableLink = 63724
select * from sp.SPMaster2 where SP2VWNumber like 'Z00142%'
select * from sp.UsageList where ULListType = 1
--
-- Retrieve a single piece of equipment pulling from all of its WOs  10515 is from prod Assembly
--
select distinct sp2vwnumber 'Z Number', sp2mfgid 'Manufacturer Number', sp2shortsapdescr 'Description'
from sp.UsageList UL
left outer join sp.SPMaster2 on ULSPLink = sp2id
where ULTableLink in (select disid from wo.WorkOrderMain where DISEquip = 10515) and ULListType = 1