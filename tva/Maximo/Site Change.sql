declare GCItems scroll cursor for
SELECT [MBOID]
	  ,CAST (TVABSLATTACHMENTID AS NUMERIC(12, 0)) as attachid
  FROM openquery(MXTEST, 
'select MBOID
	  ,TVABSLATTACHMENTID
 from MAXIMO.TVABSLATTACHMENT') where mboid like '%FGDC%'
declare @attid int
declare @mboid varchar(50)
open GCItems
fetch first from GCItems into @mboid, @attid
-- begin the process of setting the cash discount fields
while @@fetch_status = 0
begin
	--select @attid id, @mboid mbo, replace(@mboid, ':FGDC:', ':GC:') newmbo
	print 'id (' + cast(@attid as varchar(10)) + ')  mbo (' + @mboid + ') newmbo (' + replace(@mboid, ':FGDC:', ':GC:') + ')'
	fetch next from GCItems into @mboid, @attid
end
--  cleanup the cursor
close GCItems
deallocate GCItems