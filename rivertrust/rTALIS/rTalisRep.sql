-- ============================
-- Fill, GetData()
-- ============================
SELECT RepresentativeId, FirstName, MiddleName, LastName, 
Suffix, Address1, Address2, City, State, ZIP, Country 
FROM dbo.Representatives
-- ============================
-- FillByFirstAndLastName, GetDataByFirstAndLastName
-- ============================
SELECT RepresentativeId, FirstName, MiddleName, LastName, 
Suffix, Address1, Address2, City, State, ZIP, Country 
FROM dbo.Representatives
WHERE FirstName = @FirstName AND LastName = @LastName
-- ============================
-- FillByLastName(@Name)
-- ============================
SELECT RepresentativeId, FirstName, MiddleName, LastName, 
Suffix, Address1, Address2, City, State, ZIP, Country 
FROM dbo.Representatives
WHERE LastName LIKE @LastName + '%'
-- ============================
--FillByRepID(@RepresentativeID)
-- ============================
SELECT RepresentativeId, FirstName, MiddleName, LastName, 
Suffix, Address1, Address2, City, State, ZIP, Country 
FROM dbo.Representatives
WHERE RepresentativeID = @RepresentativeID