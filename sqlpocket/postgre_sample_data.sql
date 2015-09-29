drop table trip;
drop table upfall;
drop table gov_unit;
drop table owner;
drop table pivot;
drop table postgre_example;
drop table parent_example;
drop table township;
drop table county;
drop table state;
drop table fall_location;
drop table fall_description;
drop table new_falls;
drop table other_unit;
drop table dual;

create table gov_unit (
	id		integer NOT NULL,
	parent_id	integer DEFAULT 3,
	name		varchar(10),
	type		varchar(8),
	constraint gov_unit_pk 
		primary key (id),
	constraint gov_unit_type_chk
		check (type in ('County','Township','City','State')),
        constraint gov_unit_loop
                foreign key (parent_id)
                references gov_unit
	);

create table township (
	id		integer,
	name		varchar(10),
	population	integer
        );

create view small_township as
   select * from township 
   where population < 500;

create table county (
	id		integer not null,
	name		varchar(10),
	population	integer,
        constraint county_pk
           primary key (id)
        );


create table state (
	id		integer,
	name		varchar(10),
	population	integer
        );

create table other_unit (
	id		integer,
	name		varchar(10),
	population	integer
        );

create table owner (
	id		integer not null,
	name		varchar(15),
	phone		varchar(12),
	type		varchar(7),
	constraint owner_pk
		primary key (id),
	constraint owner_type_chk
		check (type in ('public','private'))
	);

create table upfall (
	id		integer not null,
	name		varchar(15),
	datum		varchar(7),
	zone		integer,
	northing	integer,
	easting		integer,
	lat_lon		varchar(20), 
	county_id	integer,
	open_to_public	varchar(1),
	owner_id	integer,
	description	varchar(80),
	confirmed_date	timestamp,
	constraint upfalls_pk
		primary key (id),
	constraint open_to_public_chk
		check (open_to_public in ('y','n')),
	constraint owner_id_fk
		foreign key (owner_id)
		references owner,
	constraint gov_unit_id
		foreign key (county_id)
		references county
	);

create table fall_location (
	id		integer,
	datum		varchar(7),
	zone		integer,
	northing	integer,
	easting		integer
        );

create table fall_description (
	id		integer,
	name		varchar(15),
	description	varchar(80)
        );

create table new_falls (
	id		integer,
	name		varchar(15),
	datum		varchar(7),
	zone		integer,
	northing	integer,
	easting		integer,
	lat_lon		varchar(20), 
	county_id	integer,
	open_to_public	varchar(1),
	owner_id	integer,
	description	varchar(80),
	confirmed_date	timestamp
        );

create table trip (
	name		varchar(10) not null,
	stop		integer not null,
	parent_stop	integer,
	constraint trips_pk
		primary key (name, stop),
	constraint parent_stop_fk
		foreign key (name, parent_stop)
		references trip,
        constraint stop_fk
                foreign key (stop) 
                references upfall
	);

CREATE TABLE pivot (
   x integer
   );

CREATE TABLE parent_example (
   name varchar(15) not null,
   country varchar(2) not null DEFAULT 'CA' 
      CONSTRAINT par_example_ctry 
      CHECK (country IN ('CA','US')),
   CONSTRAINT parent_example_pk
      PRIMARY KEY(name, country)
);
   
create table dual (
   dummy varchar(1)
);

insert into dual values ('X');

insert into gov_unit values (3,null,'Michigan','State');
insert into gov_unit values (2,3,'Alger','County');
insert into gov_unit values (1,2,'Munising','City');
insert into gov_unit values (4,2,'Munising','Township');
insert into gov_unit values (5,2,'Au Train','Township');
insert into gov_unit values (6,3,'Baraga','County');
insert into gov_unit values (7,3,'Ontonagon','County');
insert into gov_unit values (8,7,'Interior','Township');
insert into gov_unit values (9,3,'Dickinson','County');
insert into gov_unit values (10,3,'Gogebic','County');
insert into gov_unit values (11,3,'Delta','County');
insert into gov_unit values (12,11,'Masonville','Township');

insert into township values (4,'Munising',3125);
insert into township values (5,'Au Train',1172);
insert into township values (8,'Interior',375);
insert into township values (12,'Masonville',1877);

insert into county values (2,'Alger',9862);
insert into county values (6,'Baraga',8746);
insert into county values (7,'Ontonagon',7818);
insert into county values (9,'Dickinson',27472);
insert into county values (10,'Gogebic',17370);
insert into county values (11,'Delta',38520);

insert into state values (20, 'Montana', 902195);
insert into state values (21, 'N. Dakota', null);
insert into state values (3, 'Michigan', 9938444);

insert into owner values (1,'Pictured Rocks','906.387.2607','public');
insert into owner values (2,'Michigan Nature','517.655.5655','private');
insert into owner values (3,'AF LLC',null,'private');
insert into owner values (4,'MI DNR','906-228-6561','public');
insert into owner values (5,'Horseshoe Falls','906.387.2635','private');


insert into upfall values (1,'Munising Falls','NAD1927',16,5141184,0528971,null,2,'y',1,
                               'Munising''s namesake waterfall; the one on all the postcards',
                               timestamp '2005-12-08 19:30:00');
insert into upfall values (2,'Tannery Falls','NAD1927',16,5140000,0528808,null,2,'y',2,
                               'Like Munising Falls, but nicely undeveloped',
                               timestamp '2005-12-08 19:50:00');
insert into upfall values (3,'Alger Falls','NAD1927',16,5137795,0527046,null,2,'y',3,
                               'Nice falls at east entrance into town',
                               timestamp '2005-12-08 20:03:00');
