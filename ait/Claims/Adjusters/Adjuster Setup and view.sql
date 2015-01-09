declare @employeeptr int,
	@adjskill int
set @adjskill = 13
set @employeeptr = 467736
select * from CLM_AdjusterSkillType where id = @adjskill
select * from CLM_AdjusterSkillsAssigned where skillid = @adjskill
select * from CLM_AdjusterCurrentSkills where adjusterskilltypeptr = @adjskill --where employeeptr = @employeeptr
select * from CLM_AdjusterAssignments where AdjusterSkilltypePTR = @adjskill
--exec sp_proc_adjassign 6078, 13, 0
--insert into CLM_AdjusterSkillType values(12, 'Total Loss')
--insert into CLM_AdjusterSkillType values(13, 'Salvage')
--insert into CLM_AdjusterSkillType values(14, 'Subrogation')
--insert into CLM_AdjusterSkillsAssigned values(12, 0)
--insert into CLM_AdjusterSkillsAssigned values(13, 5)
--insert into CLM_AdjusterSkillsAssigned values(14, 5)
--insert into CLM_AdjusterCurrentSkills values(467741, 12)
--insert into CLM_AdjusterCurrentSkills values(467741, 14)
--insert into CLM_AdjusterCurrentSkills values(4088270, 12)
--insert into CLM_AdjusterCurrentSkills values(4088270, 13)
--insert into CLM_AdjusterCurrentSkills values(3213587, 12)
--insert into CLM_AdjusterCurrentSkills values(3213587, 13)
--insert into CLM_AdjusterCurrentSkills values(3213587, 14)
--insert into CLM_AdjusterCurrentSkills values(467736, 12)
--insert into CLM_AdjusterCurrentSkills values(467736, 13)
--insert into CLM_AdjusterCurrentSkills values(467736, 14)