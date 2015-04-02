--
-- create the tables to show the cross join demo
--
CREATE TABLE train.Product (ID int, 
                      ProductName varchar(100),
                      Cost money);
CREATE TABLE train.SalesItem (ID int, 
                        SalesDate datetime, 
                        ProductID int, 
                        Qty int, 
                        TotalSalesAmt money);
INSERT INTO train.Product 
	VALUES (1,'Widget',21.99),
	       (2,'Thingamajig',5.38), 
		   (3,'Watchamacallit',1.96);
INSERT INTO train.SalesItem
	VALUES (1,'2014-10-1',1,1,21.99),
	       (2,'2014-10-2',3,1,1.96),
	       (3,'2014-10-3',3,10,19.60),
	       (4,'2014-10-3',1,2,43.98),
	       (5,'2014-10-3',1,2,43.98); 