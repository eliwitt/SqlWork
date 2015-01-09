--
-- statements used to perform various functions for the 
-- SAP interface
--
--drop table [dbo].[SAPTest]
-- create my test table using the maspter
--
select * into [dbo].[SAPTest] 
	from sp.SPMaster2
-- 
-- let get the venor list as well
--
select * into [dbo].[SAPVendor]
	from wACom.VendorList
--
-- now let's remove a couple of the rows from the master we copied.
--
select * from sp.SPMaster2 where SP2VWNumber in ('Z0000000', 'Z0000017','Z0000034', 'Z0001504','Z0002490', 'Z0003225')
--delete from sp.SPMaster2 where SP2VWNumber = 'Z0000017'
select * from sp.SPMaster2
--insert into dbo.SAPTest (SP2VWNumber, SP2SAPMFGPN, SP2MFGID, 
--SP2MFGActual, SP2ShortSAPDescr, SP2RecQuantity,SP2IssueUOM,
-- SP2Min, SP2Max) values (
-- 'Z0000017','50001152','9900000021','ATN HÖLZEL GMBH',
--'FILTER, PROCESS',4,'EA',3, 6
-- )
 exec sp.PartsImport 'Z0000017', '50001160', '9900000021', 'Witt Test',
	'FILTER, PROCESS', 4, 'EA', 3, 6
 --
-- Z0000017	5	FILTER, PROCESS	50001152	9900000021	ATN HÖLZEL GMBH	4	EA	6.000	3.100	VB
-- Z0000034     PB1011-F01      50001284    9900000021
--use BSMS
select * from wACom.VendorList where VLSAPID = '9900000021'
--delete wACom.VendorList where VLSAPID = 0
--delete wACom.VendorList where vlid = 10881
--insert into wACom.VendorList (VLName, VLSAPID) values ('Steve Witt', 7)
--delete sp.SPMaster2 where SP2ID in (13560, 13561, 13562, 13563, 13564, 13565)
select * from sp.SPMaster2 where SP2VWNumber = 'Z0000017'

select * from sp.SPMaster2 where SP2VWNumber in ('Z0000000', 'Z0000017','Z0000034', 'Z0001504','Z0002490', 'Z0003225')
select * from wACom.VendorList where VLSAPID in ('9900000021', '9900000011', '9900000312', '9900000851', '9900000309')
