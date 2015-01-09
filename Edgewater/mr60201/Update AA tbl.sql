DECLARE @scripver VARCHAR(60),
	@last_script VARCHAR(60),
	@debug int,
	@trapped int,
	@ErrorMsg varchar(255)
--  Update the script values with the proper values
SET @scripver = '23B_Update_12'
SET @last_script = '23B_Update_11'
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
--
--  ValidValue Insert one follows
--
if @debug > 1
	print 'ValidValue ALWAYS_JUMP Insert'
insert into msc_validvalue (validtype_key, validvalue_vv, validvalue_nm)
values ('{75135B98-7025-467F-803D-4632A4402693}', 'ALWAYS_JUMP', 'Always Jump')
--
-- error checking
--
if (@@error <> 0)
begin
	set @trapped = 30
	set @ErrorMsg = 'Error attempting to insert Valid Value '
	goto Error_Handler
end
if @debug > 1
	print 'End of Insert'
--
--  ValidType follows
--
if @debug > 1
	print 'ValidType Insert'
insert into msc_validtype (validtype_key, validtypeshort_nm, validtype_nm) 
values('{D6ACDA6D-9E40-4959-A59B-A9EDCDB2DC05}', 'ANS_GROUP_TYPE', 'AnswerGroup Type')
--
-- error checking
--
if (@@error <> 0)
begin
	set @trapped = 31
	set @ErrorMsg = 'Error attempting to insert Valid Value '
	goto Error_Handler
end
if @debug > 1
	print 'End of Insert'
--
--  ValidValue Insert two follows
--
if @debug > 1
	print 'ValidValue Branch Insert'
insert into msc_validvalue (validtype_key, validValue_vv, validvalue_nm)
values('{D6ACDA6D-9E40-4959-A59B-A9EDCDB2DC05}', 'BRANCH', 'Branch Answer Group')
--
-- error checking
--
if (@@error <> 0)
begin
	set @trapped = 32
	set @ErrorMsg = 'Error attempting to insert Valid Value '
	goto Error_Handler
end
if @debug > 1
	print 'End of Insert'
--
--  ValidValue Insert three follows
--
if @debug > 1
	print 'ValidValue Collection Insert'
insert into msc_validvalue (validtype_key, validValue_vv, validvalue_nm)
values('{D6ACDA6D-9E40-4959-A59B-A9EDCDB2DC05}', 'COLLECTION', 'Collection Answer Group')
--
-- error checking
--
if (@@error <> 0)
begin
	set @trapped = 33
	set @ErrorMsg = 'Error attempting to insert Valid Value '
	goto Error_Handler
end
if @debug > 1
	print 'End of Insert'
--
--  msc_table follows
--
if @debug > 1
	print 'MSC_TABLE ANS_AnswerGroupDetail Insert'
insert into msc_table (table_nm, businessobject_nm, tableorder_num, 
templatedescription_txt, templatecolumns_txt) values
('ANS_AnswerGroupDetail', 'AnswerGroupDetailBO', 60,
'Reference ID - {0}', 'ReferenceID_nm')
--
-- error checking
--
if (@@error <> 0)
begin
	set @trapped = 34
	set @ErrorMsg = 'Error attempting to insert msc_table '
	goto Error_Handler
end
if @debug > 1
	print 'End of Insert'
--
--  msc_table follows
--
if @debug > 1
	print 'MSC_TABLE ANS_AnswerGroup Insert'
insert into msc_table (table_nm, businessobject_nm, tableorder_num, 
templatedescription_txt, templatecolumns_txt) values
('ANS_AnswerGroup', 'AnswerGroupBO', 20,
'Answer Grouping Name - {0}', 'AnswerGroup_nm')
--
-- error checking
--
if (@@error <> 0)
begin
	set @trapped = 34
	set @ErrorMsg = 'Error attempting to insert msc_table '
	goto Error_Handler
end
if @debug > 1
	print 'End of Insert'
--
--  msc_table follows
--
if @debug > 1
	print 'ValidValue TEXT_LIMIT Insert'
insert into msc_validvalue (validtype_key, validValue_vv, validvalue_nm)values('{977F6522-624B-4803-8739-6975962B862B}', 'TEXT_LIMIT', 'Max-min text size')
--
-- error checking
--
if (@@error <> 0)
begin
	set @trapped = 34
	set @ErrorMsg = 'Error attempting to insert msc_table '
	goto Error_Handler
end
if @debug > 1
	print 'End of Insert'
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