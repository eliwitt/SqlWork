-- 5.6 groups by enroller id

select distinct grp.company_nm, user_nm,Enroller_ID
from grp_enrollmentperiod gep
inner join grp_group grp
on gep.group_key = grp.group_key
inner join grp_enroller ge
on   ge.EnrollmentPeriod_key = gep.EnrollmentPeriod_key
inner join msc_user mu
on   ge.user_key = mu.user_key
where company_nm = 'USAble Life'
order by company_nm