SELECT     edg_tbl_Customers.CustomerId, edg_tbl_Customers.SubscriberId, edg_tbl_Customers.Commercial, edg_tbl_Customers.Company, 
                      edg_tbl_Customers.Contact, edg_tbl_Customers.Last_Name, edg_tbl_Customers.First_Name, edg_tbl_Customers.Middle_Name, 
                      edg_tbl_Customers.Prefix, edg_tbl_Customers.Suffix, edg_tbl_Customers.Address, edg_tbl_Customers.Address2, edg_tbl_Customers.City, 
                      edg_tbl_Customers.State, edg_tbl_Customers.ZIP, edg_tbl_Customers.Country, edg_tbl_Customers.Primary_Phone, 
                      edg_tbl_Customers.Secondary_Phone, edg_tbl_Customers.Mobile_Phone, edg_tbl_Customers.Fax, edg_tbl_Customers.TaxId, 
                      edg_tbl_Customers.Email, edg_tbl_Customers.NoTax, edg_tbl_Invoice_Master.InvoiceId, edg_tbl_Invoice_Master.InvoiceStatus, 
                      edg_tbl_Invoice_Master.InsuranceId, edg_tbl_Invoice_Master.SubscriberIdIns, edg_tbl_Invoice_Master.SalesPersonId, edg_tbl_Schedule.ScheduleId, edg_tbl_OA.oaid, 
                      edg_tbl_Invoice_Master.SubmittedOn, edg_tbl_Customers_Billto.BilltoId AS Billto_BilltoId, edg_tbl_Customers_Billto.CustomerId AS Billto_CustomerId,
                       edg_tbl_Customers_Billto.SubscriberId AS Billto_SubscriberId, edg_tbl_Customers_Billto.Commercial AS Billto_Commercial, 
                      edg_tbl_Customers_Billto.Company AS Billto_Company, edg_tbl_Customers_Billto.Contact AS Billto_Contact, 
                      edg_tbl_Customers_Billto.Last_Name AS Billto_Last_Name, edg_tbl_Customers_Billto.First_Name AS Billto_First_Name, 
                      edg_tbl_Customers_Billto.Middle_Name AS Billto_Middle_Name, edg_tbl_Customers_Billto.Prefix AS Billto_Prefix, 
                      edg_tbl_Customers_Billto.Suffix AS Billto_Suffix, edg_tbl_Customers_Billto.Address AS Billto_Address, 
                      edg_tbl_Customers_Billto.Address2 AS Billto_Address2, edg_tbl_Customers_Billto.City AS Billto_City, edg_tbl_Customers_Billto.State AS Billto_State, 
                      edg_tbl_Customers_Billto.ZIP AS Billto_ZIP, edg_tbl_Customers_Billto.Country AS Billto_Country, 
                      edg_tbl_Customers_Billto.Primary_Phone AS Billto_Primary_Phone, edg_tbl_Customers_Billto.Secondary_Phone AS Billto_Secondary_Phone, 
                      edg_tbl_Customers_Billto.Mobile_Phone AS Billto_Mobile_Phone, edg_tbl_Customers_Billto.Fax AS Billto_Fax, 
                      edg_tbl_Customers_Billto.TaxId AS Billto_TaxId, edg_tbl_Customers_Billto.Email AS BIllto_Email, 
                      edg_tbl_Customers_Billto.CreatedBy AS Billto_CreatedBy, edg_tbl_Customers_Billto.CreatedOn AS Billto_CreatedBy, 
                      edg_tbl_Customers_Billto.NoTax AS Billto_NoTax, edg_tbl_Customers.SendBillTo, edg_tbl_Invoice_Master.DateAssigned, 
                      edg_tbl_Customers.CampaignId, edg_tbl_Invoice_Master.Auction, edg_tbl_Invoice_Master.AuctionActive, edg_tbl_Invoice_Master.AuctionClosed, 
                      edg_tbl_OA_Shop.OaId AS PrivateOaId, edg_tbl_Invoice_Master.SubmittedVia,




======================================

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

ALTER  PROCEDURE [dbo].[edg_sp_FindCustomerById] 
@CustomerId int
AS
/* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	Modified by	Date		Trax #	Description
	-----------	--------	------	-------------------------------------------------------------
	J. Steve Witt	02/28/05	N/A	Added the Sales Person Id.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% */
