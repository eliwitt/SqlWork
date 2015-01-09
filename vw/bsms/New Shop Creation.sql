--
-- To add a new shop such as Paint or Bodyweld
-- you need to insert a row into each of the following tables
--
-- Then someone would need to create the team entries NOTE you must go down at least 3 levels before
-- you can add people.
-- Then all of the areas and model info is done in the Equip Control.  Once the equip is created
-- you are then ready to create work orders.  You will also have to set up all of the procedures tasks for TPMs.
--
select * from Team.wAPlants
select * from EQP.ModelGroupOne
--insert into team.wAPlants values('Academy','AC')
--insert into EQP.ModelGroupOne values('Academy', 1)