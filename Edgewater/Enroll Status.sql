update msc_validvalue set validvalue_nm = 'Enrolled'
where validvalue_vv = 'ENROLLED' and
	validtype_key = (select validtype_key from msc_validtype where validtypeshort_nm = 'Enroll_Status')