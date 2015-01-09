-- the following was from a couple in internet articles on how to import 
-- an excel spreadsheet.  None of this worked by the way.  The server would let 
-- me change some of the config settings but would never let me execute the selects

--INSERT INTO dbo.ImportTest 
sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO
sp_configure 'Ad Hoc Distributed Queries', 1;
GO
RECONFIGURE;
GO


SELECT * FROM OPENROWSET('Microsoft.Jet.OLEDB.4.0', 
'Excel 8.0;Database=C:\Users\dvusc5w\Documents\BSMS\SAPTest\sq01.xlsx', [Sheet1$])

--EXEC sp_addlinkedserver 'ImportData', 
--   'Jet 4.0', 'Microsoft.Jet.OLEDB.4.0', 
--   'C:\Users\dvusc5w\Documents\BSMS\SAPTest\sq01.xlsx', 
--   NULL, 
--   'Excel 8.0' 
--GO 

--INSERT INTO dbo.ImportTest 
--SELECT * 
--FROM OPENQUERY(ImportData, 'SELECT * FROM [Sheet1$]') 

USE [master]

GO

 

sp_configure 'show advanced options', 1

GO

RECONFIGURE WITH OverRide

GO

sp_configure 'Ad Hoc Distributed Queries', 1

GO

RECONFIGURE WITH OverRide

GO

EXEC master.dbo.sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0' , N'AllowInProcess' , 1

GO

EXEC master.dbo.sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0' , N'DynamicParameters' , 1

GO



select * FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0', 'Excel 12.0;Database=C:\Users\dvusc5w\Documents\BSMS\SAPTest\sq01.xlsx', [Sheet1$])

