SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO



ALTER   PROCEDURE DeleteEmployee
(
	@groupName	varchar(60),
	@employeeSSN	varchar(9)
)
AS
SET NOCOUNT ON
declare @groupKey	uniqueidentifier,
	@employeeKey	uniqueidentifier,
	@debug		int,
	@OrphanedCount	int,
	@EmpCount	int,
	@trapped	int,
	@ErrorMsg varchar(255)
-- to test you will need to set the groupName
--set @groupName = 'Witt Test Group'
--set @employeeSSN = '234567821'
--
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
-------------------------------------------------------------------------------
-- Cleanup any orphaned records first 
-------------------------------------------------------------------------------
DECLARE @orphanedRecordsToDelete TABLE
(
    EmployeeProduct_key uniqueidentifier
)

INSERT INTO	@orphanedRecordsToDelete
SELECT EmployeeProduct_key FROM EMP_EmployeeProductEnrollment 
WHERE EmployeeProduct_key not in (SELECT EmployeeProduct_key FROM emp_employeeproduct)
UNION 
SELECT EmployeeProduct_key FROM EMP_EmployeeProduct 
WHERE Employee_key NOT IN (SELECT Employee_key FROM EMP_Person) 

Select @OrphanedCount = Count(*) from @orphanedRecordsToDelete
if @debug > 0 
begin
	print 'There are ' + cast(@OrphanedCount as nvarchar(5)) + 
		' orphans to delete.'
	if @debug > 2
		select * from @orphanedRecordsToDelete
end

if @OrphanedCount = 0
	goto Emp_Del_Resum
if @debug > 0 
	PRINT 'Deleted Orphaned records :' + cast(@OrphanedCount as nvarchar(5))
--
-- start the orphan transaction
--
begin tran OrphanTran
-- turn on the rollback indicator on 
set @trapped = 10
-------------------------------------------------------------------------------
-- delete Employee Product Data
-------------------------------------------------------------------------------
DELETE FROM EMP_EmployeeProductData
WHERE  EmployeeProduct_key 
IN 
 (SELECT EmployeeProduct_key
  FROM   @orphanedRecordsToDelete)
if (@@error <> 0)
begin
	set @ErrorMsg = 'Error when deleting from EmlpoyeeProductData'
	goto Error_Handler
end
set @trapped = 11
-------------------------------------------------------------------------------
-- delete employee product rider
-------------------------------------------------------------------------------
DELETE FROM EMP_ProductRider
WHERE  EmployeeProduct_key 
IN 
 (SELECT EmployeeProduct_key
  FROM   @orphanedRecordsToDelete)
if (@@error <> 0)
begin
	set @ErrorMsg = 'Error when deleting from ProductRider'
	goto Error_Handler
end
set @trapped = 12
-------------------------------------------------------------------------------
-- delete completed transactions
-------------------------------------------------------------------------------
DELETE FROM EMP_CompletedTransaction
WHERE  EmployeeProductEnrollment_key 
IN 
 (SELECT EmployeeProductEnrollment_key
  FROM   EMP_EmployeeProductEnrollment EPE
  JOIN	 @orphanedRecordsToDelete O
  ON	 O.EmployeeProduct_key = EPE.EmployeeProduct_key)
if (@@error <> 0)
begin
	set @ErrorMsg = 'Error when deleting from CompletedTransaction'
	goto Error_Handler
end
set @trapped = 13
-------------------------------------------------------------------------------
-- delete employee product enrollment
-------------------------------------------------------------------------------
DELETE FROM EMP_EmployeeProductEnrollment
WHERE  EmployeeProduct_key 
IN 
 (SELECT EmployeeProduct_key
  FROM   @orphanedRecordsToDelete)
if (@@error <> 0)
begin
	set @ErrorMsg = 'Error when deleting from EmployeeProductEnrollment'
	goto Error_Handler
end
set @trapped = 14
-------------------------------------------------------------------------------
-- delete document signature
-------------------------------------------------------------------------------
DELETE FROM EMP_DocumentSignature
WHERE  EmployeeProduct_key 
IN 
 (SELECT EmployeeProduct_key
  FROM   @orphanedRecordsToDelete)
if (@@error <> 0)
begin
	set @ErrorMsg = 'Error when deleting from DocumentSignature'
	goto Error_Handler
end
set @trapped = 15
-------------------------------------------------------------------------------
-- delete employee product dependent
-------------------------------------------------------------------------------
DELETE FROM EMP_EmployeeProductDependent
WHERE  EmployeeProduct_key 
IN 
 (SELECT EmployeeProduct_key
  FROM   @orphanedRecordsToDelete)
if (@@error <> 0)
begin
	set @ErrorMsg = 'Error when deleting from EmployeeProductDependent'
	goto Error_Handler
end
set @trapped = 16
-------------------------------------------------------------------------------
-- delete Employee Product
-------------------------------------------------------------------------------
DELETE FROM EMP_EmployeeProduct
WHERE  EmployeeProduct_key 
IN 
 (SELECT EmployeeProduct_key
  FROM   @orphanedRecordsToDelete)
