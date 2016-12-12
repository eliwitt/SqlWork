--
--  look for MO detail and attrs
--  BUL -  541514  WO SSP - 541584  WO BUL - 541587
-- SSP - 541576 Jr 513498
--
select rtrim(olcuno) cust, olorno, olline, rtrim(olprdc) prdcode, rtrim(ohcope) advertiser, rtrim(ohhand) csr, 
	rtrim(substring(ulcpar, 7)) email, Aya4nb, ayqty, rtrim(oldesc) Product, rtrim(olshpm) design, 
	rtrim(boshce) item, boyvcd, boyxcd, boogqt
from vt2662afvp.mfmohr MFG
	left join vt2662afvp.sroorspl theLine on MFG.aybmnb = theLine.olorno and MFG.aywdnb = theLine.olline
	left join vt2662afvp.sroorshe sohdr on mfg.aybmnb = sohdr.ohorno
	left join VT2662AFVP.SROUSP userpro on sohdr.ohhand = UPHAND
	left join VT2662AFVP.SROCLL usercon on  '*USERPROF' = ULUCTP AND 'MAIL' = ULCLNT AND userpro.upuser = ULUSER
	left join vt2662afvp.mfcisa PrdAttr on theLine.olprdc = PrdAttr.boshce
where aya4nb = 541732;
