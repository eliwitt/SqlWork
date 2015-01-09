--select * from clm_claimlog where datestamp > '2010-11-22 20:00:00' order by datestamp
--select * from clm_claimlog where datestamp > '2010-11-23 11:59:00' order by claimid, datestamp
--select * from clm_claimlog where claimid in (1990, 1991, 1989) order by datestamp
--select * from clm_personbackup where datestamp > '2010-11-22 20:00:00'
select * from clm_claimlog order by datestamp
select top 100 b.id, b.personptr, b.firstname, b.lastname, p.id, p.firstname, p.lastname, b.action, b.datestamp 
from clm_personbackup b join clm_person p on p.id = b.personptr order by b.id desc