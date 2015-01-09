declare @order int
insert Order_Master values ('POtestOne', GETDATE(), 'Jsw', 'O', 'To be or not to be')
select @order=@@IDENTITY
insert Order_Item values (@order, 'DW01191', 'Test Item one', 'UN', 'UN', 5, 10.00, 'O')
insert Order_Item values (@order, 'DW01192', 'Test Item two', 'UN', 'UN', 3, 5.00, 'O')
insert Order_Item values (@order, 'DW01193', 'Test Item three', 'UN', 'UN', 1, .57, 'O')