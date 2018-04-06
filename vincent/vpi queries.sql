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
select * from vt2662afvp.sroorsa where oaorno = 10123767;

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
-- I attempted to update a range of rows in the hdr and srewed up royal
-- the following is how I should have done it.  I tested on my server.
-- In the original I forgot the ihorno = ohorno because of that I updated every row
-- thank god we had a backup.
--
update SaleOrHdr set ohcope = 'CB_' + (select iaattr from indesignhdr hdr
	left join indesignAttrs attrs on hdr.ihrefx = attrs.iarefx
where ihorno between 10135051 and 10135059 and iaatrn = 1 and ihorno = ohorno) 
where exists
(select * from indesignhdr hdr
where ihorno between 10135051 and 10135059 and ihorno = ohorno)
--
--# Query For Order Lines, OLSHPM=Line description
--
SELECT * FROM VT2662AFTT.SROORSPL WHERE OLORNO = {ordno}
--
--# Query For Order Line Attributes
--
SELECT * FROM VT2662AFTT.Z3DR503A WHERE TTORNO = {ordno}
SELECT * FROM VT2662AFTT.Z3DR503A WHERE TTORNO = '{1}' AND TTLINE = {2}
select * from vt2662afvp.z3dr503a  where ttytcd like '%SAV%'
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
-- the web uses the following
--
SELECT * FROM VT2662AFvp.SRBNAD WHERE ADNUM = 'C00001' AND ADAD01 = 'Y' ORDER BY ADADNO
--
-- sales data that got corupt by the Forward Maintenance prgr
--
select * from vt2662afvp.srbnoi where nonum in ('C00766', 'C01193', 'C28538', 'C33933');
--update vt2662afvp.srbnoi set nocxxcgp = '' where nonum in ('C01193', 'C28538', 'C33933');
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

--  sales order
---update  VT2662AFvp.SROORSPL set olords = 45 where OHORNO = 10133693 and olline in (930, 940 950, 970)
SELECT olords FROM VT2662AFvp.SROORSPL WHERE OlORNO = 10133693 and olline in (930, 940, 950, 970)	

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

select * from vt2662afvp.sroorshe hdr
	left join vt2662afvp.sroorspl line on hdr.ohorno = line.olorno
