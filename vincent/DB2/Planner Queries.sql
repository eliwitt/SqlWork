--  Plannerview uses a view that does not contain ohstat which indicates a deleted order
--  so sometimes I have to set the ohords to 60 so the filter will kick in.
--
--  You can use powershell and search the INI files to see some of the queries.
--  The following searches for "fromfiles" to view all of the tables in plannerview.
--
--  Select-String -Path ".\VPI\*.ini" -Pattern fromfiles
--
--  There are several strings to search for such as: select, fromfiles, and filterfiles.
--  You can look in one of the ini files to see other items to search for.
--
select * from VT2662AFVP.mfmoop where a0a4nb = 235646;

select ohorno, ohords from vt2662afvp.sroorshe where ohorno  in (10027907, 10027908, 10027910, 10032185, 10036064, 10096787, 10096762, 10178444, 10184452) ;

update vt2662afvp.sroorshe set ohords = 60  where ohorno  in (10027907, 10027908, 10027910, 10032185, 10036064, 10096787, 10096762, 10178444, 10184452) ;

Select AYA4NB,OHORDT,OHODAT,AYA0DT,AYBMNB,
OLTODC,OLMOTC,OHNAME,OHCOPE,OLSHPM,
OANAME,OAADR1,OAADR4,OAPOCD,
AYBRNB,AYABTS,(AYQTY + AYEDQT)- A0BQQT,AYAVST,A0A4ST,AYPRDC,AYHATX,
OHORNO, ohstat, OALINE,NOSHAN,OHHAND,OlORDS,A0AQNB,OLHSOL
from VTCUSTOM/IBSSTATA
where ohorno = 10207959 and OHORDS<>'60' and OHORDS<>'0'and AYA4NB>'1' /* heading=name */