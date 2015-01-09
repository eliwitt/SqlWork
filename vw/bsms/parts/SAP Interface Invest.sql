--
-- initial investigation into the SAP interface
-- Following selects statements were used in my investigation.
--
-- Vendor List not sure where or how this table is 
-- created and used by the system. There appears to be
-- about two fields from the spreadsheet used.  
-- I will load the data from the SQ01 spreadsheet.
--
select * from wACom.VendorList where VLSAPID = 9900000021
select * from sp.UsageTypes
select * from sp.WearTypes