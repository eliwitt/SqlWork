--select firm.Firmtypeid,
--	biz.businessname, biz.federaltaxid, biz.contact_personptr,
--	addr.addressline1, addr.addressline2, addr.phonenumber, addr.zipinfoptr 
--from clm_lawFirm Firm
--       join clm_businessentity biz on Firm.businessEntityPtr = biz.id 
--       join clm_address addr on biz.addressPTR = addr.id
--where Firm.id = 1
--
--update clm_businessentity set businessname = 'Law Test', federaltaxid = '123456789'
--where id = (select biz.id 
--				from clm_lawFirm Firm
--				join clm_businessentity biz on Firm.businessEntityPtr = biz.id 
--			where Firm.id = 1)
--
--update clm_address set addressline1 = '123 Testing', addressline2 = 'Suite 123',
--		phonenumber = '1234567890', zipinfoptr = '37343'
--where id = (select addr.id 
--				from clm_lawFirm Firm
--				join clm_businessentity biz on Firm.businessEntityPtr = biz.id 
--				join clm_address addr on biz.addressPTR = addr.id
--			where Firm.id = 1)
--
--update clm_lawfirm set firmtypeid = '2' where id = 1
select firm.id, biz.businessname
                        from clm_lawfirm firm
                        join clm_businessentity biz on firm.businessEntityPtr = biz.id
                        where firm.disabled <> 1 or firm.disabled is null