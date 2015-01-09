DECLARE @scripver VARCHAR(60),
	@last_script VARCHAR(60),
	@debug int,
	@trapped int,
	@ErrorMsg varchar(255)
--  Update the script values with the proper values
SET @scripver = '23B_Update_16'
SET @last_script = '23B_Update_15'
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
update msc_table set tableorder_num = 10
if (@@error <> 0)
begin
	set @trapped = 30
	set @ErrorMsg = 'Error attempting to update msc_table Start '
	goto Error_Handler
end
update msc_table set tableorder_num = 80 where table_nm = 'GRP_GroupProductDimension'
if (@@error <> 0)
begin
	set @trapped = 31
	set @ErrorMsg = 'Error attempting to update msc_table GRP_GroupProductDimension '
	goto Error_Handler
end
update msc_table set tableorder_num = 30 where table_nm = 'MSC_Contact'
if (@@error <> 0)
begin
	set @trapped = 32
	set @ErrorMsg = 'Error attempting to update msc_table MSC_Contact '
	goto Error_Handler
end
update msc_table set tableorder_num = 20 where table_nm = 'MSC_State'
if (@@error <> 0)
begin
	set @trapped = 33
	set @ErrorMsg = 'Error attempting to update msc_table MSC_State '
	goto Error_Handler
end
update msc_table set tableorder_num = 90 where table_nm = 'RUL_RuleCondition'
if (@@error <> 0)
begin
	set @trapped = 34
	set @ErrorMsg = 'Error attempting to update msc_table RUL_RuleCondition'
	goto Error_Handler
end
update msc_table set tableorder_num = 30 where table_nm = 'MSC_Report'
if (@@error <> 0)
begin
	set @trapped = 35
	set @ErrorMsg = 'Error attempting to update msc_table MSC_Report '
	goto Error_Handler
end
update msc_table set tableorder_num = 60 where table_nm = 'GRP_GroupImportEmployee'
if (@@error <> 0)
begin
	set @trapped = 36
	set @ErrorMsg = 'Error attempting to update msc_table GRP_GroupImportEmployee '
	goto Error_Handler
end
update msc_table set tableorder_num = 100 where table_nm = 'PRD_CostTableDimensionValue'
if (@@error <> 0)
begin
	set @trapped = 37
	set @ErrorMsg = 'Error attempting to update msc_table PRD_CostTableDimensionValue '
	goto Error_Handler
end
update msc_table set tableorder_num = 20 where table_nm = 'RUL_Rule'
if (@@error <> 0)
begin
	set @trapped = 38
	set @ErrorMsg = 'Error attempting to update msc_table RUL_Rule '
	goto Error_Handler
end
update msc_table set tableorder_num = 30 where table_nm = 'MSC_CustomField'
if (@@error <> 0)
begin
	set @trapped = 39
	set @ErrorMsg = 'Error attempting to update msc_table MSC_CustomField '
	goto Error_Handler
end
update msc_table set tableorder_num = 40 where table_nm = 'ANS_AnswerGroupDetail'
if (@@error <> 0)
begin
	set @trapped = 40
	set @ErrorMsg = 'Error attempting to update msc_table ANS_AnswerGroupDetail '
	goto Error_Handler
end
update msc_table set tableorder_num = 110 where table_nm = 'EMP_EmployeeProduct'
if (@@error <> 0)
begin
	set @trapped = 42
	set @ErrorMsg = 'Error attempting to update msc_table EMP_EmployeeProduct '
	goto Error_Handler
end
update msc_table set tableorder_num = 20 where table_nm = 'MSC_ValidType'
if (@@error <> 0)
begin
	set @trapped = 43
	set @ErrorMsg = 'Error attempting to update msc_table MSC_ValidType '
	goto Error_Handler
end
update msc_table set tableorder_num = 100 where table_nm = 'PRD_Informational'
if (@@error <> 0)
begin
	set @trapped = 44
	set @ErrorMsg = 'Error attempting to update msc_table PRD_Informational '
	goto Error_Handler
