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

--  Add in the update script code here!!! -----------------
--  set @debug to the value you wish
--  set the @trapped variable for each command
--  set the @ErrorMsg to something meaningful for each command
/*
--
--  Example one follows
--
if @debug > 1
	print 'Example One'
INSERT INTO ANS_AnswerValue 
VALUES ('6AB559EB-D03A-4AF5-A1EF-DFACCE903C7E',
'3F83256C-7D80-455C-ABF1-9FF3148AE6F9',
NULL,
'8848EB80-2E7B-4EF1-B671-CFDA5ADF30A6',
'Employee + 1 Child',
'Employee + Children',
9,
'N',
NULL
)
--
-- error checking
--
if (@@error <> 0)
begin
	set @trapped = 30
	set @ErrorMsg = 'Error attempting to insert Answer Value '
	goto Error_Handler
end
if @debug > 1
	print 'End of Example One'
--
-- End of example one
--
*/
/*
--
--  Example two follows
--
if @debug > 1
	print 'Example two'

DECLARE @del_error int, @ins_error int

-- Execute the DELETE statement.
DELETE msc_user
WHERE User_nm = 'amber\bcarso'
-- Set a variable to the error value for 
-- the DELETE statement.
SELECT @del_error = @@rowcount

-- Execute the INSERT statement.
insert MSC_User (User_nm, Last_nm, First_nm, UserStatus_vv, Enroller_ID)
values('bcbst\j13155w', 'Witt', 'John', 'Active', 'j13155w')
-- Set a variable to the error value for 
-- the INSERT statement.
SELECT @ins_error = @@ERROR

-- Test the error values.
IF @del_error = 1 AND @ins_error = 0
BEGIN
   -- Success. Commit the transaction.
   PRINT 'The user information has been replaced'
END
ELSE
BEGIN
   -- An error occurred. Indicate which operation(s) failed
   -- and roll back the transaction.
	IF @del_error = 0 
	begin
		set @trapped = 30
		set @ErrorMsg = 'An error occurred during execution of the DELETE statement. '
	end

	IF @ins_error <> 0
	begin
		if @trapped = 30
			set @trapped = 45
		else
			set @trapped = 40
		select @ErrorMsg = @ErrorMsg + 'An error occurred during execution of the INSERT statement.'
	end
	goto Error_Handler
END

if @debug > 1
	print 'End of Example two'
--
-- End of example two
--
*/
/*
--
--  Example three follows
--
declare @newID uniqueidentifier
if @debug > 1
	print 'Example Three'
-- modify this one too buthead
select @newID=User_key 
from MSC_User 
where User_nm = 'bcbst\j131w'
if (@@rowcount = 0) 
	begin
	set @trapped = 51
	set @ErrorMsg = 'Error retrieving the new ID '
	goto Error_Handler
end
if @debug = 2
	print 'Got the user ' + convert(nvarchar(50),@newID)

if @debug > 1
	print 'End of Example Three'
--
-- End of example three
--
*/
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