--select * from clm_vehiclepassenger where involvedpartyptr = 9267
--update clm_claimvehicle set vehiclenumber = 4 where id = 6813
--update clm_vehiclepassenger set vehiclenumber = 4 where involvedpartyptr = 9259
select * from clm_claimlog where claimid = 4140
select * from clm_personbackup where personptr in (9505, 9507, 9508) order by personptr, datestamp

--select * from clm_claimlog where claimid = 4135 order by datestamp
--select * from clm_personbackup where personptr in (9494, 9497, 9498, 9500) order by personptr, datestamp