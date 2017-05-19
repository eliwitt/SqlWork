-- 
-- create new table for testing
--
drop table newstate;
create table newstate (
	id		integer,
	name		varchar(10),
	population	integer
        );

insert into newstate values (20, 'Steve', 250100);
insert into newstate values (21, 'Jean', 100150);
insert into newstate values (3, 'Peter', 500150);
COMMIT;
