select aud.User_nm, aud.audit_dttm, audtab.table_nm,
audtab.recorddescription_nm, auddet.column_nm,
auddet.oldvalue_txt, auddet.newvalue_txt
from msc_audit aud
left join msc_audittable audtab on aud.audit_key = audtab.audit_key
left join msc_auditdetail auddet on audtab.audittable_key = auddet.audittable_key
where aud.audit_dttm > '2007-02-25 23:59:59.000' and
aud.primarytable_nm = 'EMP_Person' and 
audtab.recorddescription_nm like 'Harless%' and
auddet.column_nm like 'AddressLine%'
order by aud.audit_dttm