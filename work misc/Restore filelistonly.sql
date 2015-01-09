--RESTORE LabelONLY 
--FROM disk='C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Backup\Claims_Mar11.bak'
RESTORE HEADERONLY FROM DISK='C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Backup\Claims_Mar11.bak' 

RESTORE VERIFYONLY
FROM DISK='C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Backup\Claims_Mar11.bak' 

GO

IF @@ERROR = 0
BEGIN
   PRINT 'Backup usable'
END
ELSE
BEGIN
    PRINT 'Backup not usable'
END
GO

