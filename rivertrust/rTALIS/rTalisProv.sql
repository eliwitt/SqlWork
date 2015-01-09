-- ===========================
-- Fill, GetData()
-- ===========================
SELECT ProviderId, NPI, Name, Address1, Address2, City, State, 
ZIP, Country, UPIN 
FROM dbo.Providers
-- ===========================
-- FillByName(@Name)
-- ===========================
SELECT ProviderId, NPI, Name, Address1, Address2, City, State, 
ZIP, Country, UPIN FROM dbo.Providers
WHERE Name LIKE @Name + '%'
-- ==========================
-- FillByNPI(@NPI)
-- ==========================
SELECT ProviderId, NPI, Name, Address1, Address2, City, 
State, ZIP, Country, UPIN 
FROM dbo.Providers
WHERE NPI like @NPI + '%'
-- ==========================
-- FillByProviderId(@ProviderId)
-- ==========================
SELECT ProviderId, NPI, Name, Address1, Address2, City, State, 
ZIP, Country, UPIN FROM dbo.Providers
WHERE ProviderID = @ProviderId