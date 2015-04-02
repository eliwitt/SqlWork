--============================ linked server access =============
Hey bonehead.  You set up a linked server on s-04 and you have 
selects on that box so go check it out.


--==================  design work  ===================
--

SELECT * FROM VT2662AFTT.MFCIATL1 WHERE JYPRDC = 'WEB_BUL_CFG';

select * from  VT2662AFTT.MFCVall1 where mtyvcd = 'BU50';
select * from  VT2662AFTT.MFCparl1 where jozlcd = 'WO_BULLMAIN';
select * from  VT2662AFTT.MFCpatl2 where jpzlcd = 'WO_BULLMAIN';

--
--====================== sales orders =======================
--

select * FROM SRBSOL WHERE OLPRDC = '|prdc|' AND OLCORN = '|controlNumber|'
select * FROM VT2662AFTT.SRBSOL where olcuno = 'C00337' order by olorno, olline

--
-- Price list tables
--
select * from vt2662aftt.sroctlpl;

select * from vt2662aftt.sroprs where pspril = 'ITEMT' order by psprdc;

select * from vt2662aftt.srosprs where pspril = 'ITEMT' order by psprdc;

-- View to sroorshe sales order header
select * from vt2662afvp.srbsoh where ohorno = 10123767;
--  View to sroorsa sales order address
select * from vt2662afvp.sr2soa where oaorno = 10123767;
-- pick list xref
select * from vt2662afvp.sropix where pxplno = 2161602
--
--# Query For Order Header, OHORDS=Status 10/20
--
SELECT * FROM VT2662AFTT.SROORSHE WHERE OHORNO = {ordno}
--
-- a customers list of pending orders
--
SELECT OHORNO FROM VT2662AFTT.SROORSHE WHERE OHCUNO = '{1}' AND OHSTAT = '' AND OHORDS <= 10
--
--# Query For Order Lines, OLSHPM=Line description
--
SELECT * FROM VT2662AFTT.SROORSPL WHERE OLORNO = {ordno}
--
--# Query For Order Line Attributes
--
SELECT * FROM VT2662AFTT.Z3DR503A WHERE TTORNO = {ordno}
SELECT * FROM VT2662AFTT.Z3DR503A WHERE TTORNO = '{1}' AND TTLINE = {2}
--
--# Query for Order Status (logical join file)
--
SELECT * FROM VTCUSTOM.IBSSTATWB1 WHERE OHORNO = 10107731
-- 
-- find text that the user has entered on the line
--
SELECT OHORNO, ohcuno, ohcope, olline, olprdc, oldesc, gtdctt, gttx70
	FROM VT2662AFTT.SROORSHE sheader
	left join VT2662AFTT.SROORSPL sline on sheader.ohorno = sline.olorno
	left join vt2662aftt.srotgt stext on sline.oltxky = stext.gttxky
 WHERE gttx70 like 'Find Me%'
--
-- found the 999 entry in Sales order addresses table
-- add the  and oaline = olline to the subquery for SROORSA
-- SRoNAD is the table that you could use instead of the view
--
 Select olline, oldano,
	case when oldano = 999 then (select oaname from VT2662AFvp.SRoorsa where oaorno = olorno)
	else (SELECT adname FROM VT2662AFvp.SRBNAD WHERE ADNUM = olcuno and  adadno = OLDANO)
	end Addr
from VT2662AFvp.SRoorspl where olorno = 10117767;
--
--# Query for PO Numbers (OHOREF)
--
SELECT OHORNO, OHODAT, OHCUNO, OHICNO, OHCOPE, OHNAME, OHOREF 
FROM VT2662AFTT.SROORSHE 
WHERE OHODAT >= {yyyymmdd} AND	OHCUNO = '{custid}'
--
-- production support  issues
--
SELECT * FROM VT2662AFvp.SROORSHE 
sheader
	left join VT2662AFvp.SROORSPL sline on sheader.ohorno = sline.olornoWHERE OHORNO in (10111430, 10111275);

SELECT * FROM VT2662AFvp.SRBSOL WHERE OLORNO in (10111430, 10111275);

