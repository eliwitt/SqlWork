SELECT DISTINCT BODY_STYLE.BODY_STYLE_ID, BODY_STYLE.DSC FROM VEH 
	LEFT OUTER JOIN BODY_STYLE ON VEH.BODY_STYLE_ID = BODY_STYLE.BODY_STYLE_ID
	inner join Make_Model mm on mm.make_model_id = veh.make_model_id
WHERE VEH.MAKE_MODEL_ID = mm.make_model_id AND 
mm.[name] = 'Park Avenue' and
VEH.MODEL_YR = 2004 and body_style.dsc = '4 Door Sedan'