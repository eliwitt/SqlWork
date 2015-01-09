--select count(*) from MAXIMO.TVABSLATTACHMENT
select * from (select * from MAXIMO.TVABSLATTACHMENT)
where ROWNUM <= 5;

select * from MAXIMO.TVABSLATTACHMENT where mboid like '%352283%'


select * from (select * from MAXIMO.TVABSLATTACHMENT where mboid = 'TICKET:SQN:PROBLEM:505058')
where bslvalue = 'SUCCEED' and ROWNUM <= 5;

select * from MAXIMO.TVABSLATTACHMENT where mboid like '%PO:100758%'

select * from MAXIMO.TVABSLATTACHMENT where description = 'STATUS' and 
(bslvalue <> 'SUCCEED' and bslvalue <> 'Succeed')
--
--  locate the failed rows in the dev database
--
select count(*) from MAXIMO.TVABSLATTACHMENT where description = 'STATUS' and 
bslvalue like 'Fail: Error retrieving report%';
select count(*) from MAXIMO.TVABSLATTACHMENT where description = 'STATUS' and 
bslvalue like 'Fail: no_lib_found%';
select count(*) from MAXIMO.TVABSLATTACHMENT where description = 'STATUS' and 
bslvalue like 'Fail: no_lib_configured%';
select count(*) 
    from 
    (select (case
                    when bslvalue like 'Fail: Error retrieving report%' then '1'
                    when bslvalue like 'Fail: no_lib_found%' then '1'
                    when bslvalue like 'Fail: no_lib_configured%' then '1'
                    else '0' 
                  end) FailType, attach.*
            from MAXIMO.TVABSLATTACHMENT attach
            where description = 'STATUS' and 
            bslvalue like 'Fail%') Failures
where  Failures.FailType = '0';
select count(*) from MAXIMO.TVABSLATTACHMENT where description = 'STATUS' and 
bslvalue like 'Fail%';
--
-- the following retrieves the eleven remaining rows
--
select Failures.* 
    from 
    (select (case
                    when bslvalue like 'Fail: Error retrieving report%' then '1'
                    when bslvalue like 'Fail: no_lib_found%' then '1'
                    when bslvalue like 'Fail: no_lib_configured%' then '1'
                    else '0' 
                  end) FailType, attach.*
            from MAXIMO.TVABSLATTACHMENT attach
            where description = 'STATUS' and 
            bslvalue like 'Fail%') Failures
where  Failures.FailType = '0';