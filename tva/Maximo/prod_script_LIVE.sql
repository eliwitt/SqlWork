
--drop table item_mv_custom01_bfn_prod
--drop table item_mv_custom01_wbn_prod
--drop table item_mv_custom01_sqn_prod
--drop table item_mv_custom01_bln_prod
--drop table item_mv_custom01_fos_prod
--drop table item_mv_custom03_pso_prod
--drop table item_mv_custom01_ro_prod
--drop table item_mv_custom01_tva_prod
--drop table item_mv_custom01_nuccorp_prod

select * 
into item_mv_custom01_bfn_prod 
from tvabfnedm1.bfnedm.dbo.item_mv_custom01
where itmv01_value LIKE '%JOBPLAN%'

select * 
into item_mv_custom01_wbn_prod 
from tvawbnedm1.wbnedm.dbo.item_mv_custom01
where itmv01_value LIKE '%JOBPLAN%'

select * 
into item_mv_custom01_sqn_prod 
from tvasqnedm1.sqnedm.dbo.item_mv_custom01
where itmv01_value LIKE '%JOBPLAN%'

select * 
into item_mv_custom01_bln_prod 
from tvablnedm1.blnedm.dbo.item_mv_custom01
where itmv01_value LIKE '%JOBPLAN%'

select * 
into item_mv_custom01_fos_prod 
from chachaedmf1.chaedmf.dbo.item_mv_custom01
where itmv01_value LIKE '%JOBPLAN%'

select * 
into item_mv_custom03_pso_prod 
from chachaedme1.chaedme.dbo.item_mv_custom03
where itmv03_value LIKE '%JOBPLAN%'

select * 
into item_mv_custom01_ro_prod 
from chachaedmr1.chaedmr.dbo.item_mv_custom01
where itmv01_value LIKE '%JOBPLAN%'

select * 
into item_mv_custom01_tva_prod 
from chachaedmp1.chaedmp.dbo.item_mv_custom01
where itmv01_value LIKE '%JOBPLAN%'

select * 
into item_mv_custom01_nuccorp_prod 
from chachaedmn1.chaedmn.dbo.item_mv_custom01
where itmv01_value LIKE '%JOBPLAN%'

----------REPLICATED LIBRARIES----------------------------------------------

--drop table element_ro_repl_prod
--drop table element_tva_repl_prod
--drop table element_nuccorp_repl_prod
--drop table element_fos_repl_prod
--drop table element_pso_repl_prod

select e_name, e_ina15
into element_ro_repl_prod 
from knxknxedmr1.knxedmr.dbo.element

select e_name, e_ina15
into element_tva_repl_prod 
from knxknxedmp1.knxedmp.dbo.element

select e_name, e_ina15
into element_nuccorp_repl_prod 
from chachaedmn1.chaedmn.dbo.element

select e_name, e_ina15
into element_fos_repl_prod 
from knxknxedmr1.knxedmf.dbo.element

select e_name, e_ina20
into element_pso_repl_prod 
from knxknxedmr1.knxedme1.dbo.element


----------END REPLICATION LIBRARIES-----------------------------------------


--drop table jobplan_pso_inserts
--drop table jobplan_bfn_inserts
--drop table jobplan_bln_inserts
--drop table jobplan_fos_inserts
--drop table jobplan_ro_inserts
--drop table jobplan_wbn_inserts
--drop table jobplan_sqn_inserts
--drop table jobplan_tva_inserts
--drop table jobplan_nuccorp_inserts


select itmv01_e_name, jpnum, new_mboid as "new_mboid_itmv01_value", mboid as "old_mboid_itmv01_value" , 'nondups' as "dups_or_nondups"
into jobplan_bfn_inserts
from updated_nondup_jobplans$, item_mv_custom01_bfn_prod
where bslvalue = 'bfnedm^tvabfnedm1'
and MBOID COLLATE Database_Default = itmv01_value COLLATE Database_Default

select  itmv01_e_name, jpnum, new_mboid as "new_mboid_itmv01_value", mboid as "old_mboid_itmv01_value" , 'nondups' as "dups_or_nondups"
into jobplan_wbn_inserts
from updated_nondup_jobplans$, item_mv_custom01_wbn_prod
where bslvalue = 'wbnedm^tvawbnedm1'
and MBOID COLLATE Database_Default = itmv01_value COLLATE Database_Default

select  itmv01_e_name, jpnum, new_mboid as "new_mboid_itmv01_value", mboid as "old_mboid_itmv01_value", 'nondups' as "dups_or_nondups"
into jobplan_bln_inserts
from updated_nondup_jobplans$, item_mv_custom01_bln_prod
where bslvalue = 'blnedm^tvablnedm1'
and MBOID COLLATE Database_Default = itmv01_value COLLATE Database_Default

select itmv01_e_name, jpnum, new_mboid as "new_mboid_itmv01_value", mboid as "old_mboid_itmv01_value" , 'nondups' as "dups_or_nondups"
into jobplan_sqn_inserts
from updated_nondup_jobplans$, item_mv_custom01_sqn_prod
where bslvalue = 'sqnedm^tvasqnedm1'
and MBOID COLLATE Database_Default = itmv01_value COLLATE Database_Default

select itmv03_e_name, jpnum, new_mboid as "new_mboid_itmv03_value", mboid as "old_mboid_itmv03_value" , 'nondups' as "dups_or_nondups"
into jobplan_pso_inserts
from updated_nondup_jobplans$, item_mv_custom03_pso_prod
where bslvalue = 'chaedme^chachaedme1'
and MBOID COLLATE Database_Default = itmv03_value COLLATE Database_Default

select itmv01_e_name, jpnum, new_mboid as "new_mboid_itmv01_value", mboid as "old_mboid_itmv01_value" , 'nondups' as "dups_or_nondups"
into jobplan_fos_inserts
from updated_nondup_jobplans$, item_mv_custom01_fos_prod
where bslvalue = 'chaedmf^chachaedmf1'
and MBOID COLLATE Database_Default = itmv01_value COLLATE Database_Default

select itmv01_e_name, jpnum, new_mboid as "new_mboid_itmv01_value", mboid as "old_mboid_itmv01_value" , 'nondups' as "dups_or_nondups"
into jobplan_ro_inserts
from updated_nondup_jobplans$, item_mv_custom01_ro_prod
where bslvalue = 'chaedmr^chachaedmr1'
and MBOID COLLATE Database_Default = itmv01_value COLLATE Database_Default


