creATE PROCEDURE edg_sp_SetItemStatus
@OrderId int,
@ProdRef varchar(10),
@status char(1)
as
update Order_Item set Status = @status
where Order_Number = @OrderId and ProdRef = @ProdRef
exec edg_sp_SetOrderStatus @OrderId