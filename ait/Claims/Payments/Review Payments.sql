select *
from clm_payment 
where claimptr = 104 
and (paymentdatetime > '6/11/2010 9:23:49 AM' and paymentdatetime < '6/11/2010 9:23:50 AM')

select * from clm_paymentParts where PaymentPtr = 44
select * from clm_reserve where claimnumber = 104
--exec sp_voidreservepayments 104, '6/11/2010 9:23:49 AM', '6/11/2010 9:23:50 AM'