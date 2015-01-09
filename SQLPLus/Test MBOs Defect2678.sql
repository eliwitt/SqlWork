-- request a report for an MBO
-- 
--  check the rows of the test MBOs
--  mbos 
--  25th  (237855567, 237793350, 35086928, 34791198)  did not show up
--  26th (237763480, 237771781, 237861900)
select * from MAXIMO.TVABSLNOTIFYPROC where ownerid = 237815810;
-- report table
select * from MAXIMO.TVABSLreport where keyid in (237763480, 237771781, 237861900);
