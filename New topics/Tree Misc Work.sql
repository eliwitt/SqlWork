--
--  Trying to develop a routine to build the tree so we do not have to in the code
--  it is taking too long.
--
--
--  the least used is the model tree but here it is
--
--;with modelTree as (
--select 1 branch, MGOneID, MGOneName from EQP.ModelGroupOne where MGOneID = 1 and MGOneActive = 1
--union all
--select 2 branch, gtwo.MGTwoID, MGTwoName from EQP.ModelGroupTwo gtwo 
--	join modelTree mt on gtwo.MGTwoOneLink = mt.MGOneID
--where gtwo.MGTwoActive = 1 
--)
--select MGOneName 
--	from EQP.ModelGroupOne gone
--	join (select MGTwoName from EQP.ModelGroupTwo) as gtwo 
--where MGOneActive = 1

-- not sure what will be the best way to format the data but we can play with
-- layouts and see what would work.
--
declare @Shop int,
	@WhichTest int
set @Shop = 1
set @WhichTest = 2
if (@WhichTest = 1) 
	goto ModelTree
if (@WhichTest = 2) 
	goto EquipmentTree
	
	
ModelTree:
-- display the different tree formats so far
;with modelTree as (
select 0 branchParent, 1 branch, MGOneID branchId, MGOneName branchName 
	from EQP.ModelGroupOne 
	where MGOneID = @Shop and MGOneActive = 1
union all
select mt.branchId, 2 branch, gtwo.MGTwoID, MGTwoName 
	from EQP.ModelGroupTwo gtwo 
		join modelTree mt on gtwo.MGTwoOneLink = mt.branchId
	where gtwo.MGTwoActive = 1 
union all
select mt.branchId, 3 branch, gthree.MGThreeID, MGThreeName 
	from EQP.ModelGroupThree gthree 
		join modelTree mt on mt.branch = 2 and gthree.MGThreeTwoLink = mt.branchId
	where gthree.MGThreeActive = 1 
)
select * from modelTree order by branchParent,branchName,  branch
--
--  using joins can get the job done
select mgoneid, mgonename, mgtwoid, mgtwoname, mgthreeid, mgthreename, eqmodid,
	eqmodmodelnumber
from EQP.ModelGroupOne
left outer join EQP.ModelGroupTwo on EQP.ModelGroupOne.MGOneID = EQP.ModelGroupTwo.MGTwoOneLink
left outer join EQP.ModelGroupThree on EQP.ModelGroupTwo.MGTwoID = EQP.ModelGroupThree.MGThreeTwoLink
left outer join EQP.EquipmentModelNumber on EQP.ModelGroupThree.MGThreeID = EQP.EquipmentModelNumber.EQModGroupLink
where EQP.ModelGroupOne.MGOneID = @Shop and 
	EQP.ModelGroupOne.MGOneActive = 1 and EQP.ModelGroupTwo.MGTwoActive = 1 and
	EQP.ModelGroupThree.MGThreeActive = 1
goto Fini

EquipmentTree:
--select * from EQP.ProcNumbers
select Plant.PNID, Plant.PNName, AAID, AAareaname, LIID, LILineName, MLID, MLCELLNAME, PROCID, PROCNUMBER
from wACom.Areas Area
	left join wACom.Lines Line on Area.AAID = Line.LISatellite
	left join wACom.MachineList ML on LIID = ml.MLLINEID
	left join EQP.ProcNumbers ProcNu on ml.MLID = ProcNu.PROCARG
	left join Team.wAPlants Plant on Area.AAPlant = Plant.PNID
where AAPlant = @Shop and 
	AAActive = 1 and LIActive = 1 and MLActive = 1 and PROCACTIVE = 1
order by AAareaname, LILineName, MLCELLNAME, PROCNUMBER

Fini:	