end
update msc_table set tableorder_num = 80 where table_nm = 'GRP_DimensionEligibility'
if (@@error <> 0)
begin
	set @trapped = 45
	set @ErrorMsg = 'Error attempting to update msc_table GRP_DimensionEligibility '
	goto Error_Handler
end
update msc_table set tableorder_num = 50 where table_nm = 'EMP_Employee'
if (@@error <> 0)
begin
	set @trapped = 46
	set @ErrorMsg = 'Error attempting to update msc_table EMP_Employee '
	goto Error_Handler
end
update msc_table set tableorder_num = 60 where table_nm = 'EMP_Dependent'
if (@@error <> 0)
begin
	set @trapped = 47
	set @ErrorMsg = 'Error attempting to update msc_table EMP_Dependent '
	goto Error_Handler
end
update msc_table set tableorder_num = 70 where table_nm = 'EMP_EmployeeEnrollmentPeriod'
if (@@error <> 0)
begin
	set @trapped = 48
	set @ErrorMsg = 'Error attempting to update msc_table EMP_EmployeeEnrollmentPeriod '
	goto Error_Handler
end
update msc_table set tableorder_num = 60 where table_nm = 'EMP_EmployeeCarrier'
if (@@error <> 0)
begin
	set @trapped = 49
	set @ErrorMsg = 'Error attempting to update msc_table EMP_EmployeeCarrier '
	goto Error_Handler
end
update msc_table set tableorder_num = 30 where table_nm = 'MSC_ValidValue'
if (@@error <> 0)
begin
	set @trapped = 50
	set @ErrorMsg = 'Error attempting to update msc_table MSC_ValidValue '
	goto Error_Handler
end
update msc_table set tableorder_num = 80 where table_nm = 'PRD_Customization'
if (@@error <> 0)
begin
	set @trapped = 52
	set @ErrorMsg = 'Error attempting to update msc_table PRD_Customization '
	goto Error_Handler
end
update msc_table set tableorder_num = 20 where table_nm = 'MSC_Criteria'
if (@@error <> 0)
begin
	set @trapped = 53
	set @ErrorMsg = 'Error attempting to update msc_table MSC_Criteria '
	goto Error_Handler
end
update msc_table set tableorder_num = 50 where table_nm = 'ANS_AnswerGroupTransaction'
if (@@error <> 0)
begin
	set @trapped = 54
	set @ErrorMsg = 'Error attempting to update msc_table ANS_AnswerGroupTransaction '
	goto Error_Handler
end
update msc_table set tableorder_num = 70 where table_nm = 'EMP_EmployeeData'
if (@@error <> 0)
begin
	set @trapped = 55
	set @ErrorMsg = 'Error attempting to update msc_table EMP_EmployeeData '
	goto Error_Handler
end
update msc_table set tableorder_num = 70 where table_nm = 'EMP_EmployeeTableValue'
if (@@error <> 0)
begin
	set @trapped = 56
	set @ErrorMsg = 'Error attempting to update msc_table EMP_EmployeeTableValue '
	goto Error_Handler
end
update msc_table set tableorder_num = 90 where table_nm = 'DOC_DocumentTransaction'
if (@@error <> 0)
begin
	set @trapped = 57
	set @ErrorMsg = 'Error attempting to update msc_table DOC_DocumentTransaction '
	goto Error_Handler
end
update msc_table set tableorder_num = 50 where table_nm = 'PRD_ProductTransaction'
if (@@error <> 0)
begin
	set @trapped = 58
	set @ErrorMsg = 'Error attempting to update msc_table PRD_ProductTransaction '
	goto Error_Handler
end
update msc_table set tableorder_num = 30 where table_nm = 'MSC_Address'
if (@@error <> 0)
begin
	set @trapped = 59
	set @ErrorMsg = 'Error attempting to update msc_table MSC_Address '
	goto Error_Handler
end
update msc_table set tableorder_num = 20 where table_nm = 'MSC_TimePeriod'
if (@@error <> 0)
begin
	set @trapped = 60
	set @ErrorMsg = 'Error attempting to update msc_table MSC_TimePeriod '
	goto Error_Handler
