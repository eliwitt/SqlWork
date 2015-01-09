--
-- what types do we have
--
Select * FROM wo.WorkOrderCodes
insert into wo.WorkOrderCodes values('Corrective', 0)
insert into wo.WorkOrderCodes values('Emergency',0)
update wo.WorkOrderCodes set WOActive = 1 where WOCID in (2, 4, 5, 7, 24)