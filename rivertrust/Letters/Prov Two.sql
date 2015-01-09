SELECT     Letters_AllProvSBAckStd.LetterId, Contexts_AllProvSBAckStd.ContextId AS Context, Contexts_AllProvSBAckStd.Heading, 
                      Letters_AllProvSBAckStd.SubmittedDate, Letters_AllProvSBAckStd.MailDate AS ConsolidatedPrintedDate, 
                      Letters_AllProvSBAckStd.IndividualPrintedDate AS PrintedDate, Appeals_AllProvSBAckStd.AppellantType, Letters_AllProvSBAckStd.AddresseeType, 
                      dbo.GetBeneficiaryNameFirstInitialLast(Beneficiaries_AllProvSBAckStd.HIC) AS BeneficiaryName, Providers_AllProvSBAckStd.Name AS ProviderName, 
                      dbo.GetRepresentativeNameFirstLast(Representatives_AllProvSBAckStd.RepresentativeId) AS RepresentativeName, 
                      Providers_AllProvSBAckStd.Address1, COALESCE (Providers_AllProvSBAckStd.Address2, N'') AS Address2, Providers_AllProvSBAckStd.City, 
                      Providers_AllProvSBAckStd.State, Providers_AllProvSBAckStd.ZIP, BeneficiaryCollections_AllProvSBAckStd.AppealNumber, 
                      Appeals_AllProvSBAckStd.ContractNumber, Contractors_AllProvSBAckStd.ContractorId AS ContractorShortName, 
                      Contractors_AllProvSBAckStd.LongName AS ContractorLongName, dbo.HICMask(Beneficiaries_AllProvSBAckStd.HIC) AS HIC, 
                      Appeals_AllProvSBAckStd.MultipleClaims, '' AS ClaimControlNumber, BeneficiaryCollections_AllProvSBAckStd.ClaimPaidDate, 
                      dbo.GetAcknowledgementMinBeginningDOS(BeneficiaryCollections_AllProvSBAckStd.AppealNumber) AS BeginningDOS, 
                      dbo.GetAcknowledgementMaxEndingDOS(BeneficiaryCollections_AllProvSBAckStd.AppealNumber) AS EndingDOS, 
                      BeneficiaryCollections_AllProvSBAckStd.ServicesRendered, BeneficiaryCollections_AllProvSBAckStd.DecisionServicesCovered AS ServicesCovered, 
                      BeneficiaryCollections_AllProvSBAckStd.DecisionServicesUncovered AS ServicesUncovered, 
                      BeneficiaryCollections_AllProvSBAckStd.DecisionLiability AS ServicesUncoveredLiability, 
                      BeneficiaryCollections_AllProvSBAckStd.DecisionExplanation, Appeals_AllProvSBAckStd.ReconsiderationRequestSentDate, 
                      Appeals_AllProvSBAckStd.ReconsiderationRequestReceivedDate, 
                      BeneficiaryCollections_AllProvSBAckStd.ReconsiderationRequestWithdrawalSentDate, 
                      BeneficiaryCollections_AllProvSBAckStd.ReconsiderationRequestWithdrawalReceivedDate, DATEADD(day, 
                      COALESCE (RedeterminationStates_AllProvSBAckStd.DaysAllowedForTimeliness, 185), 
                      BeneficiaryCollections_AllProvSBAckStd.RedeterminationLetterSentDate) AS ReconsiderationTimelinessDate, 
                      BeneficiaryCollections_AllProvSBAckStd.InitialDenialDate, BeneficiaryCollections_AllProvSBAckStd.InitialDenialSummaryOfFacts, 
                      BeneficiaryCollections_AllProvSBAckStd.RedeterminationLetterSentDate, BeneficiaryCollections_AllProvSBAckStd.RedeterminationDismissalReason, 
                      BeneficiaryCollections_AllProvSBAckStd.RedeterminationSummaryOfFacts, 
                      BeneficiaryCollections_AllProvSBAckStd.DecisionAmountInControversy AS AmountInControversy, 
                      BeneficiaryCollections_AllProvSBAckStd.ReconsiderationSubmittedMaterial AS SubmittedDocumentation, 
                      BeneficiaryCollections_AllProvSBAckStd.ReconsiderationUnsubmittedMaterial AS UnSubmittedDocumentation, 
                      dbo.GetBeneficiaryDetailSingle(BeneficiaryCollections_AllProvSBAckStd.AppealNumber, BeneficiaryCollections_AllProvSBAckStd.HIC) AS ClaimsDetail,
                       COALESCE (BeneficiaryCollections_AllProvSBAckStd.DuplicateAppealNumber, N'') AS DuplicateAppealNumber, 
                      COALESCE (BeneficiaryCollections_AllProvSBAckStd.DuplicateAppealAppellantName, N'') AS DuplicateAppealAppellantName, 
                      COALESCE (BeneficiaryCollections_AllProvSBAckStd.DuplicateAppealReceivedDate, N'') AS DuplicateAppealReceivedDate, 
                      ALJs_AllProvSBAckStd.Name AS ALJName, ALJs_AllProvSBAckStd.Address1 AS ALJAddress1, ALJs_AllProvSBAckStd.Address2 AS ALJAddress2, 
                      ALJs_AllProvSBAckStd.City AS ALJCity, ALJs_AllProvSBAckStd.State AS ALJState, ALJs_AllProvSBAckStd.ZIP AS ALJZIP, 
                      Contexts_AllProvSBAckStd.AppendAppealRightsAttachment, Contexts_AllProvSBAckStd.AppendAppointmentOfRepresentativeStatement, 
                      Contexts_AllProvSBAckStd.AppendWaiverOfLiabilityStatement, Contexts_AllProvSBAckStd.PrintFlag, Contexts_AllProvSBAckStd.AvailableToUsers, 
                      COALESCE (States_AllProvSBAckStd.PrintSortOrder, - 999) AS PrintSortOrder
