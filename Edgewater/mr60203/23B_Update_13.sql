DECLARE @scripver VARCHAR(60),
	@last_script VARCHAR(60),
	@debug int,
	@trapped int,
	@ErrorMsg varchar(255)
--  Update the script values with the proper values
SET @scripver = '23B_Update_13'
SET @last_script = '23B_Update_12'
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

if @debug > 0
	print '---Start of update scripts---------'

--
-- Insert the new criteria rows
--
if @debug > 1
	print 'Insert the new criteria rows'

insert into msc_criteria (parameter_nm, Displaymodule_nm)
	values('Enrollment Dates', 'LoadEnrollmentDates')
--
-- error checking
--
if (@@error <> 0)
begin
	set @trapped = 20
	set @ErrorMsg = 'Error attempting to insert Enrollment Dates'
	goto Error_Handler
end

insert into msc_criteria (parameter_nm, Displaymodule_nm)
	values('All Groups', 'LoadMultiGroups')
--
-- error checking
--
if (@@error <> 0)
begin
	set @trapped = 21
	set @ErrorMsg = 'Error attempting to insert Multi Groups'
	goto Error_Handler
end
if @debug > 1
	print 'End of criteria inserts'

--
--    This is the beginning of the Production Report Detail setup
--
if @debug > 1
	print 'Delete Prd Dtl rpt criteria'
delete msc_reportcriteria where report_key = (select report_key from msc_report where report_nm = 'Production Report Detail')
if (@@rowcount = 0) 
	begin
	set @trapped = 30
	set @ErrorMsg = 'Error deleting the old criteria paramters for Production Report Detail'
	goto Error_Handler
end
declare @rpt_key uniqueidentifier, @cri_key uniqueidentifier
if @debug > 1
	print 'Insert rpt criteria for Prd Dtl rpt'
select @rpt_key = report_key from msc_report where report_nm = 'Production Report Detail'
select @cri_key = criteria_key from msc_criteria where parameter_nm = 'Enrollment Dates'
insert into msc_reportcriteria (report_key, criteria_key, reportcriteria_seq)
	values(@rpt_key, @cri_key, 0)
if (@@rowcount = 0) 
	begin
	set @trapped = 31
	set @ErrorMsg = 'Error inserting the criteria paramter Enrollment Dates for Production Report Detail'
	goto Error_Handler
end
select @cri_key = criteria_key from msc_criteria where parameter_nm = 'All Groups'
insert into msc_reportcriteria (report_key, criteria_key, reportcriteria_seq)
	values(@rpt_key, @cri_key, 1)
if (@@rowcount = 0) 
	begin
	set @trapped = 32
	set @ErrorMsg = 'Error inserting the criteria paramter All Groups for Production Report Detail'
	goto Error_Handler
end
select @cri_key = criteria_key from msc_criteria where parameter_nm = 'Division'
insert into msc_reportcriteria (report_key, criteria_key, reportcriteria_seq)
	values(@rpt_key, @cri_key, 2)
if (@@rowcount = 0) 
	begin
	set @trapped = 33
	set @ErrorMsg = 'Error inserting the criteria paramter Division for Production Report Detail'
	goto Error_Handler
end
select @cri_key = criteria_key from msc_criteria where parameter_nm = 'Enrollment Period'
insert into msc_reportcriteria (report_key, criteria_key, reportcriteria_seq)
	values(@rpt_key, @cri_key, 3)
if (@@rowcount = 0) 
	begin
	set @trapped = 34
	set @ErrorMsg = 'Error inserting the criteria paramter Enrollment Period for Production Report Detail'
	goto Error_Handler
end
select @cri_key = criteria_key from msc_criteria where parameter_nm = 'Disable Report Header/Footer'
insert into msc_reportcriteria (report_key, criteria_key, reportcriteria_seq)
	values(@rpt_key, @cri_key, 4)
if (@@rowcount = 0) 
	begin
	set @trapped = 35
	set @ErrorMsg = 'Error inserting the criteria paramter Disable Report Header/Footer for Production Report Detail'
	goto Error_Handler
end

--
--    This is the beginning of the Empolyee Change Report setup
--
if @debug > 1
	print 'Delete Emp Chg rpt criteria'
delete msc_reportcriteria where report_key = (select report_key from msc_report where report_nm = 'Employee Change Report Detail')
if (@@rowcount = 0) 
	begin
	set @trapped = 40
	set @ErrorMsg = 'Error deleting the old criteria paramters for Employee Change Report Detail'
	goto Error_Handler
end

if @debug > 1
	print 'Insert rpt criteria for Emp Chg rpt'
