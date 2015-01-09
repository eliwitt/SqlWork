declare @cmdStr nvarchar(1000), 
	@orgStr nvarchar(1000), 
	@TailStr nvarchar(1000),
	@FromDate	smalldatetime,
	@ThruDate	smalldatetime,
	@Division_key	nvarchar(1000),
	@Group_key 	nvarchar(1000),
	@EnrollmentPeriod_key nvarchar(1000),
	@Grp_key nvarchar(1000)
set @orgStr = ''
set @TailStr = ''
set @ThruDate = ''
set @FromDate = ''
set @ThruDate = '06/30/2008'
set @FromDate = '01/01/2001'
--
-- group  -------------------------------------------------
--
set @Group_key = 'ALL'
--  bcbst b2c6840d-0c98-4c17-880c-4f2122a69bbf
--	Ace 818b16ff-161e-4bf5-8d17-355d64510f7f
--set @Group_key = '''{818b16ff-161e-4bf5-8d17-355d64510f7f}'''
--	Chatt Chamber dd973c8a-1884-49fd-8e79-6bf5a83a3bb2
--	Hermitage Medical Associates 4b676ae6-34ea-466e-b3ac-2949c654a621
set @Group_key = '4b676ae6-34ea-466e-b3ac-2949c654a621'
--
-- enrollment period  ---------------------------------------
--
--	Ace FA05C718-5C66-49D2-A67D-2984F18DF5A2
--set @EnrollmentPeriod = '''{FA05C718-5C66-49D2-A67D-2984F18DF5A2}'''
--	Chatt Chamber 8b1acbc0-ac07-4383-8271-379001be7097
--set @EnrollmentPeriod = '''{8b1acbc0-ac07-4383-8271-379001be7097}'''
--	Hermitage Medical Associates 878387af-f666-4e6c-bd5a-b9b90e401c62
--set @EnrollmentPeriod = '''{878387af-f666-4e6c-bd5a-b9b90e401c62}'''
--
--  division  -----------------------------------------------
--set @Division_key = '''{E2BB4AAB-78D4-4919-9F79-415BC7BEBFEB}'''
set @Division_key = 'ALL'
--
--  Ace employees that might be spouses
--
-- Chris Miller 0325506E-9467-4533-8CE2-56E4F6706DEF
-- Lisa Miller  A703342F-ECBD-4C88-B64C-CB984714D1F3
-- Andrea Smith 8671FCD1-3BD7-44C6-96A0-739A7AB94499
-- John Smith   44AE1DB2-0DA8-4849-A155-88F05E75FDFA
-- James Smith  14A17CE6-8D5C-43BE-A332-999ADF763268


