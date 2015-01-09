exec edg_sp_ListModel 8

SELECT	MAKE_MODEL_ID, Make_Model.[NAME], Make.Make_ID
FROM MAKE_MODEL, Make
WHERE Make.[Name] = 'Buick' and Make.Make_ID = Make_Model.Make_ID
ORDER BY Make_Model.NAME