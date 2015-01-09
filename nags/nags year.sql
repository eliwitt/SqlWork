SELECT DISTINCT MODEL_YR,Make_Model.MAKE_MODEL_ID FROM VEH, MAKE_MODEL WHERE NAME = 'Park Avenue' and Make_Model.MAKE_MODEL_ID = VEH.MAKE_MODEL_ID
and model_yr = 2004
exec edg_sp_ListModelYear 130