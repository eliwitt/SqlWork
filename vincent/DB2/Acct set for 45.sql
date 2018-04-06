--
-- look up the line and qtys
--
select olline, olords, olcqty, olcqts, olacqt, olpruq from vt2662afvp.sroorspl  where olorno = 10208976 and olline > 550 and olords = 20

--
-- update the line with the qty        olcqty - confirmed, olcqts - Conf sales qty unit, olacqt - Actual qty, olpruq - price unit qty
--
update  vt2662afvp.sroorspl set olords = 45, olcqty = 1, olcqts= 1, olacqt= 1, olpruq= 1  where olorno = 10208976  and olline > 550 and olords = 20