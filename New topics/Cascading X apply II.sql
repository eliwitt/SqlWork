-- whoosh up some sample data
IF object_id('TempDB..#Persons') IS NOT NULL
 DROP TABLE #Persons;
GO
CREATE TABLE #Persons (
 PersonID INT IDENTITY(1,1) PRIMARY KEY CLUSTERED,
 Forename VARCHAR(20),
 Lastname VARCHAR(20),
 Title VARCHAR(10),
 DOB DATE,
 WeightKg NUMERIC (5,2),
 Heightmm INT)
;

INSERT INTO #Persons (Forename, Lastname, Title, DOB, WeightKg, Heightmm)
 SELECT 
  Forename, 
  Lastname, 
  Title,
  DOB = CONVERT(DATE,DOB,107), 
  WeightKg = CAST(RIGHT(DOB,2) AS INT) * 1.5,
 Heightmm = YEAR(CONVERT(DATE,DOB,107)) 
 FROM (
  VALUES 
  (('Francis'),('Bacon'),('Mr'),('January 22, 1561'),(NULL)),
  (('Jean'),('Baptiste'),('Mr'),('March 21, 1768'),(NULL)), 
  (('Clarence'),('Birdseye'),('Mr'),('December 9, 1886'),(NULL)),
  (('Charles'),('Babbage'),('Mr'),('November 24, 1872'),(NULL)),
  (('John'),('Logie Baird'),('Mr'),('August 13, 1888'),(NULL)),
  (('Nicolaus'),('Copernicus'),('Mr'),('February 19, 1473'),(NULL)),
  (('Christian'),('Doppler'),('Mr'),('November 29, 1803'),(NULL)),
  (('Paul'),('Ehrlich'),('Mr'),('March 14, 1854'),(NULL)),
  (('Alexander'),('Fleming'),('Mr'),('August 6, 1881'),(NULL)),
  (('Michael'),('Faraday'),('Mr'),('September 22, 1791'),(NULL)),
  (('Pierre'),('de Fermat'),('Mr'),('August 17, 1601'),(NULL)),
  (('Robert'),('Fulton'),('Mr'),('November 14, 1765'),(NULL)),
  (('Joseph'),('Fourier'),('Mr'),('March 21, 1768'),(NULL)),
  (('Galileo'),('Galilei'),('Mr'),('February 15, 1564'),(NULL)), 
  (('Stephen'),('Hawking'),('Mr'),('January 8, 1942'),(NULL)), 
  (('Otto'),('Hahn'),('Mr'),('March 8, 1879'),(NULL)), 
  (('Jean-Baptiste'),('Lamarck'),('Mr'),('August 1, 1744'),(NULL)),
  (('Konrad'),('Lorenz'),('Mr'),('November 7, 1903'),(NULL)), 
  (('Gregor'),('Mendel'),('Mr'),('July 22, 1822'),(NULL)),
  (('Guglielmo'),('Marconi'),('Mr'),('April 25, 1874'),(NULL)),
  (('Isaac'),('Newton'),('Mr'),('December 25, 1642'),(NULL)), 
  (('J. Robert'),('Oppenheimer'),('Mr'),('April 22, 1904'),(NULL)), 
  (('Joseph'),('Priestley'),('Mr'),('March 13, 1733'),(NULL)),
  (('Wolfgang'),('Pauli'),('Mr'),('April 25, 1900'),(NULL)), 
  (('Blaise'),('Pascal'),('Mr'),('June 19, 1623'),(NULL)),
  (('Craig'),('Venter'),('Mr'),('October 14, 1946'),(NULL)), 
  (('James'),('Watson'),('Mr'),('April 16, 1970'),(NULL)) 
  ) d (Forename, Lastname, Title, DOB, WeightKg)
;
select *, Century = (YEAR(DOB)/100)+1, WeightBand = CASE 
                 WHEN WeightKg < 80 THEN 1
                 WHEN WeightKg >= 80 AND WeightKg < 100 THEN 2
                 WHEN WeightKg >= 100 AND WeightKg < 120 THEN 3
                 ELSE 4 END, HeightBand = CASE 
                  WHEN Heightmm < 1700 THEN 1
                  WHEN Heightmm >= 1700 THEN 2
                  ELSE 4 END
from #Persons
-- Task: group scientists according to their weight and height 
SELECT 
  Century, 
  LightweightShorties = COUNT(z.LightweightShorty),
  -- more columns
  GihugeousTallies = COUNT(z.GihugeousTallie)
 FROM #Persons
  CROSS APPLY ( -- calculate century of birth and weight band
   SELECT 
    Century = (YEAR(DOB)/100)+1,
    WeightBand = CASE 
                 WHEN WeightKg < 80 THEN 1
                 WHEN WeightKg >= 80 AND WeightKg < 100 THEN 2
                 WHEN WeightKg >= 100 AND WeightKg < 120 THEN 3
                 ELSE 4 END
     ) x
   CROSS APPLY ( -- calculate height band
    SELECT 
     HeightBand = CASE 
                  WHEN Heightmm < 1700 THEN 1
                  WHEN Heightmm >= 1700 THEN 2
                  ELSE 4 END
     ) y
   CROSS APPLY ( -- count scientists in specific weight and height bands
    SELECT 
     LightweightShorty = CASE WHEN WeightBand = 1 AND HeightBand = 1 THEN 1        END,
     -- more columns
    GihugeousTallie = CASE WHEN WeightBand = 4 AND HeightBand = 2 THEN 1 END    ) z
  GROUP BY Century
  ORDER BY Century
-- Once the results are verified, condense the code. 
-- note differences between COUNT and SUM
-- count rows where the result is not null 
SELECT 
  x.Century,
  LightweightShorties = SUM(CASE WHEN WeightKg < 80 AND Heightmm < 1700 THEN 1 ELSE 0 END), -- SUM(1) 
  -- more columns
  GihugeousTallies = COUNT(CASE WHEN WeightKg >= 120 AND Heightmm >= 1700 THEN 1 END) 
 FROM #Persons
  CROSS APPLY (SELECT Century = (YEAR(DOB)/100)+1) x
 GROUP BY x.Century
 ORDER BY x.Century