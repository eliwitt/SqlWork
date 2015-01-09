-- the workorder
declare @EquipNu int = 68429,
	@ProcNu int,
	@ModelNu int
select @ProcNu=DISTPMNumber, @ModelNu =DISIntHold from wo.WorkOrderMain where DISID = @EquipNu
select * from wo.WorkOrderMain where DISID = @EquipNu
-- the procedure that started the whole mess
select * from tpm.TPMProcdure where TPMProcID = @ProcNu
-- the list of assets that have that model number
select * from eqp.ProcNumbers where PROCMODEL = @ModelNu
-- a list of all of the WOs for two piece of equip/assets
--select * from wo.WorkOrderMain where DISEquip in (3040, 12501)
--order by DISOpenDate desc