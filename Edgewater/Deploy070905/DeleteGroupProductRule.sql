CREATE PROCEDURE dbo.DeleteGroupProductandRule
(
	@GroupProductKey uniqueidentifier

)
AS
SET NOCOUNT ON


DECLARE @RuleInstanceKey uniqueidentifier
--DECLARE @GroupProductKey uniqueidentifier
--SET @GroupProductKey='7684be79-639f-4376-8dbc-6fa580c4cc3a'
DECLARE @GroupProductKeyString varchar(100)
SET @GroupProductKeyString = CONVERT(VARCHAR(100), @GroupProductKey) 



Select @RuleInstanceKey = RuleInstance_Key from RUL_RuleInstanceParameter where ruleInstance_txt= @GroupProductKeyString
Select @RuleInstanceKey
Delete from RUL_RuleInstanceParameter where RuleInstance_Key = @RuleInstanceKey
--Select * from RUL_RuleInstanceParameter where RuleInstance_Key = @RuleInstanceKey
Delete from RUL_RuleInstance where RuleInstance_Key = @RuleInstanceKey
--Select * from RUL_ruleinstance where RuleInstance_Key = @RuleInstanceKey
GO


--grant exec on [dbo].[DeleteGroupProductandRule] to AdminAbleReport