select itmv01_e_name, jpnum, new_mboid as "new_mboid_itmv01_value", mboid as "old_mboid_itmv01_value" , 'nondups' as "dups_or_nondups"
into jobplan_tva_inserts
from updated_nondup_jobplans$, item_mv_custom01_tva_prod
where bslvalue = 'chaedmp^chachaedmp1'
and MBOID COLLATE Database_Default = itmv01_value COLLATE Database_Default


select itmv01_e_name, jpnum, new_mboid as "new_mboid_itmv01_value", mboid as "old_mboid_itmv01_value" , 'nondups' as "dups_or_nondups"
into jobplan_nuccorp_inserts
from updated_nondup_jobplans$, item_mv_custom01_nuccorp_prod
where bslvalue = 'chaedmn^chachaedmn1'
and MBOID COLLATE Database_Default = itmv01_value COLLATE Database_Default

------Done generating inserts 

---------------------include ~ + version (jpnum:ACT:11111~1) in the new unique key if the job plan had an entry already.-----

----BFN------

--drop table jobplan_bfn_inserts_tmp
select itmv01_e_name, SUBSTRING(A.itmv01_value,1,CHARINDEX('~',A.itmv01_value) - 1 )as "itmv01_value_trimmed" , a.itmv01_value , 
	SUBSTRING(A.itmv01_value,CHARINDEX('~',A.itmv01_value),len(a.itmv01_value)) as "xter"
into jobplan_bfn_inserts_tmp
from item_mv_custom01_bfn_prod A
where CHARINDEX('~',A.itmv01_value) > 0 
and substring(itmv01_value,1,8) = 'JOBPLAN:' 

insert into jobplan_bfn_inserts
select a.itmv01_e_name, a.jpnum, a.new_mboid_itmv01_value COLLATE Database_Default + b.xter  as "new_mboid_itmv01_value"  , old_mboid_itmv01_value , dups_or_nondups
from jobplan_bfn_inserts_tmp b ,jobplan_bfn_inserts a
where old_mboid_itmv01_value + a.itmv01_e_name COLLATE Database_Default = itmv01_value_trimmed + b.itmv01_e_name COLLATE Database_Default

----BLN------
--drop table jobplan_bln_inserts_tmp
select itmv01_e_name, SUBSTRING(A.itmv01_value,1,CHARINDEX('~',A.itmv01_value) - 1 )as "itmv01_value_trimmed" , a.itmv01_value , 
	SUBSTRING(A.itmv01_value,CHARINDEX('~',A.itmv01_value),len(a.itmv01_value)) as "xter" 
into jobplan_bln_inserts_tmp
from item_mv_custom01_bln_prod A
where CHARINDEX('~',A.itmv01_value) > 0 
and substring(itmv01_value,1,8) = 'JOBPLAN:' 

insert into jobplan_bln_inserts
select a.itmv01_e_name, a.jpnum, a.new_mboid_itmv01_value COLLATE Database_Default + b.xter  as "new_mboid_itmv01_value"  , old_mboid_itmv01_value , dups_or_nondups
from jobplan_bln_inserts_tmp b ,jobplan_bln_inserts a
where old_mboid_itmv01_value + a.itmv01_e_name = itmv01_value_trimmed + b.itmv01_e_name

----SQN------

--drop table jobplan_sqn_inserts_tmp
select itmv01_e_name, SUBSTRING(A.itmv01_value,1,CHARINDEX('~',A.itmv01_value) - 1 )as "itmv01_value_trimmed" , a.itmv01_value , 
	SUBSTRING(A.itmv01_value,CHARINDEX('~',A.itmv01_value),len(a.itmv01_value)) as "xter" 
into jobplan_sqn_inserts_tmp
from item_mv_custom01_sqn_prod A
where CHARINDEX('~',A.itmv01_value) > 0 
and substring(itmv01_value,1,8) = 'JOBPLAN:' 

insert into jobplan_sqn_inserts
select a.itmv01_e_name, a.jpnum, a.new_mboid_itmv01_value COLLATE Database_Default + b.xter  as "new_mboid_itmv01_value"  , old_mboid_itmv01_value , dups_or_nondups
from jobplan_sqn_inserts_tmp b ,jobplan_sqn_inserts a
where old_mboid_itmv01_value + a.itmv01_e_name COLLATE Database_Default = itmv01_value_trimmed + b.itmv01_e_name COLLATE Database_Default

----WBN------

--drop table jobplan_wbn_inserts_tmp
select itmv01_e_name, SUBSTRING(A.itmv01_value,1,CHARINDEX('~',A.itmv01_value) - 1 )as "itmv01_value_trimmed" , a.itmv01_value , 
	SUBSTRING(A.itmv01_value,CHARINDEX('~',A.itmv01_value),len(a.itmv01_value)) as "xter" 
into jobplan_wbn_inserts_tmp
from item_mv_custom01_wbn_prod A
where CHARINDEX('~',A.itmv01_value) > 0 
and substring(itmv01_value,1,8) = 'JOBPLAN:' 

insert into jobplan_wbn_inserts
select a.itmv01_e_name, a.jpnum, a.new_mboid_itmv01_value COLLATE Database_Default + b.xter  as "new_mboid_itmv01_value"  , old_mboid_itmv01_value , dups_or_nondups
from jobplan_wbn_inserts_tmp b ,jobplan_wbn_inserts a
where old_mboid_itmv01_value + a.itmv01_e_name COLLATE Database_Default= itmv01_value_trimmed + b.itmv01_e_name COLLATE Database_Default

----TVA------

--drop table jobplan_tva_inserts_tmp
select itmv01_e_name, SUBSTRING(A.itmv01_value,1,CHARINDEX('~',A.itmv01_value) - 1 )as "itmv01_value_trimmed" , a.itmv01_value , 
	SUBSTRING(A.itmv01_value,CHARINDEX('~',A.itmv01_value),len(a.itmv01_value)) as "xter" 
into jobplan_tva_inserts_tmp
from item_mv_custom01_tva_prod A
where CHARINDEX('~',A.itmv01_value) > 0 
and substring(itmv01_value,1,8) = 'JOBPLAN:' 

insert into jobplan_tva_inserts
select a.itmv01_e_name, a.jpnum, a.new_mboid_itmv01_value COLLATE Database_Default + b.xter  as "new_mboid_itmv01_value"  , old_mboid_itmv01_value , dups_or_nondups
from jobplan_tva_inserts_tmp b ,jobplan_tva_inserts a
where old_mboid_itmv01_value + a.itmv01_e_name COLLATE Database_Default= itmv01_value_trimmed + b.itmv01_e_name COLLATE Database_Default

