-- get the ware house information
--
select custware, custdepot, profid from belron_clients, edg_tbl_subscribers
where clientid = vcustid and subscriberid = 3404

-- get the prodid
select prodid, prodref, ware, qty from belron_invqty where prodref = 'AS1S36X48'

-- get the price
select * from belron_pricing where prodref like '%AS1S36X48' and price_pro = 198

exec edg_sp_QtyLookup 'AS1S36X48',1001,'6201','6218',198