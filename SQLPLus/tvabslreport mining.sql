--  the reports table
select * from (select * from MAXIMO.TVABSLreport)
where ROWNUM <= 5;

select * from MAXIMO.TVABSLreport where keyid = 368479;

select * from MAXIMO.TVABSLATTACHMENT where mboid like '%368479%'
