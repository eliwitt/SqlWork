--
--  find claims with at least one reserve left open
--
select cm.reservesclosed, re.claimnumber, count(re.id)
from clm_claimmaster cm 
	join clm_reserve re on re.claimnumber = cm.id
where re.reserveopen = 1
group by cm.reservesclosed, re.claimnumber
--
-- for the given claim does it have all reserves closed
--
declare @closePtr int
set @closePtr = 22
if (
select count(re.id)
from clm_reserve re 
where re.claimnumber = @closePTR and re.reserveopen = 1
) = 0
	select * from clm_claimmaster where id = @closePtr
--
-- look for closed claims
--
select * from clm_claimmaster where reservesclosed  = 1
	