select sub.Subscriberid,
sub.company, sub.scheduletype,
sub.glassshopparentid
from 
edg_tbl_subscribers sub
inner join edg_tbl_parentshoprelations family on 
	sub.subscriberid = family.childshopid
where 
family.parentshopid = 3402

