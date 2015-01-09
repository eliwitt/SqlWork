/* Add new permissions */
INSERT INTO MSC_Permission ( Permission_key, Permission_cd, Permission_nm, PermissionType_vv, ExecuteAssembly_nm, ExecuteFunction_nm, Permission_desc, Last_Update_key ) VALUES ( 'CE48A70A-F47D-491F-8D1A-8201D60FBAE6', 'Admin_Product', 'Access the Product Administration Web Screens', 'CONTROL', NULL, NULL, NULL, NULL) ;
INSERT INTO MSC_Permission ( Permission_key, Permission_cd, Permission_nm, PermissionType_vv, ExecuteAssembly_nm, ExecuteFunction_nm, Permission_desc, Last_Update_key ) VALUES ( '525D2188-26B4-4A82-A872-E6EDD5D0EDBD', 'Admin_Document', 'Access the Document Administration Web Screens', 'CONTROL', NULL, NULL, NULL, NULL) ;
INSERT INTO MSC_Permission ( Permission_key, Permission_cd, Permission_nm, PermissionType_vv, ExecuteAssembly_nm, ExecuteFunction_nm, Permission_desc, Last_Update_key ) VALUES ( '42F1760B-C7F1-494C-AC85-C62A41CCBE2C', 'Admin_Table', 'Access the Table Administration Web Screens', 'CONTROL', NULL, NULL, NULL, NULL) ;

/* Assign new permissions to Administartor role */
INSERT INTO MSC_RolePermission ( RolePermission_key, Role_key, Permission_key, Last_Update_key ) VALUES ( '39A27A32-89E1-436C-B746-A6AB37182396', 'D68FA4EF-7E66-4332-A49D-51373E4C156E', 'CE48A70A-F47D-491F-8D1A-8201D60FBAE6', NULL) ;
INSERT INTO MSC_RolePermission ( RolePermission_key, Role_key, Permission_key, Last_Update_key ) VALUES ( 'C64A79C3-B6F0-4947-9B84-8DEA89A7B743', 'D68FA4EF-7E66-4332-A49D-51373E4C156E', '525D2188-26B4-4A82-A872-E6EDD5D0EDBD', NULL) ;
INSERT INTO MSC_RolePermission ( RolePermission_key, Role_key, Permission_key, Last_Update_key ) VALUES ( '70EE2F30-341E-4492-A973-5F1392B3802A', 'D68FA4EF-7E66-4332-A49D-51373E4C156E', '42F1760B-C7F1-494C-AC85-C62A41CCBE2C', NULL) ;
