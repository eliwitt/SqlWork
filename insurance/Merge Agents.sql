declare @cNam char(35),
	@agntNum char(10)

declare InsAgnt scroll cursor for
select cagentnum, cname1 from agents
order by cname1
open InsAgnt
fetch first from InsAgnt into @agntNum, @cNam
while @@fetch_status = 0
	begin
	if exists(select company from edg_tbl_insurance_company where company = @cNam)
		begin
		update edg_tbl_insurance_company set ins_type = 1 where company = @cNam		
	end
	else
		begin
		insert edg_tbl_Insurance_Company (ins_type, Company, Address, Address2, City, State, ZIP, Phone, FaxNumber, Email)
			select 1 as ins_type, cname1 as Company, cadd1 as Address, cadd2 as Address2, 
				ccity as City, cprovince as State, cpostalcode as ZIP, cphone as Phone,
				cfax as FaxNumber, cemailadd as Email
			from agents where cagentnum = @agntNum
	end
	fetch next from InsAgnt into @agntNum, @cNam
end
close InsAgnt
deallocate InsAgnt