select  ihorno, 'CB_' || iaattr from VT2662AFvp.Z3OINDIH hdr
	left join VT2662AFvp.Z3OINDIA attrs on hdr.ihrefx = attrs.iarefx
where ihorno between 10135022 and 10135196 and iaatrn = 1

--select * from vt2662afvp.z3oindia where iaatrt = 'Customer_PO' and iaattr = '3029666';
--select * from vt2662afvp.z3oindia where iarefx = 1000004985;
select * from vt2662afvp.z3oindia where iaattr = '228-11'
--update vt2662afvp.z3oindia set  iaatrt = 'Board' where iaatrt = 'BoardNo' and iaatrn = 