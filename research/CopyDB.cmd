@rem (c)2014 Roland Hangg 
@rem Version 20140911
@echo off
if .%3.==.. goto help
goto start

:help
echo.
echo  €ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€
echo  €                                                                      € €
echo  € Parameter:                                                           € €
echo  €  Source-DB_Server[\Instance]                                         € €
echo  €  Target-DB_Server[\Instance]                                         € €
echo  €  Database                                                            € €
echo  €  [New Databasename]                                                  € €
echo  €  [datestamp^|offline]                                                 € €
echo  €                                                                      € €
echo  € Requirements:                                                        € €
echo  €  -^> User must have SYSADMIN role on source and target SQL-Server     € €
echo  €  -^> User must be member in local administrators group on both servers€ €
echo  €                                                                      € €
echo  € Note:                                                                € €
echo  €  datestamp adds a datestamp with the format dbname_YYYYMMDD to the   € €
echo  €  target database. "offline" sets the source db offline and don't     € €
echo  €  use backup/restore for the transfer. A second DB-name renames the   € €
echo  €  database in the target. Is there still a database in the target     € €
echo  €  it will be overwritten but the script asks for that first. Is an    € €
echo  €  existing target DB member of an Availibility group, remove it first.€ €
echo  €                                                                      € €
echo  €‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€ €
echo    ‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€
echo.
goto end

:start
echo.
echo  €ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€
echo  € Setting environmet variables...                                      € €
echo  €‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€ €
echo    ‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€
echo.

set SQLCommand=SQLCMD
set DB=%3
set SQLServerS=%1
set SQLServerT=%2

rem The log for all copies made with this script. Add here a path is recommended
set Logfile=~CopyDB.log

rem Tempfiles. Make sure you have write permissions at the location you call the script
set TempFile1=~cpydb1.tmp
set TempFile2=~cpydb2.tmp
set TempFile3=~autofix.sql
set TempFile4=~srvinfo.sql
set TempFile5=~copyfiles.cmd

