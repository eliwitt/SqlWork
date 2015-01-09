--  to view the roles and get the keys you need

SELECT     *
FROM         MSC_Role
WHERE     (Role_nm IN ('Administrator', 'Enroller'))

--  to view the user and create an entry just fill in the empty columns

SELECT     *
FROM         MSC_User
WHERE     (Last_nm = 'Witt')

-- once you have the keys for each role and the user then you can enter this into userrole

SELECT     *
FROM         MSC_UserRole
WHERE     (User_key = '<key from the MSC_User>')