--exec sp_resetpayment 1, 518, 156
--exec sp_theTestScript 230, 517
declare @myint int
set @myint = 515
--update clm_payment set checknu = replace(str(@myint, 10, 0), ' ', '0'), issued = 0, uploaded = 0, approved = 0, voided = 1 where id = 156
select * from clm_payment where id = 156
--select * from clm_payment where checknu is not null
--select * from clm_paymentparts where paymentptr = 156
--select * from clm_reserve where id = 961
--update clm_reserve set amountpaid= 50 where id = 961
--update clm_payment set checknu = null, voided = 0, Approved = 1, uploaded = 1, voideddatetime = null
--
--     current issued issued void issued
--
select parts.id, parts.AmountPaid, pay.paymentgrossamount, pay.id, pay.checknu, pay.PaymentDateTime,
res.id, res.ReserveOpen, res.AmountPaid, res.ClosedOn
from CLM_PaymentParts parts
 join clm_payment pay on parts.paymentptr = pay.id
 left join clm_reserve res on parts.ReservePTR = res.id
where parts.id in (13850, 13854, 13856, 13861, 13862, 13873, 13874, 13884, 13892, 13962, 13970)
order by parts.id
select * from CLM_Payment where id in (13944, 13948, 13950, 13955, 13956, 13967, 13968, 13978, 13986, 14056, 14064)
--exec sp_manuallyissuepayment 13856, 61123, '06-03-2011'
--exec sp_manuallyissuepayment 13861, 61124, '06-03-2011'
--exec sp_manuallyissuepayment 13862, 61125, '06-03-2011'
--exec sp_manuallyissuepayment 13873, 61126, '06-03-2011'
--exec sp_manuallyissuepayment 13874, 61127, '06-03-2011'
--exec sp_manuallyissuepayment 13884, 61128, '06-03-2011'
--exec sp_manuallyissuepayment 13892, 61129, '06-03-2011'
--exec sp_manuallyissuepayment 13962, 61130, '06-03-2011'
--exec sp_manuallyissuepayment 13970, 61131, '06-03-2011'