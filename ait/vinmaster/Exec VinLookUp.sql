--
-- multiple vin's JNKCV54E75 using the correct date gets you the correct id
--	'1D4YB582F80024493', '10/30/2009'
--	'JTJGA31U040024493', '10/02/2004'
declare @re int
exec @re = [dbo].SP_VinlookupProd '1D4YB582F80024493', '10/30/2008'
select @re