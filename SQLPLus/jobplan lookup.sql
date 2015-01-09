--select count(*) from MAXIMO.TVABSLATTACHMENT
--
-- list twenty five jobplans
--
--  need to supply the variable jobplan which is JOBPLAN%
--
var jobplan varchar2(20);
exec :jobplan := 'JOBPLAN%';
select * from (select * from MAXIMO.TVABSLATTACHMENT where mboid like :jobplan)
where ROWNUM <= 25;
--  JOBPLAN:000281001
--  JOBPLAN:001151001
--  JOBPLAN:001151002
--  JOBPLAN:001221000
--  JOBPLAN:001371000 several
--  JOBPLAN:002110000
--  JOBPLAN:002411000
--
-- search for a jobplan in the tvabslattachment table
-- supply a value of JOBPLAN:17983
--
var jp varchar2(20);
exec :jp := 'JOBPLAN:0-11-006-082';
select * from MAXIMO.TVABSLATTACHMENT where mboid like :jp
--
-- search for the given mbo
-- 
-- supply the following format WORKORDER:SQN:113583579
--
var mbo varchar2(30);
exec :mbo := 'WORKORDER:SQN:113583579';
select * from MAXIMO.TVABSLATTACHMENT where mboid = :mbo;
--
select * from MAXIMO.TVABSLATTACHMENT where mboid = :mbo and description = 'LIBRARY'
union
select * from MAXIMO.TVABSLATTACHMENT where mboid = :mbo and description = 'ASSOCIATED';

select * from MAXIMO.TVABSLATTACHMENT where description <> 'ASSOCIATED' and description <> 'LIBRARY' and description <> 'STATUS'

--delete from MAXIMO.TVABSLATTACHMENT where tvabslattachmentid in (4576447,4576448, 4576449, 4576450, 4576451) 