This zip archive contains example data for the second edition of 
the SQL Pocket Guide. You should find the following files:

read_me.txt (which you are reading now)
oracle_sample_data.sql
db2_sample_data.sql
sqlserver_sample_data.sql
mysql_sample_data.sql
postgre_sample_data.sql

The following sections briefly describe how to load the example data into the 
various database platforms covered by this book. If you are unfamiliar with
any of the procedures described below, don't be afraid to ask your database
administrator for help.

================================
Loading Example Data Into Oracle
================================
Following are the steps for creating and loading the example data under Oracle.

1. Be sure that you are running Oracle9i Database or higher.
2. Create a user to own the tables. Grant the user the following
   priviliges: CREATE SESSION, CREATE TABLE, CREATE VIEW.
3. Log in as the user created in step 2.
4. Use the @ command to execute the oracle_sample_data.sql script. 
   For example:

      sqlplus username/password[@your_database]

      SQL> @oracle_sample_data
      SQL> set define off
      SQL> spool oracle_sample_data
      SQL>
      SQL> prompt Dropping example tables...
      Dropping example tables...
      SQL> drop table upfall;
      ...

The script first drops the tables, and then recreates them. You will see errors
on the drop commands the first time that you run the script, because the tables
will not yet exist in your schema. Output will be spooled to oracle_sample_data.lst.



=============================
Loading Example Data Into DB2
=============================

1. Start up DB2's control center.

2. Right-click on your database in the tree-view, and choose "Query"
from the context-menu to open up a Command Editor.

3. Copy and paste the contents of db2_sample_data.sql into the Command pane. 

4. Press ctrl-R to clear the results pane. 

5. Either press ctrl-ENTER or click the green "Execute" arrow to begin running tthe script.



====================================
Loading Example Data Into SQL Server
====================================

1. Start Microsoft SQL Server Management Studio Express

2. Click the New Query toolbar button to open a new query window.

3. Copy an paste the contents of msss_sample_data.sql into the command pane.

4. Click the Execute button to execute the script.

5. Find the comment out lines to create the small_township view. Copy those lines. Clear the command pane. Paste those lines back in, uncommented. Press Execute again.



===============================
Loading Example Data Into MySQL
===============================
Follow the steps below to create the example tables in MySQL:

1. You must have MySQL installed on your system. 

2. You must have access to a MySQL user with the necessary priviliges
   to create a database. My example below uses the MySQL root user.

3. Execute the mysql_sample_data.sql script as follows:

   mysql -u root -pxxx < mysql_sample_data.sql 

   Replace the xxx in the above command with your root password. Note that 
   you do not need to use the root user. I use it here only by way of example.

The script first drops a database named sqlpocket. It then (re)creates that 
database, creates the tables referenced in the book, and populates those
tables with data.



====================================
Loading Example Data Into PostgreSQL
====================================
To create the example data in a PostgreSQL database, run the table
creation script using a command such as:

psql sqlpocket -f postgres_sample_data.sql -a > postgres_sample_data.lst 2>&1

This command assumes a database name of sqlpocket. If your database has 
a different name, then replace "sqlpocket" in the command with the name
your database goes by. 
