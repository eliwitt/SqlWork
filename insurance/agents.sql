use DevSteve
insert edg_tbl_Insurance_Company (Company, Address, Address2, City, State, ZIP, Phone, FaxNumber, Email)
select cname1 as Company, cadd1 as Address, cadd2 as Address2, 
ccity as City, cprovince as State, cpostalcode as ZIP, cphone as Phone,
cfax as FaxNumber, cemailadd as Email
from EDIRECT_DEV.dbo.agents