-- collect all of the shops WOs
declare @emailtable nvarchar(max), @TableHead varchar(max)
DECLARE @theTable TABLE
(
	theRow [int] IDENTITY(1,1) NOT NULL,
	theVWNu  nvarchar(max),
	theDescr nvarchar(max),
	theMFG nvarchar(max)

);
insert into @theTable
Select top(100) SP2VWNumber,
            SP2ShortSAPDescr,
            SP2MFGGuess
      From sp.SPMaster2
      Order By SP2ID
--select * from @theTable

Set @TableHead =
N'    <h1>Spare Parts</h1><table><tr style="background-color: #5D7B9D; font-weight: bold; color: white;">' +
N'    <th>VW Number</th><th>Description</th><th>MFG</th></tr>' 

Select @emailtable = (Select Row_Number() Over(Order By theRow) % 2 As [TRRow],
            theVWNu As [TD],
            theDescr As [TD],
            theMFG As [TD]
      From @theTable
      Order By theRow
      For XML raw('tr'), Elements)

-- Replace the entity codes and row numbers
--Set @Body = Replace(@Body, '_x0020_', space(1))
--Set @Body = Replace(@Body, '_x003D_', '=')
Set @emailtable = Replace(@emailtable, '<tr><TRRow>1</TRRow>', '<tr bgcolor=#C6CFFF>')
Set @emailtable = Replace(@emailtable, '<TRRow>0</TRRow>', '')
Select @emailtable = @TableHead + @emailtable + '</table>'

select @emailtable

EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'chasqlsvr',
    @recipients = 'extern.Steven.Witt@vw.com',
    @body = @emailtable, @body_format = 'HTML',
    @subject = 'Automated Success Message' ;