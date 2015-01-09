--  insert the status header
--exec sp_insertthestatus '12345678901234567', 'steve test', 'mar 3 2010'
----  insert the lang text
--exec sp_insertthelang 1, 'en', 'This is a test of the lang'
--exec sp_insertthelang 1, 'es', 'This is not spainish'
--exec sp_insertthelang 1, 'fr', 'This is not french'
--exec sp_insertthelang 1, 'de', 'This is not german'

select * from twitterstatus
select * from twitterlangs
--delete from twitterstatus where id = 2
select twittid, twitterscreen, twittdate, twittertext
from twitterstatus ts
	join twitterlangs tl on ts.id = tl.statusid
where lang = 'es'