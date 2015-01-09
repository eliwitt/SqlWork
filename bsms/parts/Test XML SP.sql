--delete from sp.SPMaster2 where SP2VWNumber in ('Z0001504', 'Z0002490')
--delete wACom.VendorList where VLSAPID in ('9900000312', '9900000851')

select * from sp.SPMaster2 where SP2VWNumber in ('Z0000000', 'Z0000017','Z0000034', 'Z0001504','Z0002490', 'Z0003225')
select * from wACom.VendorList where VLSAPID in ('9900000021', '9900000011', '9900000312', '9900000851', '9900000309')