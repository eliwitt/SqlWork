declare @MyStatusList varchar(100)
SET @MyStatusList = ''
SELECT @MyStatusList = ISNULL(@MyStatusList,'') + StatusDesc + ',' FROM MyStatus

--SELECT @MyStatusList = ISNULL(@MyStatusList,'') + StatusDesc + ',' 
-- FROM (SELECT DISTINCT StatusDesc FROM MyStatus) x

SET @MyStatusList = SUBSTRING(@MyStatusList, 1, LEN(@MyStatusList)-1) 
SELECT @MyStatusList