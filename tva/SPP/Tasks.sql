select task.id, step.title, deadline, done, kind.label kind, 
	step.id step,rev.status revstatus 
from task 
	join step on task.step = step.id 
	join kind on step.kind = kind.id 
	join rev on task.rev = rev.id 
where rev = 100313

select * from task where id in (1112, 1113, 1114, 1115, 1116)
select * from step where id in (2, 3, 4, 5, 6)
select * from kind where id in (1, 2, 3)
--select * from task where done is not null

update task set kind = 'revision' where id = 1116