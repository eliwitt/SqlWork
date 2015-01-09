--
-- unassign skills
--
--select * from clm_coverage
declare @myClaim int
set @myClaim = 252
--select * from clm_claimmaster where id in (252, 254, 255)
--select * from clm_adjusterassignments where claimptr in (252, 254, 255)
--select * from clm_reserve where claimnumber in (252, 254, 255)
--update clm_claimmaster set claimloaded = 1 where id = 254
--
--  towing only skill
select (select [desc] from clm_adjusterskilltype where id = 7) as UnSkill from clm_reserve b
where b.claimnumber = @myClaim and b.coverageid = 5 and not exists (
select * from clm_adjusterassignments a where claimptr = @myClaim and
a.adjusterskilltypeptr = 7)
--  current skill check sql
--
select (select [desc] from clm_adjusterskilltype where id = 2) as UnSkill from clm_reserve b
where b.claimnumber = @myClaim and b.coverageid = 1 and not exists (
select * from clm_adjusterassignments a where claimptr = @myClaim and
a.adjusterskilltypeptr = 2)
union
select (select [desc] from clm_adjusterskilltype where id = 4) as UnSkill from clm_reserve b
where b.claimnumber = @myClaim and b.coverageid = 2 and not exists (
select * from clm_adjusterassignments a where claimptr = @myClaim and
a.adjusterskilltypeptr = 4)
union
select (select [desc] from clm_adjusterskilltype where id = 6) as UnSkill from clm_reserve b
where b.claimnumber = @myClaim and b.coverageid in (3,4) and not exists (
select * from clm_adjusterassignments a where claimptr = @myClaim and
a.adjusterskilltypeptr = 6)

--select * from clm_adjusterassignments where claimptr = @myClaim
--select * from clm_adjusterskilltype
select * from clm_reserve where claimnumber = @myClaim
select * from clm_claimmaster where losstype = 7
--select * from clm_coverage
--select * from clm_adjusterskilltype
select * from clm_reserve where claimnumber in (select id from clm_claimmaster where losstype = 7)
--select b.[desc] from clm_adjusterskilltype b
--where not exists (
--select * from clm_adjusterassignments a where claimptr = 146 and
--a.adjusterskilltypeptr = b.id)
--group by b.[desc]
--select * from clm_claimmaster where id = 146
--update clm_claimmaster set employeeptr = 148026 where id = 146
--
--  assign adjusters
--
select p.FirstName + ' ' + p.LastName empnam, 'Original Adjuster' as skill, DateOfAssignment as AssignDateTime 
	from goautoprod.dbo.employee e 
	join goautoprod.dbo.person p on p.id = e.PersonInfoPTR 
   join clm_claimmaster cm on cm.employeeptr = e.id 
where cm.employeeptr <> 66436 and cm.id = 146
 union 
Select p.FirstName + ' ' + p.LastName empnam, skilltype.[desc], adjuster.AssignDateTime 
	from clm_AdjusterAssignments adjuster 
	join goautoprod.dbo.employee e on e.id = adjuster.employeeptr 
	join goautoprod.dbo.person p on p.id = e.PersonInfoPTR 
	join clm_adjusterskilltype skilltype on skilltype.id = adjuster.adjusterskilltypeptr 
where Adjuster.claimptr = 146

