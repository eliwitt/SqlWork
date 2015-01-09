declare @debug int
set @debug = 1
--
-- drop the table that will hold the new GC rows
--
if object_id(N'theGCsite', N'U') is not null
	drop table theGCsite
--
-- creates the theGCSite table from the maximo table
--
select replace(bslvalue, ':FGDC', ':GC') as [BSLVALUE]
      ,[DESCRIPTION]
      ,replace(mboid, ':FGDC', ':GC') as [MBOID]
      ,[MBOTYPE]
	  ,CAST (TVABSLATTACHMENTID AS NUMERIC(12, 0)) as TVABSLATTACHMENTID
	,[ROWSTAMP]
into theGCsite
  FROM openquery(MXprdcom, 
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
	select top 5 * from theGCsite

--
-- drop the library's mult value tables copied from prd
--
if object_id(N'item_mv_custom01f1_fgdc_prd', N'U') is not null
	drop table item_mv_custom01f1_fgdc_prd
if object_id(N'item_mv_custom01p1_fgdc_prd', N'U') is not null
	drop table item_mv_custom01p1_fgdc_prd
if object_id(N'item_mv_custom01t1_fgdc_prd', N'U') is not null
	drop table item_mv_custom01t1_fgdc_prd
---
--  what are we collecting here???
--FGDC
select * 
into item_mv_custom01f1_fgdc_prd
from chachaedmf1.chaedmf.dbo.item_mv_custom01
-- you can view the top five rows by setting debug to 1
if @debug = 1 
	select top 5 * from item_mv_custom01f1_fgdc_prd
select * 
into item_mv_custom01p1_fgdc_prd 
from chachaedmp1.chaedmp.dbo.item_mv_custom01
-- you can view the top five rows by setting debug to 1
if @debug = 1 
	select top 5 * from item_mv_custom01p1_fgdc_prd
select * 
into item_mv_custom01t1_fgdc_prd  
from chapedmvlt1.edmvltcha.dbo.ITEM_MV_CUSTOM04
-- you can view the top five rows by setting debug to 1
if @debug = 1 
	select top 5 * from item_mv_custom01t1_fgdc_prd
--select * from item_mv_custom01f1_fgdc_prd where itmv01_e_name = '101760774'
--select * from theGCsite where bslvalue = 'chaedmf^chachaedmf1'
--select * from theGCsite where mboid = 'WORKORDER:FGDC:113070128'
--
-- drop temp tables that hold the new insert rows
--
if object_id(N'sitechg_nondupsf1_inserts', N'U') is not null
	drop table sitechg_nondupsf1_inserts
if object_id(N'sitechg_nondupsp1_inserts', N'U') is not null
	drop table sitechg_nondupsp1_inserts
if object_id(N'sitechg_nondupst1_inserts', N'U') is not null
	drop table sitechg_nondupst1_inserts
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
into sitechg_nondupsf1_inserts
from item_mv_custom01f1_fgdc_prd
where CHARINDEX(':FGDC',itmv01_value) > 0
-- you can view the top five rows by setting debug to 1
if @debug = 1
	select top 5 * from sitechg_nondupsf1_inserts
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
into sitechg_nondupsp1_inserts
from item_mv_custom01p1_fgdc_prd
where CHARINDEX(':FGDC',itmv01_value) > 0
if @debug = 1
	select top 5 * from sitechg_nondupsp1_inserts
--
--- inserting unid data.
--
select itmv04_e_name, 
	replace(itmv04_value, ':FGDC', ':GC') as "new_mboid_itmv04_value", 
	itmv04_value as "old_mboid_itmv04_value" , 
	"dups_or_nondups" = case  
		when CHARINDEX('~',itmv04_value) > 0 then 'dups'
		else 'nondups'
	end
into sitechg_nondupst1_inserts
from item_mv_custom01t1_fgdc_prd
where CHARINDEX(':FGDC',itmv04_value) > 0
if @debug = 1
	select top 5 * from sitechg_nondupsp1_inserts
--
-- show the results of the site change
--
--select * from theGCsite
--select * from sitechg_nondupsf1_inserts
--select * from sitechg_nondupsp1_inserts
--select * from sitechg_nondupst1_inserts

----FINAL INSERT SCRIPTS FOR ACCEPTANCE--------

--
----FOS----------
--INSERT INTO chachaedmf1.chaedmf.dbo.item_mv_custom01
--                      (ITMV01_E_NAME, ITMV01_VALUE)
--SELECT     itmv01_e_name, new_mboid_itmv01_value
--FROM         sitechg_nondupsf1_inserts
----
--------TVA----------
--INSERT INTO chachaedmp1.chaedmp.dbo.item_mv_custom01
--                      (ITMV01_E_NAME, ITMV01_VALUE)
--SELECT     itmv01_e_name, new_mboid_itmv01_value
--FROM         sitechg_nondupsp1_inserts
----
--------vlt-----------
--INSERT INTO chapedmvlt1.edmvltcha.dbo.ITEM_MV_CUSTOM04
--                      (ITMV04_E_NAME, ITMV04_VALUE)
--SELECT     itmv04_e_name, new_mboid_itmv04_value
--FROM         sitechg_nondupst1_inserts