if (@@error <> 0)
begin
	set @ErrorMsg = 'Error when deleting from EmployeeProduct'
	goto Error_Handler
end
set @trapped = 17

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

Emp_Del_Resum:
set @trapped = 0
if @debug > 0 
	print 'At the start of the Employee Delete process'
-------------------------------------------------------------------------------
-- Now Delete the group delete code...
-------------------------------------------------------------------------------
SELECT 	@groupKey = Organization_key
FROM	MSC_Organization
WHERE	Organization_nm = @groupName

IF (@@rowcount = 0)
begin
	set @ErrorMsg = @groupName + ' is an invalid Group Name resubmit with the correct name.'
	goto Error_Handler
End

SELECT 	@employeeKey = E.Person_key
FROM	EMP_PERSON P
JOIN	EMP_EMPLOYEE E 
ON 	E.Person_key = P.Person_key
JOIN 	EMP_EmployeeEnrollmentPeriod EEP
ON	EEP.Person_key = E.Person_key
JOIN	GRP_EnrollmentPeriod GP
ON	GP.EnrollmentPeriod_key = EEP.EnrollmentPeriod_key
WHERE	SSN_txt = @employeeSSN AND
	GP.Group_key = @groupKey

IF (@@rowcount = 0)
begin
	set @ErrorMsg = @employeeSSN + ' is an invalid SSN resubmit with the correct number.'
	goto Error_Handler
End

PRINT 'Deleting User - Employee_Key = '
PRINT @employeeKey
--
-- start the grp transaction
--
begin tran EmpTran
-- turn on the rollback indicator on 
set @trapped = 30
-------------------------------------------------------------------------------
-- delete Employee Product Data
-------------------------------------------------------------------------------
DELETE FROM EMP_EmployeeProductData
WHERE  Person_key = @employeeKey   
if (@@error <> 0)
begin
	set @ErrorMsg = 'Error when deleting from EmployeeProductData'
	goto Error_Handler
end
set @trapped = 31    
-------------------------------------------------------------------------------
-- delete employee product rider
-------------------------------------------------------------------------------
DELETE FROM EMP_ProductRider
WHERE       EmployeeProduct_key 
IN 
 (SELECT EmployeeProduct_key
  FROM   EMP_EmployeeProduct 
  WHERE  Employee_key = @employeeKey)
if (@@error <> 0)
begin
	set @ErrorMsg = 'Error when deleting from ProductRider'
	goto Error_Handler
end
set @trapped = 32
-------------------------------------------------------------------------------
-- delete group import employee 
-------------------------------------------------------------------------------
DELETE FROM GRP_GroupImportEmployee
WHERE  Person_key = @employeeKey
if (@@error <> 0)
begin
	set @ErrorMsg = 'Error when deleting from GroupImportEmployee'
	goto Error_Handler
end
set @trapped = 33
-------------------------------------------------------------------------------
-- delete completed transactions
-------------------------------------------------------------------------------
DELETE FROM EMP_CompletedTransaction
WHERE       EmployeeProductEnrollment_key 
IN 
 (SELECT EmployeeProductEnrollment_key
  FROM   EMP_EmployeeProductEnrollment EPE
  JOIN	 EMP_EmployeeProduct EP
  ON	 EP.EmployeeProduct_key = EPE.EmployeeProduct_key
  WHERE  EP.Employee_key = @employeeKey)
if (@@error <> 0)
begin
	set @ErrorMsg = 'Error when deleting from CompletedTransaction'
	goto Error_Handler
end
set @trapped = 34
-------------------------------------------------------------------------------
-- delete employee product enrollment
-------------------------------------------------------------------------------
DELETE FROM EMP_EmployeeProductEnrollment
WHERE       EmployeeProduct_key  
IN 
 (SELECT EmployeeProduct_key
  FROM	 EMP_EmployeeProduct
  WHERE  Employee_key = @employeeKey)
if (@@error <> 0)
begin
	set @ErrorMsg = 'Error when deleting from EmployeeProductEnrollment'
	goto Error_Handler
end
set @trapped = 35
-------------------------------------------------------------------------------
-- delete Prior Employee Product Dependent
-------------------------------------------------------------------------------
DELETE FROM EMP_PriorEmployeeProductDependent
WHERE       PriorEmployeeProduct_key  
IN 
 (SELECT PriorEmployeeProduct_key
  FROM	 EMP_PriorEmployeeProduct
  WHERE  Employee_key = @employeeKey)
if (@@error <> 0)
begin
	set @ErrorMsg = 'Error when deleting from PriorEmployeeProductDependent'
	goto Error_Handler
end
set @trapped = 36
-------------------------------------------------------------------------------
-- delete Prior Employee Product
-------------------------------------------------------------------------------
DELETE FROM EMP_PriorEmployeeProduct
WHERE  Employee_key = @employeeKey
if (@@error <> 0)
begin
	set @ErrorMsg = 'Error when deleting from PriorEmployeeProduct'
	goto Error_Handler
