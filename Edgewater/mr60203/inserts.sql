select * from  msc_reportcriteria 
where report_key in (select report_key from msc_report where report_nm = 'Production Report Detail')
order by reportcriteria_seq

delete msc_reportcriteria where report_key = (select report_key from msc_report where report_nm = 'Production Report Detail')
declare @rpt_key uniqueidentifier, @cri_key uniqueidentifier
select @rpt_key = report_key from msc_report where report_nm = 'Production Report Detail'
select @cri_key = criteria_key from msc_criteria where parameter_nm = 'Enrollment Dates'
insert into msc_reportcriteria (report_key, criteria_key, reportcriteria_seq)
	values(@rpt_key, @cri_key, 0)
select @cri_key = criteria_key from msc_criteria where parameter_nm = 'All Groups'
insert into msc_reportcriteria (report_key, criteria_key, reportcriteria_seq)
	values(@rpt_key, @cri_key, 1)
select @cri_key = criteria_key from msc_criteria where parameter_nm = 'Division'
insert into msc_reportcriteria (report_key, criteria_key, reportcriteria_seq)
	values(@rpt_key, @cri_key, 2)
select @cri_key = criteria_key from msc_criteria where parameter_nm = 'Enrollment Period'
insert into msc_reportcriteria (report_key, criteria_key, reportcriteria_seq)
	values(@rpt_key, @cri_key, 3)
select @cri_key = criteria_key from msc_criteria where parameter_nm = 'Disable Report Header/Footer'
insert into msc_reportcriteria (report_key, criteria_key, reportcriteria_seq)
	values(@rpt_key, @cri_key, 4)