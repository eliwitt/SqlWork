SELECT edg_tbl_Users.UserId AS perm_UserId, edg_tbl_Users.UserName, 
edg_tbl_Permisions.Permission_ID, edg_tbl_Permisions.Rights,
edg_tbl_Permision_Definitions.Description,edg_tbl_Permision_Definitions.Menu_Type,
edg_tbl_Permision_Definitions.Menu_order, edg_tbl_Permision_Definitions.Tag, 
edg_tbl_Permision_Definitions.Active,
edg_tbl_Permision_Definitions.Help, edg_tbl_Permision_Definitions.Subscriber_Type
FROM edg_tbl_Users 
	INNER JOIN edg_tbl_Permisions 
		ON edg_tbl_Users.UserId = edg_tbl_Permisions.User_ID 
	INNER JOIN edg_tbl_Permision_Definitions 
		ON edg_tbl_Permisions.Permission_ID = edg_tbl_Permision_Definitions.id
WHERE (edg_tbl_Users.UserId = 1109 and Subscriber_Type=1 ) order by menu_order