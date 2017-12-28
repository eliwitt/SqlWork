-- the following are sql for the indesign tables
--
--  get_orders returns one row in Z3OINDIH that is at ihstat = '0' and it sets that one row ihstat to 1
--
call vt2662aq.get_orders (?)
--
-- reset the status on the following row
--
update VT2662AFtt.Z3OINDIH set ihstat = '0' where ihorno = 10203242 and ihline in (10,20);
--
-- look at the indesign header for the given order
--
select * from VT2662AFTT.Z3OINDIH where ihorno = 10203242
--
-- calls Z3DR021
--
select * from vt2662afvp.srbsol where olorno = 10203242