declare @claimptr int, @skill int, @newptr int, @claimnu nvarchar(60)
exec goautoprod.dbo.sp_claims_getadjusterlist
--select max(id) from clm_claimmaster
--select * from clm_adjusterskilltype
--select * from clm_canassignadjusters
--select p.FirstName + ' ' + p.LastName empnam, 'Original Adjuster' as skill 
--	from goautoprod.dbo.employee e 
--	join goautoprod.dbo.person p on p.id = e.PersonInfoPTR 
--where e.id = (select EmployeePTR from clm_claimmaster where id = 15)
--union
--Select p.FirstName + ' ' + p.LastName empnam, skilltype.[desc]
--	from clm_AdjusterAssignments adjuster
--	right outer join goautoprod.dbo.employee e on e.id = adjuster.employeeptr
--	join goautoprod.dbo.person p on p.id = e.PersonInfoPTR 
--	join clm_adjusterskilltype skilltype on skilltype.id = adjuster.adjusterskilltypeptr
--where adjuster.claimptr = 15
--
--if exists(select employeeptr from clm_adjusterassignments where employeeptr = 1550)
--	select employeeptr from clm_adjusterassignments where employeeptr = 1550
--else
--	select top 1 employeeptr from clm_adjusterassignments

set @claimptr = 161
set @skill = 4
set @newptr = 1550
set @claimnu = '10125-04-29-2010'
select * from clm_adjusterassignments where claimptr = @claimptr
select id, employeeptr, claimloaded from clm_claimmaster where id = @claimptr
select * from clm_adjusterassignments where claimptr = @claimptr and
		adjusterskilltypeptr = @skill
--if exists(select employeeptr from clm_adjusterassignments where claimptr = @claimptr and
--		adjusterskilltypeptr = @skill)
--	update clm_adjusterassignments set employeeptr = @newptr, claimloaded = 1
--		where claimptr = @claimptr and adjusterskilltypeptr = @skill
--else
--	insert into clm_adjusterassignments values(@newptr, @claimnu, @claimptr, 1, @skill)
--select * from clm_adjusterassignments
--update clm_adjusterassignments set claimloaded = 1 where employeeptr = 148026 and claimptr = 229
--select max(id) from clm_claimmaster