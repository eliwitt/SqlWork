-- collect all of the shops WOs
declare @emailtable nvarchar(max)

set @emailtable =
N'    <h1>Spare Parts</h1><table><tr style="background-color: #5D7B9D; font-weight: bold; color: white;">' +
N'    <th>VW Number</th><th>Description</th><th>MFG</th></tr>' +
cast (( SELECT top(100) td = SP2VWNumber, '', td = SP2ShortDescr, '', td = SP2MFGGuess
FROM  sp.SPMaster2 for xml path('tr'), type) as nvarchar(max)) +
N'</table>';

EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'chasqlsvr',
    @recipients = 'extern.Steven.Witt@vw.com',
    @body = @emailtable, @body_format = 'HTML',
    @subject = 'Automated Success Message' ;