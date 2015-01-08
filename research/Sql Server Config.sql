EXEC sp_configure 'Show Advanced Options', 1;
RECONFIGURE;
GO
 
EXEC sp_configure 'Ad Hoc Distributed Queries', 1;
RECONFIGURE;
GO

EXEC sp_msset_oledb_prop N'Microsoft.ACE.OLEDB.12.0', 'AllowInProcess', 1;
GO
 
EXEC sp_msset_oledb_prop N'Microsoft.ACE.OLEDB.12.0', 'DynamicParameters', 1;
GO