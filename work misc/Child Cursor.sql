-- local variables
declare @kid as int
declare @id as int
set @id = 3402

declare Child scroll cursor for
select distinct ChildShopId
from 
edg_tbl_Parentshoprelations
where
parentshopid = @id and
not (childshopid = @id)

open Child
fetch first from Child into @kid
while @@fetch_status = 0
	begin
		exec edg_sp_GetSubscriberById @kid
		fetch next from Child into @kid
end
close Child
deallocate Child