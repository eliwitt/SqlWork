declare @cmdStr nvarchar(1000),
	@orgStr nvarchar(4000),
	@debug	int,
	@FromDate	smalldatetime,
	@ThruDate	smalldatetime,
	@Division_key	nvarchar(1000),
	@Group_key nvarchar(1000)
set @ThruDate = '06/30/2007'
set @FromDate = '01/01/2005'
set @Group_key = '{818b16ff-161e-4bf5-8d17-355d64510f7f}'
--set @Group_key = '{4b676ae6-34ea-466e-b3ac-2949c654a621}'
--set @Division_key = '{E2BB4AAB-78D4-4919-9F79-415BC7BEBFEB}'
--set @Group_key = 'ALL'
set @Division_key = 'ALL'

exec ProdSeed_Process @FromDate, @ThruDate
exec Process_Enrollment