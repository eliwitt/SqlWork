-- collect all of the shops WOs
Declare @Body varchar(max),
      @TableHead varchar(max),
      @TableTail varchar(max)

Set NoCount On;
Set @TableTail = '</table>';
--Set @TableHead = '<html><head>' +
--                  '<style>' +
--                  'td {border: solid black 1px;padding-left:5px;padding-right:5px;padding-top:1px;padding-bottom:1px;font-size:11pt;} ' +
--                  '</style>' +
--                  '</head>' +
--                  '<body><table cellpadding=0 cellspacing=0 border=0>' +
--                  '<tr bgcolor=#FFEFD8><td align=center><b>VW Number</b></td>' + 
--                  '<td align=center><b>Description</b></td>' + 
--                  '<td align=center><b>MFG</b></td></tr>';
Set @TableHead = '<table cellpadding=0 cellspacing=0 border=0>' +
                  '<tr bgcolor=#FFEFD8><td align=center><b>VW Number</b></td>' + 
                  '<td align=center><b>Description</b></td>' + 
                  '<td align=center><b>MFG</b></td></tr>';

Select @Body = (Select Row_Number() Over(Order By sp2vwnumber) % 2 As [TRRow],
            SP2VWNumber As [TD],
            SP2ShortSAPDescr As [TD],
            SP2MFGGuess As [TD]
      From sp.SPMaster2
      Order By SP2ID
      For XML raw('tr'), Elements)
--select @Body
-- Replace the entity codes and row numbers
--Set @Body = Replace(@Body, '_x0020_', space(1))
--Set @Body = Replace(@Body, '_x003D_', '=')
Set @Body = Replace(@Body, '<tr><TRRow>1</TRRow>', '<tr bgcolor=#C6CFFF>')
Set @Body = Replace(@Body, '<TRRow>0</TRRow>', '')
--select * from sp.SPMaster2

Select @Body = @TableHead + @Body + @TableTail

-- return output
--Select @Body

EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'chasqlsvr',
    @recipients = 'extern.Steven.Witt@vw.com',
    @body = @Body, @body_format = 'HTML',
    @subject = 'Automated Success Message' ;