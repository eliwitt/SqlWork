SELECT     dbo.Letters.LetterId, dbo.Contexts.ContextId AS Context, dbo.Contexts.Heading, dbo.Letters.SubmittedDate, 
                      dbo.Letters.MailDate AS ConsolidatedPrintedDate, dbo.Letters.IndividualPrintedDate AS PrintedDate, dbo.Appeals.AppellantType, 
                      dbo.Letters.AddresseeType, dbo.GetBeneficiaryNameFirstInitialLast(dbo.Beneficiaries.HIC) AS BeneficiaryName, 
                      dbo.Providers.Name AS ProviderName, dbo.GetRepresentativeNameFirstLast(dbo.Representatives.RepresentativeId) AS RepresentativeName, 
                      dbo.Beneficiaries.Address1, COALESCE (dbo.Beneficiaries.Address2, N'') AS Address2, dbo.Beneficiaries.City, dbo.Beneficiaries.State, 
                      dbo.Beneficiaries.ZIP, dbo.BeneficiaryCollections.AppealNumber, dbo.Appeals.ContractNumber, dbo.Contractors.ContractorId AS ContractorShortName, 
                      dbo.Contractors.LongName AS ContractorLongName, dbo.HICMask(dbo.Beneficiaries.HIC) AS HIC, dbo.Appeals.MultipleClaims, 
                      '' AS ClaimControlNumber, dbo.BeneficiaryCollections.ClaimPaidDate, dbo.GetMinBeginningDOS(dbo.BeneficiaryCollections.AppealNumber, 
                      dbo.BeneficiaryCollections.HIC) AS BeginningDOS, dbo.GetMaxEndingDOS(dbo.BeneficiaryCollections.AppealNumber, dbo.BeneficiaryCollections.HIC) 
                      AS EndingDOS, dbo.BeneficiaryCollections.ServicesRendered, dbo.BeneficiaryCollections.DecisionServicesCovered AS ServicesCovered, 
                      dbo.BeneficiaryCollections.DecisionServicesUncovered AS ServicesUncovered, 
                      dbo.BeneficiaryCollections.DecisionLiability AS ServicesUncoveredLiability, dbo.BeneficiaryCollections.DecisionExplanation, 
                      dbo.Appeals.ReconsiderationRequestSentDate, dbo.Appeals.ReconsiderationRequestReceivedDate, 
                      dbo.BeneficiaryCollections.ReconsiderationRequestWithdrawalSentDate, 
                      dbo.BeneficiaryCollections.ReconsiderationRequestWithdrawalReceivedDate, DATEADD(day, 
                      COALESCE (dbo.RedeterminationStates.DaysAllowedForTimeliness, 185), dbo.BeneficiaryCollections.RedeterminationLetterSentDate) 
                      AS ReconsiderationTimelinessDate, dbo.BeneficiaryCollections.InitialDenialDate, dbo.BeneficiaryCollections.InitialDenialSummaryOfFacts, 
                      dbo.BeneficiaryCollections.RedeterminationLetterSentDate, dbo.BeneficiaryCollections.RedeterminationDismissalReason, 
                      dbo.BeneficiaryCollections.RedeterminationSummaryOfFacts, dbo.BeneficiaryCollections.DecisionAmountInControversy AS AmountInControversy, 
                      dbo.BeneficiaryCollections.ReconsiderationSubmittedMaterial AS SubmittedDocumentation, 
                      dbo.BeneficiaryCollections.ReconsiderationUnsubmittedMaterial AS UnSubmittedDocumentation, 
                      dbo.GetBeneficiaryDetailSingle(dbo.BeneficiaryCollections.AppealNumber, dbo.BeneficiaryCollections.HIC) AS ClaimsDetail, 
                      COALESCE (dbo.BeneficiaryCollections.DuplicateAppealNumber, N'') AS DuplicateAppealNumber, 
                      COALESCE (dbo.BeneficiaryCollections.DuplicateAppealAppellantName, N'') AS DuplicateAppealAppellantName, 
                      COALESCE (dbo.BeneficiaryCollections.DuplicateAppealReceivedDate, N'') AS DuplicateAppealReceivedDate, dbo.ALJs.Name AS ALJName, 
                      dbo.ALJs.Address1 AS ALJAddress1, dbo.ALJs.Address2 AS ALJAddress2, dbo.ALJs.City AS ALJCity, dbo.ALJs.State AS ALJState, 
                      dbo.ALJs.ZIP AS ALJZIP, dbo.Contexts.AppendAppealRightsAttachment, dbo.Contexts.AppendAppointmentOfRepresentativeStatement, 
                      dbo.Contexts.AppendWaiverOfLiabilityStatement, dbo.Contexts.PrintFlag, dbo.Contexts.AvailableToUsers, COALESCE (dbo.States.PrintSortOrder, - 999) 
                      AS PrintSortOrder
FROM         dbo.Letters INNER JOIN
                      dbo.Beneficiaries ON dbo.Letters.HIC = dbo.Beneficiaries.HIC LEFT OUTER JOIN
                      dbo.Contexts ON dbo.Letters.ContextId = dbo.Contexts.ContextId LEFT OUTER JOIN
                      dbo.Appeals ON dbo.Letters.AppealNumber = dbo.Appeals.AppealNumber LEFT OUTER JOIN
                      dbo.Providers ON dbo.Appeals.ProviderId = dbo.Providers.ProviderId FULL OUTER JOIN
                      dbo.BeneficiaryCollections ON dbo.Appeals.AppealNumber = dbo.BeneficiaryCollections.AppealNumber AND 
                      dbo.Beneficiaries.HIC = dbo.BeneficiaryCollections.HIC LEFT OUTER JOIN
                      dbo.Contractors ON dbo.BeneficiaryCollections.ContractorId = dbo.Contractors.ContractorId LEFT OUTER JOIN
                      dbo.Representatives ON dbo.Appeals.RepresentativeId = dbo.Representatives.RepresentativeId LEFT OUTER JOIN
                      dbo.ALJs ON dbo.BeneficiaryCollections.ALJId = dbo.ALJs.ALJId LEFT OUTER JOIN
                      dbo.RedeterminationStates ON dbo.BeneficiaryCollections.RedeterminationState = dbo.RedeterminationStates.State LEFT OUTER JOIN
                      dbo.States ON dbo.Beneficiaries.State = dbo.States.Prefix
WHERE     (dbo.Contexts.PrintFlag <> 0) AND (dbo.Letters.MailDate IS NULL) AND (dbo.Letters.AddresseeType = 'Beneficiary') OR
                      (dbo.Contexts.PrintFlag <> 0) AND (dbo.Letters.AddresseeType = 'Beneficiary') AND (dbo.Letters.IndividualPrintedDate IS NULL)