insert into upfall values (4,'Wagner Falls','NAD1927',16,5137310,0526989,null,2,'y',4,
                               'Small, scenic falls near intersection of M-28 and M-94',
                               timestamp '2005-12-08 20:04:00');
insert into upfall values (5,'Horseshoe Falls','NAD1927',16,5138877,0527323,null,2,'y',null,
                               'Falls, garden, scenic walk, and a fish pond. Kids can feed the fish.',
                               timestamp '2005-12-08 20:07:00');
insert into upfall values (6,'Miners Falls',null,null,null,null,null,2,'y',1,
                               'Highest waterflow in the Pictured Rocks.',
                               timestamp '2005-12-08 20:10:00');
insert into upfall values (7,'Little Miners',null,null,null,null,null,2,'y',1,
                               'Scenic, must bushwhack two miles off the trail, on Little Miners River',
                               timestamp '2005-12-08 20:15:00');
insert into upfall values (8,'Scott Falls',null,null,null,null,null,2,'y',null,
                               'Scenic roadside falls near Face on the Rock',
                               timestamp '2005-12-18 21:28:00');
insert into upfall values (9,'Canyon Falls',null,null,null,null,null,6,'y',null,
                               'A few miles north of M-28 (two miles south of Alberta), but worth it',
                               timestamp '2005-12-18 21:35:00');
insert into upfall values (10,'Agate Falls',null,null,null,null,null,7,'y',null,
                               'Across road from Joseph F. Oravec Roadside Park',
                               timestamp '2005-12-18 21:35:00');
insert into upfall values (11,'Bond Falls',null,null,null,null,null,7,'y',null,
                               'Bond Falls Basin, nine miles south of Bruce Crossing',
                               timestamp '2005-12-18 21:50:00');
insert into upfall values (12,'Fumee Falls',null,null,null,null,null,9,'y',null,
                               'Start from Helen Z. Lien Roadside Park 3 1/2 miles west of Norway',
                               timestamp '2005-12-18 21:56:30');
insert into upfall values (13,'Kakabika Falls',null,null,null,null,null,10,'y',null,
                               '1/2 mile north of US-2 off of county road 527',
                               timestamp '2005-12-18 22:03:09');
insert into upfall values (14,'Rapid River Fls',null,null,null,null,null,11,'y',null,
                               'Park includes playground, barbecue pits, flowing well, picnic tables',
                               timestamp '2005-12-18 22:13:11');
insert into upfall values (30,'Twin Falls #1','NAD1927',16,5140500,0528641,null,2,'y',2,
                              'Near Twin Falls #2',
                              timestamp '2006-02-10 19:35:00');
insert into upfall values (31,'Twin Falls #2','NAD1927',16,5140500,0528663,null,2,'y',2,
                              'Near Twin Falls #1',
                              timestamp '2006-02-10 19:35:00');

insert into new_falls values (2,'Olson Falls',null,null,null,null,null,2,'y',2,
                               'Like Munising Falls, but nicely undeveloped',
                               timestamp '2005-12-08 19:50:00');
insert into new_falls values (20,'MNA Memorial',null,null,null,null,null,2,'y',2,
                               'Right near Tannery Falls',
                               timestamp '2006-01-31 09:54:00');

insert into trip values ('Munising',1,null);
insert into trip values ('Munising',2,1);
insert into trip values ('Munising',6,2);
insert into trip values ('Munising',4,6);
insert into trip values ('Munising',3,4);
insert into trip values ('Munising',5,3);
insert into trip values ('M-28',3,null);
insert into trip values ('M-28',1,3);
insert into trip values ('M-28',8,1);
insert into trip values ('M-28',9,8);
insert into trip values ('M-28',10,9);
insert into trip values ('M-28',11,10);
insert into trip values ('US-2',14,null);
insert into trip values ('US-2',12,14);
insert into trip values ('US-2',11,12);
insert into trip values ('US-2',13,11);



INSERT INTO PIVOT
SELECT huns.x+tens.x+ones.x FROM
  (SELECT 0 as x FROM dual
   UNION ALL SELECT 1 as x FROM dual
   UNION ALL SELECT 2 as x FROM dual
   UNION ALL SELECT 3 as x FROM dual
   UNION ALL SELECT 4 as x FROM dual
   UNION ALL SELECT 5 as x FROM dual
   UNION ALL SELECT 6 as x FROM dual
   UNION ALL SELECT 7 as x FROM dual
   UNION ALL SELECT 8 as x FROM dual
   UNION ALL SELECT 9 as x FROM dual) ones,
  (SELECT 0 as x FROM dual
   UNION ALL SELECT 10 as x FROM dual
   UNION ALL SELECT 20 as x FROM dual
   UNION ALL SELECT 30 as x FROM dual
   UNION ALL SELECT 40 as x FROM dual
   UNION ALL SELECT 50 as x FROM dual
   UNION ALL SELECT 60 as x FROM dual
   UNION ALL SELECT 70 as x FROM dual
   UNION ALL SELECT 80 as x FROM dual
   UNION ALL SELECT 90 as x FROM dual) tens,
  (SELECT 0 as x FROM dual
   UNION ALL SELECT 100 as x FROM dual
   UNION ALL SELECT 200 as x FROM dual
   UNION ALL SELECT 300 as x FROM dual
   UNION ALL SELECT 400 as x FROM dual
   UNION ALL SELECT 500 as x FROM dual
   UNION ALL SELECT 600 as x FROM dual
   UNION ALL SELECT 700 as x FROM dual
   UNION ALL SELECT 800 as x FROM dual
   UNION ALL SELECT 900 as x FROM dual) huns;

