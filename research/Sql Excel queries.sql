/*
For Excel ’97-2003 (.xls) files, use Excel 8.0.
For Excel 2007-2010 (.xlsx) files, use Excel 12.0 Xml.
For Excel 2007-2010 macro-enabled (.xlsm) files, use Excel 12.0 Macro.
For Excel 2007-2010 non-XML binary (.xlsb) files, use Excel 12.0.


EXEC sp_configure 'Show Advanced Options', 1;
RECONFIGURE;
GO
 
EXEC sp_configure 'Ad Hoc Distributed Queries', 1;
RECONFIGURE;
GO


*/
set ANSI_NULLS ON;
go
set ANSI_WARNINGS ON;
go

select *
from openrowset('Microsoft.ACE.OLEDB.12.0',
	'Excel 12.0 Xml; HDR=YES;
		Database=c:\steve\BDTest2.xlsx;',
	[Sheet1$])
go
--
-- excel 97 workbook
--
select *
from openrowset('Microsoft.ACE.OLEDB.12.0',
	'Excel 8.0;
		Database=c:\steve\BPNov141105.xls;',
	[Sheet1$])
go