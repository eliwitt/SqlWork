select aya4nb, ayavst, aybmnb, aywdnb, ayaavn, ayprdc, aybpnb, aybkcd, aybrnb 
from vt2662afvp.mfmohr where aya4nb in (
482733, 483792, 483835, 483836, 483869, 483886, 483890, 483910, 483911, 483929,
483902, 483859, 483862, 483930, 483889, 483742, 483882, 483758, 483867, 483868,
483915, 483578, 483757, 483925, 483787
) order by aya4nb

-- look at the status on the web

select olorno, olline, olcuno, olords, aya4nb as "MFG NU", ayavst, aybrnb, aybpnb, thz3delv, thz3crrc, thz3pstc,
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
from vt2662afvp.sroorspl OLine
	left join vt2662afvp.mfmohr MFG on Oline.olorno = MFG.aybmnb and Oline.olline = MFG.aywdnb
	left join vt2662afvp.z3optrh FedHdr on OLine.OLorno = FedHdr.Thorno and OLine.olline = FedHdr.THline and thstat <> 'D'
where aya4nb in (
482733, 483792, 483835, 483836, 483869, 483886, 483890, 483910, 483911, 483929,
483902, 483859, 483862, 483930, 483889, 483742, 483882, 483758, 483867, 483868,
483915, 483578, 483757, 483925, 483787
) order by aya4nb

/* update those that are stuck

update  vt2662afvp.mfmohr set aybrnb = 3  where aya4nb in (
482733, 483792, 483835, 483836, 483869, 483886, 483890, 483910, 483911, 483929,
483902, 483859, 483862, 483930, 483889, 483742, 483882, 483758, 483867, 483868,
483915, 483578, 483757, 483925, 483787
)

*/