end
update msc_table set tableorder_num = 60 where table_nm = 'GRP_Enroller'
if (@@error <> 0)
begin
	set @trapped = 61
	set @ErrorMsg = 'Error attempting to update msc_table GRP_Enroller '
	goto Error_Handler
end
update msc_table set tableorder_num = 50 where table_nm = 'PRD_Dimension'
if (@@error <> 0)
begin
	set @trapped = 62
	set @ErrorMsg = 'Error attempting to update msc_table PRD_Dimension '
	goto Error_Handler
end
update msc_table set tableorder_num = 90 where table_nm = 'GRP_GroupProductDimensionValue'
if (@@error <> 0)
begin
	set @trapped = 63
	set @ErrorMsg = 'Error attempting to update msc_table GRP_GroupProductDimensionValue '
	goto Error_Handler
end
update msc_table set tableorder_num = 50 where table_nm = 'GRP_EnrollmentPeriod'
if (@@error <> 0)
begin
	set @trapped = 64
	set @ErrorMsg = 'Error attempting to update msc_table GRP_EnrollmentPeriod '
	goto Error_Handler
end
update msc_table set tableorder_num = 40 where table_nm = 'MSC_AuditDetail'
if (@@error <> 0)
begin
	set @trapped = 65
	set @ErrorMsg = 'Error attempting to update msc_table MSC_AuditDetail '
	goto Error_Handler
end
update msc_table set tableorder_num = 30 where table_nm = 'MSC_UserState'
if (@@error <> 0)
begin
	set @trapped = 66
	set @ErrorMsg = 'Error attempting to update msc_table MSC_UserState '
	goto Error_Handler
end
update msc_table set tableorder_num = 20 where table_nm = 'MSC_Audit'
if (@@error <> 0)
begin
	set @trapped = 67
	set @ErrorMsg = 'Error attempting to update msc_table MSC_Audit '
	goto Error_Handler
end
update msc_table set tableorder_num = 80 where table_nm = 'PRD_QuestionUsageTransaction'
if (@@error <> 0)
begin
	set @trapped = 68
	set @ErrorMsg = 'Error attempting to update msc_table PRD_QuestionUsageTransaction '
	goto Error_Handler
end
update msc_table set tableorder_num = 70 where table_nm = 'EMP_ReportSignature'
if (@@error <> 0)
begin
	set @trapped = 69
	set @ErrorMsg = 'Error attempting to update msc_table EMP_ReportSignature '
	goto Error_Handler
end
update msc_table set tableorder_num = 80 where table_nm = 'ANS_QuestionUsageSequence'
if (@@error <> 0)
begin
	set @trapped = 70
	set @ErrorMsg = 'Error attempting to update msc_table ANS_QuestionUsageSequence '
	goto Error_Handler
end
update msc_table set tableorder_num = 100 where table_nm = 'GRP_DimensionValueEligibilityDtl'
if (@@error <> 0)
begin
	set @trapped = 71
	set @ErrorMsg = 'Error attempting to update msc_table GRP_DimensionValueEligibilityDtl '
	goto Error_Handler
end
update msc_table set tableorder_num = 60 where table_nm = 'GRP_GroupTableValue'
if (@@error <> 0)
begin
	set @trapped = 72
	set @ErrorMsg = 'Error attempting to update msc_table GRP_GroupTableValue '
	goto Error_Handler
end
update msc_table set tableorder_num = 60 where table_nm = 'PRD_DimensionValue'
if (@@error <> 0)
begin
	set @trapped = 73
	set @ErrorMsg = 'Error attempting to update msc_table PRD_DimensionValue '
	goto Error_Handler
end
update msc_table set tableorder_num = 80 where table_nm = 'RUL_RuleInstance'
if (@@error <> 0)
begin
	set @trapped = 74
	set @ErrorMsg = 'Error attempting to update msc_table RUL_RuleInstance '
	goto Error_Handler
