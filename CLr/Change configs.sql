ALTER DATABASE SteveTest 
SET TRUSTWORTHY ON;  
GO  

EXEC sp_configure 'allow updates', 0
RECONFIGURE
go

sp_configure 'show advanced options', 1;
GO
 
RECONFIGURE;
GO
 
sp_configure 'Ole Automation Procedures', 1;
GO
 
RECONFIGURE;
GO

--SELECT name, owner_sid, is_trustworthy_on from sys.databases WHERE name = 'SteveTest'