----NUCCORP------
--drop table jobplan_nuccorp_inserts_tmp
select itmv01_e_name, SUBSTRING(A.itmv01_value,1,CHARINDEX('~',A.itmv01_value) - 1 )as "itmv01_value_trimmed" , a.itmv01_value , 
	SUBSTRING(A.itmv01_value,CHARINDEX('~',A.itmv01_value),len(a.itmv01_value)) as "xter" 
into jobplan_nuccorp_inserts_tmp
from item_mv_custom01_nuccorp_prod A
where CHARINDEX('~',A.itmv01_value) > 0 
and substring(itmv01_value,1,8) = 'JOBPLAN:' 

insert into jobplan_nuccorp_inserts
select a.itmv01_e_name, a.jpnum, a.new_mboid_itmv01_value COLLATE Database_Default + b.xter  as "new_mboid_itmv01_value"  , old_mboid_itmv01_value , dups_or_nondups
from jobplan_nuccorp_inserts_tmp b ,jobplan_nuccorp_inserts a
where old_mboid_itmv01_value + a.itmv01_e_name COLLATE Database_Default= itmv01_value_trimmed + b.itmv01_e_name COLLATE Database_Default


------NON NUCLEAR------------------------------------------


----RO------
--drop table jobplan_ro_inserts_tmp
select itmv01_e_name, SUBSTRING(A.itmv01_value,1,CHARINDEX('~',A.itmv01_value) - 1 )as "itmv01_value_trimmed" , a.itmv01_value , 
	SUBSTRING(A.itmv01_value,CHARINDEX('~',A.itmv01_value),len(a.itmv01_value)) as "xter" 
into jobplan_ro_inserts_tmp
from item_mv_custom01_ro_prod A
where CHARINDEX('~',A.itmv01_value) > 0 
and substring(itmv01_value,1,8) = 'JOBPLAN:' 

insert into jobplan_ro_inserts
select a.itmv01_e_name, a.jpnum, a.new_mboid_itmv01_value COLLATE Database_Default + b.xter  as "new_mboid_itmv01_value"  , old_mboid_itmv01_value , dups_or_nondups
from jobplan_ro_inserts_tmp b ,jobplan_ro_inserts a
where old_mboid_itmv01_value + a.itmv01_e_name COLLATE Database_Default= itmv01_value_trimmed + b.itmv01_e_name COLLATE Database_Default


----PSO------
--drop table jobplan_pso_inserts_tmp
select itmv03_e_name, SUBSTRING(A.itmv03_value,1,CHARINDEX('~',A.itmv03_value) - 1 )as "itmv03_value_trimmed" , a.itmv03_value , 
	SUBSTRING(A.itmv03_value,CHARINDEX('~',A.itmv03_value),len(a.itmv03_value)) as "xter" 
into jobplan_pso_inserts_tmp
from item_mv_custom03_pso_prod A
where CHARINDEX('~',A.itmv03_value) > 0 
and substring(itmv03_value,1,8) = 'JOBPLAN:'

insert into jobplan_pso_inserts
select a.itmv03_e_name, a.jpnum, a.new_mboid_itmv03_value COLLATE Database_Default + b.xter  as "new_mboid_itmv03_value"  , old_mboid_itmv03_value , dups_or_nondups
from jobplan_pso_inserts_tmp b ,jobplan_pso_inserts a
where old_mboid_itmv03_value + a.itmv03_e_name COLLATE Database_Default= itmv03_value_trimmed + b.itmv03_e_name COLLATE Database_Default


----FOS------
--drop table jobplan_fos_inserts_tmp
select itmv01_e_name, SUBSTRING(A.itmv01_value,1,CHARINDEX('~',A.itmv01_value) - 1 )as "itmv01_value_trimmed" , a.itmv01_value , 
	SUBSTRING(A.itmv01_value,CHARINDEX('~',A.itmv01_value),len(a.itmv01_value)) as "xter" 
into jobplan_fos_inserts_tmp
from item_mv_custom01_fos_prod A
where CHARINDEX('~',A.itmv01_value) > 0 
and substring(itmv01_value,1,8) = 'JOBPLAN:' 

insert into jobplan_fos_inserts
select a.itmv01_e_name, a.jpnum, a.new_mboid_itmv01_value COLLATE Database_Default + b.xter  as "new_mboid_itmv01_value"  , old_mboid_itmv01_value , dups_or_nondups
from jobplan_fos_inserts_tmp b ,jobplan_fos_inserts a
where old_mboid_itmv01_value + a.itmv01_e_name COLLATE Database_Default= itmv01_value_trimmed + b.itmv01_e_name COLLATE Database_Default

--------------------------END include ~ + version (jpnum:ACT:11111~1) in the new unique key if the job plan had an entry already.----------
-------------------------------------------------------------------------------------------------------------------------------------------

--------------------------REPLICATED LIBRARIES PRODUCTION ONLY-------------------------------------------------------------------------------

--drop table jobplan_ro_repl_inserts
--drop table jobplan_fos_repl_inserts
--drop table jobplan_pso_repl_inserts
--drop table jobplan_tva_repl_inserts
--drop table jobplan_nuccorp_repl_inserts
----------------non nuclear----------------------------------
---ro
select itmv01_e_name, jpnum, new_mboid_itmv01_value, old_mboid_itmv01_value ,dups_or_nondups , 
	 'CHACHAEDMR1|CHAEDMR|' + itmv01_e_name + '|1' as "Unique_id", e_name as "itmv01_e_name_repl"
into jobplan_ro_repl_inserts
from jobplan_ro_inserts, element_ro_repl_prod
where e_ina15 =  'CHACHAEDMR1|CHAEDMR|' + itmv01_e_name + '|1'

---tva
select itmv01_e_name, jpnum, new_mboid_itmv01_value, old_mboid_itmv01_value ,dups_or_nondups , 
	 'CHACHAEDMP1|CHAEDMP|' + itmv01_e_name + '|1' as "Unique_id", e_name as "itmv01_e_name_repl"
into jobplan_tva_repl_inserts
from jobplan_tva_inserts, element_tva_repl_prod
where e_ina15 COLLATE Database_Default=  'CHACHAEDMP1|CHAEDMP|' + itmv01_e_name + '|1' COLLATE Database_Default

