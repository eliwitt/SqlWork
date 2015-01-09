insert into vinmake select distinct
	makecd = case make
		when 'American Motors' then
			'AMC '
		when 'Avanti' then
			'AVTI'
		when 'Buick' then
			'BUIK'
		when 'De Lorean' then
			'DELO'
		when 'International' then
			'INTL'
		when 'Jaguar' then
			'JAG '
		when 'Lotus' then
			'LOTS'
		when 'Lexus' then
			'LEXS'
		when 'Mercedes Benz' then
			'MBNZ'
		when 'Nissan' then
			'NSSN'
		when 'Range Rover' then
			'ROVR'
		when 'Renault' then
			'RNLT'
		when 'Saturn' then
			'SATN'
		when 'Smart Car' then
			'SMRT'
		when 'Toyota' then
			'TYTA'
		When 'Volkswagen' then
			'VLKS'
		when 'Volvo' then
			'VLVO'
		else
			upper(substring(make, 1, 4)) 
	end, make
from vinlookup
order by makecd