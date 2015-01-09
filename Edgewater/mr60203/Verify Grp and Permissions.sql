-- Has the group report been inserted?
select * from msc_permission
where permission_cd = '1020_GRP_Part'
-- have the additional permissions been inserted?
declare @permission_key uniqueidentifier
select @permission_key = permission_key from msc_permission where permission_nm = 'Group Participation Report'
declare @role_key uniqueidentifier
select @role_key = role_key from msc_role where role_nm = 'Enroller'
select * from msc_rolepermission 
where role_key = @role_key and permission_key = @permission_key
--insert into msc_rolepermission (role_key, permission_key)
--	values(@role_key, @permission_key)
select @role_key = role_key from msc_role where role_nm = 'Enrollment Administrator'
select * from msc_rolepermission 
where role_key = @role_key and permission_key = @permission_key
--insert into msc_rolepermission (role_key, permission_key)
--	values(@role_key, @permission_key)

