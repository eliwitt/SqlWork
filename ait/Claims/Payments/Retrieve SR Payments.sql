select payparts.id, cover.[desc], payparts.AmountPaid,
	pay.id, pay.Memo, personaddr.AddressLine1, loczip.CityName + ' ' + loczip.StateAbbr + ' ' + loczip.ZipCode, 
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
where payparts.paymentptr in (SELECT id fROM CLM_Payment
	WHERE Approved = 1 And (pay.Uploaded = 0 Or pay.Uploaded Is null))
order by pay.id,[desc]