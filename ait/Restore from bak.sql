restore database BSMS
from disk = 'C:\steve\db\BSMS_backup_2013_05_30_023003_0630614.bak'
WITH REPLACE,
	move 'BSMS' to 'c:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\CHAMPS.mdf',
	move 'BSMS_log' to 'c:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\CHAMPS_log.ldf'