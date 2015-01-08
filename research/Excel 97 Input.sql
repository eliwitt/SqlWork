select *
from openrowset('Microsoft.ACE.OLEDB.12.0',
	'Excel 8.0;
		Database=c:\steve\BPNov141105.xls;',
	[Sheet1$])