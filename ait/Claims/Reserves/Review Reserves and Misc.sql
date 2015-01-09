select pay.id, pay.memo, pay.PaymentDateTime, pay.PaymentGrossAmount,
MAX( CASE seq WHEN 1 THEN Coveragename + ' ' ELSE '' END )  + 
MAX( CASE seq WHEN 2 THEN Coveragename + ' ' ELSE '' END )  + 
MAX( CASE seq WHEN 3 THEN Coveragename + ' ' ELSE '' END )  + 
MAX( CASE seq WHEN 4 THEN Coveragename + ' ' ELSE '' END )  + 
MAX( CASE seq WHEN 5 THEN Coveragename + ' ' ELSE '' END )  +
MAX( CASE seq WHEN 6 THEN Coveragename + ' ' ELSE '' END )  + 
MAX( CASE seq WHEN 7 THEN Coveragename + ' ' ELSE '' END )  +
MAX( CASE seq WHEN 8 THEN Coveragename + ' ' ELSE '' END )  +
MAX( CASE seq WHEN 9 THEN Coveragename + ' ' ELSE '' END )  + 
MAX( CASE seq WHEN 10 THEN Coveragename + ' ' ELSE '' END ) as reslist, 
case when (cast(case when pay.Issued is null then 0 else pay.Issued end as char(1)) + 
cast(case when pay.Uploaded is null then 0 else pay.Uploaded end as char(1)) + 
cast(case when pay.Approved is null then 0 else pay.Approved end as char(1)) +
cast(case when pay.Voided is null then 0 else pay.Voided end as char(1))) = 1 then 'Voided' 
when (cast(case when pay.Issued is null then 0 else pay.Issued end as char(1)) + 
cast(case when pay.Uploaded is null then 0 else pay.Uploaded end as char(1)) +
cast(case when pay.Approved is null then 0 else pay.Approved end as char(1)) +
cast(case when pay.Voided is null then 0 else pay.Voided end as char(1))) = 10 then 'Approved' 
when (cast(case when pay.Issued is null then 0 else pay.Issued end as char(1)) + 
cast(case when pay.Uploaded is null then 0 else pay.Uploaded end as char(1)) + 
cast(case when pay.Approved is null then 0 else pay.Approved end as char(1)) + 
cast(case when pay.Voided is null then 0 else pay.Voided end as char(1))) = 11 then 'Voided' 
when (cast(case when pay.Issued is null then 0 else pay.Issued end as char(1)) + 
cast(case when pay.Uploaded is null then 0 else pay.Uploaded end as char(1)) + 
cast(case when pay.Approved is null then 0 else pay.Approved end as char(1)) + 
cast(case when pay.Voided is null then 0 else pay.Voided end as char(1))) = 100 then 'Uploaded' 
when (cast(case when pay.Issued is null then 0 else pay.Issued end as char(1)) + 
cast(case when pay.Uploaded is null then 0 else pay.Uploaded end as char(1)) + 
cast(case when pay.Approved is null then 0 else pay.Approved end as char(1)) + 
cast(case when pay.Voided is null then 0 else pay.Voided end as char(1))) = 101 then 'Voided' 
when (cast(case when pay.Issued is null then 0 else pay.Issued end as char(1)) + 
cast(case when pay.Uploaded is null then 0 else pay.Uploaded end as char(1)) + 
cast(case when pay.Approved is null then 0 else pay.Approved end as char(1)) + 
cast(case when pay.Voided is null then 0 else pay.Voided end as char(1))) = 110 then 'Uploaded' 
when (cast(case when pay.Issued is null then 0 else pay.Issued end as char(1)) + 
cast(case when pay.Uploaded is null then 0 else pay.Uploaded end as char(1)) + 
cast(case when pay.Approved is null then 0 else pay.Approved end as char(1)) + 
cast(case when pay.Voided is null then 0 else pay.Voided end as char(1))) = 111 then 'Voided' 
when (cast(case when pay.Issued is null then 0 else pay.Issued end as char(1)) + 
cast(case when pay.Voided is null then 0 else pay.Voided end as char(1))) = 11 then 'Voided' 
when (cast(case when pay.Issued is null then 0 else pay.Issued end as char(1)) + 
cast(case when pay.Voided is null then 0 else pay.Voided end as char(1))) = 10 then 'Issued'
else 'Requested' end status 
from clm_payment pay 
	join clm_paymentparts parts on pay.id = parts.paymentptr 
    left join ( SELECT p1.id, p1.claimnumber, 
			case p1.Coverageid when 1 then 'LIPD' 
			when 2 then 'LIBI' 
			when 3 then 'COMP' 
			when 4 then 'COLL'	
			when 5 then 'TOWING'
			when 6 then 'RENTAL'
			when 7 then 'MED'	
			when 8 then 'UMBI' 
			when 9 then 'UMPD' end Coveragename, 
                    ( SELECT COUNT(*)
                        FROM clm_reserve p2 
        WHERE(p2.claimnumber = p1.claimnumber) 
                         AND p2.Coverageid <= p1.Coverageid 
						and p1.amountpaid is not null) 
               FROM clm_reserve p1 ) D ( id, claimnumber, Coveragename, seq ) on pay.claimptr = d.claimnumber and parts.reserveptr = d.id 
where pay.claimptr = 148
     GROUP BY pay.id, pay.memo, pay.PaymentDateTime, pay.PaymentGrossAmount,pay.Voided, pay.Approved, pay.Uploaded, pay.Issued 
select * from clm_reserve where claimnumber = 148
--if (select AmountPaid from clm_reserve where id = 1012) is null
--	update clm_reserve set AmountPaid = 510 where id = 861 
--else
--	update clm_reserve set AmountPaid = AmountPaid + 100 where id = 1012
