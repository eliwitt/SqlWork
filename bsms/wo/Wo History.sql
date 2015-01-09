declare @cmd nvarchar(max)
set @cmd = 'select * 
	from wo.WorkOrderMain WOrder
	join wACom.MachineList MachList on WOrder.DISLineNumber = MachList.MLID
	join wACom.Lines Lines on MachList.MLLINEID = Lines.LIID
	where MachList.MLPlantID = 1 and MachList.MLActive = 1 and lines.LIActive = 1'
set @cmd = @cmd + 'and disasset = 2906'	
exec(@cmd)
exec wAppWorkOrder.wohistory 1, 1, 2906
exec wAppWorkOrder.wohistory 1, 2, 1038
-- searching for WOs for a given piece of equip/asset
select * from eqp.ProcNumbers where PROCNUMBER = '1B32-4570-MS01'
select * from eqp.Equipment where EQtID = 1435
-- cann't use the asset number because there can be equipment without an asset
select * from wo.WorkOrderMain where DISAsset = 4789
select * 
	from wo.WorkOrderMain WOrder
	join wACom.MachineList MachList on WOrder.DISLineNumber = MachList.MLID
	join wACom.Lines Lines on MachList.MLLINEID = Lines.LIID
	where DISAsset = 2906 and MachList.MLPlantID = 1 and MachList.MLActive = 1 and lines.LIActive = 1
select worder.DISID, WOrder.DISOpenDate, WOrder.DISCloseDate, WOrder.DISWorkAccomp
	from wo.WorkOrderMain WOrder
	join wACom.MachineList MachList on WOrder.DISLineNumber = MachList.MLID
	join wACom.Lines Lines on MachList.MLLINEID = Lines.LIID
	where DISEquip = 3040 and MachList.MLPlantID = 1 and MachList.MLActive = 1 and lines.LIActive = 1	
exec [EQP].[EquipHistoryWO] 4789
--select * from wACom.MachineList where mlid in (46,525)
--select * from eqp.ProcNumbers where PROCASSET is null
select * from wo.Archive