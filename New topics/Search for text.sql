SELECT Name
FROM sys.procedures
WHERE OBJECT_DEFINITION(OBJECT_ID) LIKE '%tpmcomp%'

DECLARE @Search varchar(255) 
SET @Search='Plant'  
SELECT DISTINCT     
	s.name as [Schemas], o.name AS Object_Name, o.type_desc   
FROM sys.sql_modules m          
	INNER JOIN sys.objects  o ON m.object_id=o.object_id 
	inner join sys.schemas s on o.schema_id = s.schema_id    
WHERE m.definition Like '%'+@Search+'%'     
ORDER BY 1, 3, 2 
SELECT DISTINCT     
	s.name as [Schemas], o.name AS Object_Name, o.type_desc   
FROM sys.objects  o 
	inner join sys.schemas s on o.schema_id = s.schema_id    
WHERE o.name LIKE '%'+@Search+'%'     
ORDER BY 1, 3, 2 