-- 4.1 Cost information per product for all dimensions (Example: Accident Elite Products)
select distinct p.Product_nm, dx.DimensionSeq_val,dx.Dimension_vv as 'Dimension', dx.DimensionType_vv as 'Dimension Type', 
ans.Answer_Identifier_nm,av2.answershort_nm as 'Dimensionvalue', premium_amt
from prd_product p
join prd_costTableSet cts on p.Product_key = cts.Product_key
join prd_costTable ct on ct.CostTableSet_key = cts.CostTableSet_key
join prd_costTableValue ctv on ctv.CostTable_key = ct.CostTable_key
left join prd_dimensionvalue dvX on dvX.DimensionValue_key = ctv.DimensionValue_X_key
left join prd_dimension dx on dvx.Dimension_key = dx.Dimension_key
left join ans_answer ans on ans.answer_key = dx.answer_key
left join ans_answervalue av2 on av2.answervalue_key = dvx.answervalue_key 
where product_nm like  'Accident Elite%'
and dx.Dimension_vv is not null
union
select distinct p.Product_nm, dy.DimensionSeq_val,dy.Dimension_vv as 'Dimension', dy.DimensionType_vv as 'Dimension Type', 
ans.Answer_Identifier_nm,  av1.answershort_nm as 'Dimension Value',
premium_amt
from prd_product p
join prd_costTableSet cts on p.Product_key = cts.Product_key
join prd_costTable ct on ct.CostTableSet_key = cts.CostTableSet_key
join prd_costTableValue ctv on ctv.CostTable_key = ct.CostTable_key
left join prd_dimensionvalue dvY on dvY.DimensionValue_key = ctv.DimensionValue_Y_key
left join prd_dimension dY on dvY.Dimension_key = dY.Dimension_key
left join ans_answer ans on ans.answer_key = dy.answer_key
left join ans_answervalue av1 on av1.answervalue_key = dvy.answervalue_key 
where product_nm like  'Accident Elite%'
and dy.Dimension_vv is not null
union
select distinct p.product_nm, d.DimensionSeq_val,d.Dimension_vv as 'Addl Dimension', 
DimensionType_vv  as 'Addl Dimension Type',ans.Answer_Identifier_nm, av1.answershort_nm as 'Additional Dimension Value',null
from prd_dimension d
  JOIN prd_product p on p.product_key = d.product_key
  JOIN PRD_dimensionvalue dv on dv.Dimension_key = d.Dimension_key
  JOIN PRD_CostTableDimensionValue ctdv on dv.DimensionValue_key = ctdv.DimensionValue_key
left join ans_answer ans on ans.answer_key = d.answer_key
left join ans_answervalue av1 on av1.answervalue_key = dv.answervalue_key 
where product_nm like  'Accident Elite%' 
and dv.Disabled_flg = 'N'
      AND Dimension_vv = 'ADDITIONAL'
and d.Dimension_vv is not null
ORDER BY  p.Product_nm,'Dimension'