---pso
select itmv03_e_name, jpnum, new_mboid_itmv03_value, old_mboid_itmv03_value ,dups_or_nondups , 
	 'CHACHAEDME1|CHAEDME|' + itmv03_e_name + '|1' as "Unique_id", e_name as "itmv03_e_name_repl"
into jobplan_pso_repl_inserts
from jobplan_pso_inserts, element_pso_repl_prod
where e_ina20 =  'CHACHAEDME1|CHAEDME|' + itmv03_e_name + '|1'

---fos
select itmv01_e_name, jpnum, new_mboid_itmv01_value, old_mboid_itmv01_value ,dups_or_nondups , 
	 'CHACHAEDMF1|CHAEDMF|' + itmv01_e_name + '|1' as "Unique_id", e_name as "itmv01_e_name_repl"
into jobplan_fos_repl_inserts
from jobplan_fos_inserts, element_fos_repl_prod
where e_ina15 =  'CHACHAEDMF1|CHAEDMF|' + itmv01_e_name + '|1'

-----replicated library nuclear corp for all nuclear BSLs (BFN,WBN,BLN,SQN)

select itmv01_e_name, jpnum, new_mboid_itmv01_value, old_mboid_itmv01_value ,dups_or_nondups , 
	 'TVABLNEDM1|BLNEDM|' + itmv01_e_name + '|1' as "Unique_id", e_name as "itmv01_e_name_repl"
into jobplan_nuccorp_repl_inserts
from jobplan_bln_inserts, element_nuccorp_repl_prod
where e_ina15 COLLATE Database_Default=  'TVABLNEDM1|BLNEDM|' + itmv01_e_name + '|1' COLLATE Database_Default 

insert into jobplan_nuccorp_repl_inserts
select itmv01_e_name, jpnum, new_mboid_itmv01_value, old_mboid_itmv01_value ,dups_or_nondups , 
	 'TVABFNEDM1|BFNEDM|' + itmv01_e_name + '|1' as "Unique_id", e_name as "itmv01_e_name_repl"
from jobplan_bfn_inserts, element_nuccorp_repl_prod
where e_ina15 COLLATE Database_Default=  'TVABFNEDM1|BFNEDM|' + itmv01_e_name + '|1' COLLATE Database_Default

insert into jobplan_nuccorp_repl_inserts
select itmv01_e_name, jpnum, new_mboid_itmv01_value, old_mboid_itmv01_value ,dups_or_nondups , 
	 'TVAWBNEDM1|WBNEDM|' + itmv01_e_name + '|1' as "Unique_id", e_name as "itmv01_e_name_repl"
from jobplan_wbn_inserts, element_nuccorp_repl_prod
where e_ina15 COLLATE Database_Default=  'TVAWBNEDM1|WBNEDM|' + itmv01_e_name + '|1' COLLATE Database_Default

insert into jobplan_nuccorp_repl_inserts
select itmv01_e_name, jpnum, new_mboid_itmv01_value, old_mboid_itmv01_value ,dups_or_nondups , 
	 'TVASQNEDM1|SQNEDM|' + itmv01_e_name + '|1' as "Unique_id", e_name as "itmv01_e_name_repl"
from jobplan_sqn_inserts, element_nuccorp_repl_prod
where e_ina15 COLLATE Database_Default=  'TVASQNEDM1|SQNEDM|' + itmv01_e_name + '|1' COLLATE Database_Default

-----Completed BSLs (BFN,WBN,BLN,SQN)

--------------------------END REPLICATED LIBRARIES---------------------------------------------------------------------------

--------------------------INSERT DUPLICATE JOBPLAN OLD/NEW UNID/UNIQUE ID----------------------------------------------------

INSERT INTO jobplan_bfn_inserts
select itmv01_e_name, jpnum, new_mboid as "new_mboid_itmv01_value", mboid as "old_mboid_itmv01_value" , 'dups' as "dups_or_nondups"
from updated_dup_jobplans$, item_mv_custom01_bfn_prod
where bslvalue = 'bfnedm^tvabfnedm1'
and MBOID COLLATE Database_Default = itmv01_value COLLATE Database_Default

INSERT INTO jobplan_wbn_inserts
select  itmv01_e_name, jpnum, new_mboid as "new_mboid_itmv01_value", mboid as "old_mboid_itmv01_value" , 'dups' as "dups_or_nondups"
from updated_dup_jobplans$, item_mv_custom01_wbn_prod
where bslvalue = 'wbnedm^tvawbnedm1'
and MBOID COLLATE Database_Default = itmv01_value COLLATE Database_Default

INSERT INTO jobplan_bln_inserts
select  itmv01_e_name, jpnum, new_mboid as "new_mboid_itmv01_value", mboid as "old_mboid_itmv01_value", 'dups' as "dups_or_nondups"
from updated_dup_jobplans$, item_mv_custom01_bln_prod
where bslvalue = 'blnedm^tvablnedm1'
and MBOID COLLATE Database_Default = itmv01_value COLLATE Database_Default

INSERT INTO jobplan_sqn_inserts
select itmv01_e_name, jpnum, new_mboid as "new_mboid_itmv01_value", mboid as "old_mboid_itmv01_value" , 'dups' as "dups_or_nondups"
from updated_dup_jobplans$, item_mv_custom01_sqn_prod
where bslvalue = 'sqnedm^tvasqnedm1'
and MBOID COLLATE Database_Default = itmv01_value COLLATE Database_Default

INSERT INTO jobplan_pso_inserts
select itmv03_e_name, jpnum, new_mboid as "new_mboid_itmv03_value", mboid as "old_mboid_itmv03_value" , 'dups' as "dups_or_nondups"
from updated_dup_jobplans$, item_mv_custom03_pso_prod
where bslvalue = 'chaedme^chachaedme1'
and MBOID COLLATE Database_Default = itmv03_value COLLATE Database_Default

INSERT INTO jobplan_fos_inserts
select itmv01_e_name, jpnum, new_mboid as "new_mboid_itmv01_value", mboid as "old_mboid_itmv01_value" , 'dups' as "dups_or_nondups"
from updated_dup_jobplans$, item_mv_custom01_fos_prod
where bslvalue = 'chaedmf^chachaedmf1'
and MBOID COLLATE Database_Default = itmv01_value COLLATE Database_Default

INSERT INTO jobplan_ro_inserts
select itmv01_e_name, jpnum, new_mboid as "new_mboid_itmv01_value", mboid as "old_mboid_itmv01_value" , 'dups' as "dups_or_nondups"
from updated_dup_jobplans$, item_mv_custom01_ro_prod
where bslvalue = 'chaedmr^chachaedmr1'
and MBOID COLLATE Database_Default = itmv01_value COLLATE Database_Default

