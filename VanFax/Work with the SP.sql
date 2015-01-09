/*
update Order_Item set Status = 'O' where Order_Number = 2 and ProdRef = 'DW01191'
update Order_Item set Status = 'O' where Order_Number = 2 and ProdRef = 'DW01192'
update Order_Item set Status = 'C' where Order_Number = 2 and ProdRef = 'DW01193'
*/
exec edg_sp_SetItemStatus 2,'DW01192','O'
select * from Order_Master
select * from Order_Item