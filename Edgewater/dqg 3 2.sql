-- 3.2 Product/Rider Level Rules:

select
 p.Rider_flg[Is Rider?],
 COALESCE(pr.Productshort_nm, '') [Parent Product Short Name],
 p.Productshort_nm [Product Short Name],
 r.rule_nm [Rule Type],
 ri.instancerule_nm [Rule Name],
 ri.Message_txt [Error Message],
 rp.parameter_nm [Parameter Name],
 COALESCE(rip.ruleinstance_txt, a.Question_Entity_vv + '.' + a.Field_Label_txt) [Value],
 c.productdisplay_nm [Group Product From Drop-Down],
 a2.Question_Entity_vv + '.' + a2.Field_Label_txt [Condition AI],
 rc.Operator_vv [Condition Operator],
 rc.RuleConditionValue_txt [Condition Comparison Value],
 rc.RuleConditionValueType_vv [Condition Display Format]
from rul_ruleinstance ri
join prd_product p on ri.product_key = p.product_key
join rul_rule r on ri.rule_key = r.rule_key
join rul_ruleinstanceparameter rip on ri.ruleinstance_key = rip.ruleinstance_key
join rul_ruleparameter rp on rip.ruleparameter_key = rp.ruleparameter_key
left join ANS_Answer a on rip.Answer_key = a.answer_key
left join grp_groupproduct gpr on rip.groupproduct_key = gpr.groupproduct_key
left join prd_customization c on rip.groupproduct_key = c.groupproduct_key
left join prd_rider rd on p.product_key = rd.rider_key
left join prd_product pr on rd.product_key = pr.product_key
left join RUL_RuleCondition rc on ri.RuleInstance_key = rc.RuleInstance_key
left join ANS_Answer a2 on rc.Answer_key = a2.Answer_key
order by [Parent Product Short Name], [Rule Type]
