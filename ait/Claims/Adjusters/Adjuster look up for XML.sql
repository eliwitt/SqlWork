declare @ClaimMast int, @EnitNU int
set @ClaimMast = 283
set @EnitNU = 0
select EmployeePtr, AdjusterSkillTypePTR, 
	case 
		-- do we have towing
		when AdjusterSkillTypePTR = 7 then
			case 
				when exists(select * from clm_reserve where claimnumber = @ClaimMast and coverageid = 5) then
				'OTAUT'
			end
		-- do we having LIPD
		when AdjusterSkillTypePTR = 2 then
			case 
				when exists(select * from clm_reserve where claimnumber = @ClaimMast and coverageid = 1) then
				'PRPD'
			end
		-- do we having LIBI
		when AdjusterSkillTypePTR = 4 then
			case 
				when exists(select * from clm_reserve where claimnumber = @ClaimMast and coverageid = 2) then
				'BODI'
			end
		else
			'Not Yet'
	end coverage,
	-- the entity on the claim
	case 
		-- do we have towing
		when AdjusterSkillTypePTR = 7 then
			case 
				when exists(select * from clm_reserve where claimnumber = @ClaimMast and coverageid = 5) then
				(select distinct entitynumber from clm_reserve where claimnumber = @ClaimMast and coverageid = 5)
			end
		-- do we having LIPD
		when AdjusterSkillTypePTR = 2 then
			case 
				when exists(select * from clm_reserve where claimnumber = @ClaimMast and coverageid = 1) then
				(select distinct entitynumber from clm_reserve where claimnumber = @ClaimMast and coverageid = 1)
			end
		-- do we having LIBI
		when AdjusterSkillTypePTR = 4 then
			case 
				when exists(select * from clm_reserve where claimnumber = @ClaimMast and coverageid = 2) then
				(select distinct entitynumber from clm_reserve where claimnumber = @ClaimMast and coverageid = 2)
			end
		else
			0
	end entity
	from clm_adjusterassignments adjassign
	where claimptr = @ClaimMast
order by EmployeePtr
--select * from clm_adjusterassignments where claimptr = @ClaimMast
--select * from clm_reserve where claimnumber = @ClaimMast
--
--  get the coverage type most will have the same loss type
--  special OTAUC is coverage type OTAU with a loss type COLL
--			OTAUT is coverage type OTAU with a loss type TOWL
--			UNINB is coverage type UNIN with a loss type BODI
--			UNINP is coverage type UNIN with a loss type PRPD
--
-- is this claim a towing claim and do we have a towing adjuster
--
--if exists(select * from clm_adjusterassignments where adjuster.claimptr = @ClaimMast and adjuster.adjusterskilltype = 7)
--	if exists(select * from clm_claimmaster where id = @ClaimMast and losstype = 7)
--		if exists(select * from clm_claimvehicle where claimmasterptr = @ClaimMast and vehiclenumber = 1)
--			select 
--
--  the following list of codes comes from the XML manual for PAPP policies
--
--select case	
--		when adjusterskilltypeptr=1 then 'OTAU'
--		when adjusterskilltypeptr=2 then 'PRPD'
--		when adjusterskilltypeptr=3 then 'OTAU'
--		when adjusterskilltypeptr=4 then 'BODI'
--		when adjusterskilltypeptr=5 then 'OTAU'
--		when adjusterskilltypeptr=6 then 'OTAUC'
--		when adjusterskilltypeptr=7 then 'OTAUT'
--		when adjusterskilltypeptr=8 then 'MPAY'
--		when adjusterskilltypeptr=9 then 'UNINB'
--		when adjusterskilltypeptr=10 then 'UNINP'
--		else 'OTAU' end Coverage
--from clm_adjusterassignments where claimptr = @ClaimMast