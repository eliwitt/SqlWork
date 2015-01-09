select 'NUC' as site, i.ina_name, a.ai_name, a.ai_tablename, a.ai_length
from chachaedmt1.chatvaa.dbo.ina_info i, chachaedmt1.chatvaa.dbo.attr_info a
where i.ina_attr_no = a.ai_id
--order by i.ina_name
order by a.ai_name