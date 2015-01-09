--select * from theGCsite
--select * from sitechg_nondupsf1_inserts
--select * from sitechg_nondupsp1_inserts
--
-- verify double entries
--
select * 
from chachaedmf1.chaedmf.dbo.item_mv_custom01
where itmv01_e_name = '102710148'
-- you can view the top five rows by setting debug to 1
select * 
from chachaedmp1.chaedmp.dbo.item_mv_custom01
where itmv01_e_name = '101760741'

--
-- generate files of the chagnes
--
select * 
from chachaedmf1.chaedmf.dbo.item_mv_custom01
where itmv01_value like '%:GC:%' or itmv01_value like '%:GC' or itmv01_value like '%:GC~%'

select * 
from chachaedmp1.chaedmp.dbo.item_mv_custom01
where itmv01_value like '%:GC:%' or itmv01_value like '%:GC' or itmv01_value like '%:GC~%'

select [BSLVALUE]
      ,[DESCRIPTION]
      ,[MBOID]
      ,[MBOTYPE]
	  ,CAST (TVABSLATTACHMENTID AS NUMERIC(12, 0)) as TVABSLATTACHMENTID
	,[ROWSTAMP]
FROM openquery(MXprdcom, 
'select BSLVALUE
      ,DESCRIPTION
      ,MBOID
      ,MBOTYPE
	  ,TVABSLATTACHMENTID
		,ROWSTAMP
 from MAXIMO.TVABSLATTACHMENT where (mboid like ''%:GC'' or mboid like ''%:GC:%'')
 and description in (''LIBRARY'', ''ASSOCIATED'')')
