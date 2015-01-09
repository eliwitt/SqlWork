
--select bslvalue, count(*)
--from updated_dup_jobplans$
--group by  bslvalue


select * 
into item_mv_custom01_fos_accp 
from chachaedma1.fosedma1.dbo.item_mv_custom01

select * 
into item_mv_custom01_ro_accp 
from chachaedma1.rsoedma1.dbo.item_mv_custom01

select * 
into item_mv_custom01_site_accp 
from chaaedmn1.site_accp.dbo.item_mv_custom01

select * 
into item_mv_custom03_pso_accp
from chachaedma1.tpsedma1.dbo.item_mv_custom03


--drop table jobplan_pso_accp_inserts
--drop table jobplan_site_accp_inserts
--drop table jobplan_fos_accp_inserts
--drop table jobplan_ro_accp_inserts

--- inserting job plan data.
select itmv01_e_name, new_mboid as "new_mboid_itmv01_value", mboid as "old_mboid_itmv01_value" , 'nondups' as "dups_or_nondups"
into jobplan_fos_accp_inserts
from SITE_ACCP_NONDUP_to_ACCP_BSL_Re$, item_mv_custom01_fos_accp
where bslvalue = 'fosedma1^chachaedma1'
and MBOID COLLATE Database_Default = itmv01_value COLLATE Database_Default

select  itmv01_e_name, new_mboid as "new_mboid_itmv01_value", mboid as "old_mboid_itmv01_value" , 'nondups' as "dups_or_nondups"
into jobplan_ro_accp_inserts
from SITE_ACCP_NONDUP_to_ACCP_BSL_Re$, item_mv_custom01_ro_accp
where bslvalue = 'rsoedma1^chachaedma1'
and MBOID COLLATE Database_Default = itmv01_value COLLATE Database_Default

select  itmv01_e_name, new_mboid as "new_mboid_itmv01_value", mboid as "old_mboid_itmv01_value", 'nondups' as "dups_or_nondups"
into jobplan_site_accp_inserts
from SITE_ACCP_NONDUP_to_ACCP_BSL_Re$, item_mv_custom01_site_accp
where bslvalue = 'site_accp^chaaedmn1'
and MBOID COLLATE Database_Default = itmv01_value COLLATE Database_Default

select itmv03_e_name, new_mboid as "new_mboid_itmv03_value", mboid as "old_mboid_itmv03_value" , 'nondups' as "dups_or_nondups"
into jobplan_pso_accp_inserts
from SITE_ACCP_NONDUP_to_ACCP_BSL_Re$, item_mv_custom03_pso_accp
where bslvalue = 'tpsedma1^chachaedma1'
and MBOID COLLATE Database_Default = itmv03_value COLLATE Database_Default



--include ~ + version (jpnum:ACT:11111~1) in the new unique key if the job plan had an entry already.

----FOS------
select itmv01_e_name, SUBSTRING(A.itmv01_value,1,CHARINDEX('~',A.itmv01_value) - 1 )as "itmv01_value_trimmed" , a.itmv01_value , 
	SUBSTRING(A.itmv01_value,CHARINDEX('~',A.itmv01_value),len(a.itmv01_value)) as "xter" 
into jobplan_fos_accp_inserts_tmp
from item_mv_custom01_fos_accp A
where CHARINDEX('~',A.itmv01_value) > 0 
and substring(itmv01_value,1,8) = 'JOBPLAN:' 

insert into jobplan_fos_accp_inserts
select a.itmv01_e_name, a.new_mboid_itmv01_value COLLATE Database_Default + b.xter  as "new_mboid_itmv01_value"  , old_mboid_itmv01_value , dups_or_nondups
from jobplan_fos_accp_inserts_tmp b ,jobplan_fos_accp_inserts a
where old_mboid_itmv01_value + a.itmv01_e_name COLLATE Database_Default= itmv01_value_trimmed + b.itmv01_e_name COLLATE Database_Default


----PSO------
select itmv03_e_name, SUBSTRING(A.itmv03_value,1,CHARINDEX('~',A.itmv03_value) - 1 )as "itmv03_value_trimmed" , a.itmv03_value , 
	SUBSTRING(A.itmv03_value,CHARINDEX('~',A.itmv03_value),len(a.itmv03_value)) as "xter" 