end
set @trapped = 37
-------------------------------------------------------------------------------
-- delete Employee Data
-------------------------------------------------------------------------------
DELETE FROM EMP_EmployeeData
WHERE  Person_key = @employeeKey
if (@@error <> 0)
begin
	set @ErrorMsg = 'Error when deleting from EmployeeData'
	goto Error_Handler
end
set @trapped = 38
-------------------------------------------------------------------------------
-- delete employee carrier
-------------------------------------------------------------------------------
DELETE FROM EMP_EmployeeCarrier
WHERE  Person_key = @employeeKey  
if (@@error <> 0)
begin
	set @ErrorMsg = 'Error when deleting from EmployeeCarrier'
	goto Error_Handler
end
set @trapped = 39
-------------------------------------------------------------------------------
-- delete employee table value
-------------------------------------------------------------------------------
DELETE FROM EMP_EmployeeTableValue
WHERE  Person_key = @employeeKey
if (@@error <> 0)
begin
	set @ErrorMsg = 'Error when deleting from EmployeeTableValue'
	goto Error_Handler
end
set @trapped = 40
-------------------------------------------------------------------------------
-- delete report signature
-------------------------------------------------------------------------------
DELETE FROM EMP_ReportSignature
WHERE  Person_key = @employeeKey 
if (@@error <> 0)
begin
	set @ErrorMsg = 'Error when deleting from ReportSignature'
	goto Error_Handler
end
set @trapped = 41
-------------------------------------------------------------------------------
-- delete document signature
-------------------------------------------------------------------------------
DELETE FROM EMP_DocumentSignature
WHERE       EmployeeProduct_key  
IN 
 (SELECT EmployeeProduct_key
  FROM	 EMP_EmployeeProduct
  WHERE  Employee_key = @employeeKey )
if (@@error <> 0)
begin
	set @ErrorMsg = 'Error when deleting from DocumentSignature'
	goto Error_Handler
end
set @trapped = 42
-------------------------------------------------------------------------------
-- delete employee product dependent
-------------------------------------------------------------------------------
DELETE FROM EMP_EmployeeProductDependent
WHERE       EmployeeProduct_key  
IN 
 (SELECT EmployeeProduct_key
  FROM	 EMP_EmployeeProduct
  WHERE  Employee_key = @employeeKey)
if (@@error <> 0)
begin
	set @ErrorMsg = 'Error when deleting from EmployeeProductDependent'
	goto Error_Handler
end
set @trapped = 43
-------------------------------------------------------------------------------
-- delete Employee Product
-------------------------------------------------------------------------------
DELETE FROM EMP_EmployeeProduct
WHERE  Employee_key = @employeeKey  
if (@@error <> 0)
begin
	set @ErrorMsg = 'Error when deleting from EmployeeProduct'
	goto Error_Handler
end
set @trapped = 44
-------------------------------------------------------------------------------
-- delete dependents
-------------------------------------------------------------------------------
DELETE FROM EMP_Dependent
WHERE  Employee_key = @employeeKey     
if (@@error <> 0)
begin
	set @ErrorMsg = 'Error when deleting from Dependent'
	goto Error_Handler
end
set @trapped = 45
-------------------------------------------------------------------------------
-- delete employee enrollment period
-------------------------------------------------------------------------------
DELETE FROM EMP_EmployeeEnrollmentPeriod
WHERE  Person_key = @employeeKey  
if (@@error <> 0)
begin
	set @ErrorMsg = 'Error when deleting from EmployeeEnrollmentPeriod'
	goto Error_Handler
end
set @trapped = 46
-------------------------------------------------------------------------------
-- delete employee
-------------------------------------------------------------------------------
DELETE FROM EMP_Employee
WHERE  Person_key = @employeeKey   
if (@@error <> 0)
begin
	set @ErrorMsg = 'Error when deleting from Employee'
	goto Error_Handler
end
set @trapped = 47
-------------------------------------------------------------------------------
-- delete person
-------------------------------------------------------------------------------
DELETE FROM EMP_Person
WHERE  Person_key = @employeeKey  
if (@@error <> 0)
begin
	set @ErrorMsg = 'Error when deleting from Person'
	goto Error_Handler
end
-------------------------------------------------------------------------
-- bottom of the grp deletes
-------------------------------------------------------------------------
if @debug = 4
begin
	rollback tran EmpTran
	if @debug > 0 
		print 'Successfully deleted the employee trans rollbacked.'
end
else
begin
	commit tran EmpTran
	if @debug > 0
		print 'Successfully deleted the employee trans committed.'
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
	if @trapped < 30
	begin
		print 'Rollback the Orphans'
		rollback tran OrphanTran
	end
	else
	begin
		print 'Rollback the GrpEmpTrans'
		rollback tran EmpTran
	end
end
else
	print @ErrorMsg


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

