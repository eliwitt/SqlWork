-- This script will back out the Group Part showing
-- up on the web menu
--
declare @permission_key uniqueidentifier
select @permission_key = permission_key from msc_permission where permission_nm = 'Group Participation Report'
declare @role_key uniqueidentifier
select @role_key = role_key from msc_role where role_nm = 'Administrator'


delete from msc_rolepermission 
	where role_key = @role_key and permission_key = @permission_key