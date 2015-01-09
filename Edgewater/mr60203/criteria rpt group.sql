select report_nm, c.parameter_nm, c.displaymodule_nm
from msc_report rpt
	join msc_reportcriteria rptc
		on rpt.report_key = rptc.report_key
	join msc_criteria c
		on rptc.criteria_key = c.criteria_key
order by report_nm, reportcriteria_seq