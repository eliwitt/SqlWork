--  dup from saint louie
select id, CityName, StateAbbr, zipcode from ZipInfo where ZipCode = 63146 and Ziptype = 'S'
-- hixson
select id, CityName + ', ' + StateAbbr locnam, zipcode from ZipInfo where ZipCode = 37343 and Ziptype = 'S'

--update clm_address set zipinfoptr = 34636