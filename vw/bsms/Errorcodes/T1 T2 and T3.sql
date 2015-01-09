select * from wACom.T1Errors
--iNSERT INTO wACom.T1Errors (t1plant, t1desc, t1active) VALUES (3,'Start here overtype the text', 0)
--delete from wACom.t3errors

select * from wACom.t2errors
--insert into wacom.t2errors values(1,'Second level overtype this text', 0)
--insert into wacom.t2errors values(2, 'Second level overtype this text', 0)
--insert into wacom.t2errors values(3, 'Second level overtype this text', 0)


select * from wACom.t3errors
--insert into wacom.t3errors values (1, 'Third level overtype this text', 0)
--insert into wACom.t3errors values (2, 'Third level overtype this text', 0)
--insert into wACom.t3errors values (3, 'Third level overtype this text', 0)



select T1.t1id, t1desc, t1active, T2.t2id, t2desc, t2active, t3id, t3desc, t3active
from wACom.T1Errors T1
left join wACom.t2errors T2 on T1.t1id = T2.t1id
left join wACom.t3errors T3 on T2.t2id = T3.t2id
--
-- delete from the root of the tree
--
update TCodes set t3active =1
from ( select t3active
	from wACom.T1Errors T1
		left join wACom.t2errors T2 on T1.t1id = T2.t1id
		left join wACom.t3errors T3 on T2.t2id = T3.t2id where T1.t1id = 1) as TCodes
update TCodes set t2active = 1
from ( select t2active
	from wACom.T1Errors T1
		left join wACom.t2errors T2 on T1.t1id = T2.t1id
		left join wACom.t3errors T3 on T2.t2id = T3.t2id where T1.t1id = 1) as TCodes
update wACom.T1Errors set t1active = 1
where t1id = 1
		
--
-- delete from the second level
--
update TCodes set t3active =1
from ( select t3active
	from wACom.t2errors T2 
		left join wACom.t3errors T3 on T2.t2id = T3.t2id where T2.t2id = 2) as TCodes
update wACom.t2errors set t2active = 1
where t2id = 2
--
--  delete from the thrid level
--
update wACom.t3errors set t3active = 1
where t3id = 3
--
--  update and inserts work follow
--
-- first lets review the data
select T1.t1plant, T1.t1id, t1desc, t1active, T2.t2id, t2desc, t2active, t3id, t3desc, t3active
from wACom.T1Errors T1
left join wACom.t2errors T2 on T1.t1id = T2.t1id
left join wACom.t3errors T3 on T2.t2id = T3.t2id
where t1plant = 3 and t1desc = '1A03-SQM-RB101'
--
-- now update the description field
update wACom.T3Errors set t3desc = 'Test' where t3id = 4