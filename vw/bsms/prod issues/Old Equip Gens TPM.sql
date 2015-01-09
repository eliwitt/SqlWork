--
-- prod issue a piece of equip not active keeps generating 
-- a TPM.  The generator does not look at the actvie column.
-- The user asked to just set the fields to 0 so I did
--
select * from EQP.ProcNumbers where PROCNUMBER like '1B11-1600%'
select * from EQP.ProcNumbers where PROCASSIGNTO = 56
select PROCQUARTGROUP, PROCSEMIGROUP, PROCANUALGROUP, 
	PROCMONTHGROUP, PROCWEEKGROUP from eqp.ProcNumbers where PROCID = 165
update eqp.ProcNumbers set PROCQUARTGROUP = 0, PROCSEMIGROUP = 0, PROCANUALGROUP = 0, 
	PROCMONTHGROUP = 0, PROCWEEKGROUP = 0 where PROCID = 165