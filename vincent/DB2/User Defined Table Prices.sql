--  statements to handle the pricing tables
--
select * from vt2662afvp.mfudtd where ciubce = 'WOCUSTPRIC' and ciufce = 'C01298'
union
select * from vt2662afvp.mfudtd where ciubce = 'TRIWPRICE' and ciufce = 'C01298';

--select * from vt2662afvp.mfudtd where ciubce = 'WOCUSTPRIC' and ciuece = '7 OZ'
--select * from vt2662aftt.mfudtd where ciubce = 'WBU70' and ciuece = 'Rigid Vinyl';
--insert into vt2662aftt.mfudtd (ciubce, ciagdt, ciuece, ciufce, cixsqt) values('WBU70','20140529','RIGID VINYL','C00001', 1.10),('WBU70','20140529','SAV','C00001', 2.12)
--update vt2662aftt.mfudtd set ciuece = 'RIGID VINYL' where ciubce = 'WBU70' and ciufce = 'C00001' and ciuece = 'Rigid Vinyl';
--select * from vt2662afvp.mfudtd where ciubce = 'WOCUSTPRIC' and ciuece = 'PE' and ciufce in ('C00174', 'C00248', 'C00387', 'C00875', 'C00940', 'C00944')
--update vt2662afvp.mfudtd set cixsqt = .4 
where ciubce = 'WOCUSTPRIC' and ciufce in ('C00174', 'C00248', 'C00387', 'C00875', 'C00940', 'C00944') and ciuece = 'PE';

--
-- insert a row
--
insert into vt2662afvp.mfudtd (ciubce, ciagdt, ciuece, ciufce, cixsqt) 
values('WOCUSTPRIC','20140602','10 OZ','C00415', .42),
          ('WOCUSTPRIC','20140602','12 OZ','C00415', .51),
('WOCUSTPRIC','20140602','15 OZ BACKLIT','C00415', 1.37),
            ('WOCUSTPRIC','20140602','7 OZ','C00415', .35),
                ('WOCUSTPRIC','20140602','PE','C00415', .35),
        ('WOCUSTPRIC','20140602','MESH','C00415', 1.25);

--
-- insert a TRI row
--
insert into vt2662afvp.mfudtd (ciubce, ciagdt, ciuece, ciufce, cixsqt) 
values ('TRIWPRICE','20150914','RIGID VINYL','C00928', .92),
          ('TRIWPRICE','20150914','SAV','C00928', .92),
('TRIWPRICE','20150914','RIGID VINYL','C26731', .92),
          ('TRIWPRICE','20150914','SAV','C26731', .92),
('TRIWPRICE','20150914','RIGID VINYL','C34019', .92),
          ('TRIWPRICE','20150914','SAV','C34019', .92),
('TRIWPRICE','20150914','RIGID VINYL','C00182', .92),
          ('TRIWPRICE','20150914','SAV','C00182', .92);
--
-- change for sissy
--
select * from vt2662afvp.mfudtd where ciubce = 'WOCUSTPRIC' and ciuece = '7 OZ' and ciufce in('C20072', 'C06567', 'C01004', 'C28012', 'C00923');
update vt2662afvp.mfudtd set cixsqt = .31 where ciubce = 'WOCUSTPRIC' and ciuece = '7 OZ' and ciufce in('C20072', 'C06567', 'C01004', 'C28012', 'C00923');
--
-- discount header
--
select * from vt2662afvp.srodih 
--
-- item discount detail table
--
select * from vt2662afvp.srodid where dddmk1 in('C20072', 'C06567', 'C01004', 'C28012', 'C00923');
update vt2662afvp.srodid set dddcam = 41.00 where dddmk1 in ('C20072', 'C06567', 'C01004', 'C28012', 'C00923') and dddmk2 = 'SSP'