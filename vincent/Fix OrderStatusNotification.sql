-- 
-- check to see if the user has any rows with blank order numbers
-- this will cause an error in the code and not return any thing
-- to the web
--
-- get the user's contact id
--
SELECT *
  FROM [VPI_Online].[dbo].[Contacts]
  WHERE lastname in ('lowney') order by firstName
--
-- identify the blank ordernumber rows
--
SELECT *
  FROM OrderStatusNotification 
  where contactId = 1412 and dateAdded > '2016-07-01' order by orderNumber desc
--
-- to correct this error remove the rows by setting the dateAdded to 1900-01-01
--
update OrderStatusNotification 
set dateAdded = '1900-01-01'
where orderStatusNotificationId in (128093, 128095)