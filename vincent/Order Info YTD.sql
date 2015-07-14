select * 
into vpi.orders201506YTD
from
openquery(vt2662afvp,'
select distinct ohcuno, ohorno, olline, olscpr, ohodat, oloqty, olcqty, aya4nb, a0a3cd, ayprdc, boprdc, ayhatx
 from vt2662afvp.sroorshe SOHdr
    left join vt2662afvp.sroorspl Oline on SOHdr.ohorno = Oline.olorno and Oline.olshpm <> ''FREIGHT''
    left join vt2662afvp.mfmohr MFG on Oline.olorno = MFG.aybmnb and Oline.olline = MFG.aywdnb
    left join vt2662afvp.mfmoop Moop on MFG.aya4nb = Moop.a0a4nb and Moop.a0aqnb = 20
    left join vt2662afvp.mfcisa cfgparent on Oline.olprdc = cfgparent.boshce 
where a0a2dt between 20150101 and 20150614 order by ohcuno, ohorno, olline')
-- opers
select * 
 into vpi.opers201506YTD
from
openquery(vt2662afvp,'
select distinct ohcuno, ohorno, olline, a0a4nb, a0aqnb, a0a3cd, a0a2dt as "Start Date", a0altm as "Start time", a0a3dt as "Completion date", a0aitm as "Completion time"
 from vt2662afvp.sroorshe SOHdr
    left join vt2662afvp.sroorspl Oline on SOHdr.ohorno = Oline.olorno and Oline.olshpm <> ''FREIGHT''
    left join vt2662afvp.mfmohr MFG on Oline.olorno = MFG.aybmnb and Oline.olline = MFG.aywdnb
    left join vt2662afvp.mfmoop Moop on MFG.aya4nb = Moop.a0a4nb
where a0a2dt between 20150101 and 20150614 order by ohcuno, ohorno, olline, a0a4nb, a0aqnb')

-- cfgitems
select * 
 into vpi.cfgitems201506YTD
from
openquery(vt2662afvp,'
select distinct olprdc, boyvcd, boyxcd, boogqt
 from  vt2662afvp.sroorshe SOHdr
    left join vt2662afvp.sroorspl Oline on SOHdr.ohorno = Oline.olorno and Oline.olshpm <> ''FREIGHT''
	 left join vt2662afvp.mfmohr MFG on Oline.olorno = MFG.aybmnb and Oline.olline = MFG.aywdnb
left join vt2662afvp.mfmoop Moop on MFG.aya4nb = Moop.a0a4nb
    left join vt2662afvp.mfcisa CfgItem on mfg.ayprdc = CfgItem.boshce
where a0a2dt between 20150101 and 20150614 and boyvcd is not null order by olprdc, boyvcd')