declare @cmd varchar(4000),
@envir varchar(40),
@cat varchar(40)

set @envir = 'chachaedmt1'
set @cat = 'chatvaa'
set @cmd = 'select * 
from ' + @envir + '.' + @cat + '.dbo.item_mv_custom01'
if object_id(N'jobplan_pso_accp_inserts', N'U') is not null
	drop table jobplan_pso_accp_inserts
exec(@cmd)

select * 
from chachaedma1.rsoedma1.dbo.item_mv_custom01

select * 
from chaaedmn1.site_accp.dbo.item_mv_custom01

select * 
from chachaedma1.tpsedma1.dbo.item_mv_custom03

select * from sitechg_nondups_inserts