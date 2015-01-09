declare @resid int
-- passenger /other  23826
-- owner 23825
set @resid = 23824
--
-- vehicle passenger and others
--
if exists(
select res.id, res.coverageid, ent.id, ent.Injured
	from clm_reserve res
		join CLM_VehiclePassenger vehpass on res.ClaimNumber = vehpass.ClaimMasterPTR
		join clm_involvedparty ent on vehpass.involvedpartyptr = ent.id and res.EntityNumber = ent.EntityNumber
where res.id = @resid)
begin
	update CLM_InvolvedParty set Injured = 1
		from clm_reserve res
		join CLM_VehiclePassenger vehpass on res.ClaimNumber = vehpass.ClaimMasterPTR
		join clm_involvedparty ent on vehpass.involvedpartyptr = ent.id and res.EntityNumber = ent.EntityNumber
	where res.id = @resid
end
--
-- property owner
--
if exists(
select res.id, res.coverageid, ent.id, ent.Injured
	from clm_reserve res
		join CLM_OtherProperty other on res.ClaimNumber = other.ClaimMasterPTR
		join clm_involvedparty ent on other.involvedpartyptr = ent.id and res.EntityNumber = ent.EntityNumber
where res.id = @resid)
begin
	update CLM_InvolvedParty set Injured = 1
		from clm_reserve res
			join CLM_OtherProperty other on res.ClaimNumber = other.ClaimMasterPTR
			join clm_involvedparty ent on other.involvedpartyptr = ent.id and res.EntityNumber = ent.EntityNumber
	where res.id = @resid
end

--update cLM_InvolvedParty set Injured = 0 where ID = 14318