select @rpt_key = report_key from msc_report where report_nm = 'Employee Change Report Detail'
select @cri_key = criteria_key from msc_criteria where parameter_nm = 'Enrollment Dates'
insert into msc_reportcriteria (report_key, criteria_key, reportcriteria_seq)
	values(@rpt_key, @cri_key, 0)
if (@@rowcount = 0) 
	begin
	set @trapped = 41
	set @ErrorMsg = 'Error inserting the criteria paramter Enrollment Dates for Employee Change Report Detail'
	goto Error_Handler
end
select @cri_key = criteria_key from msc_criteria where parameter_nm = 'All Groups'
insert into msc_reportcriteria (report_key, criteria_key, reportcriteria_seq)
	values(@rpt_key, @cri_key, 1)
if (@@rowcount = 0) 
	begin
	set @trapped = 42
	set @ErrorMsg = 'Error inserting the criteria paramter All Groups for Employee Change Report Detail'
	goto Error_Handler
end
select @cri_key = criteria_key from msc_criteria where parameter_nm = 'Enrollment Period'
insert into msc_reportcriteria (report_key, criteria_key, reportcriteria_seq)
	values(@rpt_key, @cri_key, 2)
if (@@rowcount = 0) 
	begin
	set @trapped = 43
	set @ErrorMsg = 'Error inserting the criteria paramter Enrollment Period for Employee Change Report Detail'
	goto Error_Handler
end
select @cri_key = criteria_key from msc_criteria where parameter_nm = 'Disable Report Header/Footer'
insert into msc_reportcriteria (report_key, criteria_key, reportcriteria_seq)
	values(@rpt_key, @cri_key, 3)
if (@@rowcount = 0) 
	begin
	set @trapped = 44
	set @ErrorMsg = 'Error inserting the criteria paramter Disable Report Header/Footer for Employee Change Report Detail'
	goto Error_Handler
end

--
--    This is the beginning of the Production Report Summary – Productivity setup
--
if @debug > 1
	print 'Delete Prd Rpt Sum criteria'
delete msc_reportcriteria where report_key = (select report_key from msc_report where report_nm = 'Production Report Summary – Productivity')
if (@@rowcount = 0) 
	begin
	set @trapped = 50
	set @ErrorMsg = 'Error deleting the old criteria paramters for Production Report Summary – Productivity'
	goto Error_Handler
end

if @debug > 1
	print 'Insert rpt criteria for Prd Rpt Sum rpt'
select @rpt_key = report_key from msc_report where report_nm = 'Production Report Summary – Productivity'
select @cri_key = criteria_key from msc_criteria where parameter_nm = 'Enrollment Dates'
insert into msc_reportcriteria (report_key, criteria_key, reportcriteria_seq)
	values(@rpt_key, @cri_key, 0)
if (@@rowcount = 0) 
	begin
	set @trapped = 51
	set @ErrorMsg = 'Error inserting the criteria paramter Enrollment Dates for Production Report Summary – Productivity'
	goto Error_Handler
end
select @cri_key = criteria_key from msc_criteria where parameter_nm = 'All Groups'
insert into msc_reportcriteria (report_key, criteria_key, reportcriteria_seq)
	values(@rpt_key, @cri_key, 1)
if (@@rowcount = 0) 
	begin
	set @trapped = 52
	set @ErrorMsg = 'Error inserting the criteria paramter All Groups for Production Report Summary – Productivity'
	goto Error_Handler
end
select @cri_key = criteria_key from msc_criteria where parameter_nm = 'Division'
insert into msc_reportcriteria (report_key, criteria_key, reportcriteria_seq)
	values(@rpt_key, @cri_key, 2)
if (@@rowcount = 0) 
	begin
	set @trapped = 53
	set @ErrorMsg = 'Error inserting the criteria paramter Division for Production Report Summary – Productivity'
	goto Error_Handler
end
select @cri_key = criteria_key from msc_criteria where parameter_nm = 'Enrollment Period'
insert into msc_reportcriteria (report_key, criteria_key, reportcriteria_seq)
	values(@rpt_key, @cri_key, 3)
if (@@rowcount = 0) 
	begin
	set @trapped = 54
	set @ErrorMsg = 'Error inserting the criteria paramter Enrollment Period for Production Report Summary – Productivity'
	goto Error_Handler
end
select @cri_key = criteria_key from msc_criteria where parameter_nm = 'Disable Report Header/Footer'
insert into msc_reportcriteria (report_key, criteria_key, reportcriteria_seq)
	values(@rpt_key, @cri_key, 4)
if (@@rowcount = 0) 
	begin
	set @trapped = 55
	set @ErrorMsg = 'Error inserting the criteria paramter Disable Report Header/Footer for Production Report Summary – Productivity'
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