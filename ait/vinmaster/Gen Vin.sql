--
-- by using the wildcards _ % I can found the vins using the ISO input
--
select *
from vinlookup_0510
where model like 'Boxster%' or model like 'Carrera%'
order by year
--
--	where vin like 'WP0CA298_5%'  where model in ('Boxster', 'Carrera GT')
--	where model like 'Boxster%' or model like 'Carrera%'
--	where style_raw like 'SED4X24D' or style_raw like 'SED4X44D'
--
--  JA3AB36F%  worked
--  5GZ_Z534_7 is from my vin 5GZCZ53467... the VUE
--  WP0CA298&5 Porsche is causing problems
--  JA4_S21W% or JA4%S21W% did not find anything it works i tried it with JA3AB_6F%