FROM         dbo.Letters AS Letters_AllProvSBAckStd INNER JOIN
                      dbo.Beneficiaries AS Beneficiaries_AllProvSBAckStd ON Letters_AllProvSBAckStd.HIC = Beneficiaries_AllProvSBAckStd.HIC LEFT OUTER JOIN
                      dbo.Contexts AS Contexts_AllProvSBAckStd ON Letters_AllProvSBAckStd.ContextId = Contexts_AllProvSBAckStd.ContextId LEFT OUTER JOIN
                      dbo.Appeals AS Appeals_AllProvSBAckStd ON Letters_AllProvSBAckStd.AppealNumber = Appeals_AllProvSBAckStd.AppealNumber LEFT OUTER JOIN
                      dbo.Providers AS Providers_AllProvSBAckStd ON Appeals_AllProvSBAckStd.ProviderId = Providers_AllProvSBAckStd.ProviderId FULL OUTER JOIN
                      dbo.BeneficiaryCollections AS BeneficiaryCollections_AllProvSBAckStd ON 
                      Appeals_AllProvSBAckStd.AppealNumber = BeneficiaryCollections_AllProvSBAckStd.AppealNumber AND 
                      Beneficiaries_AllProvSBAckStd.HIC = BeneficiaryCollections_AllProvSBAckStd.HIC LEFT OUTER JOIN
                      dbo.Contractors AS Contractors_AllProvSBAckStd ON 
                      BeneficiaryCollections_AllProvSBAckStd.ContractorId = Contractors_AllProvSBAckStd.ContractorId LEFT OUTER JOIN
                      dbo.Representatives AS Representatives_AllProvSBAckStd ON 
                      Appeals_AllProvSBAckStd.RepresentativeId = Representatives_AllProvSBAckStd.RepresentativeId LEFT OUTER JOIN
                      dbo.ALJs AS ALJs_AllProvSBAckStd ON BeneficiaryCollections_AllProvSBAckStd.ALJId = ALJs_AllProvSBAckStd.ALJId LEFT OUTER JOIN
                      dbo.RedeterminationStates AS RedeterminationStates_AllProvSBAckStd ON 
                      BeneficiaryCollections_AllProvSBAckStd.RedeterminationState = RedeterminationStates_AllProvSBAckStd.State LEFT OUTER JOIN
                      dbo.States AS States_AllProvSBAckStd ON Providers_AllProvSBAckStd.State = States_AllProvSBAckStd.Prefix
WHERE     (Contexts_AllProvSBAckStd.PrintFlag <> 0) AND (Letters_AllProvSBAckStd.MailDate IS NULL) AND 
                      (Letters_AllProvSBAckStd.AddresseeType = 'Provider') AND (Letters_AllProvSBAckStd.ContextId = 'Acknowledgement - Standard') AND 
                      (Letters_AllProvSBAckStd.AppealNumber IN
                          (SELECT     AppealNumber
                            FROM          dbo.BeneficiaryCollections AS BeneficiaryCollections_AKS
                            GROUP BY AppealNumber
                            HAVING      (COUNT(*) = 1))) OR
                      (Contexts_AllProvSBAckStd.PrintFlag <> 0) AND (Letters_AllProvSBAckStd.AddresseeType = 'Provider') AND 
                      (Letters_AllProvSBAckStd.ContextId = 'Acknowledgement - Standard') AND (Letters_AllProvSBAckStd.AppealNumber IN
                          (SELECT     AppealNumber
                            FROM          dbo.BeneficiaryCollections AS BeneficiaryCollections_AKS2
                            GROUP BY AppealNumber
                            HAVING      (COUNT(*) = 1))) AND (Letters_AllProvSBAckStd.IndividualPrintedDate IS NULL)