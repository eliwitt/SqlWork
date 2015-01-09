--
-- drop the table that will hold the new GC rows
--
if object_id(N'theGCsite', N'U') is not null
	drop table theGCsite
--
-- creates the theGCSite table using a select statement
--
select [BSLVALUE]
      ,[DESCRIPTION]
      ,replace(mboid, ':FGDC', ':GC') as MBOID
      ,[MBOTYPE]
	  ,CAST (TVABSLATTACHMENTID AS NUMERIC(12, 0)) as TVABSLATTACHMENTID
	,[ROWSTAMP]
into theGCsite
  FROM openquery(MXtest, 
'select BSLVALUE
      ,DESCRIPTION
      ,MBOID
      ,MBOTYPE
	  ,TVABSLATTACHMENTID
		,ROWSTAMP
 from MAXIMO.TVABSLATTACHMENT where mboid like ''%FGDC%''') 

select * from theGCSite order by TVABSLATTACHMENTID
SELECT [BSLVALUE]
      ,[DESCRIPTION]
      ,[MBOID]
      ,[MBOTYPE]
	  ,CAST (TVABSLATTACHMENTID AS NUMERIC(12, 0)) TVABSLATTACHMENTID
	,[ROWSTAMP]
  FROM openquery(MXprdcom, 
'select BSLVALUE
      ,DESCRIPTION
      ,MBOID
      ,MBOTYPE
	  ,TVABSLATTACHMENTID
		,ROWSTAMP
 from MAXIMO.TVABSLATTACHMENT where mboid like ''%FGDC%'' order by TVABSLATTACHMENTID')
--update theGCSite set mboid = replace(mboid, ':FGDC', ':GC')
--delete theGCSite
exec LookupMBO MXtest, '%:FGDC%', 0