SELECT * FROM VT2662AFVP.Z3OPTRH WHERE THORNO in (10111430, 10111275);
--
-- ohcope -- advertiser
-- ohorno -- order number
-- 
-- oldesc -- description
-- ohmotc -- Trans code  
-- ohmott -- Trans description
--
select ohcope, ohorno, ohmotc, ohmott, thz3pstd, thz3evdt
FROM VT2662AFvp.SROORSHE sheader
left join VT2662AFVP.Z3OPTRH ship on sheader.ohorno = ship.THORNO
WHERE THORNO in (10111430, 10111275) and ohmotc <> 'VPI' and  thstat <> 'D'
union
select ohcope, ohorno, ohmotc, ohmott, thcstrcn,  thz3evdt
FROM VT2662AFvp.SROORSHE sheader
left join VT2662AFVP.Z3OPTRH ship on sheader.ohorno = ship.THORNO
WHERE THORNO in (10111430, 10111275) and ohmotc = 'VPI' and  thstat <> 'D';
--
-- package types
--
select * from vt2662aftt.z3bptp


--
-- new retrieval for the web service
--
select ohcuno, oaname, ohcope, olshpm, ohodat, olprdc as itemno, oldesc, olmotc as Shpmth, aya0dt as TGTSDT, 
	oldsdt as ACTSDT, olrdvd as TGTDLD, pdz3pddt as ACTDLD, pdz3podn as rcvdby, thcstrcn, ohoref as ponum, 
	ohorno as Ordno, olline as ORLine, updesc as CSRNam, substring(ulcpar, 7) as CSREmail
 from  vt2662afvp.sroorshe SOHdr
    left join vt2662afvp.sroorspl Oline on SOHdr.ohorno = Oline.olorno and Oline.olshpm <> 'FREIGHT'
    left join vt2662afvp.mfmohr MFG on Oline.olorno  = MFG.aybmnb and Oline.olline = MFG.aywdnb
    left join vt2662afvp.sroorsa OAddr on Oline.olorno = OAddr.oaorno and Oline.olline = OAddr.oaline
    left join vt2662afvp.sronoi SInfo on SOHdr.ohcuno = SInfo.nonum
    left join  vt2662afvp.srousp ibsuser on SInfo.noshan = ibsuser.uphand
    left join vt2662afvp.srocll on ibsuser.upuser = uluser
    left join VT2662AFVP.Z3OPTRH on  Oline.olplno = thplno and Oline.olorno = thorno and thz3delv = 'Y'
    left join VT2662AFVP.Z3OPTRpD on thcstrcn = pdcstrcn
where ohorno = 10116557

--
-- new retrieval of the orders data including the cfg'd items
--
select ohcuno as "Customer Number", ohorno as "Sales Order Nu", olline as "Sales Order Line", olsalp as "Price",
	ohodat as "Order Date", oloqty as "Qty Ordered", olcqty as "Confirmed Qty", 
	aya4nb as "MFG Order Nu", ayprdc as "Item", ayhatx as "Description",
	boyvcd as "Config item", boyxcd as "Cfg attr val", boogqt as "Cfg Value Nu"
 from  vt2662afvp.sroorshe SOHdr
    left join vt2662afvp.sroorspl Oline on SOHdr.ohorno = Oline.olorno and Oline.olshpm <> 'FREIGHT'
    left join vt2662afvp.mfmohr MFG on Oline.olorno = MFG.aybmnb and Oline.olline = MFG.aywdnb
    left join vt2662afvp.mfcisa CfgItem on Oline.olprdc = CfgItem.boshce
where ohorno = 10124940
--
-- the following two queries are used in sql server and openquery is by far faster than issuing the
--  select without it.
--
-- retrieve the order details for the given time period
--  Note: When I added cfgparent I had to add distinct to remove the duplicated rows from that join
--
select * 
 into orders2011
