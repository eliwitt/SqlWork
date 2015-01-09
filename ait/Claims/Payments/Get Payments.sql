declare @partsid int, @claimnu nvarchar(18)
set @partsid = 1842
set @claimnu = '25683-10-04-2010'

select Payment.id, PaymentDateTime, PaymentGrossAmount, Memo, addr.addressline1, 
	zipper.cityname + ', ' + zipper.StateAbbr location, zipper.zipcode, 
	parts.amountPaid, closesReserve, res.id,  [desc], res.amountpaid
 from clm_payment payment
	left join clm_paymentparts parts on payment.id = parts.paymentptr
	left join clm_address addr on payment.addressptr = addr.id
	left join zipinfo zipper on addr.zipinfoptr = zipper.id
	left join clm_reserve res on parts.reserveptr = res.id
	left join clm_coverage cover on res.coverageid = cover.id
where parts.id = @partsid

select parts.id, payment.id, payment.checknu,
	payment.issued, uploaded, approved, payment.voided, parts.issued
 from clm_payment payment
	left join clm_paymentparts parts on payment.id = parts.paymentptr
	left join clm_address addr on payment.addressptr = addr.id
	left join zipinfo zipper on addr.zipinfoptr = zipper.id
	left join clm_reserve res on parts.reserveptr = res.id
	left join clm_coverage cover on res.coverageid = cover.id
where parts.id = @partsid and payment.id = parts.paymentptr


Select pp.id
	from clm_paymentparts pp
	join clm_payment pm on pp.paymentptr = pm.id
	join clm_claimmaster cm on pm.claimptr = cm.id
	where pp.id = @partsid
		and @claimnu = cm.claimnumber

select payparts.id, pay.id payid, pay.voided 
   from clm_paymentparts payparts 
   join clm_payment pay on payparts.paymentptr = pay.id 
   where payparts.id = @partsid
--update clm_reserve set AmountPaid = AmountPaid - 8.99
--where id = 569
--
--select parts.amountpaid, max(case seq when 1 then reserve.coverageid else '' end) + ', ' + max(case seq when 2 then reserve.coverageid else '' end)
--	from clm_paymentparts parts
--	join clm_reserve reserve on parts.reserveptr = reserve.id
--where paymentptr = 1
--group by parts.amountpaid
----
--select res1.id, res1.coverageid, 
--			(select count(*) from clm_reserve res2 where res1.id = res2.id and res2.coverageid <= res1.coverageid)
--				from clm_reserve res1 where res1.id in (45,47)
--
----select * from clm_reserve where id in (45, 47)
--select PaymentDateTime, PaymentGrossAmount, person.Firstname + ' ' + person.lastname Payee, 
--	max( case seq when 1 then rescoverage.coverageid else ' ' end ) + ', ' +
--	max( case seq when 2 then rescoverage.coverageid else ' ' end ) + ', ' + 
--	max( case seq when 3 then rescoverage.coverageid else ' ' end ) + ', ' +
--	max( case seq when 4 then rescoverage.coverageid else ' ' end ) + ', ' +
--	max( case seq when 5 then rescoverage.coverageid else ' ' end ) + ', ' +
--	max( case seq when 6 then rescoverage.coverageid else ' ' end ) coverage
-- from clm_payment payment
--	join clm_person person on payment.personptr = person.id
--	join clm_paymentparts payparts on payment.id = payparts.paymentptr
--	join (select res1.id, 
--			case res1.coverageid when 1 then 'LIPD'
--				when 2 then 'LIPB'
--				when 4 then 'COLL'
--				when 5 then 'TOWG'
--				when 6 then 'RENTAL' end coverageid, 
--			(select count(*) from clm_reserve res2 where res2.id = res1.id and res2.coverageid <= res1.coverageid) seq
--				from clm_reserve res1) rescoverage on payparts.reserveptr = rescoverage.id
--where claimptr = 9
--group by PaymentDateTime, PaymentGrossAmount, person.Firstname, person.lastname
--
