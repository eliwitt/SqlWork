declare @SubscriberId int
set @SubscriberId = 3430
SELECT edg_tbl_Invoice_Master.InvoiceId, 
	edg_tbl_Invoice_Master.SubscriberId, 
	edg_tbl_Invoice_Master.CustomerId, 
	edg_tbl_Customers.Commercial, 
	edg_tbl_Customers.Company AS CustomerCompany, 
	edg_tbl_Customers.Last_Name, 
	edg_tbl_Customers.First_Name, 
	edg_tbl_Invoice_Master.SubmittedOn,
	edg_tbl_Invoice_Master.Balance, 
	edg_tbl_Invoice_Master.InvGrossTotal, 
	edg_tbl_Invoice_Master.InvDeductible, 
	edg_tbl_Invoice_Master.InvNetTotal, 
	edg_tbl_Invoice_Master.InvSubTotal, 
	edg_tbl_Invoice_Master.SubscriberIdIns, 
	edg_tbl_Subscribers.Company AS ShopCompany, 
	edg_tbl_Insurance_Company.Company AS InsCompany,
	case 
		when edg_tbl_Invoice_Master.CustomerInvoiceId IS NULL then edg_tbl_Invoice_Master.InvoiceId
		else edg_tbl_Invoice_Master.CustomerInvoiceId
	end as CustomerInvoiceId
FROM edg_tbl_Invoice_Master 
	INNER JOIN edg_tbl_Customers ON edg_tbl_Invoice_Master.CustomerId = edg_tbl_Customers.CustomerId 
	LEFT OUTER JOIN edg_tbl_Insurance_Company ON edg_tbl_Invoice_Master.InsuranceId = edg_tbl_Insurance_Company.InsuranceId 
	LEFT OUTER JOIN edg_tbl_Subscribers ON edg_tbl_Invoice_Master.SubscriberId = edg_tbl_Subscribers.SubscriberId
WHERE edg_tbl_Invoice_Master.SubscriberId = @SubscriberId and 
	edg_tbl_Invoice_Master.InvoiceStatus > 1 AND 
	edg_tbl_Invoice_Master.Balance <> 0
	
