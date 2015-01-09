declare @Role uniqueidentifier,
	@newID uniqueidentifier,
	@debug int,
	@trapped int,
	@ErrorMsg varchar(255)
set @debug = 1
-- find the adminsitrator guid
SELECT     @Role=Role_Key
FROM         MSC_Role
WHERE     Role_nm = 'Administrator'
if (@@rowcount = 0) 
	begin
	set @trapped = 10
	set @ErrorMsg = 'Error retrieving administrator GUID '
	goto Error_Handler
end
if @debug = 1
	print 'Found admin ' + convert(nvarchar(50), @Role)

-- modify this one too buthead
select @newID=User_key 
from MSC_User 
where User_nm = 'bcbst\j13155w'
if (@@rowcount = 0) 
	begin
	set @trapped = 21
	set @ErrorMsg = 'Error retrieving the new ID '
	goto Error_Handler
end
if @debug = 1
	print 'Got the user ' + convert(nvarchar(50),@newID)
--
-- now insert the user role with the keys we have stored
insert MSC_UserRole (User_key, Role_key)
values (@newID, @Role)
if (@@error <> 0)
	begin
	set @trapped = 30
	set @ErrorMsg = 'Error attempting to insert role '
	goto Error_Handler
end
-- bottom of the script
Error_Handler:
if @debug = 1
	print 'Error Handler'

IF @ErrorMsg IS NOT NULL
     BEGIN
	SELECT @ErrorMsg = 'aa_setuser: ' + @ErrorMsg + '  ' + convert(varchar(10), @trapped)
	RAISERROR(@ErrorMsg, 11, 1)
	--return 21
     END
if @trapped > 10
	rollback