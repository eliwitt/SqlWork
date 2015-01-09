--
-- find the claim by the claimnumber
-- claims under research 33896-02-19-2011 24865-2-12-05-2010 40473-01-15-2011 7987-2-01-20-2011
--
declare @claimptr int
select @claimptr = id from clm_claimmaster where claimnumber = '39810-02-22-2011'
----update clm_payment set voided = 0, voideddatetime = null where id = 61
select * from clm_claimmaster where id = @claimptr
--
-- look at the payments for this claim
select * from clm_payment where claimptr = @claimptr
--
-- the payment parts
select * from clm_paymentparts where paymentptr in (select id from clm_payment where claimptr = @claimptr)
--
-- the reserves
--select * from clm_reserve where id = 8928
--select id, amountpaid, reserveopen, closedon from clm_reserve 
--	where id in (select reserveptr from clm_paymentparts where paymentptr = 3414)
--
--select * from clm_reserve where claimnumber = 3328
--
-- misc select statements
--
--select * from clm_claimmaster where claimnumber = '18145-2-12-19-2010'
--select id from clm_payment where id = 41 and (rejected = 0 or rejected is null)
--select * from clm_payment where id = 41
--update clm_payment set rejected = 0 where id = 3414
--exec sp_resetpayment 2, 3414
--exec sp_resetpayment 1, 41
--update clm_reserve set AmountPaid = AmountPaid - (
--	select amountpaid from clm_paymentParts where paymentptr = 41), 
--ReserveOpen = 1, ClosedOn = null 
--where id in (
--select reserveptr from clm_paymentParts where paymentptr = 41) 
--select * from clm_payment where claimptr = (select id from clm_claimmaster where claimnumber = '18145-2-12-19-2010')
--select * from clm_payment where rejected = 1
--
-- who edited the claim
--select * from clm_claimlog where claimid = 1561 order by datestamp desc
--
--
--select id, claimptr , paymentgrossamount, issued, uploaded, approved, voided, rejected
--	from clm_payment where id in (select paymentptr from clm_paymentparts where id in (3382, 3383,3570,3542,3459))
--
--select * from clm_paymentparts where id in (3570,3542, 3459)