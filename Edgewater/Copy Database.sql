-- Copy a database on the same server
-- Create a logical backup device for the full AdminAble backup.
USE master
EXEC sp_addumpdevice 'disk', 'AATest', 
   'c:\AdminAble\AdminAbleTest.dat'

-- Back up the full AdminAble database.
BACKUP DATABASE AdminAble_23B_test TO AATest

--  you can move the file anywhere you want
--  you will need the data and log file names from the backup
RESTORE FILELISTONLY 
FROM disk='C:\Project\AdminAble\data\AdminAbleTest.dat'

-- Create the new database from the back file.  Here is where you need the data and log
-- file names.
RESTORE DATABASE AdminAble_Eval 
   FROM DISK = 'C:\Project\AdminAble\data\AATest.dat'
   WITH MOVE 'AdminAble_14_Clean_BCBST_Data' TO 'C:\Project\AdminAble\data\AdminAble_Eval_Data.mdf',
   MOVE 'AdminAble_14_Clean_BCBST_Log' TO 'C:\Project\AdminAble\data\AdminAble_Eval_log.ldf'
