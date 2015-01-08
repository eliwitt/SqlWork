
-------------------- order header--he and line--pl  ----------10108116_10
	
SELECT * FROM VT2662AFvp.SROORSHE WHERE OHORNO = 10108116;
SELECT * FROM VT2662AFvp.SROORSPL WHERE OLORNO = 10108116;


---------------------------  manufactor order header ----------

--select * from vt2662aftt.mfmohr fetch first 10 rows only

select * from vt2662afvp.mfmohr where aybmnb = 10108116;



---------------------  fedex data  ---------------------

--select * from vt2662aftt.z3optrh fetch first 10 rows only

select * from vt2662afvp.z3optrh where thorno >= 10108116;

select * from vt2662afvp.z3dr503a where ttorno = 10108116;
-- find all orders within a given date range

-- SELECT * FROM table(VTCUSTOMTT.udtf0001t('C00337',20140301,20140318,'C', '' )) as t where ordqty > 0