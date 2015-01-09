exec sp_linkedservers

select * from CHAAEDMN1.[site_accp].dbo.app 

SELECT [BSLVALUE]
      ,[DESCRIPTION]
      ,[MBOID]
      ,[MBOTYPE]
	  ,CAST (TVABSLATTACHMENTID AS NUMERIC(12, 2)) as attachid
	,[ROWSTAMP]
  FROM openquery(MXTEST, 
'select BSLVALUE
      ,DESCRIPTION
      ,MBOID
      ,MBOTYPE
	  ,TVABSLATTACHMENTID
		,ROWSTAMP
 from MAXIMO.TVABSLATTACHMENT')

SELECT *
  FROM openquery(MXTEST, 
'select *
 from MAXIMO.TVABSLATTACHMENT')

--select * from mxtest..MAXIMO.TVABSLNOTIFYPROC
SELECT *
  FROM openquery(MXTEST, 
'select *
 from MAXIMO.TVABSLNOTIFYPROC')