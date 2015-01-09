restore database ClaimProdMar11
from disk = 'C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Backup\Claims_Mar11.bak'
with 
	move 'ClaimsSchema' to 'C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Data\ClaimProdMar11.mdf',
	move 'ClaimsSchema_log' to 'C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Data\ClaimProdMar11_log.ldf'