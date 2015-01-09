-- search for conflicts
select Employee_key, EmployeeProductStatus_vv,
LastPhase_vv, conflict_type, reason_code, reason_text
from [conflict_Group Employee Data Merge_EMP_EmployeeProduct]
where MSrepl_create_time > '2007-02-25'