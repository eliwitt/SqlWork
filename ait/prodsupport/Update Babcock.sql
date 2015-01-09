select paymentptr from clm_paymentparts where id in (2624, 2625, 2626, 2629, 2631, 2633, 2634, 2635, 2636, 2637, 2638,
2639, 2640, 2642, 2643, 2644, 2651, 2652, 2653)


--update clm_payment set GoAutVendor = 'LAE 1099' where id in(
--select paymentptr from clm_paymentparts where id in (2624, 2625, 2626, 2629, 2631, 2633, 2634, 2635, 2636, 2637, 2638,
--2639, 2640, 2642, 2643, 2644, 2651, 2652, 2653)
--)

select * from clm_payment where id in(
select paymentptr from clm_paymentparts where id in (2624, 2625, 2626, 2629, 2631, 2633, 2634, 2635, 2636, 2637, 2638,
2639, 2640, 2642, 2643, 2644, 2651, 2652, 2653))

select distinct payparts.id invnu, cover.[desc], payparts.AmountPaid, claimdata.claimnumber, 
	pay.id, personaddr.AddressLine1, loczip.CityName, loczip.StateAbbr, loczip.ZipCode,  
	pay.PayName, pay.PayVoucherRef, pay.PaySundry, pay.PayCkDesc, pay.PayTxnId, 
   pay.PaymentGrossAmount, pay.GoAutoVendor, convert(nvarchar(10), pay.PaymentDateTime, 101) PaymentDateTime 
	From CLM_PaymentParts payparts 
    Join CLM_Reserve reserve 
		On payparts.ReservePTR = reserve.id  
    Join CLM_Coverage cover 
		On reserve.CoverageID = cover.id 
	join CLM_Payment pay  
		on payparts.paymentptr = pay.id 
    Join CLM_Address personaddr 
		On pay.AddressPTR = personaddr.ID 
    Join ZipInfo loczip 
		On personaddr.ZipInfoPTR = loczip.ID 
    Join CLM_claimmaster claimdata 
		On pay.claimPTR = claimdata.id  
where payparts.paymentptr = 2653
 order by claimnumber 