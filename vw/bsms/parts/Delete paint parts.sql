select SUBSTRING(sp2vwnumber,1,1), * from sp.SPMaster2 where SUBSTRING(sp2vwnumber,1,1) <> 'Z'
--delete sp.SPMaster2 where sp2id in (37018,37019,37020,37021,37022,37023,37024,37025,3702
select * from sp.SPMaster2
select * from wACom.VendorList where VLID = 10867