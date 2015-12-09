CREATE PROCEDURE vt2662ap.ShippingReport
     (IN ShipDate DECIMAL(8,0))

DYNAMIC RESULT SETS 1 
      LANGUAGE SQL 
BEGIN
declare Ship cursor for
with FedOrders (customer, ordernu, linenu, picklst, tracknu, estddt, qty, desc, design) as
(
	select olcuno, thorno, olline, thplno, thcstrcn, thz3eddt, oloqty, oldesc, olshpm
		from (select  thorno, thplno, thcstrcn, thz3eddt from vt2662afvp.z3optrd feddtl
			 left join vt2662afvp.z3optrh fedhdr on evcstrcn = thcstrcn
			where evz3pstc = 'PU' and evz3evdt = ShipDate)
		left join VT2662AFvp.SRoorspl on thorno = olorno and thplno = olplno
)
select customer, ordernu, linenu, picklst, tracknu, estddt, qty, desc, ohcope as advertiser, design, oaname, oaadr1, oaadr2, oaadr3, oaadr4, oapocd from FedOrders
	left join vt2662afvp.sroorsa on ordernu = oaorno and linenu = oaline
	left join vt2662afvp.sroorshe on ordernu = ohorno
where (oaname like 'CCO%') or (oaname like 'Clear%') or (oaname like 'clear%')
 order by customer, ordernu, linenu, picklst;
open Ship;
 return;
END