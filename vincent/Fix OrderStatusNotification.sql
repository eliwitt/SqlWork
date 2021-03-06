-- 
-- check to see if the user has any rows with blank order numbers
-- this will cause an error in the code and not return any thing
-- to the web
--
-- get the user's contact id
--
SELECT *
  FROM Contacts
  WHERE lastname in ('tadros') order by firstName
--
-- identify the blank ordernumber rows
--
SELECT *
  FROM OrderStatusNotification 
  where contactId = 2111 and dateAdded > '2017-01-01' order by orderNumber desc
--
-- to correct this error remove the rows by setting the dateAdded to 1900-01-01
--
update OrderStatusNotification 
set dateAdded = '1900-01-01'
where orderStatusNotificationId in (135659, 135661)

--
-- global update
--
SELECT count(*)
  FROM OrderStatusNotification 
  where ordernumber = '' and dateAdded <> '1900-01-01' order by dateAdded

update OrderStatusNotification 
set dateAdded = '1900-01-01'
where ordernumber = '' and dateAdded <> '1900-01-01'