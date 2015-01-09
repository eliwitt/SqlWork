--
--    This is the beginning of the Production Report Detail setup
--
DECLARE @scripver VARCHAR(60),
	@last_script VARCHAR(60),
	@debug int,
	@trapped int,
	@ErrorMsg varchar(255)
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
select @cri_key = criteria_key from msc_criteria where parameter_nm = 'Enrollment Date Range'
insert into msc_reportcriteria (report_key, criteria_key, reportcriteria_seq)
	values(@rpt_key, @cri_key, 0)
if (@@rowcount = 0) 
	begin
	set @trapped = 31
	set @ErrorMsg = 'Error inserting the criteria paramter Enrollment Dates for Production Report Detail'
	goto Error_Handler
end
select @cri_key = criteria_key from msc_criteria where parameter_nm = 'Group(s)'
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
select @cri_key = criteria_key from msc_criteria where parameter_nm = 'Enrollment Date Range'
insert into msc_reportcriteria (report_key, criteria_key, reportcriteria_seq)
	values(@rpt_key, @cri_key, 0)
if (@@rowcount = 0) 
	begin
	set @trapped = 41
	set @ErrorMsg = 'Error inserting the criteria paramter Enrollment Dates for Employee Change Report Detail'
	goto Error_Handler
end
select @cri_key = criteria_key from msc_criteria where parameter_nm = 'Group(s)'
insert into msc_reportcriteria (report_key, criteria_key, reportcriteria_seq)
	values(@rpt_key, @cri_key, 1)
if (@@rowcount = 0) 
	begin
	set @trapped = 42
	set @ErrorMsg = 'Error inserting the criteria paramter All Groups for Employee Change Report Detail'
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
select @rpt_key = report_key from msc_report where report_nm = 'Production Report Summary – Productivity'
select @cri_key = criteria_key from msc_criteria where parameter_nm = 'Enrollment Date Range'
insert into msc_reportcriteria (report_key, criteria_key, reportcriteria_seq)
	values(@rpt_key, @cri_key, 0)
if (@@rowcount = 0) 
	begin
	set @trapped = 41
	set @ErrorMsg = 'Error inserting the criteria paramter Enrollment Dates for Employee Change Report Detail'
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
if @debug > 1
	print 'Insert rpt criteria for Prd Rpt Sum rpt'
select @cri_key = criteria_key from msc_criteria where parameter_nm = 'Group(s)'
insert into msc_reportcriteria (report_key, criteria_key, reportcriteria_seq)
	values(@rpt_key, @cri_key, 1)
if (@@rowcount = 0) 
	begin
	set @trapped = 52
	set @ErrorMsg = 'Error inserting the criteria paramter All Groups for Production Report Summary – Productivity'
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