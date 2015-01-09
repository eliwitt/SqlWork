exec [Development].[RecursiveTestIng]
--SELECT TOP 1000 [IDCol]
--      ,[NameCol]
--      ,[Parent]
--  FROM [BSMS].[Development].[RecursiveTest]
;
with cte
as
	(
	SELECT IDCol,NameCol,Parent FROM [Development].[RecursiveTest] WHERE Parent = 0

	UNION ALL

	SELECT C.IDCol,C.NameCol,C.Parent FROM cte AS R
		inner join [Development].[RecursiveTest] AS C
		 on C.Parent = R.IDCol
	)



	SELECT * from cte 
	--select * FROM cte WHERE IDCol in (SELECT parent from cte)
	--union
	--select * from  cte WHERE Parent = @Pop
	
	
	--SELECT C.IDCol,C.NameCol,C.Parent FROM [Development].[RecursiveTest] AS R
	--	inner join [Development].[RecursiveTest] AS C
	--	 on C.Parent = R.IDCol