select  xdval.dimensionvalue_seq, ydval.dimensionvalue_seq, premium_amt
from prd_costtablevalue costvalue
	left join prd_dimensionvalue xdval
		on dimensionvalue_x_key = xdval.dimensionvalue_key
	left join prd_dimensionvalue ydval
		on dimensionvalue_y_key = ydval.dimensionvalue_key
where costtable_key = '{f1a1a359-d852-47db-8af3-c4efd01e29e6}'
group by ydval.dimensionvalue_seq, xdval.dimensionvalue_seq, premium_amt
/*
select * 
from prd_dimensionvalue
where dimensionvalue_key = '{BFFBDE0E-AEAF-48D0-BA9A-657E9B39FCB0}'

select CostTable_nm, 
(select distinct count(*)
from prd_costtablevalue
where costtable_key = '{f1a1a359-d852-47db-8af3-c4efd01e29e6}'
group by dimensionvalue_x_key) as X, 
(select distinct count(*)
from prd_costtablevalue
where costtable_key = '{f1a1a359-d852-47db-8af3-c4efd01e29e6}'
group by dimensionvalue_y_key) as Y
from prd_costtable
where costtable_key = '{f1a1a359-d852-47db-8af3-c4efd01e29e6}'
*/