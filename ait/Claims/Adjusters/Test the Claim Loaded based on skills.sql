declare @setit int, @theClaim int
set @setit = 1
set @theClaim = 260
print @setit
--
--  we have coverage of (1) LIPD with no one assigned to it do not set the claimloaded
--
if exists(select * from clm_reserve where claimnumber = @theClaim and coverageid = 1 and reserveopen = 1 and not exists (
			select * from clm_adjusterassignments a where claimptr = @theClaim and
				a.adjusterskilltypeptr = 2))
	set @setit = 0
print @setit
--
--  we have coverage of (2) LIBI with no one assigned to it do not set the claimloaded
--
if exists(select * from clm_reserve where claimnumber = @theClaim and coverageid = 2 and reserveopen = 1 and not exists (
			select * from clm_adjusterassignments a where claimptr = @theClaim and
				a.adjusterskilltypeptr = 4))
	set @setit = 0
print @setit
--
--  we have coverage of (3,4) Comp/Coll with no one assigned to it do not set the claimloaded
--
if exists(select * from clm_reserve where claimnumber = @theClaim and coverageid in (3,4) and reserveopen = 1 and not exists (
			select * from clm_adjusterassignments a where claimptr = @theClaim and
				a.adjusterskilltypeptr = 6))
	set @setit = 0
print @setit
--
--  we have coverage of (5) Towing with no one assigned to it do not set the claimloaded
--
if exists(select * from clm_reserve where claimnumber = @theClaim and coverageid = 5 and reserveopen = 1 and not exists (
			select * from clm_adjusterassignments a where claimptr = @theClaim and
				a.adjusterskilltypeptr = 7))
	set @setit = 0
print @setit
--
--  we have coverage of (7) MED with no one assigned to it do not set the claimloaded
--
if exists(select * from clm_reserve where claimnumber = @theClaim and coverageid = 7 and reserveopen = 1 and not exists (
			select * from clm_adjusterassignments a where claimptr = @theClaim and
				a.adjusterskilltypeptr = 8))
	set @setit = 0
print @setit
--
--  we have coverage of (8) UMBI with no one assigned to it do not set the claimloaded
--
if exists(select * from clm_reserve where claimnumber = @theClaim and coverageid = 8 and reserveopen = 1 and not exists (
			select * from clm_adjusterassignments a where claimptr = @theClaim and
				a.adjusterskilltypeptr = 9))
	set @setit = 0
print @setit
--
--  we have coverage of (9) UMPD with no one assigned to it do not set the claimloaded
--
if exists(select * from clm_reserve where claimnumber = @theClaim and coverageid = 9 and reserveopen = 1 and not exists (
			select * from clm_adjusterassignments a where claimptr = @theClaim and
				a.adjusterskilltypeptr = 10))
	set @setit = 0
print @setit
if not exists(select * from clm_reserve where claimnumber = @theClaim)
begin
	if exists(select * from clm_adjusterassignments where claimptr = @theClaim and adjusterskilltypeptr = 3)
		set @setit = 1
	else 
		set @setit = 0
end
print @setit