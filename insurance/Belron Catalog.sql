-- Do we have a match in the insurance company 142
select * from edg_tbl_Insurance_Company
where cCustNum in (select ccustnum from EDIRECT_PROD_NEW.dbo.customers)
order by cCustNum

-- The rows that do not match in the insurance company 483 + 10 = 493
select * from edg_tbl_Insurance_Company
where insuranceid > 9935 and cCustNum > '' and
	cCustNum not in (select ccustnum from EDIRECT_PROD_NEW.dbo.customers)
order by cCustNum

--  Belron PROD_NEW Rows
select * from EDIRECT_PROD_NEW.dbo.customers order by ccustnum


-- count how many rows that need work
select count(*) from edg_tbl_insurance_company
where insuranceid > 9935


--  Belron Old Rows
select * from EDIRECT_PROD.dbo.customers



-- Invoices using the new/old Belron insurance rows 40
select inv.invoiceid, inv.subscriberid, inv.insuranceid,
	sub.company
from edg_tbl_invoice_master inv
	inner join edg_tbl_subscribers sub
		on inv.subscriberid = sub.subscriberid
where InsuranceId > 9935