select olorno, olline, olcuno, olords, aya4nb as "MFG NU", ayavst, aybrnb, aybpnb, thz3delv, thz3crrc, thz3pstc, thz3eddt, thcstrcn,
 	case
		when olords = 10 then '00500-Not Confirmed'
		when olords = 30 then '7000-Finished'
		when olords = 45 and thcstrcn like 'delivered%' then '9000-Order Delivered'
		when olords = 45 and thz3delv = 'Y' then '9000-Order Delivered'
		when olords = 45 and thz3delv = '' then '8000-Order Shipped'
		when olords = 45 and thz3delv = 'N' then '8000-Order Shipped'
		when olords = 60 and thz3delv = 'Y' then '9000-Order Delivered'
		when olords = 60 and thcstrcn like 'delivered%' then '9000-Order Delivered'
		when olords = 60 and thz3delv = '' then '8000-Order Shipped'
		when olords = 60 and thz3delv = 'N' then '8000-Order Shipped'
		when olords = 20 and ayavst = '10' and aybrnb = 0 and aybpnb = 0 then '1000-Please upload art'
		when olords = 20 and ayavst = '20' and aybrnb = 0 and aybpnb = 0 then '1000-Please upload art'
		when olords = 20 and ayavst = '20' and aybrnb = 0 and aybpnb = 10 then '1000-Please upload art'
		when olords = 20 and ayavst = '40' and aybrnb = 0 and aybpnb = 10 then '2000-Order Confirmation'
		when olords = 20 and ayavst = '40' and aybrnb = 1 and aybpnb = 10 then '3000-Ready 4 Approval'
		when olords = 20 and ayavst = '40' and aybrnb = 1 and aybpnb = 15 then '3000-Ready 4 Approval'
		when olords = 20 and ayavst = '40' and aybrnb = 2 and aybpnb = 15 then '4000-Proof Approved'
		when olords = 20 and ayavst = '40' and aybrnb = 2 and aybpnb = 18 then '4000-Proof Approved'
		when olords = 20 and ayavst = '40' and aybrnb = 3 and aybpnb = 18 then '5000-Ripped'
		when olords = 20 and ayavst = '40' and aybrnb = 3 and aybpnb = 20 then '5000-Ripped'
		when olords = 20 and ayavst = '40' and aybrnb = 4 and aybpnb = 20 then '6000-Printed'
		when olords = 20 and ayavst = '40' and aybrnb = 4 and aybpnb = 30 then '6000-Printed'
		when olords = 20 and ayavst = '60' and aybrnb = 5 and aybpnb = 30 then '7000-Finished'
		when olords = 20 and ayavst = '60' and aybrnb = 6 and aybpnb = 30 then '7000-Finished'
		when olords = 45 and ayavst = '60' and aybrnb = 5 and aybpnb = 30 then '8000-Order Shipped'
		else 'Undefined'
	end Status
from vt2662aftt.sroorspl OLine
	left join vt2662aftt.mfmohr MFG on Oline.olorno = MFG.aybmnb and Oline.olline = MFG.aywdnb
	left join vt2662aftt.z3optrh FedHdr on OLine.OLorno = FedHdr.Thorno and OLine.olline = FedHdr.THline and thstat <> 'D'
where olorno in (10058444, 10058446)
order by olcuno;


--update  vt2662aftt.mfmohr set ayavst = '40', aybrnb = 1, aybpnb = 10 where aya4nb = 291749  -- please approve proof
--update vt2662aftt.z3optrh set thz3delv = 'N' where Thorno = 10058321 and THline = 10
--select * from vt2662aftt.sropix where pxplno = 2044522
--select * from vt2662aftt.sroorspl where olorno = 10058321
--update  vt2662aftt.sroorspl set olplno = 2044522 where olorno = 10058321
--select * from vt2662aftt.sropix where pxorno > 10058100;
--select * from vt2662aftt.sroofl where oforno in (10058444, 10058446);
select * from  vt2662afvp.z3optrh where thcstrcn = '639685052271';
--update vt2662afvp.z3optrh set thorno = '10058444', thz3shpr = '10058444_1' where thcstrcn = '639685052271';
--update vt2662afvp.z3optrh set thplno = 2044524 where thcstrcn = '639685052271';
--insert into vt2662aftt.sroofl (oflid1, oforno, ofdate, oftime, oflid2, ofstat, ofz3entd) values('SO', '10058444', 20150609, 133900, 'TS', '', '639685052271');
--update vt2662aftt.sroofl set oftime = 143900 where oforno = '10058444' and ofz3entd = '639685052271';
--insert into vt2662aftt.sropix (pxplno, pxorno) values(2044524, 10058444);
--update vt2662aftt.sroorspl set olords = 45 where olorno = 10058444