declare @myid int, @userid nvarchar(255)
set @userid = 'dvusc5w'
--
-- the following two selects are used in clsWUID.UID to check a users access and menu
-- items
Select TMID, PNID, PNNAME, TMProdUID, TMTitleLink 
FROM TEAM.WinAppTeamSecView 
WHERE TMUserName = @userid
--

Select * FROM TEAM.WinAppTeamSecView WHERE TMUserName = @userid
Select @myid = TMID FROM TEAM.WinAppTeamSecView WHERE TMUserName = @userid
SELECT * FROM SEC.AccessTable WHERE ATUID = @myid
--select * from Team.teammembers where TMLastName like 'Manuputty%'
--
-- 4 -- Brad Webb (webbbra)
-- 22 - Paul Courtney old developer (courtp)
-- 39 - Duane Pondell works in Body Shop and is the only name assigning asset numbers (pondeld)
-- 49 - Frank Huettenhain (huettef)
-- 56 - Matthew Clegg (DVUS077)
-- 103 - Eric Wilson--Assembly (wilsone)
-- 169 - Bob Parker worker in Paint Shop (parkero)
-- 303 - Jens Busch (dvushef)
-- 332p 325d - Steve Witt (dvusc5w) me
--
select * from Team.teammembers where TMID in (56, 22, 39, 49, 103, 169, 303, 325)
--update Team.teammembers set TMUserName = 'dvusc5w' where TMID = 325

Select TMID, PNID, PNNAME, TMProdUID, TMTitleLink 
FROM TEAM.WinAppTeamSecView 
WHERE TMID in (22, 39, 49, 103, 169, 303, 325)
--
-- the following tables both contain the plant or shops but take a look at 
-- the data and you can see that the keys can not be used to match.
--
select * from Team.wAPlants
SELECT * FROM EQP.ModelGroupOne
--
-- NOTE need this for the filter change in the app NOTE -----------
--update EQP.ModelGroupOne set MGOneName = 'Bodyweld' where MGOneID = 1

--
--  the following updates I use to set with my id so I can test the application with different 
--  accesses
--
-- 332p grp 0, dpt 0, plant 1
--update Team.teammembers set TMGROUPLINK = 3, tmplantlink = 5, tmdepartmentlink=2 where TMID = 325
--update team.teammembers set TMSecurityLevel = 1 where TMID=22


--select * from Team.wAGroupNames
--update Team.teammembers set TMUserName = 'parkero', TMEmail = '',
--TMProdUID = '', TMFirstName = 'Bob', TMLastName = 'Parker' where TMID = 169
--
--
--
--select top 50 * from team.OvertimeHours
--update SEC.AccessTable set ATTeamAccess = 1, ATTeamManage = 1, ATTeamSecLevel = 1,
--	ATTTeamAccessForm = 1, ATTTpmRibbonButton = 1, ATOpenItemRibbonButton = 1, 
--	ATDowntime = 1, ATDocumentation = 1, ATWorkOrders = 1, ATPartTracking = 1,
--	ATDown_Add = 1, ATDown_OpenItem = 1, ATDown_WorkOrder = 1, ATDown_Delete = 1,
--	ATOvertimeEdit = 1, ATDocEdit = 1, ATTeamBuildButton = 1, ATTeamReports = 1, 
--	ATOvertimeManage = 1, ATTeamBuildSuper = 1, wAOIMenu = 1, wATeamMenu = 1,
--	wAEcoMenu = 1, wAPartsMenu = 1, wATeam_Security_Supervisor = 1, wABeta = 0, 
--	wADocAdd = 1
--	where ATID = 318

--
-- team memebers that don't appear in the left panel on the scheduler usually need 
-- this column, tmdepartmentlink, set in order for them to appear.
--
-- Schdeler->[Scheduler].[LeftPanelScheduler]->Team.TeamMemberEditView
--
-- find the member in question
select * from Team.teammembers where TMLastName like 'Adams%'
select * from Team.teammembers where TMLastName like 'Meeks%'
select * from Team.ShiftTable
select * from Team.wAPlants
select * from team.waDepartments where DNName = 'Maintenance'
select * from Team.wAGroupNames
SELECT * FROM Team.waTeam
SELECT * FROM Team.TeamMemberTitles
select * from Team.TeamAssignments 
SELECT * FROM wAppTeam.TeamManagerView WHERE PNID = 1
--
-- pull only team members from the department of Maintenance
--
exec [Scheduler].[LeftPanelScheduler] 1
-- update Team.teammembers set tmdepartmentlink=2 where TMID in (336)
-- list of team members by department
SELECT TMLastName, TMFirstName, TMLastName + '  ' + TMFirstName, TMID,
	TMNShift, STShiftName, ASGID, ASGName, GNNames, DNName, DNID, STColor,
	ISNULL(GNID, 1) as GNID
FROM Team.TeamMemberEditView
WHERE PNID = 5 AND DNName = 'Maintenance'
Order by tmnshift, tmlastname