end
update msc_table set tableorder_num = 80 where table_nm = 'DOC_DocumentUsage'
if (@@error <> 0)
begin
	set @trapped = 75
	set @ErrorMsg = 'Error attempting to update msc_table DOC_DocumentUsage '
	goto Error_Handler
end
update msc_table set tableorder_num = 30 where table_nm = 'MSC_AuditTable'
if (@@error <> 0)
begin
	set @trapped = 76
	set @ErrorMsg = 'Error attempting to update msc_table MSC_AuditTable '
	goto Error_Handler
end
update msc_table set tableorder_num = 50 where table_nm = 'GRP_GroupImport'
if (@@error <> 0)
begin
	set @trapped = 77
	set @ErrorMsg = 'Error attempting to update msc_table GRP_GroupImport '
	goto Error_Handler
end
update msc_table set tableorder_num = 40 where table_nm = 'GRP_Group'
if (@@error <> 0)
begin
	set @trapped = 78
	set @ErrorMsg = 'Error attempting to update msc_table GRP_Group '
	goto Error_Handler
end
update msc_table set tableorder_num = 20 where table_nm = 'MSC_Coverage'
if (@@error <> 0)
begin
	set @trapped = 79
	set @ErrorMsg = 'Error attempting to update msc_table MSC_Coverage '
	goto Error_Handler
end
update msc_table set tableorder_num = 80 where table_nm = 'PRD_CostTableSet'
if (@@error <> 0)
begin
	set @trapped = 80
	set @ErrorMsg = 'Error attempting to update msc_table PRD_CostTableSet '
	goto Error_Handler
end
update msc_table set tableorder_num = 90 where table_nm = 'PRD_CostTable'
if (@@error <> 0)
begin
	set @trapped = 81
	set @ErrorMsg = 'Error attempting to update msc_table PRD_CostTable '
	goto Error_Handler
end
update msc_table set tableorder_num = 120 where table_nm = 'EMP_EmployeeProductData'
if (@@error <> 0)
begin
	set @trapped = 82
	set @ErrorMsg = 'Error attempting to update msc_table EMP_EmployeeProductData '
	goto Error_Handler
end
update msc_table set tableorder_num = 60 where table_nm = 'GRP_EnrollmentLicensure'
if (@@error <> 0)
begin
	set @trapped = 83
	set @ErrorMsg = 'Error attempting to update msc_table GRP_EnrollmentLicensure '
	goto Error_Handler
end
update msc_table set tableorder_num = 120 where table_nm = 'EMP_EmployeeProductDependent'
if (@@error <> 0)
begin
	set @trapped = 84
	set @ErrorMsg = 'Error attempting to update msc_table EMP_EmployeeProductDependent '
	goto Error_Handler
end
update msc_table set tableorder_num = 30 where table_nm = 'MSC_ValidTypeUsage'
if (@@error <> 0)
begin
	set @trapped = 85
	set @ErrorMsg = 'Error attempting to update msc_table MSC_ValidTypeUsage '
	goto Error_Handler
end
update msc_table set tableorder_num = 50 where table_nm = 'PRD_PurchaserCoverage'
if (@@error <> 0)
begin
	set @trapped = 86
	set @ErrorMsg = 'Error attempting to update msc_table PRD_PurchaserCoverage '
	goto Error_Handler
end
update msc_table set tableorder_num = 120 where table_nm = 'EMP_EmployeeProductEnrollment'
if (@@error <> 0)
begin
	set @trapped = 87
	set @ErrorMsg = 'Error attempting to update msc_table EMP_EmployeeProductEnrollment '
	goto Error_Handler
end
update msc_table set tableorder_num = 30 where table_nm = 'MSC_UserLanguage'
if (@@error <> 0)
begin
	set @trapped = 88
	set @ErrorMsg = 'Error attempting to update msc_table MSC_UserLanguage '
	goto Error_Handler
end
update msc_table set tableorder_num = 50 where table_nm = 'PRD_Rider'
if (@@error <> 0)
begin
	set @trapped = 89
	set @ErrorMsg = 'Error attempting to update msc_table PRD_Rider '
	goto Error_Handler
