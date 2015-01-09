select id, date_from, date_to, vin, effective_date from vinlookup 
where vin in (
select distinct vin from vinlookup where date_from = '10/01/2009' group by vin having count(vin) > 1
)
order by vin, id