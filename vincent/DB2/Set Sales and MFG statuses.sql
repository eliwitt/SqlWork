--
-- an order was created that had several line that where processed by a 3rd party
--
--  Thank god the order lines had pick list number with them so I inserted fedex rows for those lines
--
SELECT * FROM table(VTCUSTOM.udtf0001t('C01803',20161201,20161229,'C', '' )) as t where ordqty > 0 and ordno = 10178811

insert into vt2662afvp.z3optrh (thz3crrc, thcstrcn, thz3delv, thz3evdt, thz3evtm, thplno, thorno, thline)
values('FEDEX', 'delivered 12/28 override', ' ', 20161228, 150730, 2237429, 10178811, 20)

-----------------------------------------------------------------------------------------------------------------
--
-- locate the planner view order
--  10171209
Select AYA4NB,OHORDT,OHODAT,AYA0DT,AYBMNB,OLTODC,ohords,OLMOTC,
OHNAME,OHCOPE,OLSHPM,OANAME,OAADR1,OAADR4,OAPOCD,AYBRNB,
AYABTS,(AYQTY + AYEDQT)- A0BQQT,AYAVST,A0A4ST,AYPRDC,AYHATX,OHORNO,
OALINE,NOSHAN,OHHAND,OlORDS,A0AQNB,OLHSOL	
From VTCUSTOM.IBSSTATA	
where ohorno in (10171209, 10171242) 

-- set the status on the hdr
-- planner view does not look at ohstat and this causes trouble
-- so I have to set the ohords and olords to 60  because the system
-- does not set them if you delete the record
--
update  vt2662afvp.sroorshe set ohords = 60  where ohorno = 10209283
--
-- lines too
--
update  vt2662afvp.sroorspl set olords = 60  where olorno = 10209283

-- look at common orders
--
select aya4nb, ayavst, aybmnb, aywdnb, ayaavn, ayprdc, aybpnb, aybkcd, aybrnb 
from vt2662afvp.mfmohr where aya4nb in (526767, 526828) order by aya4nb

-- set the mfg hdr 
update  vt2662afvp.mfmohr set ayavst = 10, aybrnb = 0, aybkcd = '', aybpnb = 0, aya2dt = 0  where aya4nb = 

-- set the hdr to 20 on stuck mo
update  vt2662afvp.mfmohr set ayavst = 20  where aya4nb =

-- set the status on the order line
update  vt2662afvp.sroorspl set olords = 60  where olorno = 10171209 and olline = 10 

-- check the mfg oop lines ------------------------------------
select * from VT2662AFVP.mfmoop where a0a4nb = 526767

select a0a4nb, a0aqnb, a0a2dt, a0a3dt, a0a4st 
from VT2662AFVP.mfmoop where a0a4nb = 572655 order by a0aqnb 

-- set the moop entries -----------------------------------------
update  vt2662afvp.mfmoop set a0a2dt = 20160826, a0a3dt = 20160826, a0a4st = 60  where a0a4nb = 526767 and a0aqnb > 10
-- reset a mo operation
update  vt2662afvp.mfmoop set a0a2dt = 0, a0a3dt = 0, a0a4st = '' where a0a4nb = 563023 and a0aqnb = 10;


-- aaron's fat finger
update  vt2662afvp.mfmoop set a0a2dt = 20170428, a0a3dt = 20170428 where a0a4nb = 562969 and a0aqnb = 10;

update  vt2662afvp.mfmohr set aybrnb = aybrnb + 1  where aya4nb in (
562969
)