INSERT INTO jobplan_tva_inserts
select itmv01_e_name, jpnum, new_mboid as "new_mboid_itmv01_value", mboid as "old_mboid_itmv01_value" , 'dups' as "dups_or_nondups"
from updated_dup_jobplans$, item_mv_custom01_tva_prod
where bslvalue = 'chaedmp^chachaedmp1'
and MBOID COLLATE Database_Default = itmv01_value COLLATE Database_Default

INSERT INTO jobplan_nuccorp_inserts
select itmv01_e_name, jpnum, new_mboid as "new_mboid_itmv01_value", mboid as "old_mboid_itmv01_value" , 'dups' as "dups_or_nondups"
from updated_dup_jobplans$, item_mv_custom01_nuccorp_prod
where bslvalue = 'chaedmn^chachaedmn1'
and MBOID COLLATE Database_Default = itmv01_value COLLATE Database_Default


--------------------------END INSERT DUPLICATE JOBPLAN OLD/NEW UNID/UNIQUE ID-----------------------------------------------
----------------------------------------------------------------------------------------------------------------------------


--------------------------INSERT THE NEW MBOIDs INTO PORDUCTION BSLs (INCLUDING REPLICATION)--------------------------------

---------CREATE INSERT HISTORY TABLE------------

CREATE TABLE insert_history(table_inserts_completed varchar(50) Null)

------------------------------------------------


-- Insert JOBPLAN_INSERTS into Multi-Value tables ---------

INSERT INTO tvablnedm1.blnedm.dbo.item_mv_custom01
                      (ITMV01_E_NAME, ITMV01_VALUE)
SELECT     itmv01_e_name, new_mboid_itmv01_value
FROM         jobplan_bln_inserts

insert into insert_history 
select 'tvablnedm1.blnedm.dbo.item_mv_custom01'


INSERT INTO tvawbnedm1.wbnedm.dbo.item_mv_custom01
                      (ITMV01_E_NAME, ITMV01_VALUE)
SELECT     itmv01_e_name, new_mboid_itmv01_value
FROM         jobplan_wbn_inserts

insert into insert_history 
select 'tvawbnedm1.wbnedm.dbo.item_mv_custom01'


INSERT INTO tvasqnedm1.sqnedm.dbo.item_mv_custom01
                      (ITMV01_E_NAME, ITMV01_VALUE)
SELECT     itmv01_e_name, new_mboid_itmv01_value
FROM         jobplan_sqn_inserts

insert into insert_history 
select 'tvasqnedm1.sqnedm.dbo.item_mv_custom01'


INSERT INTO tvabfnedm1.bfnedm.dbo.item_mv_custom01
                      (ITMV01_E_NAME, ITMV01_VALUE)
SELECT     itmv01_e_name, new_mboid_itmv01_value
FROM         jobplan_bfn_inserts

insert into insert_history 
select 'tvabfnedm1.bfnedm.dbo.item_mv_custom01'


INSERT INTO chachaedmf1.chaedmf.dbo.item_mv_custom01
                      (ITMV01_E_NAME, ITMV01_VALUE)
SELECT     itmv01_e_name, new_mboid_itmv01_value
FROM         jobplan_fos_inserts

insert into insert_history 
select 'chachaedmf1.chaedmf.dbo.item_mv_custom01'


INSERT INTO chachaedme1.chaedme.dbo.item_mv_custom03
                      (ITMV03_E_NAME, ITMV03_VALUE)
SELECT     itmv03_e_name, new_mboid_itmv03_value
FROM         jobplan_pso_inserts

insert into insert_history 
select 'chachaedme1.chaedme.dbo.item_mv_custom03'


INSERT INTO chachaedmr1.chaedmr.dbo.item_mv_custom01
                      (ITMV01_E_NAME, ITMV01_VALUE)
SELECT     itmv01_e_name, new_mboid_itmv01_value
FROM         jobplan_ro_inserts

insert into insert_history 
select 'chachaedmr1.chaedmr.dbo.item_mv_custom01'


INSERT INTO chachaedmp1.chaedmp.dbo.item_mv_custom01
                      (ITMV01_E_NAME, ITMV01_VALUE)
SELECT     itmv01_e_name, new_mboid_itmv01_value
FROM         jobplan_tva_inserts

insert into insert_history 
select 'chachaedmp1.chaedmp.dbo.item_mv_custom01'


INSERT INTO chachaedmn1.chaedmn.dbo.item_mv_custom01
                      (ITMV01_E_NAME, ITMV01_VALUE)
SELECT     itmv01_e_name, new_mboid_itmv01_value
FROM         jobplan_nuccorp_inserts

insert into insert_history 
select 'chachaedmn1.chaedmn.dbo.item_mv_custom01'


-- Insert JOBPLAN_REPL_INSERTS into REPL ITEM_MV_CUSTOM01 --------

INSERT INTO chachaedmn1.chaedmn.dbo.item_mv_custom01
                      (ITMV01_E_NAME, ITMV01_VALUE)
SELECT     itmv01_e_name_repl, new_mboid_itmv01_value
FROM         jobplan_nuccorp_repl_inserts

insert into insert_history 
select 'chachaedmn1.chaedmn.dbo.item_mv_custom01'


INSERT INTO knxknxedmp1.knxedmp.dbo.item_mv_custom01
                      (ITMV01_E_NAME, ITMV01_VALUE)
SELECT     itmv01_e_name_repl, new_mboid_itmv01_value
FROM         jobplan_tva_repl_inserts

insert into insert_history 
select 'knxknxedmp1.knxedmp.dbo.item_mv_custom01'


INSERT INTO knxknxedmr1.knxedmr.dbo.item_mv_custom01
                      (ITMV01_E_NAME, ITMV01_VALUE)
SELECT     itmv01_e_name_repl, new_mboid_itmv01_value
FROM         jobplan_ro_repl_inserts

insert into insert_history 
select 'knxknxedmr1.knxedmr.dbo.item_mv_custom01'


INSERT INTO knxknxedmr1.knxedmf.dbo.item_mv_custom01
                      (ITMV01_E_NAME, ITMV01_VALUE)
SELECT     itmv01_e_name_repl, new_mboid_itmv01_value
FROM         jobplan_fos_repl_inserts

insert into insert_history 
select 'knxknxedmr1.knxedmf.dbo.item_mv_custom01'


INSERT INTO knxknxedmr1.knxedme1.dbo.item_mv_custom03
                      (ITMV03_E_NAME, ITMV03_VALUE)