end
update msc_table set tableorder_num = 70 where table_nm = 'GRP_GroupProduct'
if (@@error <> 0)
begin
	set @trapped = 90
	set @ErrorMsg = 'Error attempting to update msc_table GRP_GroupProduct '
	goto Error_Handler
end
update msc_table set tableorder_num = 30 where table_nm = 'MSC_UserRole'
if (@@error <> 0)
begin
	set @trapped = 91
	set @ErrorMsg = 'Error attempting to update msc_table MSC_UserRole '
	goto Error_Handler
end
update msc_table set tableorder_num = 120 where table_nm = 'EMP_ProductRider'
if (@@error <> 0)
begin
	set @trapped = 92
	set @ErrorMsg = 'Error attempting to update msc_table EMP_ProductRider '
	goto Error_Handler
end
update msc_table set tableorder_num = 40 where table_nm = 'MSC_ReportCriteria'
if (@@error <> 0)
begin
	set @trapped = 93
	set @ErrorMsg = 'Error attempting to update msc_table MSC_ReportCriteria '
	goto Error_Handler
end
update msc_table set tableorder_num = 80 where table_nm = 'EMP_PriorEmployeeProduct'
if (@@error <> 0)
begin
	set @trapped = 94
	set @ErrorMsg = 'Error attempting to update msc_table EMP_PriorEmployeeProduct '
	goto Error_Handler
end
update msc_table set tableorder_num = 90 where table_nm = 'EMP_PriorEmployeeProductDependent'
if (@@error <> 0)
begin
	set @trapped = 95
	set @ErrorMsg = 'Error attempting to update msc_table EMP_PriorEmployeeProductDependent '
	goto Error_Handler
end
update msc_table set tableorder_num = 40 where table_nm = 'PRD_Product'
if (@@error <> 0)
begin
	set @trapped = 96
	set @ErrorMsg = 'Error attempting to update msc_table PRD_Product '
	goto Error_Handler
end
update msc_table set tableorder_num = 80 where table_nm = 'GRP_GroupProductFilter'
if (@@error <> 0)
begin
	set @trapped = 97
	set @ErrorMsg = 'Error attempting to update msc_table GRP_GroupProductFilter '
	goto Error_Handler
end
update msc_table set tableorder_num = 50 where table_nm = 'GRP_GroupTableType'
if (@@error <> 0)
begin
	set @trapped = 98
	set @ErrorMsg = 'Error attempting to update msc_table GRP_GroupTableType '
	goto Error_Handler
end
update msc_table set tableorder_num = 50 where table_nm = 'PRD_ApprovedStates'
if (@@error <> 0)
begin
	set @trapped = 99
	set @ErrorMsg = 'Error attempting to update msc_table PRD_ApprovedStates '
	goto Error_Handler
end
update msc_table set tableorder_num = 20 where table_nm = 'MSC_User'
if (@@error <> 0)
begin
	set @trapped = 100
	set @ErrorMsg = 'Error attempting to update msc_table MSC_User '
	goto Error_Handler
end
update msc_table set tableorder_num = 20 where table_nm = 'MSC_Permission'
if (@@error <> 0)
begin
	set @trapped = 101
	set @ErrorMsg = 'Error attempting to update msc_table MSC_Permission '
	goto Error_Handler
end
update msc_table set tableorder_num = 90 where table_nm = 'GRP_DimensionValueEligibility'
if (@@error <> 0)
begin
	set @trapped = 102
	set @ErrorMsg = 'Error attempting to update msc_table GRP_DimensionValueEligibility '
	goto Error_Handler
end
update msc_table set tableorder_num = 30 where table_nm = 'EMP_Person'
if (@@error <> 0)
begin
	set @trapped = 103
	set @ErrorMsg = 'Error attempting to update msc_table EMP_Person '
	goto Error_Handler
end
update msc_table set tableorder_num = 50 where table_nm = 'ANS_AnswerValue'
if (@@error <> 0)
begin
	set @trapped = 104
	set @ErrorMsg = 'Error attempting to update msc_table ANS_AnswerValue '
	goto Error_Handler
