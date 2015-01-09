--select make, model, vin_prefix, year, count(year) from vinlookup
--group by make, model, vin_prefix, year
--order by make, model, vin_prefix,year
--
-- to verify use the q from above to get the model then run the below
--
--select * from vinlookup
--where make = 'Alfa Romeo' and model = 'Spider VEL'
-- or 
--where make = 'American Motors' and vin_prefix = '11'
--
select make, year, count(year) [Total by year] from vinlookup
group by make, year
order by year, make