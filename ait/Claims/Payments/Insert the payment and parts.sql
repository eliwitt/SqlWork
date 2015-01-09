exec sp_insertPayment 1, '23', '04/21/2010', 500.23, 'Steve', 'Witt', '12345 Testing', 123456
exec sp_insertpaypart 1, 2, 50.23, 0
delete from clm_person where id = 47
delete from clm_address where id = 95
delete from clm_payment where id = 1
delete from clm_paymentparts where id = 1