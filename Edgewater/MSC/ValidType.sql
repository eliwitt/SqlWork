select * from msc_validtype 
where validtypeshort_nm in 
('Account_type',
'Contact_Type',
'Dependent_Type',
'Enroller_Languages',
'Enrollment_Type',
'Industry_Type',
'Product_Type')
order by validtypeshort_nm