rem Reading source and target information
if exist %TempFile4% del %TempFile4%
echo DECLARE @Instanzname nvarchar(512)     >>%TempFile4%
echo DECLARE @Servername nvarchar(512)      >>%TempFile4%
echo DECLARE @DefaultData nvarchar(512)     >>%TempFile4%
echo DECLARE @DefaultLog nvarchar(512)      >>%TempFile4%
echo DECLARE @BackupDirectory nvarchar(512) >>%TempFile4%
echo EXEC master.dbo.xp_instance_regread N'HKEY_LOCAL_MACHINE', N'Software\Microsoft\MSSQLServer\MSSQLServer', N'DefaultData', @DefaultData OUTPUT                 >>%TempFile4%
echo EXEC master.dbo.xp_instance_regread N'HKEY_LOCAL_MACHINE', N'Software\Microsoft\MSSQLServer\MSSQLServer', N'DefaultLog', @DefaultLog OUTPUT                   >>%TempFile4%
echo EXEC master.dbo.xp_instance_regread	N'HKEY_LOCAL_MACHINE', N'Software\Microsoft\MSSQLServer\MSSQLServer', N'BackupDirectory', @BackupDirectory OUTPUT  >>%TempFile4%
echo select @Instanzname=@@servername       >>%TempFile4%
echo if (charindex('\', @@servername, 1)=0) select @Servername=@@servername else set @Servername=SUBSTRING (@@servername ,1 , (charindex('\', @@servername, 1)-1)) >>%TempFile4%
echo print 'Server:      ' + @Servername                      >>%TempFile4%
echo print 'Instance:    ' + @Instanzname                     >>%TempFile4%
echo print 'Backup Path: ' + @BackupDirectory                 >>%TempFile4%
echo print 'Data Path:   ' + @DefaultData                     >>%TempFile4%
echo print 'Log Path:    ' + @DefaultLog                      >>%TempFile4%

if exist %TempFile2% del %TempFile2%
%SQLCommand% -E -S %SQLServerS% -i%TempFile4% -o%TempFile2%

findstr /C:"Server:      " %TempFile2% >%TempFile1%
for /F "tokens=*" %%i in (%TempFile1%) do @set ServerS=%%i
set ServerS=%ServerS:~13,127%

findstr /C:"Backup Path: " %TempFile2% >%TempFile1%
for /F "tokens=*" %%i in (%TempFile1%) do @set PathSBackup=%%i
set PathSBackup=%PathSBackup:~13,127%

findstr /C:"Data Path:   " %TempFile2% >%TempFile1%
for /F "tokens=*" %%i in (%TempFile1%) do @set PathSData=%%i
set PathSData=%PathSData:~13,127%

findstr /C:"Log Path:    " %TempFile2% >%TempFile1%
for /F "tokens=*" %%i in (%TempFile1%) do @set PathSLog=%%i
set PathSLog=%PathSLog:~13,127%

if exist %TempFile2% del %TempFile2%
%SQLCommand% -E -S %SQLServerT% -i%TempFile4% -o%TempFile2%

findstr /C:"Server:      " %TempFile2% >%TempFile1%
for /F "tokens=*" %%i in (%TempFile1%) do @set ServerT=%%i
set ServerT=%ServerT:~13,127%

findstr /C:"Backup Path: " %TempFile2% >%TempFile1%
for /F "tokens=*" %%i in (%TempFile1%) do @set PathTBackup=%%i
set PathTBackup=%PathTBackup:~13,127%

findstr /C:"Data Path:   " %TempFile2% >%TempFile1%
for /F "tokens=*" %%i in (%TempFile1%) do @set PathTData=%%i
set PathTData=%PathTData:~13,127%

findstr /C:"Log Path:    " %TempFile2% >%TempFile1%
for /F "tokens=*" %%i in (%TempFile1%) do @set PathTLog=%%i
set PathTLog=%PathTLog:~13,127%

rem Remove temporary files
if exist %TempFile1% del %TempFile1%
if exist %TempFile2% del %TempFile2%
if exist %TempFile4% del %TempFile4%
if exist %TempFile5% del %TempFile5%

rem summary server informations
echo.
echo  €ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo  €  Source-Instance:    %SQLServerS%
echo  €  Source-Server:      %ServerS%
echo  €  Source-Backup Path: %3
echo  €  Source-Data Path:   %PathSBackup%
echo  €  Source-Log Path:    %PathSData%
echo  €                      %PathSLog%
echo  €  Target-Instance:   
echo  €  Target-Server:      %SQLServerT%
echo  €  Target-Backup Path: %ServerT%
echo  €  Target-Data Path:   %PathTBackup%
echo  €  Target-Log Path:    %PathTData%
echo  €  Ziel-Log Pfad:      %PathTLog%
echo  €
echo  €  TransferDB:       %DB%
echo  €‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
rem Set the OS Version for datestamp
set OSVersion=2008
ver |findstr "5." >nul
if %ERRORLEVEL%==0 set OSVersion=2003

if .%PathSBackup%.==.. goto ErrorPath
if .%PathTBackup%.==.. goto ErrorPath
if .%PathSBackup:~0,1%.==.~. goto ErrorPath
if .%PathTBackup:~0,1%.==.~. goto ErrorPath

echo.
echo  €ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo  € Source path: %PathSBackup%
echo  € Target Path: %PathTBackup%
echo  € Log Path:    %PathTLog%
echo  €‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.

goto %OSVersion%

rem Get the timestamp
:2008
set Tag=%DATE:~7,2%
set Monat=%DATE:~4,2%
set Jahr=%DATE:~10,4%
goto SetTimeStamp

:2003
set Tag=%DATE:~0,2%
set Monat=%DATE:~3,2%
set Jahr=%DATE:~6,4%
goto SetTimeStamp

:SetTimeStamp
set TimeStamp=
if /I .%4.==.datestamp. set TimeStamp=_%Jahr%%Monat%%Tag%
if .%TimeStamp%.==.. goto CheckParameter
echo.
echo  €ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo  € Timestamp: %TimeStamp%
echo  €‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.

:CheckParameter
set TargetDBName=%DB%
if /I .%4.==.datestamp. set TargetDBName=%DB%%TimeStamp%
if /I .%5.==.offline. set TargetDBName=%4
if /I .%4.==.datestamp. goto CheckDBInTarget
if /I .%5.==.offline. goto CheckDBInTarget
if not .%4.==.. set TargetDBName=%4
if /I .%4.==.offline. set TargetDBName=%3

goto CheckDBInTarget

:CheckDBInTarget
set DBExists=False
if exist %TempFile1% del %TempFile1%
%SQLCommand% -E -S %SQLServerT% -d master -Q"sp_helpdb '%TargetDBName%'" -o%TempFile1%
findstr /I "The database '%TargetDBName%' does not exist" %TempFile1% >nul
if .%ERRORLEVEL%.==.1. goto DBStillExists
if exist %TempFile1% del %TempFile1%
goto NoDBInTarget

:DBStillExists
echo.
echo  €ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo  €
echo  € Attention! The database %DB% still exists on %SQLServerT%!
echo  € If you continue it will be overwritten without further backup!
echo  €
echo  € Abort by pressing CTRL+C, continue by pressing any key...
echo  €
echo  €‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
set DBExists=True
pause >nul

if .%DBExists%.==.True. %SQLCommand% -E -S %SQLServerT% -d master -Q"ALTER DATABASE [%TargetDBName%] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE"
if .%DBExists%.==.True. %SQLCommand% -E -S %SQLServerT% -d master -Q"DROP DATABASE [%TargetDBName%]"

goto NoDBInTarget

:NoDBInTarget
echo User:      %USERDOMAIN%\%USERNAME%     >>%Logfile%
echo Time:      %DATE% %TIME%               >>%Logfile%
echo Source:    %SQLServerS% %DB%           >>%Logfile%
echo Target:    %SQLServerT% %TargetDBName% >>%Logfile%
echo Parameter: %1 %2 %3 %4 %5 %6           >>%Logfile%
echo -------------------------------------- >>%Logfile%

if /I .%4.==.offline. goto CopyOffline
if /I .%5.==.offline. goto CopyOfflineWithRename

goto Losgehts

:CopyOfflineWithRename
set TargetDBName=%4
goto CopyOffline

rem Here starts the transfer with offline/filecopy/attach
:CopyOffline
rem Get the physical filenames
rem path with filename...
if exist %TempFile1% del %TempFile1%
if exist %TempFile2% del %TempFile2%
echo @echo off >%TempFile5%

set AttachCMD=
set CopyTargetPathData=\\%ServerT%\%PathTData:~0,1%$%PathTData:~2,255%
set CopyTargetPathLog=\\%ServerT%\%PathTLog:~0,1%$%PathTLog:~2,255%
set Counter=1
set FileCounterLog=1
set FileCounterData=1
%SQLCommand% -E -S %SQLServerS% -Q"select count(*), '##x##' from [%DB%]..sysfiles" -o%TempFile1%
findstr /I "##x##" %TempFile1% >%TempFile2%
for /F "tokens=1" %%i in (%TempFile2%) do @set MaxCount=%%i

:GetFileInfos
%SQLCommand% -E -S %SQLServerS% -Q"select filename, '##x##' from [%DB%]..sysfiles where fileid=%Counter%" -o%TempFile1%
findstr /I "##x##" %TempFile1% >%TempFile2%
for /F "tokens=1" %%i in (%TempFile2%) do @set FileNameQ=%%i
set FileNameQ=\\%ServerS%\%FileNameQ:~0,1%$%FileNameQ:~2,255%

%SQLCommand% -E -S %SQLServerS% -Q"select groupid, '##x##' from [%DB%]..sysfiles where fileid=%Counter%" -o%TempFile1%
findstr /I "##x##" %TempFile1% >%TempFile2%
for /F "tokens=1" %%i in (%TempFile2%) do @set GroupID=%%i
if .%GroupID%.==.0. goto LogFile
goto DataFile

:LogFile
set FileExt=ldf
set FileNoExt=%FileCounterLog%
if %FileNoExt% LSS 10 set FileNoExt=0%FileNoExt%
if %MaxCount% EQU 2 set FileNoExt=

echo copy "%FileNameQ%" "%CopyTargetPathLog%\%TargetDBName%_Log%FileNoExt%.%FileExt%" /Y >>%TempFile5%
set AttachCMD=%AttachCMD%( FILENAME = N'%PathTLog%\%TargetDBName%_Log%FileNoExt%.%FileExt%' )
set /a FileCounterLog=%FileCounterLog% + 1

goto NextFile

:DataFile
set FileExt=ndf
set FileNoExt=%FileCounterData%
if %FileNoExt% LSS 10 set FileNoExt=0%FileNoExt%
if %MaxCount% EQU 2 set FileNoExt=

%SQLCommand% -E -S %SQLServerS% -Q"select fileid, '##x##' from [%DB%]..sysfiles where fileid=%Counter%" -o%TempFile1%
findstr /I "##x##" %TempFile1% >%TempFile2%
for /F "tokens=1" %%i in (%TempFile2%) do @set FileID=%%i
if .%FileID%.==.1. set FileExt=mdf

echo copy "%FileNameQ%" "%CopyTargetPathData%\%TargetDBName%_Data%FileNoExt%.%FileExt%" /Y >>%TempFile5%
set AttachCMD=%AttachCMD%( FILENAME = N'%PathTData%\%TargetDBName%_Data%FileNoExt%.%FileExt%' )
set /a FileCounterData=%FileCounterData% + 1

goto NextFile

:NextFile
if %Counter% EQU %MaxCount% goto GotAllFiles
set AttachCMD=%AttachCMD%,
set /a Counter=%Counter% + 1
goto GetFileInfos

:GotAllFiles

if exist %TempFile1% del %TempFile1%
if exist %TempFile2% del %TempFile2%

rem kill all connections
echo DECLARE @dbspid as int                               >%TempFile1%
echo DECLARE @dbname as varchar(50)                      >>%TempFile1%
echo DECLARE @killcommand as varchar(50)                 >>%TempFile1%
echo SET @dbname = '%DB%'                                >>%TempFile1%
echo DECLARE ConnectionKiller CURSOR FOR                 >>%TempFile1%
echo SELECT sysproc.spid FROM sysprocesses AS sysproc    >>%TempFile1%
echo INNER JOIN sysdatabases AS sysdb ON                 >>%TempFile1%
echo     sysdb.dbid = sysproc.dbid                       >>%TempFile1%
echo WHERE sysdb.NAME IN (@dbname) UNION                 >>%TempFile1%
echo SELECT sysproc.blocked FROM sysprocesses AS sysproc >>%TempFile1%
echo INNER JOIN sysdatabases AS sysdb ON                 >>%TempFile1%
echo     sysdb.dbid = sysproc.dbid                       >>%TempFile1%
echo WHERE sysdb.NAME IN (@dbname)                       >>%TempFile1%
echo AND sysproc.blocked^<^>0                            >>%TempFile1%
echo OPEN ConnectionKiller                               >>%TempFile1%
echo FETCH NEXT FROM ConnectionKiller INTO @dbspid       >>%TempFile1%
echo  WHILE @@FETCH_STATUS = 0                           >>%TempFile1%
echo  BEGIN                                              >>%TempFile1%
echo   SET @killcommand = 'KILL '+CAST(@dbspid AS VARCHAR(50)) >>%TempFile1%
echo   EXEC (@killcommand)                               >>%TempFile1%
echo   FETCH NEXT FROM ConnectionKiller INTO @dbspid     >>%TempFile1%
echo  END                                                >>%TempFile1%
echo CLOSE ConnectionKiller                              >>%TempFile1%
echo DEALLOCATE ConnectionKiller                         >>%TempFile1%
%SQLCommand% -E -S %SQLServerS% -d master -i"%TempFile1%"

if exist %TempFile1% del %TempFile1%
rem set DB offline
%SQLCommand% -E -S %SQLServerS% -d master -Q"alter database [%DB%] set offline with rollback immediate"

echo.
echo  €ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo  € Source:
echo  € %CopyDataS%
echo  € %CopyLogS%
echo  € Target:
echo  € %CopyTargetPathData%
echo  € %CopyTargetPathLog%
echo  €‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.

echo.
echo  €ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo  € Copy...
call %TempFile5%
echo  € Attach Database...
%SQLCommand% -E -S %SQLServerT% -d master -Q"CREATE DATABASE [%TargetDBName%] ON %AttachCMD% FOR ATTACH"
echo  €‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
rem cleanup
if exist %TempFile1% del %TempFile1%
if exist %TempFile2% del %TempFile2%
if exist %TempFile5% del %TempFile5%

goto CompatibilityLevel

:Losgehts
rem Here starts the transfer with backup/restore
rem First create a backup
echo.
echo  €ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo  € Backup-path source: %SQLServerS%: %PathSBackup% %DB%
echo  € Backup-path target:   %SQLServerT%: %PathTBackup% %TargetDBName%
echo  € Backup the DB...
%SQLCommand% -E -S %SQLServerS% -Q"BACKUP DATABASE [%DB%] TO  DISK = N'%PathSBackup%\%DB%%TimeStamp%.bak' WITH COPY_ONLY, NOFORMAT, INIT, NAME = N'%DB%-Full Backup', SKIP, NOUNLOAD,  STATS = 10"
echo  €
echo  € move the backup...
set CopyPathS=\\%ServerS%\%PathSBackup:~0,1%$%PathSBackup:~2,255%
set CopyPathT=\\%ServerT%\%PathTBackup:~0,1%$%PathTBackup:~2,255%
echo  € Source-Path: %CopyPathS%
echo  € Target-Path:  %CopyPathT%
echo  €
echo  € copy...
rem Copy the backup file
if .%CopyPathS%.==.%CopyPathT%. goto RestoreDB
copy %CopyPathS%\%DB%%TimeStamp%.bak %CopyPathT% /Y >nul
if not exist %CopyPathT%\%DB%%TimeStamp%.bak goto Copyfehler
if exist %CopyPathS%\%DB%%TimeStamp%.bak goto RemoveSourceFile

:RemoveSourceFile
rem Remove the sourcefile to save space
if .%SQLServerS%.==.%SQLServerT%. goto RestoreDB
del %CopyPathS%\%DB%%TimeStamp%.bak
goto RestoreDB

echo  € move of the backup file finished.
echo  €‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.

:RestoreDB
rem Determine the logical filenames
set CMDDataDevices=
set CMDLogDevices=
set Counter=1
set FileCounterLog=1
set FileCounterData=1
%SQLCommand% -E -S %SQLServerS% -Q"select count(*), '##x##' from [%DB%]..sysfiles" -o%TempFile1%
findstr /I "##x##" %TempFile1% >%TempFile2%
for /F "tokens=1" %%i in (%TempFile2%) do @set MaxCount=%%i

:GetDeviceInfos
%SQLCommand% -E -S %SQLServerS% -Q"select name, '##x##' from [%DB%]..sysfiles where fileid=%Counter%" -o%TempFile1%
findstr /I "##x##" %TempFile1% >%TempFile2%
for /F "tokens=1" %%i in (%TempFile2%) do @set LogicalName=%%i

%SQLCommand% -E -S %SQLServerS% -Q"select groupid, '##x##' from [%DB%]..sysfiles where fileid=%Counter%" -o%TempFile1%
findstr /I "##x##" %TempFile1% >%TempFile2%
for /F "tokens=1" %%i in (%TempFile2%) do @set GroupID=%%i
if .%GroupID%.==.0. goto LogDevice
goto DataDevice

:LogDevice
set FileExt=ldf
set FileNoExt=%FileCounterLog%
if %FileNoExt% LSS 10 set FileNoExt=0%FileNoExt%
if %MaxCount% EQU 2 set FileNoExt=

set CMDLogDevices=%CMDLogDevices%MOVE N'%LogicalName%' TO N'%PathTData%\%TargetDBName%_Log%FileNoExt%.%FileExt%',
set /a FileCounterLog=%FileCounterLog% + 1

goto NextDevice

:DataDevice
set FileExt=ndf
set FileNoExt=%FileCounterData%
if %FileNoExt% LSS 10 set FileNoExt=0%FileNoExt%
if %MaxCount% EQU 2 set FileNoExt=

%SQLCommand% -E -S %SQLServerS% -Q"select fileid, '##x##' from [%DB%]..sysfiles where fileid=%Counter%" -o%TempFile1%
findstr /I "##x##" %TempFile1% >%TempFile2%
for /F "tokens=1" %%i in (%TempFile2%) do @set FileID=%%i
if .%FileID%.==.1. set FileExt=mdf

set CMDDataDevices=%CMDDataDevices%MOVE N'%LogicalName%' TO N'%PathTData%\%TargetDBName%_data%FileNoExt%.%FileExt%',
set /a FileCounterData=%FileCounterData% + 1

goto NextDevice

:NextDevice
if %Counter% EQU %MaxCount% goto GotAllDevices
set /a Counter=%Counter% + 1
goto GetDeviceInfos
:GotAllDevices

if exist %TempFile1% del %TempFile1%
if exist %TempFile2% del %TempFile2%

echo.
echo  €ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo  €
echo  € Restore the database to %SQLServerT%.[%TargetDBName%]...
%SQLCommand% -E -S %SQLServerT% -Q"RESTORE DATABASE [%TargetDBName%] FROM  DISK = N'%PathTBackup%\%DB%%TimeStamp%.bak' WITH  FILE = 1,  %CMDDataDevices% %CMDLogDevices%  NOUNLOAD,  REPLACE,  STATS = 10"
echo  €
echo  €‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.

:RemoveTargetFile
rem clean up
if exist %CopyPathT%\%DB%%TimeStamp%.bak del %CopyPathT%\%DB%%TimeStamp%.bak

:CompatibilityLevel
echo.
echo  €ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo  €
echo  € Set new compatibility level if necessary...

%SQLCommand% -E -S %SQLServerT% -Q"DECLARE @CompLevel varchar(4);DECLARE @SQL varchar (128);SELECT @CompLevel=compatibility_level FROM sys.databases WHERE name = 'master';select @SQL='ALTER DATABASE [%TargetDBName%] SET COMPATIBILITY_LEVEL = ' + @CompLevel + ';';exec (@SQL);"

rem Set Pageverify: Checksum (recommended by M$)
echo  € Suggested property: pageverify: checksum...
%SQLCommand% -E -S %SQLServerT% -Q"ALTER DATABASE [%TargetDBName%] set PAGE_VERIFY CHECKSUM with NO_WAIT"

rem Fix the orphant users
echo  € Orphand users...
echo DECLARE @SQLString VARCHAR(6300)             >%TempFile3%
echo SELECT    @SQLString = ''                    >>%TempFile3%
echo SELECT    @SQLString = @SQLString + 'EXEC [dbo].[sp_Change_Users_Login] ''Update_One'','''+[Name]+''','''+[Name]+''' ' >>%TempFile3%
echo FROM      [dbo].[SysUsers]                   >>%TempFile3%
echo WHERE     [IsSqlUser] = 1                    >>%TempFile3%
echo AND       (SId IS NOT NULL AND SId ^<^> 0x0) >>%TempFile3%
echo AND       SUSER_SNAME(SId) IS NULL           >>%TempFile3%
echo IF LEN(LTRIM(RTRIM(@SQLString))) ^<^> 0      >>%TempFile3%
echo BEGIN                                        >>%TempFile3%
echo     PRINT(@SQLString)                        >>%TempFile3%
echo     EXEC(@SQLString)                         >>%TempFile3%
echo END                                          >>%TempFile3%
%SQLCommand% -E -S  %SQLServerT% -d %TargetDBName% -i"%TempFile3%"
echo  €
echo  €‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
rem do some clean up stuff
if exist %CopyPathT%\%DB%%TimeStamp%.bak del %CopyPathT%\%DB%%TimeStamp%.bak
if exist %TempFile1% del %TempFile1%
if exist %TempFile2% del %TempFile2%
if exist %TempFile3% del %TempFile3%
if exist %TempFile4% del %TempFile4%
if exist %TempFile5% del %TempFile5%
goto end

rem Errorhandling
:Copyfehler
echo.
echo  €ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€
echo  €                                                                      € €
echo  € Error while copiing the backups!!                                    € €
echo  €                                                                      € €
echo  €‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€ €
echo    ‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€
echo.
goto end

:ErrorPath
echo.
echo  €ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€
echo  €                                                                      € €
echo  € Error getting the pathes!!!                                          € €
echo  €                                                                      € €
echo  €‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€ €
echo    ‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€
echo.
goto end

:end
echo  €ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€
echo  € End of batch. Thanks for using rolX CopyDB ;-)                       € €
echo  €‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€ €
echo    ‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€
