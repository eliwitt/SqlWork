--select * from employees where reportsto is not null
--select * from territories
select orders.orderid, firstname + lastname employee, companyname, orderdate, requireddate, productname, 
	ordet.unitprice, quantity, ordet.unitprice * quantity, discount, 
	(ordet.unitprice * quantity - (((ordet.unitprice * quantity)* discount)))
from orders
	join [order details] ordet on orders.orderid = ordet.orderid
	join products on ordet.productid = products.productid
	join customers on orders.customerid = customers.customerid
	join employees on orders.employeeid = employees.employeeid
order by orderdate
--
-- total the detail rows in one result set and the totals in another
-- don't like it
--
select firstname + lastname employee, companyname, orderdate, requireddate, 
	totorder.productname, totorder.unitprice, totorder.quantity, 
	totprice, discount,	netprice
from orders
	join (
		select distinct orderid, productname, 
			ordet.unitprice, quantity, ordet.unitprice * quantity as totprice, discount, 
			(ordet.unitprice * quantity - (((ordet.unitprice * quantity)* discount))) as netprice
		from [order details] ordet
			join products on ordet.productid = products.productid
	) totorder on orders.orderid = totorder.orderid
	join customers on orders.customerid = customers.customerid
	join employees on orders.employeeid = employees.employeeid
order by orders.orderid, orderdate
compute sum(totprice),  sum(netprice) by orders.orderid
--
-- now lets try to create a results set with totals
--
select orders.orderid, '0' rowsid, firstname + ' ' + lastname employee, companyname, orderdate, 
	requireddate, productname, ordet.unitprice, quantity, 
	ordet.unitprice * quantity [Total Gross Price], discount, 
	(ordet.unitprice * quantity - (((ordet.unitprice * quantity)* discount))) [Total Net Price]
from orders
	join [order details] ordet on orders.orderid = ordet.orderid
	join products on ordet.productid = products.productid
	join customers on orders.customerid = customers.customerid
	join employees on orders.employeeid = employees.employeeid
union
select orders.orderid, '1' rowsid, ' ', companyname, orderdate, 
	requireddate, ' ', 0, totpices, totprice, 0, totorder
from orders
	join (
		select orders.orderid, sum(quantity) totpices,
			sum(ordet.unitprice * quantity) totprice, 
			sum((ordet.unitprice * quantity - (((ordet.unitprice * quantity)* discount)))) totorder
		from orders
			join [order details] ordet on orders.orderid = ordet.orderid
		group by orders.orderid, orderdate, requireddate
	) ordet on orders.orderid = ordet.orderid
	join customers on orders.customerid = customers.customerid
	join employees on orders.employeeid = employees.employeeid
order by orders.orderid, orderdate, rowsid