end
update msc_table set tableorder_num = 100 where table_nm = 'PRD_CostTableValue'
if (@@error <> 0)
begin
	set @trapped = 105
	set @ErrorMsg = 'Error attempting to update msc_table PRD_CostTableValue '
	goto Error_Handler
end
update msc_table set tableorder_num = 20 where table_nm = 'GRP_GroupImportType'
if (@@error <> 0)
begin
	set @trapped = 106
	set @ErrorMsg = 'Error attempting to update msc_table GRP_GroupImportType '
	goto Error_Handler
end
update msc_table set tableorder_num = 30 where table_nm = 'MSC_RolePermission'
if (@@error <> 0)
begin
	set @trapped = 107
	set @ErrorMsg = 'Error attempting to update msc_table MSC_RolePermission '
	goto Error_Handler
end
update msc_table set tableorder_num = 20 where table_nm = 'DOC_Document'
if (@@error <> 0)
begin
	set @trapped = 108
	set @ErrorMsg = 'Error attempting to update msc_table DOC_Document '
	goto Error_Handler
end
update msc_table set tableorder_num = 30 where table_nm = 'RUL_RuleParameter'
if (@@error <> 0)
begin
	set @trapped = 109
	set @ErrorMsg = 'Error attempting to update msc_table RUL_RuleParameter '
	goto Error_Handler
end
update msc_table set tableorder_num = 50 where table_nm = 'GRP_Data'
if (@@error <> 0)
begin
	set @trapped = 110
	set @ErrorMsg = 'Error attempting to update msc_table GRP_Data '
	goto Error_Handler
end
update msc_table set tableorder_num = 120 where table_nm = 'EMP_DocumentSignature'
if (@@error <> 0)
begin
	set @trapped = 111
	set @ErrorMsg = 'Error attempting to update msc_table EMP_DocumentSignature '
	goto Error_Handler
end
update msc_table set tableorder_num = 20 where table_nm = 'MSC_Role'
if (@@error <> 0)
begin
	set @trapped = 112
	set @ErrorMsg = 'Error attempting to update msc_table MSC_Role '
	goto Error_Handler
end
update msc_table set tableorder_num = 70 where table_nm = 'ANS_QuestionUsage'
if (@@error <> 0)
begin
	set @trapped = 113
	set @ErrorMsg = 'Error attempting to update msc_table ANS_QuestionUsage '
	goto Error_Handler
end
update msc_table set tableorder_num = 20 where table_nm = 'MSC_Organization'
if (@@error <> 0)
begin
	set @trapped = 114
	set @ErrorMsg = 'Error attempting to update msc_table MSC_Organization '
	goto Error_Handler
end
update msc_table set tableorder_num = 50 where table_nm = 'GRP_GroupCarrier'
if (@@error <> 0)
begin
	set @trapped = 115
	set @ErrorMsg = 'Error attempting to update msc_table GRP_GroupCarrier '
	goto Error_Handler
end
update msc_table set tableorder_num = 130 where table_nm = 'EMP_CompletedTransaction'
if (@@error <> 0)
begin
	set @trapped = 116
	set @ErrorMsg = 'Error attempting to update msc_table EMP_CompletedTransaction '
	goto Error_Handler
end
update msc_table set tableorder_num = 30 where table_nm = 'ANS_Answer'
if (@@error <> 0)
begin
	set @trapped = 117
	set @ErrorMsg = 'Error attempting to update msc_table ANS_Answer '
	goto Error_Handler
end
update msc_table set tableorder_num = 90 where table_nm = 'RUL_RuleInstanceParameter'
if (@@error <> 0)
begin
	set @trapped = 118
	set @ErrorMsg = 'Error attempting to update msc_table RUL_RuleInstanceParameter '
	goto Error_Handler
end
update msc_table set tableorder_num = 20 where table_nm = 'ANS_AnswerGroup'
if (@@error <> 0)
begin
	set @trapped = 119
	set @ErrorMsg = 'Error attempting to update msc_table ANS_AnswerGroup '
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
	set @trapped = 150
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