into jobplan_pso_accp_inserts_tmp
from item_mv_custom03_pso_accp A
where CHARINDEX('~',A.itmv03_value) > 0 
and substring(itmv03_value,1,8) = 'JOBPLAN:'

insert into jobplan_pso_accp_inserts
select a.itmv03_e_name, a.new_mboid_itmv03_value COLLATE Database_Default + b.xter  as "new_mboid_itmv03_value"  , old_mboid_itmv03_value , dups_or_nondups
from jobplan_pso_accp_inserts_tmp b ,jobplan_pso_accp_inserts a
where old_mboid_itmv03_value + a.itmv03_e_name COLLATE Database_Default= itmv03_value_trimmed + b.itmv03_e_name COLLATE Database_Default


----RO------
select itmv01_e_name, SUBSTRING(A.itmv01_value,1,CHARINDEX('~',A.itmv01_value) - 1 )as "itmv01_value_trimmed" , a.itmv01_value , 
	SUBSTRING(A.itmv01_value,CHARINDEX('~',A.itmv01_value),len(a.itmv01_value)) as "xter" 
into jobplan_ro_accp_inserts_tmp
from item_mv_custom01_ro_accp A
where CHARINDEX('~',A.itmv01_value) > 0 
and substring(itmv01_value,1,8) = 'JOBPLAN:' 

insert into jobplan_ro_accp_inserts
select a.itmv01_e_name, a.new_mboid_itmv01_value COLLATE Database_Default + b.xter  as "new_mboid_itmv01_value"  , old_mboid_itmv01_value , dups_or_nondups
from jobplan_ro_accp_inserts_tmp b ,jobplan_ro_accp_inserts a
where old_mboid_itmv01_value + a.itmv01_e_name COLLATE Database_Default= itmv01_value_trimmed + b.itmv01_e_name COLLATE Database_Default


----SITE_ACCP------
select itmv01_e_name, SUBSTRING(A.itmv01_value,1,CHARINDEX('~',A.itmv01_value) - 1 )as "itmv01_value_trimmed" , a.itmv01_value , 
	SUBSTRING(A.itmv01_value,CHARINDEX('~',A.itmv01_value),len(a.itmv01_value)) as "xter"
into jobplan_site_accp_inserts_tmp
from item_mv_custom01_site_accp A
where CHARINDEX('~',A.itmv01_value) > 0 
and substring(itmv01_value,1,8) = 'JOBPLAN:' 

insert into jobplan_site_accp_inserts
select a.itmv01_e_name, a.new_mboid_itmv01_value COLLATE Database_Default + b.xter  as "new_mboid_itmv01_value"  , old_mboid_itmv01_value , dups_or_nondups
from jobplan_site_accp_inserts_tmp b ,jobplan_site_accp_inserts a
where old_mboid_itmv01_value + a.itmv01_e_name COLLATE Database_Default = itmv01_value_trimmed + b.itmv01_e_name COLLATE Database_Default



----FINAL INSERT SCRIPTS FOR ACCEPTANCE--------

----FOS----------
INSERT INTO item_mv_custom01_fos_accp
                      (ITMV01_E_NAME, ITMV01_VALUE)
SELECT     itmv01_e_name, new_mboid_itmv01_value
FROM         jobplan_fos_accp_inserts

----PSO----------
INSERT INTO item_mv_custom03_pso_accp
                      (ITMV03_E_NAME, ITMV03_VALUE)
SELECT     itmv03_e_name, new_mboid_itmv03_value
FROM         jobplan_pso_accp_inserts

----RO-----------
INSERT INTO item_mv_custom01_ro_accp
                      (ITMV01_E_NAME, ITMV01_VALUE)
SELECT     itmv01_e_name, new_mboid_itmv01_value
FROM         jobplan_ro_accp_inserts

----SITE_ACCP-----------
INSERT INTO item_mv_custom01_site_accp
                      (ITMV01_E_NAME, ITMV01_VALUE)
SELECT     itmv01_e_name, new_mboid_itmv01_value
FROM         jobplan_site_accp_inserts