SELECT     itmv03_e_name_repl, new_mboid_itmv03_value
FROM         jobplan_pso_repl_inserts

insert into insert_history 
select 'knxknxedmr1.knxedme1.dbo.item_mv_custom03'
--------------------------END INSERTING THE NEW MBOIDs INTO PORDUCTION BSLs (INCLUDING REPLICATION)-------------------------


----------------------------------------------------------------------------------------------------------------------------
--------------------------Create table FINAL_JOBPLANS_INSERTS_COMPARISON----------------------------------------------------

SELECT DISTINCT A.jpnum as JPNUM, B.ITMV01_E_NAME AS E_NAME, B.ITMV01_VALUE AS VALUE
INTO         a_jobplan_inserts_final_compare
FROM         TVABFNEDM1.bfnedm.dbo.item_mv_custom01 AS B 
INNER JOIN   jobplan_bfn_inserts as A
ON           B.ITMV01_E_NAME COLLATE Database_Default = A.itmv01_e_name COLLATE Database_Default AND 
             B.ITMV01_VALUE COLLATE Database_Default = A.old_mboid_itmv01_value COLLATE Database_Default
WHERE     (B.ITMV01_VALUE LIKE '%JOBPLAN%')

INSERT INTO  a_jobplan_inserts_final_compare
SELECT DISTINCT A.jpnum, B.ITMV01_E_NAME, B.ITMV01_VALUE
FROM         TVABFNEDM1.bfnedm.dbo.item_mv_custom01 AS B 
INNER JOIN   jobplan_bfn_inserts as A
ON           B.ITMV01_E_NAME COLLATE Database_Default = A.itmv01_e_name COLLATE Database_Default AND 
             B.ITMV01_VALUE COLLATE Database_Default = A.new_mboid_itmv01_value COLLATE Database_Default
WHERE     (B.ITMV01_VALUE LIKE '%JOBPLAN%')

INSERT INTO  a_jobplan_inserts_final_compare
SELECT DISTINCT A.jpnum, B.ITMV01_E_NAME, B.ITMV01_VALUE
FROM         TVABLNEDM1.blnedm.dbo.item_mv_custom01 AS B 
INNER JOIN   jobplan_bln_inserts as A
ON           B.ITMV01_E_NAME COLLATE Database_Default = A.itmv01_e_name COLLATE Database_Default AND 
             B.ITMV01_VALUE COLLATE Database_Default = A.old_mboid_itmv01_value COLLATE Database_Default
WHERE     (B.ITMV01_VALUE LIKE '%JOBPLAN%')

INSERT INTO  a_jobplan_inserts_final_compare
SELECT DISTINCT A.jpnum, B.ITMV01_E_NAME, B.ITMV01_VALUE
FROM         TVABLNEDM1.blnedm.dbo.item_mv_custom01 AS B 
INNER JOIN   jobplan_bln_inserts as A
ON           B.ITMV01_E_NAME COLLATE Database_Default = A.itmv01_e_name COLLATE Database_Default AND 
             B.ITMV01_VALUE COLLATE Database_Default = A.new_mboid_itmv01_value COLLATE Database_Default
WHERE     (B.ITMV01_VALUE LIKE '%JOBPLAN%')

INSERT INTO  a_jobplan_inserts_final_compare
SELECT DISTINCT A.jpnum, B.ITMV01_E_NAME, B.ITMV01_VALUE
FROM         chachaedmf1.chaedmf.dbo.item_mv_custom01 AS B 
INNER JOIN   jobplan_fos_inserts as A
ON           B.ITMV01_E_NAME COLLATE Database_Default = A.itmv01_e_name COLLATE Database_Default AND 
             B.ITMV01_VALUE COLLATE Database_Default = A.old_mboid_itmv01_value COLLATE Database_Default
WHERE     (B.ITMV01_VALUE LIKE '%JOBPLAN%')

INSERT INTO  a_jobplan_inserts_final_compare
SELECT DISTINCT A.jpnum, B.ITMV01_E_NAME, B.ITMV01_VALUE
FROM         chachaedmf1.chaedmf.dbo.item_mv_custom01 AS B 
INNER JOIN   jobplan_fos_inserts as A
ON           B.ITMV01_E_NAME COLLATE Database_Default = A.itmv01_e_name COLLATE Database_Default AND 
             B.ITMV01_VALUE COLLATE Database_Default = A.new_mboid_itmv01_value COLLATE Database_Default
WHERE     (B.ITMV01_VALUE LIKE '%JOBPLAN%')

INSERT INTO  a_jobplan_inserts_final_compare
SELECT DISTINCT A.jpnum, B.ITMV01_E_NAME, B.ITMV01_VALUE
FROM         chachaedmn1.chaedmn.dbo.item_mv_custom01 AS B 
INNER JOIN   jobplan_nuccorp_inserts as A
ON           B.ITMV01_E_NAME COLLATE Database_Default = A.itmv01_e_name COLLATE Database_Default AND 
             B.ITMV01_VALUE COLLATE Database_Default = A.old_mboid_itmv01_value COLLATE Database_Default
WHERE     (B.ITMV01_VALUE LIKE '%JOBPLAN%')

INSERT INTO  a_jobplan_inserts_final_compare
SELECT DISTINCT A.jpnum, B.ITMV01_E_NAME, B.ITMV01_VALUE
FROM         chachaedmn1.chaedmn.dbo.item_mv_custom01 AS B 
INNER JOIN   jobplan_nuccorp_inserts as A
ON           B.ITMV01_E_NAME COLLATE Database_Default = A.itmv01_e_name COLLATE Database_Default AND 
             B.ITMV01_VALUE COLLATE Database_Default = A.new_mboid_itmv01_value COLLATE Database_Default
WHERE     (B.ITMV01_VALUE LIKE '%JOBPLAN%')

INSERT INTO  a_jobplan_inserts_final_compare
SELECT DISTINCT A.jpnum, B.ITMV01_E_NAME, B.ITMV01_VALUE
FROM         chachaedmr1.chaedmr.dbo.item_mv_custom01 AS B 
INNER JOIN   jobplan_ro_inserts as A
ON           B.ITMV01_E_NAME COLLATE Database_Default = A.itmv01_e_name COLLATE Database_Default AND 
             B.ITMV01_VALUE COLLATE Database_Default = A.old_mboid_itmv01_value COLLATE Database_Default
WHERE     (B.ITMV01_VALUE LIKE '%JOBPLAN%')

