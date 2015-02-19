select distinct ohcuno, oaname, ohcope, olshpm, ohodat, olprdc as itemno, oldesc, olmotc as Shpmth, aya0dt as TGTSDT, oldsdt as ACTSDT,
    olrdvd as TGTDLD, pdz3pddt as ACTDLD, pdz3podn as rcvdby, thcstrcn, ohoref as ponum, ohorno as Ordno, olline as ORLine,
    updesc as CSRNam, substring(ulcpar, 7) as CSREmail,
 	case 
		when olords = 10 then '00500' 
 		when olords = 30 then '7000' 
		when olords = 45 and thcstrcn like 'delivered%' then '9000' 
		when olords = 45 and thz3delv = 'Y' then '9000' 
		when olords = 45 and thz3delv = '' then '8000' 
		when olords = 45 and thz3delv = 'N' then '8000' 
 		when olords = 60 and thz3delv = 'Y' then '9000' 
		when olords = 60 and thcstrcn like 'delivered%' then '9000' 
		when olords = 60 and thz3delv = '' then '8000' 
		when olords = 60 and thz3delv = 'N' then '8000' 
 		when olords = 20 and ayavst = '10' and aybrnb = 0 and aybpnb = 0 then '1000' 
		when olords = 20 and ayavst = '20' and aybrnb = 0 and aybpnb = 0 then '1000' 
		when olords = 20 and ayavst = '20' and aybrnb = 0 and aybpnb = 10 then '1000' 
		when olords = 20 and ayavst = '40' and aybrnb = 0 and aybpnb = 10 then '2000' 
		when olords = 20 and ayavst = '40' and aybrnb = 1 and aybpnb = 10 then '3000' 
		when olords = 20 and ayavst = '40' and aybrnb = 1 and aybpnb = 15 then '3000' 
		when olords = 20 and ayavst = '40' and aybrnb = 2 and aybpnb = 15 then '4000' 
		when olords = 20 and ayavst = '40' and aybrnb = 2 and aybpnb = 18 then '4000' 
		when olords = 20 and ayavst = '40' and aybrnb = 3 and aybpnb = 18 then '5000' 
		when olords = 20 and ayavst = '40' and aybrnb = 3 and aybpnb = 20 then '5000' 
		when olords = 20 and ayavst = '40' and aybrnb = 4 and aybpnb = 20 then '6000' 
		when olords = 20 and ayavst = '40' and aybrnb = 4 and aybpnb = 30 then '6000' 
		when olords = 20 and ayavst = '60' and aybrnb = 5 and aybpnb = 30 then '7000' 
		when olords = 20 and ayavst = '60' and aybrnb = 6 and aybpnb = 30 then '7000' 
		when olords = 45 and ayavst = '60' and aybrnb = 5 and aybpnb = 30 then '8000' 
		else 'Undefined' 
	end Status,
 	case
		when olords = 10 then 'Not Confirmed'
		when olords = 30 then 'Finished'
		when olords = 45 and thcstrcn like 'delivered%' then 'Order Delivered'
		when olords = 45 and thz3delv = 'Y' then 'Order Delivered'
		when olords = 45 and thz3delv = '' then 'Order Shipped'
		when olords = 45 and thz3delv = 'N' then 'Order Shipped'
		when olords = 60 and thz3delv = 'Y' then 'Order Delivered'
		when olords = 60 and thcstrcn like 'delivered%' then 'Order Delivered'
		when olords = 60 and thz3delv = '' then 'Order Shipped'
		when olords = 60 and thz3delv = 'N' then 'Order Shipped'
		when olords = 20 and ayavst = '10' and aybrnb = 0 and aybpnb = 0 then 'Please upload art'
		when olords = 20 and ayavst = '20' and aybrnb = 0 and aybpnb = 0 then 'Please upload art'
		when olords = 20 and ayavst = '20' and aybrnb = 0 and aybpnb = 10 then 'Please upload art'
		when olords = 20 and ayavst = '40' and aybrnb = 0 and aybpnb = 10 then 'Order Confirmation'
		when olords = 20 and ayavst = '40' and aybrnb = 1 and aybpnb = 10 then 'Ready 4 Approval'
		when olords = 20 and ayavst = '40' and aybrnb = 1 and aybpnb = 15 then 'Ready 4 Approval'
		when olords = 20 and ayavst = '40' and aybrnb = 2 and aybpnb = 15 then 'Proof Approved'
		when olords = 20 and ayavst = '40' and aybrnb = 2 and aybpnb = 18 then 'Proof Approved'
		when olords = 20 and ayavst = '40' and aybrnb = 3 and aybpnb = 18 then 'Ripped'
		when olords = 20 and ayavst = '40' and aybrnb = 3 and aybpnb = 20 then 'Ripped'
		when olords = 20 and ayavst = '40' and aybrnb = 4 and aybpnb = 20 then 'Printed'
		when olords = 20 and ayavst = '40' and aybrnb = 4 and aybpnb = 30 then 'Printed'
		when olords = 20 and ayavst = '60' and aybrnb = 5 and aybpnb = 30 then 'Finished'
		when olords = 20 and ayavst = '60' and aybrnb = 6 and aybpnb = 30 then 'Finished'
		when olords = 45 and ayavst = '60' and aybrnb = 5 and aybpnb = 30 then 'Order Shipped'
		else 'Undefined'
	end StatusText
 from  vt2662aftt.sroorshe SOHdr
	left join vt2662aftt.sroorspl Oline on SOHdr.ohorno = Oline.olorno and Oline.olshpm <> 'FREIGHT'
	left join vt2662aftt.mfmohr MFG on Oline.olprdc = MFG.ayprdc
	left join vt2662aftt.sroorsa OAddr on Oline.olorno = OAddr.oaorno and Oline.olline = OAddr.oaline
	left join vt2662aftt.sronoi SInfo on SOHdr.ohcuno = SInfo.nonum
	left join  vt2662aftt.srousp ibsuser on SInfo.noshan = ibsuser.uphand
	left join vt2662aftt.srocll on ibsuser.upuser = uluser
	left join VT2662aftt.Z3OPTRH on  Oline.olplno = thplno and Oline.olorno = thorno and thz3delv = 'Y'
	left join VT2662aftt.Z3OPTRpD on thcstrcn = pdcstrcn
where ohcuno = 'C00001' and ohorno = 10058107