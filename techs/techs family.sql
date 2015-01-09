select tech.techid, tech.subscriberid, tech.marketid, tech.FirstName, tech.LastName
from edg_tbl_technicians as tech
where 
tech.subscriberid in (select Childshopid
	from 
	edg_tbl_Parentshoprelations
	where
	parentshopid = 3418)