-- request a report for an MBO
select * from MAXIMO.TVABSLJOBRECORD where recordid in (81951, 161102, 149018, 17258);
-- the attachment table
select * from MAXIMO.TVABSLATTACHMENT where mboid like '%329230%';
-- let's look at the attahment for report errors
select * from MAXIMO.TVABSLATTACHMENT where description = 'STATUS' and 
bslvalue like 'Fail: Error retrieving report%';
select * from MAXIMO.TVABSLATTACHMENT where description = 'STATUS' and 
bslvalue like '%PDF%';
--  check the status of the MBO
select * from MAXIMO.TVABSLNOTIFYPROC where ownerid = 237999387;
-- report table
select * from MAXIMO.TVABSLreport where keyid in (81951, 161102, 149018, 17258)
--delete from MAXIMO.TVABSLJOBRECORD where recordid = 237815810;
--select keyid, reporturl, tvabslreportid  from MAXIMO.TVABSLreport where transdate > '17-MAY-12'