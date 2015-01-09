--set Rowcount 100
-- to reset rowcount then use the following: set rowcount 0
declare @ClaimPtr int, @VehCnt int
declare VehProblm cursor for
select claimmasterptr, count(vehiclenumber)
from clm_claimvehicle 
group by claimmasterptr

open VehProblm
fetch next from VehProblm into @ClaimPtr, @VehCnt
while (@@fetch_status = 0)
begin
    -- does the claim have more than two vehicles
	--
	if @VehCnt > 2
		if exists(select vehiclenumber  from clm_claimvehicle where claimmasterptr = @ClaimPtr group by vehiclenumber having count(vehiclenumber) > 1)
			select * from clm_claimvehicle where claimmasterptr = @ClaimPtr

	fetch next from VehProblm into @ClaimPtr, @VehCnt
end
close VehProblm
deallocate VehProblm
