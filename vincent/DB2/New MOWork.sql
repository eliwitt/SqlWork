select * from vt2662afvp.sroorshe where ohorno = 10187028;
select * from vt2662afvp.sroorspl where olorno = 10187028;
select * from vt2662afvp.srotgt where gttxky = (select ohtxky from vt2662afvp.sroorshe where ohorno = 10140999);
select * from vt2662afvp.srotgt where gttxky = (select oltxky from vt2662afvp.sroorspl where olorno = 10140999 and olline = 10);
select * from vt2662afvp.z3optrh where thorno = 10187028;