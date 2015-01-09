declare @CMastPtr int,
	@adjskill int, 
	@protype	int,
	@ClaimNumber nvarchar(20)
set @protype = 0
set @CMastPtr = 6078
set @adjskill = 13
select @ClaimNumber = ClaimNumber from clm_claimmaster where ID = @CMastPtr
if @protype = 0
	goto removeAdj
--
--  we have coverage of (1) LIPD with no one assigned to it do not set the claimloaded
--
if not exists (select * from clm_adjusterassignments a where claimptr = @CMastPtr and
				a.adjusterskilltypeptr = @adjSkill)
	insert into CLM_AdjusterAssignments values(0, @ClaimNumber, @CMastPtr, 1, @adjSkill, GETDATE())
goto complete
removeAdj:
delete from CLM_AdjusterAssignments where claimptr = @CMastPtr and ClaimNumber = @ClaimNumber and
				adjusterskilltypeptr = @adjSkill
complete:
print 'fini'