INSERT INTO  a_jobplan_inserts_final_compare
SELECT DISTINCT A.jpnum, B.ITMV01_E_NAME, B.ITMV01_VALUE
FROM         chachaedmr1.chaedmr.dbo.item_mv_custom01 AS B 
INNER JOIN   jobplan_ro_inserts as A
ON           B.ITMV01_E_NAME COLLATE Database_Default = A.itmv01_e_name COLLATE Database_Default AND 
             B.ITMV01_VALUE COLLATE Database_Default = A.new_mboid_itmv01_value COLLATE Database_Default
WHERE     (B.ITMV01_VALUE LIKE '%JOBPLAN%')

INSERT INTO  a_jobplan_inserts_final_compare
SELECT DISTINCT A.jpnum, B.ITMV01_E_NAME, B.ITMV01_VALUE
FROM         tvasqnedm1.sqnedm.dbo.item_mv_custom01 AS B 
INNER JOIN   jobplan_sqn_inserts as A
ON           B.ITMV01_E_NAME COLLATE Database_Default = A.itmv01_e_name COLLATE Database_Default AND 
             B.ITMV01_VALUE COLLATE Database_Default = A.old_mboid_itmv01_value COLLATE Database_Default
WHERE     (B.ITMV01_VALUE LIKE '%JOBPLAN%')

INSERT INTO  a_jobplan_inserts_final_compare
SELECT DISTINCT A.jpnum, B.ITMV01_E_NAME, B.ITMV01_VALUE
FROM         tvasqnedm1.sqnedm.dbo.item_mv_custom01 AS B 
INNER JOIN   jobplan_sqn_inserts as A
ON           B.ITMV01_E_NAME COLLATE Database_Default = A.itmv01_e_name COLLATE Database_Default AND 
             B.ITMV01_VALUE COLLATE Database_Default = A.new_mboid_itmv01_value COLLATE Database_Default
WHERE     (B.ITMV01_VALUE LIKE '%JOBPLAN%')

INSERT INTO  a_jobplan_inserts_final_compare
SELECT DISTINCT A.jpnum, B.ITMV01_E_NAME, B.ITMV01_VALUE
FROM         chachaedmp1.chaedmp.dbo.item_mv_custom01 AS B 
INNER JOIN   jobplan_tva_inserts as A
ON           B.ITMV01_E_NAME COLLATE Database_Default = A.itmv01_e_name COLLATE Database_Default AND 
             B.ITMV01_VALUE COLLATE Database_Default = A.old_mboid_itmv01_value COLLATE Database_Default
WHERE     (B.ITMV01_VALUE LIKE '%JOBPLAN%')

INSERT INTO  a_jobplan_inserts_final_compare
SELECT DISTINCT A.jpnum, B.ITMV01_E_NAME, B.ITMV01_VALUE
FROM         chachaedmp1.chaedmp.dbo.item_mv_custom01 AS B 
INNER JOIN   jobplan_tva_inserts as A
ON           B.ITMV01_E_NAME COLLATE Database_Default = A.itmv01_e_name COLLATE Database_Default AND 
             B.ITMV01_VALUE COLLATE Database_Default = A.new_mboid_itmv01_value COLLATE Database_Default
WHERE     (B.ITMV01_VALUE LIKE '%JOBPLAN%')

INSERT INTO  a_jobplan_inserts_final_compare
SELECT DISTINCT A.jpnum, B.ITMV01_E_NAME, B.ITMV01_VALUE
FROM         tvawbnedm1.wbnedm.dbo.item_mv_custom01 AS B 
INNER JOIN   jobplan_wbn_inserts as A
ON           B.ITMV01_E_NAME COLLATE Database_Default = A.itmv01_e_name COLLATE Database_Default AND 
             B.ITMV01_VALUE COLLATE Database_Default = A.old_mboid_itmv01_value COLLATE Database_Default
WHERE     (B.ITMV01_VALUE LIKE '%JOBPLAN%')

INSERT INTO  a_jobplan_inserts_final_compare
SELECT DISTINCT A.jpnum, B.ITMV01_E_NAME, B.ITMV01_VALUE
FROM         tvawbnedm1.wbnedm.dbo.item_mv_custom01 AS B 
INNER JOIN   jobplan_wbn_inserts as A
ON           B.ITMV01_E_NAME COLLATE Database_Default = A.itmv01_e_name COLLATE Database_Default AND 
             B.ITMV01_VALUE COLLATE Database_Default = A.new_mboid_itmv01_value COLLATE Database_Default
WHERE     (B.ITMV01_VALUE LIKE '%JOBPLAN%')

INSERT INTO  a_jobplan_inserts_final_compare
SELECT DISTINCT A.jpnum, B.ITMV03_E_NAME, B.ITMV03_VALUE
FROM         chachaedme1.chaedme.dbo.item_mv_custom03 AS B 
INNER JOIN   jobplan_pso_inserts as A
ON           B.ITMV03_E_NAME COLLATE Database_Default = A.itmv03_e_name COLLATE Database_Default AND 
             B.ITMV03_VALUE COLLATE Database_Default = A.old_mboid_itmv03_value COLLATE Database_Default
WHERE     (B.ITMV03_VALUE LIKE '%JOBPLAN%')

INSERT INTO  a_jobplan_inserts_final_compare
SELECT DISTINCT A.jpnum, B.ITMV03_E_NAME, B.ITMV03_VALUE
FROM         chachaedme1.chaedme.dbo.item_mv_custom03 AS B 
INNER JOIN   jobplan_pso_inserts as A
ON           B.ITMV03_E_NAME COLLATE Database_Default = A.itmv03_e_name COLLATE Database_Default AND 
             B.ITMV03_VALUE COLLATE Database_Default = A.new_mboid_itmv03_value COLLATE Database_Default
WHERE     (B.ITMV03_VALUE LIKE '%JOBPLAN%')

INSERT INTO  a_jobplan_inserts_final_compare
SELECT DISTINCT A.jpnum, B.ITMV03_E_NAME, B.ITMV03_VALUE
FROM         knxknxedmr1.knxedme1.dbo.item_mv_custom03 AS B 
INNER JOIN   jobplan_pso_repl_inserts as A
ON           B.ITMV03_E_NAME COLLATE Database_Default = A.itmv03_e_name COLLATE Database_Default AND 
             B.ITMV03_VALUE COLLATE Database_Default = A.old_mboid_itmv03_value COLLATE Database_Default
WHERE     (B.ITMV03_VALUE LIKE '%JOBPLAN%')

