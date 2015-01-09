--  527289  614596
select * from policy where policynumber = '10039'
exec SP_Claims_GetDriverListAtTOL '10039', '2010-08-05'
select * from operator where policyptr = 614596
update operator set dlstate = 'XX' where policyptr = 614596