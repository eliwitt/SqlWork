declare @debug int
set @debug = 1
--
-- drop the table that will hold the new GC rows
--
if object_id(N'theDevGCsite', N'U') is not null
	drop table theDevGCsite
--
-- creates the theDevGCsite table from the maximo table
--
select replace(bslvalue, ':FGDC', ':GC') as [BSLVALUE]
      ,[DESCRIPTION]
      ,replace(mboid, ':FGDC', ':GC') as [MBOID]
      ,[MBOTYPE]
	  ,CAST (TVABSLATTACHMENTID AS NUMERIC(12, 0)) as TVABSLATTACHMENTID
	,[ROWSTAMP]
into theDevGCsite
  FROM openquery(MXtest, 
'select BSLVALUE
      ,DESCRIPTION
      ,MBOID
      ,MBOTYPE
	  ,TVABSLATTACHMENTID
		,ROWSTAMP
 from MAXIMO.TVABSLATTACHMENT where mboid like ''%FGDC%''
 and description in (''LIBRARY'', ''ASSOCIATED'')')
-- you can view the top five rows by setting debug to 1
if @debug = 1
	select top 5 * from theDevGCsite

--
-- drop the library's mult value tables copied from prd
--
if object_id(N'item_mv_custom01f1_fgdc_dev', N'U') is not null
	drop table item_mv_custom01f1_fgdc_dev
if object_id(N'item_mv_custom01p1_fgdc_dev', N'U') is not null
	drop table item_mv_custom01p1_fgdc_dev
---
--  what are we collecting here???
--FGDC
select * 
into item_mv_custom01f1_fgdc_dev
from chachaedma1.fosedma1.dbo.item_mv_custom01
-- you can view the top five rows by setting debug to 1
if @debug = 1 
	select top 5 * from item_mv_custom01f1_fgdc_dev
select * 
into item_mv_custom01p1_fgdc_dev 
from chachaedmt1.chatvaa.dbo.item_mv_custom01
-- you can view the top five rows by setting debug to 1
if @debug = 1 
	select top 5 * from item_mv_custom01p1_fgdc_dev
--select * from item_mv_custom01f1_fgdc_dev where itmv01_e_name = '101760774'
--select * from theDevGCsite where bslvalue = 'chaedmf^chachaedmf1'
--select * from theDevGCsite where mboid = 'WORKORDER:FGDC:113070128'
--
-- drop temp tables that hold the new insert rows
--
if object_id(N'sitechg_fosdevbsl_inserts', N'U') is not null
	drop table sitechg_fosdevbsl_inserts
if object_id(N'sitechg_tvadevbsl_inserts', N'U') is not null
	drop table sitechg_tvadevbsl_inserts
--
--- inserting UNID data.
-- 
select itmv01_e_name, 
	replace(itmv01_value, ':FGDC', ':GC') as "new_mboid_itmv01_value", 
	itmv01_value as "old_mboid_itmv01_value" , 
	"dups_or_nondups" = case  
		when CHARINDEX('~',itmv01_value) > 0 then 'dups'
		else 'nondups'
	end
into sitechg_fosdevbsl_inserts
from item_mv_custom01f1_fgdc_dev
where CHARINDEX(':FGDC',itmv01_value) > 0
-- you can view the top five rows by setting debug to 1
if @debug = 1
	select top 5 * from sitechg_fosdevbsl_inserts
--
--- inserting UNID data.
--
select itmv01_e_name, 
	replace(itmv01_value, ':FGDC', ':GC') as "new_mboid_itmv01_value", 
	itmv01_value as "old_mboid_itmv01_value" , 
	"dups_or_nondups" = case  
		when CHARINDEX('~',itmv01_value) > 0 then 'dups'
		else 'nondups'
	end
into sitechg_tvadevbsl_inserts
from item_mv_custom01p1_fgdc_dev
where CHARINDEX(':FGDC',itmv01_value) > 0
if @debug = 1
	select top 5 * from sitechg_tvadevbsl_inserts
--
-- this is where i stopped
--
if @debug = 1
begin
	select * from theDevGCsite
	select * from sitechg_fosdevbsl_inserts
	select * from sitechg_tvadevbsl_inserts
end
----FINAL INSERT SCRIPTS FOR ACCEPTANCE--------

--
----FOS----------
--INSERT INTO chachaedma1.fosedma1.dbo.item_mv_custom01
--                      (ITMV01_E_NAME, ITMV01_VALUE)
--SELECT     itmv01_e_name, new_mboid_itmv01_value
--FROM         sitechg_fosdevbsl_inserts
----
--------TVA----------
--INSERT INTO chachaedmt1.chatvaa.dbo.item_mv_custom01
--                      (ITMV01_E_NAME, ITMV01_VALUE)
--SELECT     itmv01_e_name, new_mboid_itmv01_value
--FROM         sitechg_tvadevbsl_inserts
--
-- verify for Robert that the conversion worked
--
--select * 
--from chachaedma1.fosedma1.dbo.item_mv_custom01
--where itmv01_e_name = '004108438'