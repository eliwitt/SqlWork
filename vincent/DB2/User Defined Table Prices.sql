--select * from vt2662afvp.mfudtd where ciubce = 'WOCUSTPRIC' and ciuece = '7 OZ'
--select * from vt2662aftt.mfudtd where ciubce = 'WBU70' and ciuece = 'Rigid Vinyl';
--insert into vt2662aftt.mfudtd (ciubce, ciagdt, ciuece, ciufce, cixsqt) values('WBU70','20140529','RIGID VINYL','C00001', 1.10),('WBU70','20140529','SAV','C00001', 2.12)
--update vt2662aftt.mfudtd set ciuece = 'RIGID VINYL' where ciubce = 'WBU70' and ciufce = 'C00001' and ciuece = 'Rigid Vinyl';
--select * from vt2662afvp.mfudtd where ciubce = 'WOCUSTPRIC' and ciuece = 'PE' and ciufce in ('C00174', 'C00248', 'C00387', 'C00875', 'C00940', 'C00944')
--update vt2662afvp.mfudtd set cixsqt = .4 where ciubce = 'WOCUSTPRIC' and ciufce in ('C00174', 'C00248', 'C00387', 'C00875', 'C00940', 'C00944') and ciuece = 'PE';
insert into vt2662afvp.mfudtd (ciubce, ciagdt, ciuece, ciufce, cixsqt) 
values('WOCUSTPRIC','20140602','10 OZ','C00415', .42),
          ('WOCUSTPRIC','20140602','12 OZ','C00415', .51),
('WOCUSTPRIC','20140602','15 OZ BACKLIT','C00415', 1.37),
            ('WOCUSTPRIC','20140602','7 OZ','C00415', .35),
                ('WOCUSTPRIC','20140602','PE','C00415', .35),
        ('WOCUSTPRIC','20140602','MESH','C00415', 1.25);
