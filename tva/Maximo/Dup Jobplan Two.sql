
--
-- examine the current job plans that where converted
--
select * 
from chachaedmt1.chatvaa.dbo.item_mv_custom01
where itmv01_value like 'JOBPLAN:26340'
select * 
from chachaedmt1.chatvaa.dbo.item_mv_custom01
where itmv01_value like 'JOBPLAN:%:%'

--
-- found 
--		JOBPLAN:ACT-11483	12
--		JOBPLAN:GAF-1010	1
--
select * 
from chachaedma1.fosedma1.dbo.item_mv_custom01
where itmv01_value like 'JOBPLAN:ACT-11483'

select * 
from chachaedma1.fosedma1.dbo.item_mv_custom01
where itmv01_value like 'JOBPLAN:%:%'