SELECT     edg_tbl_Customers.CustomerId, edg_tbl_Customers.SubscriberId, edg_tbl_Customers.Commercial, edg_tbl_Customers.Company, 
                      edg_tbl_Customers.Contact, edg_tbl_Customers.Last_Name, edg_tbl_Customers.First_Name, edg_tbl_Customers.Middle_Name, 
                      edg_tbl_Customers.Prefix, edg_tbl_Customers.Suffix, edg_tbl_Customers.Address, edg_tbl_Customers.Address2, edg_tbl_Customers.City, 
                      edg_tbl_Customers.State, edg_tbl_Customers.ZIP, edg_tbl_Customers.Country, edg_tbl_Customers.Primary_Phone, 
                      edg_tbl_Customers.Secondary_Phone, edg_tbl_Customers.Mobile_Phone, edg_tbl_Customers.Fax, edg_tbl_Customers.TaxId, 
                      edg_tbl_Customers.Email, edg_tbl_Customers.NoTax, edg_tbl_Invoice_Master.InvoiceId, edg_tbl_Invoice_Master.InvoiceStatus, 
                      edg_tbl_Invoice_Master.InsuranceId, edg_tbl_Schedule.ScheduleId, edg_tbl_Invoice_Master.SubscriberIdIns, edg_tbl_OA.oaid, 
                      edg_tbl_Invoice_Master.SubmittedOn, edg_tbl_Customers_Billto.BilltoId AS Billto_BilltoId, edg_tbl_Customers_Billto.CustomerId AS Billto_CustomerId,
                       edg_tbl_Customers_Billto.SubscriberId AS Billto_SubscriberId, edg_tbl_Customers_Billto.Commercial AS Billto_Commercial, 
                      edg_tbl_Customers_Billto.Company AS Billto_Company, edg_tbl_Customers_Billto.Contact AS Billto_Contact, 
                      edg_tbl_Customers_Billto.Last_Name AS Billto_Last_Name, edg_tbl_Customers_Billto.First_Name AS Billto_First_Name, 
                      edg_tbl_Customers_Billto.Middle_Name AS Billto_Middle_Name, edg_tbl_Customers_Billto.Prefix AS Billto_Prefix, 
                      edg_tbl_Customers_Billto.Suffix AS Billto_Suffix, edg_tbl_Customers_Billto.Address AS Billto_Address, 
                      edg_tbl_Customers_Billto.Address2 AS Billto_Address2, edg_tbl_Customers_Billto.City AS Billto_City, edg_tbl_Customers_Billto.State AS Billto_State, 
                      edg_tbl_Customers_Billto.ZIP AS Billto_ZIP, edg_tbl_Customers_Billto.Country AS Billto_Country, 
                      edg_tbl_Customers_Billto.Primary_Phone AS Billto_Primary_Phone, edg_tbl_Customers_Billto.Secondary_Phone AS Billto_Secondary_Phone, 
                      edg_tbl_Customers_Billto.Mobile_Phone AS Billto_Mobile_Phone, edg_tbl_Customers_Billto.Fax AS Billto_Fax, 
                      edg_tbl_Customers_Billto.TaxId AS Billto_TaxId, edg_tbl_Customers_Billto.Email AS BIllto_Email, 
                      edg_tbl_Customers_Billto.CreatedBy AS Billto_CreatedBy, edg_tbl_Customers_Billto.CreatedOn AS Billto_CreatedBy, 
                      edg_tbl_Customers_Billto.NoTax AS Billto_NoTax, edg_tbl_Customers.SendBillTo, edg_tbl_Invoice_Master.DateAssigned, 
                      edg_tbl_Customers.CampaignId, edg_tbl_Customers.ContactNotes, edg_tbl_Invoice_Master.Auction, edg_tbl_Invoice_Master.AuctionActive, 
                      edg_tbl_Invoice_Master.AuctionClosed, edg_tbl_OA_Shop.OaId AS PrivateOaId, edg_tbl_Invoice_Master.SubmittedVia, edg_tbl_Invoice_Master.SalesPersonId,
                      (
                      SELECT COUNT(*)
	         FROM   edg_tbl_Messages
	         WHERE  (InvoiceID = edg_tbl_Invoice_Master.InvoiceID) 
                      )  AS Unred
FROM         edg_tbl_Schedule RIGHT OUTER JOIN
                      edg_tbl_OA_Shop RIGHT OUTER JOIN
                      edg_tbl_Invoice_Master ON edg_tbl_OA_Shop.InsuranceId = edg_tbl_Invoice_Master.InsuranceId LEFT OUTER JOIN
                      edg_tbl_OA ON edg_tbl_Invoice_Master.SubscriberIdIns = edg_tbl_OA.subscriberid ON 
                      edg_tbl_Schedule.InvoiceId = edg_tbl_Invoice_Master.InvoiceId RIGHT OUTER JOIN
                      edg_tbl_Customers_Billto RIGHT OUTER JOIN
                      edg_tbl_Customers ON edg_tbl_Customers_Billto.CustomerId = edg_tbl_Customers.CustomerId ON 
                      edg_tbl_Invoice_Master.CustomerId = edg_tbl_Customers.CustomerId
WHERE     (edg_tbl_Customers.CustomerId = @CustomerId)

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