from
openquery(vt2662afvp,'
select distinct ohcuno, ohorno, olline, olscpr, ohodat, oloqty, olcqty, aya4nb, a0a3cd, ayprdc, boprdc, ayhatx
 from vt2662afvp.sroorshe SOHdr
    left join vt2662afvp.sroorspl Oline on SOHdr.ohorno = Oline.olorno and Oline.olshpm <> ''FREIGHT''
    left join vt2662afvp.mfmohr MFG on Oline.olorno = MFG.aybmnb and Oline.olline = MFG.aywdnb
    left join vt2662afvp.mfmoop Moop on MFG.aya4nb = Moop.a0a4nb and Moop.a0aqnb = 20
    left join vt2662afvp.mfcisa cfgparent on Oline.olprdc = cfgparent.boshce 
where ohodat between 20110101 and 20111231')
--
-- retrieve the cfg items for each order line for the given time period
--
select * 
 into cfgitems2011
from
openquery(vt2662afvp,'
select distinct olprdc, boyvcd, boyxcd, boogqt
 from  vt2662afvp.sroorshe SOHdr
    left join vt2662afvp.sroorspl Oline on SOHdr.ohorno = Oline.olorno and Oline.olshpm <> ''FREIGHT''
    left join vt2662afvp.mfcisa CfgItem on Oline.olprdc = CfgItem.boshce
where ohodat between 20110101 and 20111231 and boyvcd is not null order by olprdc, boyvcd')
---
-- for the current year we use different columns and tables
---
select * 
into orders201501test
from
openquery(vt2662afvp,'
select distinct ohcuno, ohorno, olline, olscpr, ohodat, oloqty, olcqty, aya4nb, a0a3cd, ayprdc, boprdc, ayhatx
 from vt2662afvp.sroorshe SOHdr
    left join vt2662afvp.sroorspl Oline on SOHdr.ohorno = Oline.olorno and Oline.olshpm <> ''FREIGHT''
    left join vt2662afvp.mfmohr MFG on Oline.olorno = MFG.aybmnb and Oline.olline = MFG.aywdnb
    left join vt2662afvp.mfmoop Moop on MFG.aya4nb = Moop.a0a4nb and Moop.a0aqnb = 20
    left join vt2662afvp.mfcisa cfgparent on Oline.olprdc = cfgparent.boshce 
where a0a2dt between 20150101 and 20150110 order by ohcuno, ohorno, olline')
-- opers
select * 
 into opers201501test
from
openquery(vt2662afvp,'
select distinct ohcuno, ohorno, olline, a0a4nb, a0aqnb, a0a3cd, a0a2dt as "Start Date", a0altm as "Start time", a0a3dt as "Completion date", a0aitm as "Completion time"
 from vt2662afvp.sroorshe SOHdr
    left join vt2662afvp.sroorspl Oline on SOHdr.ohorno = Oline.olorno and Oline.olshpm <> ''FREIGHT''
    left join vt2662afvp.mfmohr MFG on Oline.olorno = MFG.aybmnb and Oline.olline = MFG.aywdnb
    left join vt2662afvp.mfmoop Moop on MFG.aya4nb = Moop.a0a4nb
where a0a2dt between 20150101 and 20150110 order by ohcuno, ohorno, olline, a0a4nb, a0aqnb')

-- cfgitems
select * 
 into cfgitems201501test
from
openquery(vt2662afvp,'
select distinct olprdc, boyvcd, boyxcd, boogqt
 from  vt2662afvp.sroorshe SOHdr
    left join vt2662afvp.sroorspl Oline on SOHdr.ohorno = Oline.olorno and Oline.olshpm <> ''FREIGHT''
	 left join vt2662afvp.mfmohr MFG on Oline.olorno = MFG.aybmnb and Oline.olline = MFG.aywdnb
left join vt2662afvp.mfmoop Moop on MFG.aya4nb = Moop.a0a4nb
    left join vt2662afvp.mfcisa CfgItem on mfg.ayprdc = CfgItem.boshce
where a0a2dt between 20150101 and 20150110 and boyvcd is not null order by olprdc, boyvcd')


--
-- use CTE to combine fields into one colmun  works in sql server but not Navigator
--
with combinedCfg (CBRow, CBprdc, CBboyvcd, CBFields) as
(
	select 1, olprdc, min(boyvcd), cast(min(boyvcd) as varchar(8000))
		from vt2662afvp.s10a3a30.vt2662afvp.sroorspl Oline
		inner join vt2662afvp.s10a3a30.vt2662afvp.mfcisa CfgItem on Oline.olprdc = CfgItem.boshce
	where olorno = 10124940
	group by olprdc
	union all
	select cb1.CBRow + 1, olprdc, boyvcd, cb1.CBFields + ', ' + boyvcd
		from vt2662afvp.s10a3a30.vt2662afvp.sroorspl Oline
		inner join vt2662afvp.s10a3a30.vt2662afvp.mfcisa CfgItem on Oline.olprdc = CfgItem.boshce
		inner join combinedCfg cb1 on cb1.CBprdc = Oline.olprdc
	where olorno = 10124940 and boyvcd > cb1.CBboyvcd
)
select CB.CBprdc, CBFields
	from combinedCfg CB
	inner join (
		select CBprdc, max(CBRow) as MaxRow 
		from combinedCfg group by CBprdc
	) R on CB.CBRow = R.MaxRow and CB.CBprdc = R.CBprdc
order by CBprdc;
--
--  this one worked in Navigator  notice it was how I concated the fields
--
with combinedCfg (CBRow, CBprdc, CBboyvcd, CBFields) as
(
	select 1, olprdc, boyvcd, cast(boyvcd  ||';'||rtrim(boyxcd)||';'||boogqt as varchar(8000))
		from vt2662afvp.sroorspl Oline
		inner join vt2662afvp.mfcisa CfgItem on Oline.olprdc = CfgItem.boshce
	where olorno in (10124940, 10124974)
	union all
	select 1 + cb1.CBRow, olprdc, boyvcd, cb1.CBFields || ', '|| boyvcd ||';'||rtrim(boyxcd)||';'||boogqt
		from vt2662afvp.sroorspl Oline
		inner join vt2662afvp.mfcisa CfgItem on Oline.olprdc = CfgItem.boshce
		inner join combinedCfg cb1 on cb1.CBprdc = Oline.olprdc
	where olorno in (10124940, 10124974) and boyvcd > cb1.CBboyvcd
	order by olprdc
)
select ohcuno as "Customer Number", ohorno as "Sales Order Nu", olline as "Sales Order Line", olsalp as "Price",
	ohodat as "Order Date", oloqty as "Qty Ordered", olcqty as "Confirmed Qty", 
	aya4nb as "MFG Order Nu", ayprdc as "Item", ayhatx as "Description",
	CBFields
 from  vt2662afvp.sroorshe SOHdr
    left join vt2662afvp.sroorspl Oline on SOHdr.ohorno = Oline.olorno and Oline.olshpm <> 'FREIGHT'
    left join vt2662afvp.mfmohr MFG on Oline.olprdc = MFG.ayprdc
   inner join combinedCfg CB on Oline.olprdc = CB.CBprdc
   	inner join (
		select CBprdc, max(CBRow) as MaxRow
		from combinedCfg group by CBprdc
	) R on CB.CBRow = R.MaxRow and CB.CBprdc = R.CBprdc
where ohorno in (10124940, 10124974) 

--
--===========================  products =========================
--
-- products
--
SELECT JWPRDC, JWZLCD FROM VT2662AFTT.MFCITEL1 WHERE JWPRDC LIKE 'WEB_%' AND JWSROM = 'VPI' AND JWPRDC = '" + code + "'
--
-- config item attributes
--
SELECT * FROM VT2662AFTT.MFCIATL0
--
-- con items
--
SELECT * FROM VT2662AFTT.MFCitel0 where jwprdc = 'WEB_BUL_CFG';
--
-- Product attributes, JPN9QT and JPOAQT allowed range
--
SELECT * FROM VT2662AFTT.MFCIATL1 WHERE JYPRDC = '{0}' AND JYSROM = 'VPI' AND JYZLCD = '{1}' AND JYYVCD = '{2}'
--  Allowed values, MTQ1TX=attr description
SELECT * FROM VT2662AFTT.MFCVALL1 WHERE MTYVCD =
--
-- temp xml table holding the order's info like BU70/FL010
--
select * from vt2662aftt.z3dr503a where ttorno = {ordno}


SELECT * FROM VT2662AFTT.MFCIATL1 where jyprdc ='WEB_FLS_CFG';
SELECT * FROM vt2662aftt.MFCPATL2 
	 where jpzlcd in (select jyzlcd from  VT2662AFTT.MFCIATL1 where jyprdc ='WEB_FLS_CFG');



SELECT JWPRDC, JWZLCD FROM VT2662AFTT.MFCITE WHERE JWPRDC LIKE 'WEB_%';
SELECT * FROM VT2662AFTT.MFCIAT where jyprdc = 'WEB_FLS_CFG';
select * from VT2662AFTT.MFCVAL where mtyvcd = 'WBU70';
--
--========================= configurator product ===================
--

--  configurator table, PGPRDC=code, PGPSNA=name, PGDESC=description 
--
SELECT PGPRDC, PGPSNA, PGDESC FROM {0}.SROPRG WHERE PGPRDC LIKE 'WEB%' AND PGPRDC = ''
SELECT * FROM vt2662aftt.SROPRG WHERE PGPRDC LIKE 'WEB%'
--
-- box sizes -----------------------------------------------------
--
SELECT SROPRU.PJWIDT, SROPRU.PJLENG, SROPRU.PJHIGH 
FROM SROPRG, SROPRU 
WHERE PGPRDC = PJPRDC AND PGDSUN = PJUNIT AND PGPRDC = '{product code}'

--
--# Get Events (Descending Order)
--
SELECT * FROM VT2662AFTT.SROOFL ORDER BY OFDATE, OFTIME DESC
SELECT * FROM VT2662AFvp.SROOFL where oforno = '10109456' ORDER BY OFDATE, OFTIME DESC

--
--# Get Processed Events
--
SELECT * FROM VT2662AFTT.SROOFL WHERE OFSTAT = 'P'
--
--# Clear processed events
--
UPDATE VT2662AFTT.SROOFL SET OFSTAT = ''


--
-- look at the user defined table entries
--
--  current product price table  WOCUSTPRIC
select * from vt2662afvp.mfudtd where ciubce = 'WOCUSTPRIC' order by ciuece, ciufce;

--  insert entries into the user defined table
insert into vt2662afvp.mfudtd (ciubce, ciagdt, ciuece, ciufce, cixsqt) 
values('WOCUSTPRIC','20140602','10 OZ','C00002', .10),('WOCUSTPRIC','20140602','12 OZ','C00002', .12),('WOCUSTPRIC','20140602','15 OZ BACKLIT','C00002', 2.75),('WOCUSTPRIC','20140602','7 OZ','C00002', .07),('WOCUSTPRIC','20140602','PE','C00002', .08),('WOCUSTPRIC','20140602','MESH','C00002', 1.75);

-- had to update the valid from date  NOTE:  it must match!!
update vt2662aftt.mfudtd set ciagdt = '20140529' where ciubce = 'WBU70' and ciufce = 'C00002';

	--  current product price table  WOCUSTPRIC
select * from vt2662afvp.mfudtd 
where ciubce = 'WOCUSTPRIC' and ciufce in ( 'C00260', 'C00333', 'C00167', 'C00067', 'C00069') 
	and ciuece in ('7 OZ', 'PE')
order by ciuece, ciufce;

--update vt2662afvp.mfudtd set cixsqt = .35 where ciubce = 'WOCUSTPRIC' and ciufce in ( 'C00260', 'C00333', 'C00167', 'C00067', 'C00069') 
--	and ciuece in ('7 OZ', 'PE');
--	
-------------------- order header--he and line--pl  ----------
--	
SELECT * FROM VT2662AFTT.SROORSHE WHERE OHORNO >= 10056620
SELECT * FROM VT2662AFTT.SROORSPL WHERE OLORNO >= 10056620

SELECT 
	OHORNO, OHODAT, OHCUNO, OHICNO, OHCOPE, OHNAME, OHOREF 
FROM 
	VT2662AFTT.SROORSHE 
WHERE 
	OHODAT >= 20140220 AND
	OHCUNO = 'C00218'
--===================== indesign  tables ==========================
--
-- indesign table
--
--INSERT INTO VT2662AFTT/Z3OINDIH (IHORNO,IHLINE,IHBCNB,IHPRDC,IHREFX,IHSTAT,IHCRTS,IHUPTS) VALUES(|orno|,|line|,|mfgo|,'|item|',|refx|,'|stat|','|crts|','|upts|')
select * from VT2662AFTT.Z3OINDIH
--
-- indesign attributes
--
--INSERT INTO VT2662AFTT/Z3OINDIA (IAREFX,IAATRN,IACATC,IAATRT,IAATTR) VALUES(|refx|,|atrn|,'|catc|','|atrt|','|attr|')
select * from VT2662AFTT.Z3OINDIA


select attrs.iaatrt, attrs.iaattr from VT2662AFtt.Z3OINDIH hdr
	left join VT2662AFTT.Z3OINDIA attrs on hdr.ihrefx = attrs.iarefx
where ihorno = 10108797

-- list the hdr data
select * from  VT2662AFtt.Z3OINDIH where ihorno= 10114450;

-- list the attrs for a WO
select attrs.* from VT2662AFtt.Z3OINDIH hdr
	left join VT2662AFTT.Z3OINDIA attrs on hdr.ihrefx = attrs.iarefx
where ihorno = 10114450;

-- update the hdr status
update VT2662AFtt.Z3OINDIH set ihstat = '0' where ihorno in (10114450);


--  insert rows to the attrs for the WO
insert  into VT2662AFTT.Z3OINDIA (iarefx, iacatc, iaatrt, iaattr) 
select ihrefx as iarefx, '', 'Size', '12x40' from VT2662AFtt.Z3OINDIH hdr where ihorno = 10114450;
insert  into VT2662AFTT.Z3OINDIA (iarefx, iacatc, iaatrt, iaattr) 
select ihrefx as iarefx, '', 'Bus_Icon', 'Yes' from VT2662AFtt.Z3OINDIH hdr where ihorno = 10114450;


--
--===========================  manufacturer order header ==================
--
--   srbsol is a view to sroorspl
--
SELECT OLORNO, OLLINE, OLOQTY FROM SRBSOL WHERE OLORNO = |orderNumber| AND OLSTAT <> 'D'
--
--select * from vt2662aftt.mfmohr fetch first 10 rows only
--
-- header
--
select * from vt2662aftt.mfmohr where aybmnb >= 10056620
--
--  cfgd item attrs
--
select * from vt2662afvp.mfcisa where boshce = 'BAN_10100357_10';
--
--  customer sales order link
--
select LTBCNB FROM MFCULI WHERE LTORNO = |getLine.OLORNO| AND LTLINE = |getLine.OLLINE|
--
-- mfg operations
--
-- operations table
select * from VT2662AFTT.mfmoop where a0a4nb = 291014
--   a4a3cd = 'FNBL' and A4REAs <> ''
-- operations history
select * from VT2662AFTT.mfmooy where a4a4nb = 291014
--
--========================  fedex data  ==========================
--
-- configurator transit method
--
SELECT * FROM VT2662AFTT.SRBCTLSG WHERE CTMOTC LIKE 'F%'

--
--select * from vt2662aftt.z3optrh fetch first 10 rows only

select * from vt2662aftt.z3optrh where thorno >= 10056620

SELECT * FROM VT2662AFVP.Z3OPTRH WHERE THORNO = 10109233 AND THLINE = 10
--
--  look at the header and detail info
--  10118892 - delivered 10/29 in THCSTRCN
--
select thcstrcn, thz3pstc, thz3evdt, thorno, thline, thz3shpr, evcstrcn,
 	evz3pstc, evz3pstd, evz3evdt, pdcstrcn, pdz3pddt
	from VT2662AFVP.Z3OPTRH	
	left join VT2662AFVP.Z3OPTRD on thcstrcn = evcstrcn
	left join VT2662AFVP.Z3OPTRpD on thcstrcn = pdcstrcn
where THORNO = 10116557 and thstat <> 'D';

-- sometimes we have to enter the tracking info again because of a mistake
-- this leaves a dup entry so this manually removes the dup using the bad
-- tracking number.   thstat = 'D' and thz3evdt >= 20140501
--
--DELETE FROM VT2662AFVP.Z3OPTRH WHERE THCSTRCN = '583182093397'

update VT2662AFTT.Z3OPTRH set thstat = 'D'	 where VT2662AFTT.Z3OPTRH.THORNO = 10057213

--
-- find all orders within a given date range
--
SELECT * FROM table(VTCUSTOMTT.udtf0001t('C05771',20131220,20140306,'C', '' )) as t where ordqty > 0
--
--================================== spreadsheet ===================
--
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
	left join vt2662afvp.mfmohr OHdr on OLine.olprdc = OHdr.ayprdc
	left join vt2662afvp.z3optrh FedHdr on OLine.OLorno = FedHdr.Thorno and OLine.olline = FedHdr.THline and thstat <> 'D'
where olcuno = 'C26605' and olorno in (10124542, 10124532)
order by olcuno
--
--================================== company ============================
--
--  Company table
--
SELECT * FROM VTCUSTOMTT.IBSBPNAM WHERE NANUM = ''
SELECT * FROM VTCUSTOMTT.IBSBPNAM where naname like '%Fairway%'
--
--  suppose to be the Biz partner file
--
select distinct nanum as "Customer No", naname as "Account Name", 
naadr1 || chr(10) || naadr2 || chr(10) || naadr3 as Address, naadr4 as "City", naspcd as "ST", 
 substring(napocd,4) as zip, SigSales.ctname as "Business Development Exec",  
SigCSR.ctname as "Account Owner", substring(nacrdt,0,5) as "Customer Since" , Phone.nfphno
from vt2662afvp.sronam SNam	
left join  vt2662afvp.sronoi SInfo on SNam.nanum = SInfo.nonum	
left join vt2662afvp.srbctlsd SigSales on SNam.naarha = SigSales.ctsign	
left join vt2662afvp.srbctlsd SigCSR on SInfo.noshan = SigCSR.ctsign	
left join vt2662afvp.sronfp Phone on SNam.nanum = Phone.nfnano and nfdesc = 'Company phone'
where nanum like 'C%'and nacrdt > 20140801 order by nanum

-- A/R Customer file  I can use this file to filter the rev
select * from vt2662afvp.srocma where cmcuno in ('C00001', 'C05771', 'C02324', 'C02323', 'C26605')

-- here i use the table to filter
select ihcuno, sum(case when ihtypp = 1 then iholto else - iholto end) as income
from vt2662afvp.srbish ISH
	left join  vt2662afvp.srodta Detail on ISH.ihrefx = Detail.dtrefx 
	left join vt2662afvp.srocma ARCust on ish.ihcuno = ARCust.cmcuno 
where dtperi = 201502 and ARCust.cmdeno = '' and dtvoty = '80' group by ihcuno order by ihcuno;
--
--
--  filter out WL
--
select ihcuno, sum(case when ihtypp = 1 then iholto else - iholto end) as income
from vt2662afvp.srbish ISH
	left join  vt2662afvp.srodta Detail on ISH.ihrefx = Detail.dtrefx 
where ihcuno <> 'C26605' and ihcuno not in (select nonum from vt2662afvp.sronoi where nocgrp = 'MWL')
 and dtperi = 201502 and dtvoty = '80' group by ihcuno order by ihcuno;

 --
 --  wl totals
 --
 --
 select ihcuno, sum(case when ihtypp = 1 then iholto else - iholto end) as income
from vt2662afvp.srbish ISH
	left join  vt2662afvp.srodta Detail on ISH.ihrefx = Detail.dtrefx 
where (ihcuno = 'C26605' or ihcuno in (select nonum from vt2662afvp.sronoi where nocgrp = 'MWL'))
and dtperi = 201502 and dtvoty = '80' 
group by ihcuno

--
-- Inoice Search Header
--
select * from vt2662afvp.srbish;

--
-- the following produces the output that Tricia creates
--
select ihcuno, sum(case when ihtypp = 1 then iholto else - iholto end) as income
from vt2662afvp.srbish ISH
	left join  vt2662afvp.srodta Detail on ISH.ihrefx = Detail.dtrefx 
where dtperi = 201407 and dtvoty = '80' group by ihcuno order by ihcuno;
--
-- alternative or old version
--
select ihcuno, sum(case when ihtypp = 1 then iholto else - iholto end) as income 
from vt2662afvp.srbish 
where ihcuno = 'C00046' and ihodat between 20140701 and 20140731 group by ihcuno;
--
-- A/R transaction file
--
select * from vt2662afvp.srodta;
--
--  working with ---------------------------------------------------
select * from vt2662afvp.srbish where ihcuno = 'C00046' and ihodat between 20140701 and 20140731;

select *from vt2662afvp.srbish ISH	
left join  vt2662afvp.srodta Detail on ISH.ihcuno = Detail.dtcuno 
where dtperi = 201407 and dtvoty = '80' and ihcuno = 'C00046' and ihodat between 20140701 and 20140731
;
--
----
--===================== user file  =========================================
--
-- ibs, NOSHAN=CSRCode, NOMOTC=shipping method
--
SELECT NOSHAN FROM VT2662AFVP.SRONOI WHERE NONUM =
--
-- email data
--
SELECT ULCPAR FROM VT2662AFVP.SROCLL WHERE ULUCTP = '*USERPROF' AND ULCLNT = 'MAIL' AND ULUSER = ''
--
--
--
SELECT CTNAME FROM VT2662AFVP.SRBCTLSD WHERE CTSIGN = ''
--
--
--
SELECT UPUSER FROM VT2662AFVP.SROUSP WHERE UPHAND = ''
--
--===============================  sys wide ===================================
--
-- search for a column in the tables in the sys
--
SELECT SYSTEM_COLUMN_NAME, SYSTEM_TABLE_NAME, SYSTEM_TABLE_SCHEMA
FROM qsys2.syscolumns WHERE system_column_name = 'F2PCKN' and system_table_schema =
'VT2662AFVP'