where ohcuno = 'C00069' and ohstat <> 'D' and ohcope like '%YMCA%' and oldesc like '%Clip%'
--
-- package types(a.k.a. Box Sizes)
--
select * from vt2662aftt.z3bptp WHERE PTPCKT LIKE 'TRI%' AND PTNWGT > 0 ORDER BY PTGVOL ASC


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
    left join VT2662AFVP.Z3OPTRH on  Oline.olplno = thplno and Oline.olorno = thorno 
    left join VT2662AFVP.Z3OPTRpD on thcstrcn = pdcstrcn and thz3delv = 'Y'
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
into vpi.orders2015
from
openquery(vt2662afvp,'
select distinct ohcuno, ohorno, olline, olscpr, ohodat, oloqty, olcqty, aya4nb, a0a3cd, ayprdc, boprdc, ayhatx
 from vt2662afvp.sroorshe SOHdr
    left join vt2662afvp.sroorspl Oline on SOHdr.ohorno = Oline.olorno and Oline.olshpm <> ''FREIGHT''
    left join vt2662afvp.mfmohr MFG on Oline.olorno = MFG.aybmnb and Oline.olline = MFG.aywdnb
    left join vt2662afvp.mfmoop Moop on MFG.aya4nb = Moop.a0a4nb and Moop.a0aqnb = 20
    left join vt2662afvp.mfcisa cfgparent on Oline.olprdc = cfgparent.boshce 
where a0a2dt between 20150101 and 20151231 order by ohcuno, ohorno, olline')
-- opers
select * 
 into vpi.opers2015
from
openquery(vt2662afvp,'
select distinct ohcuno, ohorno, olline, a0a4nb, a0aqnb, a0a3cd, a0a2dt as "Start Date", a0altm as "Start time", a0a3dt as "Completion date", a0aitm as "Completion time"
 from vt2662afvp.sroorshe SOHdr
    left join vt2662afvp.sroorspl Oline on SOHdr.ohorno = Oline.olorno and Oline.olshpm <> ''FREIGHT''
    left join vt2662afvp.mfmohr MFG on Oline.olorno = MFG.aybmnb and Oline.olline = MFG.aywdnb
    left join vt2662afvp.mfmoop Moop on MFG.aya4nb = Moop.a0a4nb
where a0a2dt between 20150101 and 20151231 order by ohcuno, ohorno, olline, a0a4nb, a0aqnb')
-- cfgitems
select * 
 into vpi.cfgitems2015
from
openquery(vt2662afvp,'
select distinct olprdc, boyvcd, boyxcd, boogqt
 from  vt2662afvp.sroorshe SOHdr
    left join vt2662afvp.sroorspl Oline on SOHdr.ohorno = Oline.olorno and Oline.olshpm <> ''FREIGHT''
	 left join vt2662afvp.mfmohr MFG on Oline.olorno = MFG.aybmnb and Oline.olline = MFG.aywdnb
left join vt2662afvp.mfmoop Moop on MFG.aya4nb = Moop.a0a4nb
    left join vt2662afvp.mfcisa CfgItem on mfg.ayprdc = CfgItem.boshce
where a0a2dt between 20150101 and 20151231 and boyvcd is not null order by olprdc, boyvcd')


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
-- the pending order page retrieves a lot of data I provided a alternative
--
SELECT OHORNO, olorno, olline, olprdc, oloqty, oldano, olmotc,
	case
		when olline is null then 'false'
		when olprdc is null then 'false'
		when oloqty is null then 'false'
		when oldano is null then 'false'
		when olmotc is null then 'false'
		when oloqty = 0 then 'false'
		when oldano = 0 then 'false'
	else 'true'
	end complete
	FROM vt2662aftt.SROORSHE hdr
	left join vt2662aftt.SROORSPL line on hdr.ohorno = line.OLORNO
WHERE OHCUNO = 'C00001' AND OHSTAT = '' AND OHORDS <= 10
--
-- related tables
--
select distinct olorno, olline, olplno, oldlvd, aya4nb, a0astx, a0a3dt, thcstrcn, evz3evdt,evz3evtm from vt2662afvp.sroorspl Oline
left join vt2662afvp.mfmohr MFG on Oline.olorno  = MFG.aybmnb and Oline.olline = MFG.aywdnb
left join vt2662afvp.mfmoop Moop on MFG.aya4nb = Moop.a0a4nb and Moop.a0aqnb = 15
left join vt2662afvp.z3optrh FexHdr on OLine.olorno = FexHdr.thorno and OLine.olplno = thplno
left join vt2662afvp.z3optrd FexDlt on FexHdr.thcstrcn = FexDlt.evcstrcn and FexDlt.evz3pstc = 'PU'
where olorno = 10181644

--
--==========================  quotation =========================
--
--  quote header
select * from vt2662aftt.sroquh where qhquno = 70014
update vt2662aftt.sroquh set qhstat = 'D' where qhquno = 70014
--  quote line
select * from vt2662aftt.sroqupl where qlquno = 70005
update vt2662aftt.sroqupl set qlstat = 'D' where qlquno = 70005

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
-- cfg atr
--
SELECT * FROM VT2662AFTT.MFCatr where jnyvcd like 'BU%'
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
--
-- parameter table
--
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
--  Log Point contain the events code and description
--
select * from vt2662afvp.sroctllp

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
-- create a copy of the schema for MFUDTD in STEVEWORK
--
CREATE TABLE UserPrices AS (
    SELECT *
    FROM vt2662aftt.mfudtd
) WITH NO DATA
--
--copy the data from MFUDTD
--
insert into userprices select * from vt2662aftt.mfudtd;

insert into userprices select ciubce, ciagdt, '7 OZ BB', cixqqt, ciufce, cixrqt, cixsqt, ciaavn, ciabts from userprices where ciubce = 'WBU70' and ciuece = '7 OZ';

select * from vt2662afvp.mfudtd where ciubce = 'WBU80' order by ciuece, ciufce;
-- tt data
select * from userprices where ciubce = 'WBU70' and ciuece like '7 OZ%'
-- vp data 
select * from userprices where ciubce = 'WOCUSTPRIC' and ciuece like '7 OZ%'
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

select count(*) from  VT2662AFtt.Z3OINDIH where ihstat <> 9 and ihcrts > '2016-02-17 01:01:01.0001'

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

--Update CB MOs
update VT2662AFtt.Z3OINDIH 
SET IHSTAT = 0 
where ihbcnb in (
select ihbcnb from VT2662AFtt.Z3OINDIH hdr
    left join VT2662AFTT.Z3OINDIA attrs on hdr.ihrefx = attrs.iarefx
where  (ihbcnb > 563891 and ihbcnb < 564787)  and iaattr in('CDP','DTCND')
)


--  insert rows to the attrs for the WO
insert  into VT2662AFTT.Z3OINDIA (iarefx, iacatc, iaatrt, iaattr) 
select ihrefx as iarefx, '', 'Size', '12x40' from VT2662AFtt.Z3OINDIH hdr where ihorno = 10114450;
insert  into VT2662AFTT.Z3OINDIA (iarefx, iacatc, iaatrt, iaattr) 
select ihrefx as iarefx, '', 'Bus_Icon', 'Yes' from VT2662AFtt.Z3OINDIH hdr where ihorno = 10114450;

--
-- had to create entries
--
select 'insert into VT2662AFtt.Z3OINDIA values (' || iarefx  || ',' || ' (select max(iaatrn) from VT2662AFTT.Z3OINDIA where iarefx = ' || iarefx  || ') + 1, '''', ''JobNbr'', ''' || iaattr || ''''  from VT2662AFtt.Z3OINDIH hdr
	left join VT2662AFtt.Z3OINDIA attrs on hdr.ihrefx = attrs.iarefx
where ihorno between 10152783 and 10152979 and iaatrt = 'Board'


with OrdInfo (ordnu, ordline, ordcode, ordvalue) as 
(
select ttorno, ttline, ttytcd, ttforv from vt2662afvp.z3dr503a where (ttorno = 10157050 and ttline in (180, 230)) or (ttorno = 10158058 and ttline = 60) or (ttorno = 10154380 and ttline = 20) or (ttorno = 10158058 and ttline = 170) or (ttorno = 10160323 and ttline = 20) or (ttorno = 10159127 and ttline = 10)
)
select * from OrdInfo where ordcode like '%SF%'
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
select * from vt2662afvp.mfmohr where aybmnb >= 10056620
--
-- update the Manufactor header to the correct status
--
update  vt2662afvp.mfmohr set aybrnb = 2 where aya4nb = 446583
--
--  cfgd item attrs
--
select * from vt2662afvp.mfcisa where boshce = 'BAN_10100357_10';
--
-- when we tested ext I entered a value that killed the UDTF.  Come to find out
-- that the field size has a limit of around 9999.  Ext will never be bigger than the board.
--
update VT2662AFTT.MFCISA set boogqt = 120.00 WHERE boyvcd like 'EXT%' and BOSHCE = 'WO EXT_10058519_20';
SELECT * FROM VT2662AFTT.MFCISA WHERE boyvcd like 'EXT%' and BOSHCE = 'WO EXT_10058519_20';
--
-- update the status on the orders in the sub-select
--
update vt2662aftt.mfmohr set aybrnb = 2, aybpnb = 15  where aya4nb in (
select aya4nb from vt2662aftt.mfmohr MFG
	left join vt2662aftt.sroorspl OLine on MFG.aybmnb = Oline.olorno and  MFG.aywdnb = Oline.olline
where olords = 20 and ayavst = '40' and aybrnb = 1 and aybpnb = 10
)

update VT2662AFvp.SROOFL set ofstat = '' where oforno in (
10141385, 10141367, 10141368, 10141370, 10141371, 10141372, 10141373, 10141374, 10141375, 10141376, 10141377, 10141380, 10141381, 10141382,
10141386, 10141387, 10141389, 10141390, 10141391, 10141393, 10141395, 10141398, 10141402, 10141404, 10141408, 10141416, 10141421, 10141428,
10141430, 10141431, 10141432, 10141433, 10141434, 10141435, 10141436, 10141437, 10141438
) and oflid2 in ('OC', 'AR', 'TS', 'TD')
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
--
-- the MO hdr, oper, and text relationship
--
select aybmnb, a0aqnb, a0a3cd, gttx70
from vt2662afvp.mfmohr  hdr 
	left join VT2662AFvp.mfmoop oper on hdr.aya4nb = oper.a0a4nb
	left join vt2662afvp.srotgt motxt on oper.a0txky = motxt.gttxky
where aybmnb = 10144577 order by a0aqnb 
--
--
--========================  fedex data  ==========================
--
-- configurator transit method
--
SELECT * FROM VT2662AFTT.SRBCTLSG WHERE CTMOTC LIKE 'F%'

--
--select * from vt2662aftt.z3optrh fetch first 10 rows only

select * from vt2662aftt.z3optrh where thorno >= 10056620
select * from vt2662afvp.z3optrh where thz3eddt > 20150615
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
--
--=================================Planner View ====================
--
-- work centre list for Plannerview
-- using a view
select * from vt2662afvp.mfwcfll1 where aiqpst = '1' order by 1
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
	left join vt2662afvp.mfmohr MFG on Oline.olorno = MFG.aybmnb and Oline.olline = MFG.aywdnb
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
--
-- biz partner and a/r customer file
--
select * from vt2662afvp.sronam where nanum = 'C05771';
select * from vt2662afvp.srocma where cmcuno = 'C05771';  -- this table CMCRST is for credit stops
--
-- Trading Partner Documents - DI information such as Integrator handler and invoice email addresses
--
select * from vt2662afvp.srotpd where emnum = 'C00001'
--
-- lookup using the internal name
--
select nanum as "Customer No", naname as "Account Name"
from vt2662afvp.sronam	
where nansna like 'CCO/%' order by nanSNA

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
with wlaccts (wlcuno, wlincome) as
(
select 'C26605', sum(case when ihtypp = 1 then iholto else - iholto end) as income
from vt2662afvp.srbish ISH
	left join  vt2662afvp.srodta Detail on ISH.ihrefx = Detail.dtrefx 
where dtperi = 201507 and dtvoty = '80' and (ihcuno in (select nonum from vt2662afvp.sronoi where nocgrp = 'MWL') or ihcuno = 'C26605')
group by ihcuno 
)
select wlcuno, sum(wlincome) as income from wlaccts group by wlcuno
union
select ihcuno, sum(case when ihtypp = 1 then iholto else - iholto end) as income
from vt2662afvp.srbish ISH
	left join  vt2662afvp.srodta Detail on ISH.ihrefx = Detail.dtrefx 
where dtperi = 201507 and dtvoty = '80' and ihcuno not in (select nonum from vt2662afvp.sronoi where nocgrp = 'MWL') and ihcuno <> 'C26605'
group by ihcuno
order by 1;

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
select * from vt2662afvp.sronoi where nocgrp = 'MWL'
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

===========================  MS SQL Server tables ================================
--
--  insert a fav entry
--
insert into [dbo].[Favorites] (contactid, baseProduct, name, width, height, attributes, active)
values(1842, 'WEB_JRB_CFG', 'Overflow test7', 50, 10, '<attributes>
  <attribute name="JR10" value="JR BOARD" />
</attributes>', 1)
--
-- (de)active a fav entry  0=deactive 1=active
--
update [dbo].[Favorites] set [active] = 0 where [favoriteId] in (10190, 10191, 10192, 10193, 10194, 10195, 10196)
--
-- list a users fav
--
select * from Favorites 
where contactId in (select contactid from Contacts where emailaddress like 'stevew%') and
active = 1 order by name
--
--  check the order recorded status
--
SELECT *
  FROM [VPI_Online].[dbo].[OrderStatusNotification]
  WHERE orderNumber = 10142634
--
-- alternative
--
SELECT firstName + ' ' + lastname, orderNumber, lineNumber, [type], dateAdded, emailaddress
FROM OrderStatusNotification notify
	left join Contacts on notify.contactid = Contacts.contactid
WHERE notify.companyid = 'C23952' order by orderNumber

SELECT contactid, emailaddress, firstName, lastName, flags
  FROM [VPI_Online].[dbo].[Contacts]
  WHERE contactid in (2329)

  update Contacts set flags = 'AE' WHERE contactid = 2329
--....shows contactId 2470 as the ACCOUNT_EXEC.

SELECT contactid, companyid, emailaddress, firstName, lastName
  FROM [VPI_Online].[dbo].[Contacts]
  WHERE contactid in (2470, 1958)

  --   We have an issue where entries are create in the OrderStatusNotification table with
  --   order numbers for users.  This causes their cureent order page to error
  --
  --  get the contact id of the user 
select * from Contacts where emailaddress in (
'adamlowney@clearchannel.com', 'markjacobsen@clearchannel.com', 'GeorgetteTadros2@clearchannel.com',
'stevew@vincentprinting.com'
)
--
-- locate contacts based on the companyid
--
SELECT *
  FROM Contacts
where companyid like '%!,%' escape '!'
--where companyid like '%C02120%' or companyid like '%C00002%'


--  with the contact id look in the notification table
--    Adam's id
SELECT * FROM OrderStatusNotification where contactId = 1412 order by orderNumber desc
--
-- if there is a blank order number set the date field to 1900
-- a blank order number in this table can cause the web to build a bad
-- sql command and error out.
--
select * from  OrderStatusNotification where orderStatusNotificationId = 126808
update OrderStatusNotification set dateAdded = '1900-01-01' where orderStatusNotificationId = 126808

--To create the user on the new machine:

CREATE LOGIN vincent 
	WITH PASSWORD = N'$password', 
	sid = $sid,
	DEFAULT_DATABASE=[master], 
	DEFAULT_LANGUAGE=[us_english], 
	CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF;
GO

-- * don't enclose the SID in quotes

--
-- you can use this query to look for a string that starts with [
-- 
select * from mydata where mychar LIKE '[ [ ]%'

--- Linked server tables
--
-- Customer - Sales Order Info  SRONOI
--
-- User Profile SROUSP
--
SELECT nonum, noshan, updesc 
FROM vt2662afvp.s10a3a30.vt2662afvp.sronoi SInfo
	left join vt2662afvp.s10a3a30.vt2662afvp.srousp ibsuser on SInfo.noshan = ibsuser.uphand

select * from vt2662afvp.s10a3a30.vt2662afvp.srousp
============================  my schema  =========================================
--
--date conversion pg 21
--
select u.id, monthname(u.confirmed_date) || ' ' || rtrim(char(day(u.confirmed_date))) || ',' || rtrim(char(year(u.confirmed_date))) confirmed, confirmed_date from upfall u;

--
-- aggregate functions pg 52
--
select count(u.county_id) as count_count from upfall u;
select count( distinct u.county_id) as count_count from upfall u;
--
-- group by
--
select t.name as tour_name, u.name from upfall u inner join trip t on u.id = t.stop;
select t.name as tour_name, count(*) from upfall u inner join trip t on u.id = t.stop group by t.name;
--
-- using the having clause you can restrict the rows returned from the group by
--
select t.name as tour_name, count(*) from upfall u inner join trip t on u.id = t.stop group by t.name having count(*) >= 6;
--
-- this technique helps reduce the group by list
--
select c.id as county_id, c.name as county_name,
	agg.falls_count
from county c
	inner join ( select u.county_id, count(*) as falls_count from upfall u group by u.county_id ) agg
		on c.id = agg.county_id;
--
-- conversion pg 93
--
select char(100.12345), char(decimal('100.12345', 5, 2)) from pivot where x=1;

--
--  hierarchical queries pg 8
--
select id, name, type, parent_id
from gov_unit
start with parent_id is null
connect by parent_id = prior id;

--
--  Recursive pg 62
--
with recursiveGov (depth, id, parent_id, name, type) as
(
	select 1, parent.id, parent.parent_id, parent.name, parent.type
	from gov_unit parent where parent.parent_id is null
	union all
	select parent.depth+1, child.id, child.parent_id, child.name, child.type
	from recursiveGov parent, gov_unit child
	where child.parent_id = parent.id)
select depth, id, parent_id, name, type from recursiveGov


--
-- I converted a SQL mag example to DB2
--

-- notice that to use identity for DB2 you have to add additional
-- statements.  It works
--
CREATE TABLE LIKETest(
    id      decimal(6) not null
	generated always as  IDENTITY (
	start with 1 increment by 1
	maxvalue 999999
	cache 20 no order),
    Name    varchar(1000),
    phone   varchar(1000),
    last_movie_release  date,
    amount  varchar(1000),
    comments varchar(1000)
);

CREATE INDEX IX_LIKETest ON LIKETest(Name);

-- dates in DB2 need the dash
INSERT INTO LIKETest(Name, phone, last_movie_release, amount, comments)
VALUES
    ( 'Bruce Wayne',     'Confidential',   '2012-07-20', '35131'        , 'Reach at email: bwayne@WayneIndustries.com'),
    ( 'Clark Kent',      '8457390095',     '2013-06-14', '58455.64'     , 'Work email: ckent@daily_planet.com'),
    ( 'Richard Grayson', '212-555-0187',   '1997-06-20', '.63521'       , 'Known as Dick Grayson'),
    ( 'Diana Prince',    '849-555-0139',   NULL      , '58485.'       , 'Amazon princess, treat with respect'),
    ( 'J''onn J''onzz',  'N/A',           NULL      , '-15612'       , 'Last Martian'),
    ( 'Barry Allen',     '(697) 555-0142', NULL      , '-1.5413'      , 'Too fast'),
    ( 'Reed Richards',   '917-330-2568',   '2015-08-07', '-4156-15'     , NULL),
    ( 'Susan Storm',     '917-970-0138',   '2015-08-07', '156.516.51'   , NULL),
    ( 'Johnny Storm',    '917-913-0172',   '2015-08-07', '665465-'      , NULL),
    ( 'Ben Grimm',       '917-708-0141',   '2015-08-07', 'One Thousand' , NULL),
    ( 'Peter Parker',    '917-919-0140',   '2014-05-02', '56E6546'      , 'With great power comes great responsibility'),
    ( 'Tony Stark',      '492-167-0139',   '2013-05-03', '$'            , ''),
    ( 'Wade Wilson',     '692-257-1937',   NULL      , 'ss'           , 'Just 50% hero'),
    ( 'Bruce Banner',    '781-167-4628',   '2008-06-13', 'FFFFFF'       , 'sdo@a#%^add34.voi');

--
--  queries on the table above
--
SELECT *
 FROM LIKETest
 WHERE Name LIKE '___n%';

SELECT *
 FROM LIKETest
 WHERE Name LIKE '%n___';

--
-- to check for numerics.  To date have not found a good example for DB2
--
SELECT id, name, amount, 
CASE
  WHEN LENGTH(RTRIM(TRANSLATE(amount, '*', ' -.0123456789'))) = 0 
  THEN 'All digits'
  ELSE 'No'
END AmtNumeric
 FROM LIKETest

 select u.id, u.county_id, u.northing n1,
	min(u.northing) over (partition by u.county_id) n2,
	avg(u.northing) over () n3,
	max(u.northing) over (partition by u.open_to_public) n4
from sqlpocket.upfall u;


SELECT XML2CLOB(
    XMLELEMENT(NAME "falls",
        XMLAGG(xmlelement(name "fall", xmlattributes(m.id),
            xmlelement(name "name", m.name),
            xmlelement(name "desc", m.description)
       )
    ))) as theFalls
    FROM upfall M
fetch first 100 rows only

===========================  work on the dashboard ===============================
--
-- dashboard data
--
SELECT MFMOHR.AYBMNB, MFMOHR.AYWDNB, MFMOOP.A0A4NB, MFMOOP.A0AQNB, MFMOOP.A0A3CD, MFMOOP.A0A2DT, MFMOOP.A0A3DT,  
case  when SQTbl.ttforv is null then '0' else cast(SQTbl.ttforv as integer)  end SqFt
 from S10A3A30.vt2662afvp.mfmohr mfmohr 
    left join S10A3A30.vt2662afvp.mfmoop mfmoop on mfmohr.aya4nb = mfmoop.a0a4nb
left join (select ttorno, ttline, ttforv from S10A3A30.vt2662afvp.z3dr503a where ttytcd like '%SF') SQTbl on mfmohr.aybmnb = ttorno and mfmohr.aywdnb = ttline
where a0a3dt = 20150706 order by aybmnb, aywdnb, a0a4nb, a0aqnb
--
-- the openquery version
--
select * from
openquery(vt2662afvp,'
select aybmnb, aywdnb, a0a4nb, a0aqnb, a0a3cd, a0a2dt as "Start Date", a0a3dt as "Completion date",
  case  when SQTbl.ttforv is null then ''0'' else SQTbl.ttforv end SqFt
 from vt2662afvp.mfmohr MFG 
    left join vt2662afvp.mfmoop Moop on MFG.aya4nb = Moop.a0a4nb
left join (select ttorno, ttline, ttforv from vt2662afvp.z3dr503a where ttytcd like ''%SF'') SQTbl on MFG.aybmnb = ttorno and MFG.aywdnb = ttline
where a0a3dt = 20150630 order by aybmnb, aywdnb, a0a4nb, a0aqnb')
--  the attr table
select * from vt2662afvp.z3dr503a where ttorno = 10133741
--  ttorno = 10133741;
select * from vt2662afvp.z3dr503a where ttytcd like '%SF%' and ttorno > 10133740;
--select * from vt2662afvp.mfcisa where boshce like '%10133741%';
--
-- verify my counts
--
SELECT count(*)
 from vt2662afvp.mfmohr mfmohr 
	left join vt2662afvp.mfmoop mfmoop on mfmohr.aya4nb = mfmoop.a0a4nb
	left join (select ttorno, ttline, ttforv from vt2662afvp.z3dr503a where ttytcd like '%SF') SQTbl 
		on mfmohr.aybmnb = ttorno and mfmohr.aywdnb = ttline
where a0a3dt = 20150715 and a0a3cd = 'DIPRT' and ayavst <> 60

select * from vt2662afvp.z3dr503a where ttorno = 10134950 and ttline = 10 and trim(ttytcd) like '%SF'

SELECT OHORNO,OlLINE, A0A4NB, A0AQNB, A0A3CD, aybrnb, A0A3DT,  
	case  when SQTbl.ttforv is null then '0' else cast(SQTbl.ttforv as integer) end SqFt
 from VTCUSTOM.IBSSTATA 
	left join (select ttorno, ttline, ttforv from vt2662afvp.z3dr503a where trim(ttytcd) like '%SF') SQTbl 
		on OHORNO = ttorno and OlLINE = ttline
where OHORDS<>'60' and OHORDS<>'0' and AYA4NB>'1' and a0a3cd = 'VIPRX' and AYBRNB = 4 and a0aqnb = 20 order by OHORNO,OlLINE, a0a4nb, a0aqnb


SELECT OHORNO,OlLINE, A0A4NB, A0AQNB, A0A3CD, aybrnb, ayqty, aya0dt, 
	CAST( 
    	LPAD( RTRIM( CHAR( INTEGER(A0A3DT/1000000 ))), 2, '0' ) || '/' || LPAD( RTRIM( CHAR( MOD( A0A3DT/10000, 100 ))), 2, '0' )  || '/' || MOD( A0A3DT, 10000 ) 
AS CHAR(10)) 
AS chardateresult,
	case  when SQTbl.ttforv is null then '0' else cast(SQTbl.ttforv as integer) end SqFt
 from VTCUSTOM.IBSSTATA 
	left join (select ttorno, ttline, ttforv from vt2662afvp.z3dr503a where trim(ttytcd) like '%SF') SQTbl 
		on OHORNO = ttorno and OlLINE = ttline
where OHORDS<>'60' and OHORDS<>'0' and AYA4NB>'1' and olhsol <> 'Y' order by OHORNO,OlLINE, a0a4nb, a0aqnb

-- current query to 
SELECT OHORNO,OlLINE, A0A4NB, A0AQNB, A0A3CD, aybrnb, (ayqty + ayedqt) - a0bqqt as ayqty, 
	DATE(INSERT(INSERT(LEFT(CHAR(aya0dt),8),5,0,'-'),8,0,'-')) aya0dt, A0A3DT, 
	case  when SQTbl.ttforv is null then '0' else (cast(SQTbl.ttforv as integer) * (ayqty + ayedqt) - a0bqqt) end SqFt
 from VTCUSTOM.IBSSTATA 
	left join (select ttorno, ttline, ttforv from vt2662afvp.z3dr503a where trim(ttytcd) like '%SF') SQTbl 
		on OHORNO = ttorno and OlLINE = ttline
where OHORDS<>'60' and OHORDS<>'0' and AYA4NB>'1' and olhsol <> 'Y' order by OHORNO,OlLINE, a0a4nb, a0aqnb

===================== Delivery addr  ======================
--
--  10136956 two shipping add
--
--  delivery report
select thorno, thplno, oaadr1, oaadr2, oaadr3, oaadr4, oapocd
from (select  thorno, thplno, max(thz3evdt) maxdate from vt2662afvp.z3optrh 
		where thz3pstc = 'LO'
		group by thorno, thplno)
	left join VT2662AFvp.SRoorspl on thorno = olorno and thplno = olplno
	left join vt2662afvp.sroorsa on olorno = oaorno and olline = oaline

--
-- Don't forget to remove the freight line
--
SELECT thorno, olline, olplno, THZ3EVDT, THZ3EVTM, THCSTRCN FROM VT2662AFVP.Z3OPTRH 
	left join VT2662AFvp.SRoorspl on thorno = olorno and thplno = olplno and olprdc <> 'FREIGHT'
WHERE THZ3CRRC = 'FEDEX' and THCSTRCN = '647253808095'

--  help queries
select * from VT2662AFVP.Z3OPTRH where thorno in (10130641);
select * from  VT2662AFVP.Z3OPTRD where evcstrcn in (select thcstrcn from VT2662AFVP.Z3OPTRH where thorno in (10130641));
select * from  VT2662AFVP.Z3OPTRPD where pdcstrcn in (select thcstrcn from VT2662AFVP.Z3OPTRH where thorno in (10130641));


-- verify order
SELECT OHORNO, ohcuno, ohcope, olline, olplno, olprdc, oaadr1
	FROM VT2662AFvp.SROORSHE sheader
	left join VT2662AFvp.SROORSPL sline on sheader.ohorno = sline.olorno
	left join vt2662afvp.sroorsa on olorno = oaorno and olline = oaline
 WHERE ohorno =10136956

select * from VT2662AFVP.Z3OPTRH where thz3pstc = 'LO' order by thz3evtm, thz3evdt desc;

select * from VT2662AFVP.Z3OPTRH where thorno in (10124216 );
select * from  VT2662AFVP.Z3OPTRD where evcstrcn in (select thcstrcn from VT2662AFVP.Z3OPTRH where thorno in (10124216 ));
select * from  VT2662AFVP.Z3OPTRPD where pdcstrcn in (select thcstrcn from VT2662AFVP.Z3OPTRH where thorno in (10124216 ));

select * from VT2662AFvp.SRoorsa where oaorno = 10124216 

with FedOrders (customer, ordernu, linenu, picklst, tracknu, estddt, qty, desc, design) as
(
	select olcuno, thorno, olline, thplno, thcstrcn, thz3eddt, oloqty, oldesc, olshpm
		from (select  thorno, thplno, thcstrcn, thz3eddt from vt2662afvp.z3optrd feddtl
			 left join vt2662afvp.z3optrh fedhdr on evcstrcn = thcstrcn
			where evz3pstc = 'PU' and evz3evdt = 20151111)
		left join VT2662AFvp.SRoorspl on thorno = olorno and thplno = olplno
)
select customer, ordernu, linenu, picklst, tracknu, estddt, qty, desc, 
	ohcope as advertiser, design, oaname, oaadr1, oaadr2, oaadr3, oaadr4, oapocd 
	from FedOrders
	left join vt2662afvp.sroorsa on ordernu = oaorno and linenu = oaline
	left join vt2662afvp.sroorshe on ordernu = ohorno
where (oaname like 'CCO%') or (oaname like 'Clear%') or (oaname like 'clear%')
 order by customer, ordernu, linenu, picklst

select  thorno, thplno, thcstrcn, thz3eddt from
	 vt2662afvp.z3optrd feddtl
	 left join vt2662afvp.z3optrh fedhdr on evcstrcn = thcstrcn
where evz3pstc = 'PU' and evz3evdt = 20151111
order by thorno

call vt2662ap.shippingreport(20160208);

select olorno, olline, olplno, thz3eddt, olcuno, olords, aya4nb as "MFG NU", ayavst, aybrnb, aybpnb, thz3delv, thz3crrc, thz3pstc,
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
	end Status, evz3pstd
from vt2662afvp.sroorspl OLine
	left join vt2662afvp.mfmohr MFG on Oline.olorno = MFG.aybmnb and Oline.olline = MFG.aywdnb
	left join vt2662afvp.z3optrh FedHdr on OLine.OLorno = FedHdr.Thorno and OLine.olline = FedHdr.THline and thstat <> 'D'
	left join vt2662afvp.z3optrd feddtl on fedhdr.thcstrcn = feddtl.evcstrcn and fedhdr.thz3evdt = feddtl.evz3evdt and fedhdr.thz3evtm = feddtl.evz3evtm
where olstat <> 'D' and olorno in (10145434, 10145700, 10145569, 10145638, 10145654, 10145403)
order by olorno, olline
=============================  Work on the Order Flow Log ==================================
-- list of AR orders with no AP entry  now if a line had AP line we would need to mod this sql
--
select * from vt2662aftt.sroofl where oflid2 = 'AR' and oforno not in (
	select oforno from vt2662aftt.sroofl where oflid2 = 'AP'
);

--
--  insert into the log entries for AP
--
insert into vt2662aftt.sroofl (oflid1, oforno, ofline, ofdate, oftime, oflid2, ofordt, ofsrom, ofprdc, ofords, ofstat)
	( select 'SO',  oforno, ofline, ofdate, oftime + 20,  'AP', 'OO', 'VPI',  ofprdc, 20, 'P'
	from vt2662aftt.sroofl where oforno = 10059355 and ofline = 10 and oflid2 = 'AR')

--
-- using the above insert I want to see if I do not receive the overnight
--
select * from vt2662aftt.sroofl where oforno = 10059355
--
-- if everything looks good then I will run the following
--
insert into vt2662aftt.sroofl (oflid1, oforno, ofline, ofdate, oftime, oflid2, ofordt, ofsrom, ofprdc, ofords, ofstat)
	( select 'SO',  oforno, ofline, ofdate, oftime + 20,  'AP', 'OO', 'VPI',  ofprdc, 20, 'P'
	from vt2662aftt.sroofl where oflid2 = 'AR' and oforno not in (
	select oforno from vt2662aftt.sroofl where oflid2 = 'AP'))

select (select count(*) from vt2662afvp.sroofl where oflid2 in ('TS', 'TD') and ofdate > 20151018) as total,
	 (select count(*) from vt2662afvp.sroofl where oflid2 = 'TS' and ofdate > 20151018 and ofline = 0) as TSNoline,
	 (select count(*) from vt2662afvp.sroofl where oflid2 = 'TS' and ofdate > 20151018 and ofline > 0) as TSHasline,
	 (select count(*) from vt2662afvp.sroofl where oflid2 = 'TD' and ofdate > 20151018 and ofline = 0) as TDNoline,
	 (select count(*) from vt2662afvp.sroofl where oflid2 = 'TD' and ofdate > 20151018 and ofline > 0) as TDHasline
from sysibm.sysdummy1


select oforno, ofline, 1 as serial, oflid2, max(ofdate) date, max(oftime) time from vt2662afvp.sroofl where oforno = 10181644 and oflid2 = 'OC' group by oforno, ofline, oflid2
union
select oforno, ofline, 2 as serial, oflid2, max(ofdate) date , max(oftime) time from vt2662afvp.sroofl where oforno = 10181644 and oflid2 = 'AP' group by oforno, ofline, oflid2
union
select oforno, ofline, 3 as serial, oflid2, max(ofdate) date , max(oftime) time from vt2662afvp.sroofl where oforno = 10181644 and oflid2 = 'TS' group by oforno, ofline, oflid2
order by oforno, ofline, serial, oflid2 desc, date, time

===================================  XML work  ==========================================
SELECT XML2CLOB(
    XMLELEMENT(NAME "my_object",
        XMLATTRIBUTES(M.Name AS "column_1", M.County_id)
    )) as xml
    FROM upfall M
fetch first 100 rows only


======================= reset MO ===================
--
--   Order aybmnb  Line aywdnb
--
update vt2662aftt.mfmohr 
	set ayavst = 20, aybpnb = 0, aybkcd = '', aybrnb = 0 
where aybmnb = 10059791 and aywdnb = 20;
update VT2662AFTT.mfmoop
	set a0a2dt = 0, a0a3dt = 0, a0a4st = 0
where a0a4nb = 293039 and a0aqnb = 10;


	select * from vt2662aftt.mfmohr where aybmnb = 10059791;
select * from VT2662AFTT.mfmoop where a0a4nb = 293038;

select * from vt2662aftt.mfmohr where aybmnb = 10059752;
select * from VT2662AFTT.mfmoop where a0a4nb = 293032;