--
-- misc asset queries
--
--select * from team.wAPlants
--SELECT  * FROM wAppEqp.EqpEdit
--SELECT * FROM   EQP.IdleAssetLocations
--
-- I add asset 4795 found out that the app does not keep the title
-- I used 'InfraAsset-grpII-001' but it does nothing with it.
--
-- the equipment the Add Asset is used to insert into this table
select * from EQP.Equipment where EQPlant = 4
-- the asset assignment table
select * from EQP.AssetAssignmentHistory AssHist
left join EQP.Equipment Eqpt on AssHist.AAHAssetID = Eqpt.EQTID
where EQPlant = 4
-- when you drag from idle to the equipment tree the asset is assigned
-- to this functional position number.
select * from eqp.ProcNumbers where PROCID = 13589

select aahid, aahdate, cast(AAHAssetID as nvarchar(10)) + '-' + Eqpt.EQTDescription 'Asset Title', 
		' was moved from ' as [from],
		case 
			when  AAHFromIdle > 0 then FromLoc.IALName
			when AAHFromProc > 0 then FromProc.PROCNUMBER
		end as [Fromloc], 
		' to ' as [to],
		case 
			when  AAHToIdle > 0 then ToLoc.IALName
			when AAHToProc > 0 then ToProc.PROCNUMBER
		end as [ToLoc], 
		AssHist.AAHCause, TMem.TMFirstName + ' ' + TMem.TMLastName [by]
from EQP.AssetAssignmentHistory AssHist 
	left join EQP.Equipment Eqpt on AssHist.AAHAssetID = Eqpt.EQTID
	left join eqp.ProcNumbers FromProc on AssHist.AAHFromProc = FromProc.PROCID
	left join eqp.ProcNumbers ToProc on AssHist.AAHToProc = ToProc.PROCID
	left join EQP.IdleAssetLocations FromLoc on AssHist.AAHFromIdle = FromLoc.IALID
	left join EQP.IdleAssetLocations ToLoc on AssHist.AAHToIdle = ToLoc.IALID
	left join Team.teammembers TMem on AssHist.AAHUserID = TMem.TMID
where Eqpt.EQPlant = 3
