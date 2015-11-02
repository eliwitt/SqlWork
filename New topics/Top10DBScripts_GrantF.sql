--
--  sp_who2/ sys.dm_exec_requests/ sp_whoisactive
--
--  the following sql is much like sp_who2
--
SELECT  *
FROM    sys.dm_exec_requests AS der
        CROSS APPLY sys.dm_exec_sql_text(der.sql_handle) AS dest
        CROSS APPLY sys.dm_exec_query_plan(der.plan_handle) AS deqp;
GO
--
--  the following is an example of what you can do with the info from 
--  these tables.
--
SELECT  SUBSTRING(dest.text, ( der.statement_start_offset / 2 ) + 1,
                  ( CASE der.statement_end_offset
                      WHEN -1 THEN DATALENGTH(dest.text)
                      ELSE der.statement_end_offset
                           - der.statement_start_offset
                    END ) / 2 + 1) AS querystatement ,
        deqp.query_plan ,
        der.session_id ,
        der.start_time ,
        der.status ,
        DB_NAME(der.database_id) AS DBName ,
        USER_NAME(der.user_id) AS UserName ,
        der.blocking_session_id ,
        der.wait_type ,
        der.wait_time ,
        der.wait_resource ,
        der.last_wait_type ,
        der.cpu_time ,
        der.total_elapsed_time ,
        der.reads ,
        der.writes
FROM    sys.dm_exec_requests AS der
        CROSS APPLY sys.dm_exec_sql_text(der.sql_handle) AS dest
        CROSS APPLY sys.dm_exec_query_plan(der.plan_handle) AS deqp;
GO
--
--  by setting the statistics on you can get 
--  more info about the sql you are running
--
SET STATISTICS IO ON;
SET STATISTICS TIME ON;
...
SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;
GO
--
-- backup a database
--
BACKUP DATABASE AdventureWorks2014 
TO DISK = 'D:\bu\adw.bak' 
WITH COPY_ONLY;
GO
--
-- get info on an object
--
sp_help 'Sales.SalesOrderHeader';
GO
--
-- log info on the databases
--
DBCC SQLPERF (LOGSPACE);
GO
--  reset the statistics on Latches and Waits
--
DBCC SQLPERF("sys.dm_os_latch_stats" , CLEAR);
DBCC SQLPERF("sys.dm_os_wait_stats" , CLEAR);
GO
--
-- gather info on queries
--
--  also look to sys.dm_exec_procedure_stats
--
SELECT  SUBSTRING(dest.text, ( deqs.statement_start_offset / 2 ) + 1,
                  ( CASE deqs.statement_end_offset
                      WHEN -1 THEN DATALENGTH(dest.text)
                      ELSE deqs.statement_end_offset
                           - deqs.statement_start_offset
                    END ) / 2 + 1) AS querystatement ,
        deqp.query_plan ,
        deqs.execution_count ,
        deqs.total_worker_time ,
        deqs.total_logical_reads ,
        deqs.total_elapsed_time
FROM    sys.dm_exec_query_stats AS deqs
        CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest
        CROSS APPLY sys.dm_exec_query_plan(deqs.plan_handle) AS deqp;
GO
--
-- create a new database from a backup
--
RESTORE DATABASE ADW
FROM DISK = 'D:\bu\adw.bak'
WITH MOVE 'AdventureWorks2014_Data' TO 'E:\data\adwnew.mdb',
MOVE 'AdventureWorks2014_Log' TO 'F:\log\adwnewlog.ldb',
NORECOVERY;
GO
-- validate the creation in a seprate step
--
RESTORE DATABASE ADW 
WITH RECOVERY;
GO
-- list info about the files in the backup file
--
RESTORE FILELISTONLY 
FROM DISK = 'c:\bu\adw.bak';
GO
--
-- how much space is the database taking up
--
EXEC sys.sp_spaceused;
GO
-- for an object
EXEC sys.sp_spaceused @objname = N'Sales.SalesOrderHeader';
GO
-- @updateusage helps with accurate size and space info
EXEC sys.sp_spaceused @objname = N'Sales.SalesOrderHeader',
    @updateusage = 'true';
GO
--
-- gather statistics info on an object
--
DBCC SHOW_STATISTICS('Sales.SalesOrderHeader','PK_SalesOrderHeader_SalesOrderID');
GO