/****** Script for SelectTopNRows command from SSMS  ******/
SELECT *
  FROM [BSMS].[EQP].[ProcNumbers] where PROCASSET in (77, 715)
  
select * from eqp.ProcNumbers where PROCWEEKGROUP = 3