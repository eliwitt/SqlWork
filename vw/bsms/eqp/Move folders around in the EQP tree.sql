select * from wACom.lines where LILineName like 'BSOR'
--update wACom.lines set LIActive = 0 where LIID in (139, 140)
select * from wACom.machinelist where MLCELLNAME like '3899 Stotz BSOR%'
--update wACom.machinelist set MLLINEID = 9 where MLID = 392
select * from wACom.lines where LISatellite = 5