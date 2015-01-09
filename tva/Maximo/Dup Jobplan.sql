--
-- creates the theGCSite table from the maximo table
--
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
 from MAXIMO.TVABSLATTACHMENT where mboid like ''JOBPLAN:600106553%''
 ')
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
 from MAXIMO.TVABSLATTACHMENT where mboid like ''JOBPLAN:TEST VIEWATTACH%''
 ')

select * 
from tvawbnedm1.wbnedm.dbo.item_mv_custom01
where itmv01_value like 'JOBPLAN:WBN:600106553%'
select * 
from tvawbnedm1.wbnedm.dbo.item_mv_custom01
where itmv01_value like 'JOBPLAN:600106553%'

select * 
from tvawbnedm1.wbnedm.dbo.item_mv_custom01
where itmv01_value like 'JOBPLAN:WBN:TEST%'

select * 
from tvawbnedm1.wbnedm.dbo.item_mv_custom02