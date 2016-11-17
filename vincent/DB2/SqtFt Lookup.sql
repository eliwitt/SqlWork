with OrdInfo (ordnu, ordline, ordcode, ordvalue) as 
(
select ttorno, ttline, ttytcd, ttforv from vt2662afvp.z3dr503a where (ttorno = 10157050 and ttline in (180, 230)) or (ttorno = 10158058 and ttline = 60) or (ttorno = 10154380 and ttline = 20) or (ttorno = 10158058 and ttline = 170) or (ttorno = 10160323 and ttline = 20) or (ttorno = 10159127 and ttline = 10)
)
select * from OrdInfo where ordcode like '%SF%'