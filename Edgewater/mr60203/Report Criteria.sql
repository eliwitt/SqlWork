select * from 
	msc_criteria cri
	join msc_reportcriteria  rcri on rcri.criteria_key = cri.criteria_key
where rcri.report_key in (select report_key from msc_report where report_nm = 'Production Report Detail')
order by rcri.reportcriteria_seq