DECLARE @scripver VARCHAR(60),
	@last_script VARCHAR(60),
	@debug int,
	@trapped int,
	@ErrorMsg varchar(255)
--  Update the script values with the proper values
SET @scripver = '23B_Update_15'
SET @last_script = '23B_Update_14'
-- 0 turn off
-- 1 update script only
-- 2 User defined
-- 3 User defined
-- 4 User defined
-- 5 all messages
set @debug = 2
--
-- set the trapped indicator to 11 for the start of the transaction
--
set @trapped = 11
--
-- start the transaction
--
begin transaction
--
-- check the msc_parameter table for the scriptversion row 
-- add it if it is not there
--
if @debug = 5
	print 'Checking the MSC_Parameter table'
if not exists (select 'x' from MSC_Parameter where parameter_cd='SCRIPTVERSION')
begin
	if @debug = 5
		print 'Inserting the scriptversion row into the MSC_Parameter table'
	insert into MSC_Parameter (Parameter_key, Parameter_cd,Parameter_txt,Parameter_desc,Last_Update_key)
		VALUES (newid(),'SCRIPTVERSION',@last_script,'Version of fixup script',newid())
	if (@@error <> 0)
	begin
		set @trapped = 12
		set @ErrorMsg = 'Error attempting to insert the scriptversion row into the msc_parameter '
		goto Error_Handler
	end
end
--
-- verify the previous script number
-- if it does not then check to see if this script has been applied
--
if @debug = 5
	print 'Verifying the script version number'
if not exists (select 'x' from MSC_Parameter where parameter_cd = 'SCRIPTVERSION' and parameter_txt = @last_script) 
BEGIN
	if exists (select 'x' from MSC_Parameter where parameter_cd = 'SCRIPTVERSION' and parameter_txt = @scripver) 
		select @ErrorMsg = @scripver + ' has already been applied'
	else
		set @ErrorMsg = 'Sorry, You cannot run this script because prior required scripts have not been applied'
	set @trapped = 14
	goto Error_Handler	
END
--
-- 
--
if @debug = 5
	print 'Running the updates to the database'
--
--  The Trapped count should start at thirty
--
if @debug > 0
	print '---Start of update scripts---------'

if @debug > 1
	print 'Insert the new Group Participation report'

insert into msc_permission (permission_cd, permission_nm, permissiontype_vv)
	values('1020_GRP_Part', 'Group Participation Report', 'REPORT')
--
-- error checking
--
if (@@error <> 0)
begin
	set @trapped = 30
	set @ErrorMsg = 'Error attempting to insert Group Participation Report'
	goto Error_Handler
end
if @debug > 1
	print 'End of Group Participation inserts'

if @debug > 1
	print 'Insert the new row into msc report'
declare @permission_key uniqueidentifier
select @permission_key = permission_key from msc_permission where permission_nm = 'Group Participation Report'
if (@@rowcount = 0) 
	begin
	set @trapped = 31
	set @ErrorMsg = 'Error retrieving the permission key for Group Participation Report'
	goto Error_Handler
end
INSERT INTO MSC_Report ( Report_nm, ReportShort_nm, ReportProgram_nm, ValidationModule_nm, Permission_key) 
	VALUES ( 'Group Participation Report', '1020_GRP_Part', 'GroupParticipationReport', NULL, @permission_key)
--
-- error checking
--
if (@@error <> 0)
begin
	set @trapped = 32
	set @ErrorMsg = 'Error attempting to insert Group Participation Report'
	goto Error_Handler
end
if @debug > 1
	print 'Insert the new row into msc report was successful'

if @debug > 1
	print 'Insert rolepermission'
declare @role_key uniqueidentifier
select @role_key = role_key from msc_role where role_nm = 'Administrator'
insert into msc_rolepermission (role_key, permission_key)
	values(@role_key, @permission_key)
--
-- error checking
--
if (@@error <> 0)
begin
	set @trapped = 33
	set @ErrorMsg = 'Error attempting to insert Administrator'
	goto Error_Handler
end
select @role_key = role_key from msc_role where role_nm = 'Enroller'
insert into msc_rolepermission (role_key, permission_key)
	values(@role_key, @permission_key)
--
-- error checking
--
if (@@error <> 0)
begin
	set @trapped = 33
	set @ErrorMsg = 'Error attempting to insert Enroller'
	goto Error_Handler
end
select @role_key = role_key from msc_role where role_nm = 'Enrollment Administrator'
insert into msc_rolepermission (role_key, permission_key)
	values(@role_key, @permission_key)
--
-- error checking
--
if (@@error <> 0)
begin
	set @trapped = 33
	set @ErrorMsg = 'Error attempting to insert Enrollment Administrator'
	goto Error_Handler
end
if @debug > 1
	print 'End of rolepermission inserts'

declare @rpt_key uniqueidentifier, @cri_key uniqueidentifier
if @debug > 1
	print 'Insert rpt criteria for Group rpt'
select @rpt_key = report_key from msc_report where report_nm = 'Group Participation Report'
select @cri_key = criteria_key from msc_criteria where parameter_nm = 'All Groups'
insert into msc_reportcriteria (report_key, criteria_key, reportcriteria_seq)
	values(@rpt_key, @cri_key, 0)
if (@@rowcount = 0) 
	begin
	set @trapped = 34
	set @ErrorMsg = 'Error inserting the criteria paramter All Groups for Production Report Detail'
	goto Error_Handler
end
select @cri_key = criteria_key from msc_criteria where parameter_nm = 'Enrollment Period'
insert into msc_reportcriteria (report_key, criteria_key, reportcriteria_seq)
	values(@rpt_key, @cri_key, 1)
if (@@rowcount = 0) 
	begin
	set @trapped = 35
	set @ErrorMsg = 'Error inserting the criteria paramter Enrollment Period for Production Report Detail'
	goto Error_Handler
end
select @cri_key = criteria_key from msc_criteria where parameter_nm = 'Disable Report Header/Footer'
insert into msc_reportcriteria (report_key, criteria_key, reportcriteria_seq)
	values(@rpt_key, @cri_key, 3)
if (@@rowcount = 0) 
	begin
	set @trapped = 36
	set @ErrorMsg = 'Error inserting the criteria paramter Disable Report Header/Footer for Production Report Detail'
	goto Error_Handler
end
--
-- End of update script  ----------------------------------
--
if @debug > 0
	print '---End of Updates---'
if @debug = 5
	print 'Update the script version number in the table'
-- Update the Script run Version
Update MSC_parameter SET Parameter_txt = @scripver, Last_Update_key = newid() 
	WHERE parameter_cd = 'SCRIPTVERSION'
if (@@error <> 0)
begin
	set @trapped = 90
	set @ErrorMsg = 'Error attempting to update the scriptversion row '
	goto Error_Handler
end
--
-- if you get here you are a lucky son of a b%^*&
--
commit
return

--
-- bottom of the script
--
Error_Handler:
if @debug = 5
	print 'In the Error Handler'

IF @ErrorMsg IS NOT NULL
BEGIN
	SELECT @ErrorMsg = 'aa Update script: ' + @ErrorMsg + '  ' + convert(varchar(10), @trapped)
	-- Using "with log" inserts a message into the event log
	-- RAISERROR(@ErrorMsg, 11, 1) with log 
	RAISERROR(@ErrorMsg, 11, 1)
	--return 21
END

if @trapped > 10
	rollback