/****** Script for SelectTopNRows command from SSMS  ******/
 --insert into clm_appraiserDailyMax values (1, 1)
 --insert into clm_appraiserDailyMax values (2, 1)
 --select * from sys.sysobjects where type = 'tr'
select object_name(o.parent_obj) [table], o.name [trigger]
from sys.sql_modules m 
join sys.sysobjects o on m.object_id=o.id
join sys.schemas s on s.schema_id = o.uid
where o.type='tr'


 select * from CLM_AppraiserDailyMax
 select app.id, biz.businessname biznam, dbo.F_Appraiser_OverLimit(app.id)
 from clm_appriaser app
      join clm_businessentity biz on app.businessentityptr = biz.id 
 where app.id = 2 and dbo.F_Appraiser_OverLimit(app.id) = 0
 select * from CLM_AppraisalRequestLog where AppraiserPTR = 2
 --insert into CLM_AppraisalRequestLog values (2,1,'04-20-2011')
 --exec sp_personreserve 3182, 14311, 2