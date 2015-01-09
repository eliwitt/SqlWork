create  PROCEDURE edg_sp_SetOrderStatus
@OrderId int
as
declare	@Itemstat char (1),
	@Openstat char(1), 
	@Complete char(1)

set @Openstat = ''
set @Complete = ''

declare OItems scroll cursor for
select Status
from 
Order_Item
where
Order_Number = @OrderId

open OItems
fetch first from OItems into @Itemstat
while @@fetch_status = 0
	begin
		if (@Itemstat = 'O')
			begin
			set @Openstat = 'O'
		end
		if (@Itemstat = 'C')
			begin
			set @Complete = 'C'
		end
		fetch next from OItems into @Itemstat
end
close OItems
deallocate OItems
if ((@Openstat = 'O') and (@Complete = 'C'))
	update Order_Master set Status = 'P' where Order_Number = @OrderId
else
	if ((@Openstat = '') and (@Complete = 'C'))
		update Order_Master set Status = 'C' where Order_Number = @OrderId
	else
		update Order_Master set Status = 'O' where Order_Number = @OrderId