INSERT INTO  a_jobplan_inserts_final_compare
SELECT DISTINCT A.jpnum, B.ITMV03_E_NAME, B.ITMV03_VALUE
FROM         knxknxedmr1.knxedme1.dbo.item_mv_custom03 AS B 
INNER JOIN   jobplan_pso_repl_inserts as A
ON           B.ITMV03_E_NAME COLLATE Database_Default = A.itmv03_e_name COLLATE Database_Default AND 
             B.ITMV03_VALUE COLLATE Database_Default = A.new_mboid_itmv03_value COLLATE Database_Default
WHERE     (B.ITMV03_VALUE LIKE '%JOBPLAN%')

INSERT INTO  a_jobplan_inserts_final_compare
SELECT DISTINCT A.jpnum, B.ITMV01_E_NAME, B.ITMV01_VALUE
FROM         chachaedmn1.chaedmn.dbo.item_mv_custom01 AS B 
INNER JOIN   jobplan_nuccorp_repl_inserts as A
ON           B.ITMV01_E_NAME COLLATE Database_Default = A.itmv01_e_name COLLATE Database_Default AND 
             B.ITMV01_VALUE COLLATE Database_Default = A.old_mboid_itmv01_value COLLATE Database_Default
WHERE     (B.ITMV01_VALUE LIKE '%JOBPLAN%')

INSERT INTO  a_jobplan_inserts_final_compare
SELECT DISTINCT A.jpnum, B.ITMV01_E_NAME, B.ITMV01_VALUE
FROM         chachaedmn1.chaedmn.dbo.item_mv_custom01 AS B 
INNER JOIN   jobplan_nuccorp_repl_inserts as A
ON           B.ITMV01_E_NAME COLLATE Database_Default = A.itmv01_e_name COLLATE Database_Default AND 
             B.ITMV01_VALUE COLLATE Database_Default = A.new_mboid_itmv01_value COLLATE Database_Default
WHERE     (B.ITMV01_VALUE LIKE '%JOBPLAN%')

INSERT INTO  a_jobplan_inserts_final_compare
SELECT DISTINCT A.jpnum, B.ITMV01_E_NAME, B.ITMV01_VALUE
FROM         knxknxedmr1.knxedmf.dbo.item_mv_custom01 AS B 
INNER JOIN   jobplan_fos_repl_inserts as A
ON           B.ITMV01_E_NAME COLLATE Database_Default = A.itmv01_e_name COLLATE Database_Default AND 
             B.ITMV01_VALUE COLLATE Database_Default = A.old_mboid_itmv01_value COLLATE Database_Default
WHERE     (B.ITMV01_VALUE LIKE '%JOBPLAN%')

INSERT INTO  a_jobplan_inserts_final_compare
SELECT DISTINCT A.jpnum, B.ITMV01_E_NAME, B.ITMV01_VALUE
FROM         knxknxedmr1.knxedmf.dbo.item_mv_custom01 AS B 
INNER JOIN   jobplan_fos_repl_inserts as A
ON           B.ITMV01_E_NAME COLLATE Database_Default = A.itmv01_e_name COLLATE Database_Default AND 
             B.ITMV01_VALUE COLLATE Database_Default = A.new_mboid_itmv01_value COLLATE Database_Default
WHERE     (B.ITMV01_VALUE LIKE '%JOBPLAN%')

INSERT INTO  a_jobplan_inserts_final_compare
SELECT DISTINCT A.jpnum, B.ITMV01_E_NAME, B.ITMV01_VALUE
FROM         knxknxedmr1.knxedmr.dbo.item_mv_custom01 AS B 
INNER JOIN   jobplan_ro_repl_inserts as A
ON           B.ITMV01_E_NAME COLLATE Database_Default = A.itmv01_e_name COLLATE Database_Default AND 
             B.ITMV01_VALUE COLLATE Database_Default = A.old_mboid_itmv01_value COLLATE Database_Default
WHERE     (B.ITMV01_VALUE LIKE '%JOBPLAN%')

INSERT INTO  a_jobplan_inserts_final_compare
SELECT DISTINCT A.jpnum, B.ITMV01_E_NAME, B.ITMV01_VALUE
FROM         knxknxedmr1.knxedmr.dbo.item_mv_custom01 AS B 
INNER JOIN   jobplan_ro_repl_inserts as A
ON           B.ITMV01_E_NAME COLLATE Database_Default = A.itmv01_e_name COLLATE Database_Default AND 
             B.ITMV01_VALUE COLLATE Database_Default = A.new_mboid_itmv01_value COLLATE Database_Default
WHERE     (B.ITMV01_VALUE LIKE '%JOBPLAN%')

INSERT INTO  a_jobplan_inserts_final_compare
SELECT DISTINCT A.jpnum, B.ITMV01_E_NAME, B.ITMV01_VALUE
FROM         knxknxedmp1.knxedmp.dbo.item_mv_custom01 AS B 
INNER JOIN   jobplan_tva_repl_inserts as A
ON           B.ITMV01_E_NAME COLLATE Database_Default = A.itmv01_e_name COLLATE Database_Default AND 
             B.ITMV01_VALUE COLLATE Database_Default = A.old_mboid_itmv01_value COLLATE Database_Default
WHERE     (B.ITMV01_VALUE LIKE '%JOBPLAN%')

INSERT INTO  a_jobplan_inserts_final_compare
SELECT DISTINCT A.jpnum, B.ITMV01_E_NAME, B.ITMV01_VALUE
FROM         knxknxedmp1.knxedmp.dbo.item_mv_custom01 AS B 
INNER JOIN   jobplan_tva_repl_inserts as A
ON           B.ITMV01_E_NAME COLLATE Database_Default = A.itmv01_e_name COLLATE Database_Default AND 
             B.ITMV01_VALUE COLLATE Database_Default = A.new_mboid_itmv01_value COLLATE Database_Default
WHERE     (B.ITMV01_VALUE LIKE '%JOBPLAN%')

select distinct *
into FINAL_JOBPLAN_INSERTS_COMPARISON
from a_jobplan_inserts_final_compare
order by jpnum

drop table a_jobplan_inserts_final_compare


--------------------------End create table FINAL_JOBPLANS_INSERTS_COMPARISON------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------

-------------------------verify count of insert to jobplan duplicates and jobplan non duplicate counts----------------------
-------------------------END verify count of insert to jobplan duplicates and jobplan non duplicate counts------------------
----------------------------------------------------------------------------------------------------------------------------

