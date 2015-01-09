-- select for Quote phase for BSBCT Medical
SELECT * FROM ANS_QuestionUsage 
WHERE Phase_Type_vv = 'QUOTE' 
AND Product_key = '8683da6e-9621-4ac5-b28b-63ca0d88782a'  
ORDER BY DefaultSequence_num ASC