CREATE PROCEDURE DeleteOrphanedEmployeeProductRecords 
(
	@EmployeeProduct_Key	UNIQUEIDENTIFIER,
	@GroupProduct_Key	UNIQUEIDENTIFIER
)

AS

/*
This procedure will be called to delete the orphaned EmployeePro-
duct related records which cause problem when trying to view the 
document for the  employee who was enrolled in a product that has
been deleted from server, but not in the local database. This pro-
cedure is first introduced for fixing the issue defined in TR60293.
--------------------Peng Yu  July-27-2007-------------------------
*/

declare @debug		int,
	@trapped	int,
	@ErrorMsg varchar(255)
--  set @debug to an integer and you will get print statements
--  0 = turn off
--  1 = Info for us
--  2 = high level
--  3 = detail
--  4 = no change
set @debug = 0

-- trapped is used to indicate that a rollback is required
set @trapped = 0 
if @debug > 0
	print 'At the start of the Orphan process'

--
-- start the orphan transaction
--
begin tran OrphanTran
-- turn on the rollback indicator on 
set @trapped = 10
-------------------------------------------------------------------------------
-- delete Completed Transactions
-------------------------------------------------------------------------------
DELETE FROM emp_CompletedTransaction 
where EmployeeProductEnrollment_key = 
(
SELECT EmployeeProductEnrollment_key 
FROM emp_EmployeProductEnrollment
WHERE EmployeeProduct_key =@EmployeeProduct_Key
)
if (@@error <> 0)
begin
	set @ErrorMsg = 'Error when deleting from emp_CompletedTransaction'
	goto Error_Handler
end
set @trapped = 11
-------------------------------------------------------------------------------
-- delete Employee Product Enrollment
-------------------------------------------------------------------------------
DELETE FROM emp_EmployeeProductEnrollment 
WHERE EmployeeProduct_key =@EmployeeProduct_Key
if (@@error <> 0)
begin
	set @ErrorMsg = 'Error when deleting from emp_EmployeeProductEnrollment'
	goto Error_Handler
end
set @trapped = 12
-------------------------------------------------------------------------------
-- delete Signature from the document for the product
-------------------------------------------------------------------------------
DELETE FROM emp_DocumentSignature 
WHERE EmployeeProduct_key =@EmployeeProduct_Key
if (@@error <> 0)
begin
	set @ErrorMsg = 'Error when deleting from emp_DocumentSignature'
	goto Error_Handler
end
set @trapped = 13
-------------------------------------------------------------------------------
-- delete the Employee Dependent records for the product
-------------------------------------------------------------------------------
DELETE FROM emp_EmployeeProductDependent 
WHERE EmployeeProduct_key =@EmployeeProduct_Key
if (@@error <> 0)
begin
	set @ErrorMsg = 'Error when deleting from emp_EmployeeProductDependent'
	goto Error_Handler
end
set @trapped = 14
-------------------------------------------------------------------------------
-- delete rider for the product
-------------------------------------------------------------------------------
DELETE FROM emp_ProductRider 
WHERE EmployeeProduct_key =@EmployeeProduct_Key
if (@@error <> 0)
begin
	set @ErrorMsg = 'Error when deleting from emp_ProductRider'
	goto Error_Handler
end
set @trapped = 15
-------------------------------------------------------------------------------
-- delete data entries for the employee enrolled for the product
-------------------------------------------------------------------------------
DELETE FROM emp_EmployeeProductData 
WHERE EmployeeProduct_key =@EmployeeProduct_Key
if (@@error <> 0)
begin
	set @ErrorMsg = 'Error when deleting from emp_EmployeeProductData'
	goto Error_Handler
end
set @trapped = 16
-------------------------------------------------------------------------------
-- delete the employee-product entries
-------------------------------------------------------------------------------
DELETE FROM emp_EmployeeProduct 
WHERE GroupProduct_key = @GroupProduct_Key
if (@@error <> 0)
begin
	set @ErrorMsg = 'Error when deleting from emp_EmployeeProduct'
	goto Error_Handler
end
-------------------------------------------------------------------------
-- bottom of the orphans
-------------------------------------------------------------------------
if @debug = 4
begin
	rollback tran OrphanTran
	if @debug > 0
		print 'Successfully deleted the orphans trans rollbacked.'
end
else
begin
	commit tran OrphanTran
	if @debug > 0
		print 'Successfully deleted the orphans trans committed.'
end
return
----------------------------------------------------------------------
-- Error Handler
----------------------------------------------------------------------
Error_Handler:
if @debug > 0 
	print 'In Error Handler'

if @trapped > 0 
begin
	print cast(@trapped as nvarchar(5)) + ' ' + @ErrorMsg
	if @debug > 0
		print 'Rollback the trans'

	print 'Rollback the Orphans'
	rollback tran OrphanTran
end
else
	print @ErrorMsg
GO

