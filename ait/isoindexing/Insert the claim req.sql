-- script creates the clm_claimisoindexing row
--
declare @claimptr int, @reqtype tinyint, @theXml xml
set @claimptr = 200
set @reqtype = 10
set @theXml = '<ACORD><me>I am ' + cast(@claimptr as nvarchar(3)) + '</me></ACORD>'
exec sp_insertisoresults @claimptr, @reqtype, @theXml

select * from clm_claimisoindexing