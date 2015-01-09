declare @thePart int
set @thePart = 110
select payparts.id, pay.id, pay.voided, payparts.amountpaid,
	res.id, res.amountpaid
   from clm_paymentparts payparts 
   join clm_payment pay on payparts.paymentptr = pay.id 
	join clm_reserve res on payparts.reserveptr = res.id
   where pay.voided = 1 And payparts.id = @thePart
select * from clm_payment where id = 74
--update clm_payment set voided = 0 where id in (61, 74)
set @thePart = 97
select payparts.id, pay.id, pay.voided, payparts.amountpaid,
	res.id, res.amountpaid
   from clm_paymentparts payparts 
   join clm_payment pay on payparts.paymentptr = pay.id 
	join clm_reserve res on payparts.reserveptr = res.id
   where pay.voided = 1 And payparts.id = @thePart
select * from clm_payment where id = 61
--update clm_reserve set amountpaid = 3547.67 where id = 569
--update clm_reserve set AmountPaid = AmountPaid - (
--	select amountpaid from clm_paymentParts where id = @thePart), 
--ReserveOpen = 1, ClosedOn = null  
--where id = (
--select reserveptr from clm_paymentParts where id = @thePart)
--select payparts.id, pay.id, pay.voided, payparts.amountpaid,
--	res.id, res.amountpaid
--   from clm_paymentparts payparts 
--   join clm_payment pay on payparts.paymentptr = pay.id 
--	join clm_reserve res on payparts.reserveptr = res.id
--   where pay.voided = 1 And payparts.id = @thePart