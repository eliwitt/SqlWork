SELECT     Letters_AllProvSBMBPrefixes.LetterId, Contexts_AllProvSBMBPrefixes.ContextId AS Context, Contexts_AllProvSBMBPrefixes.Heading, 
                      Letters_AllProvSBMBPrefixes.SubmittedDate, Letters_AllProvSBMBPrefixes.MailDate AS ConsolidatedPrintedDate, 
                      Letters_AllProvSBMBPrefixes.IndividualPrintedDate AS PrintedDate, Appeals_AllProvSBMBPrefixes.AppellantType, 
                      Letters_AllProvSBMBPrefixes.AddresseeType, dbo.GetBeneficiaryNameFirstInitialLast(Beneficiaries_AllProvSBMBPrefixes.HIC) AS BeneficiaryName, 
                      Providers_AllProvSBMBPrefixes.Name AS ProviderName, 
                      dbo.GetRepresentativeNameFirstLast(Representatives_AllProvSBMBPrefixes.RepresentativeId) AS RepresentativeName, 
                      Providers_AllProvSBMBPrefixes.Address1, COALESCE (Providers_AllProvSBMBPrefixes.Address2, N'') AS Address2, 
                      Providers_AllProvSBMBPrefixes.City, Providers_AllProvSBMBPrefixes.State, Providers_AllProvSBMBPrefixes.ZIP, 
                      BeneficiaryCollections_AllProvSBMBPrefixes.AppealNumber, Appeals_AllProvSBMBPrefixes.ContractNumber, 
                      Contractors_AllProvSBMBPrefixes.ContractorId AS ContractorShortName, Contractors_AllProvSBMBPrefixes.LongName AS ContractorLongName, 
                      dbo.HICMask(Beneficiaries_AllProvSBMBPrefixes.HIC) AS HIC, Appeals_AllProvSBMBPrefixes.MultipleClaims, '' AS ClaimControlNumber, 
                      BeneficiaryCollections_AllProvSBMBPrefixes.ClaimPaidDate, dbo.GetMinBeginningDOS(BeneficiaryCollections_AllProvSBMBPrefixes.AppealNumber, 
                      BeneficiaryCollections_AllProvSBMBPrefixes.HIC) AS BeginningDOS, 
                      dbo.GetMaxEndingDOS(BeneficiaryCollections_AllProvSBMBPrefixes.AppealNumber, BeneficiaryCollections_AllProvSBMBPrefixes.HIC) 
                      AS EndingDOS, BeneficiaryCollections_AllProvSBMBPrefixes.ServicesRendered, 
                      BeneficiaryCollections_AllProvSBMBPrefixes.DecisionServicesCovered AS ServicesCovered, 
                      BeneficiaryCollections_AllProvSBMBPrefixes.DecisionServicesUncovered AS ServicesUncovered, 
                      BeneficiaryCollections_AllProvSBMBPrefixes.DecisionLiability AS ServicesUncoveredLiability, 
                      BeneficiaryCollections_AllProvSBMBPrefixes.DecisionExplanation, Appeals_AllProvSBMBPrefixes.ReconsiderationRequestSentDate, 
                      Appeals_AllProvSBMBPrefixes.ReconsiderationRequestReceivedDate, 
                      BeneficiaryCollections_AllProvSBMBPrefixes.ReconsiderationRequestWithdrawalSentDate, 
                      BeneficiaryCollections_AllProvSBMBPrefixes.ReconsiderationRequestWithdrawalReceivedDate, DATEADD(day, 
                      COALESCE (RedeterminationStates_AllProvSBMBPrefixes.DaysAllowedForTimeliness, 185), 
                      BeneficiaryCollections_AllProvSBMBPrefixes.RedeterminationLetterSentDate) AS ReconsiderationTimelinessDate, 
                      BeneficiaryCollections_AllProvSBMBPrefixes.InitialDenialDate, BeneficiaryCollections_AllProvSBMBPrefixes.InitialDenialSummaryOfFacts, 
                      BeneficiaryCollections_AllProvSBMBPrefixes.RedeterminationLetterSentDate, 
                      BeneficiaryCollections_AllProvSBMBPrefixes.RedeterminationDismissalReason, 
                      BeneficiaryCollections_AllProvSBMBPrefixes.RedeterminationSummaryOfFacts, 
                      BeneficiaryCollections_AllProvSBMBPrefixes.DecisionAmountInControversy AS AmountInControversy, 
                      BeneficiaryCollections_AllProvSBMBPrefixes.ReconsiderationSubmittedMaterial AS SubmittedDocumentation, 
                      BeneficiaryCollections_AllProvSBMBPrefixes.ReconsiderationUnsubmittedMaterial AS UnSubmittedDocumentation, 
                      dbo.GetBeneficiaryDetailSingle(BeneficiaryCollections_AllProvSBMBPrefixes.AppealNumber, BeneficiaryCollections_AllProvSBMBPrefixes.HIC) 
                      AS ClaimsDetail, COALESCE (BeneficiaryCollections_AllProvSBMBPrefixes.DuplicateAppealNumber, N'') AS DuplicateAppealNumber, 
                      COALESCE (BeneficiaryCollections_AllProvSBMBPrefixes.DuplicateAppealAppellantName, N'') AS DuplicateAppealAppellantName, 
                      COALESCE (BeneficiaryCollections_AllProvSBMBPrefixes.DuplicateAppealReceivedDate, N'') AS DuplicateAppealReceivedDate, 
                      ALJs_AllProvSBMBPrefixes.Name AS ALJName, ALJs_AllProvSBMBPrefixes.Address1 AS ALJAddress1, 
                      ALJs_AllProvSBMBPrefixes.Address2 AS ALJAddress2, ALJs_AllProvSBMBPrefixes.City AS ALJCity, ALJs_AllProvSBMBPrefixes.State AS ALJState, 
                      ALJs_AllProvSBMBPrefixes.ZIP AS ALJZIP, Contexts_AllProvSBMBPrefixes.AppendAppealRightsAttachment, 
                      Contexts_AllProvSBMBPrefixes.AppendAppointmentOfRepresentativeStatement, Contexts_AllProvSBMBPrefixes.AppendWaiverOfLiabilityStatement, 
                      Contexts_AllProvSBMBPrefixes.PrintFlag, Contexts_AllProvSBMBPrefixes.AvailableToUsers, COALESCE (States_AllProvSBMBPrefixes.PrintSortOrder, 
                      - 999) AS PrintSortOrder
FROM         dbo.Letters AS Letters_AllProvSBMBPrefixes INNER JOIN
                      dbo.Beneficiaries AS Beneficiaries_AllProvSBMBPrefixes ON 
                      Letters_AllProvSBMBPrefixes.HIC = Beneficiaries_AllProvSBMBPrefixes.HIC LEFT OUTER JOIN
                      dbo.Contexts AS Contexts_AllProvSBMBPrefixes ON 
                      Letters_AllProvSBMBPrefixes.ContextId = Contexts_AllProvSBMBPrefixes.ContextId LEFT OUTER JOIN
                      dbo.Appeals AS Appeals_AllProvSBMBPrefixes ON 
                      Letters_AllProvSBMBPrefixes.AppealNumber = Appeals_AllProvSBMBPrefixes.AppealNumber LEFT OUTER JOIN
                      dbo.Providers AS Providers_AllProvSBMBPrefixes ON 
                      Appeals_AllProvSBMBPrefixes.ProviderId = Providers_AllProvSBMBPrefixes.ProviderId FULL OUTER JOIN
                      dbo.BeneficiaryCollections AS BeneficiaryCollections_AllProvSBMBPrefixes ON 
                      Appeals_AllProvSBMBPrefixes.AppealNumber = BeneficiaryCollections_AllProvSBMBPrefixes.AppealNumber AND 
                      Beneficiaries_AllProvSBMBPrefixes.HIC = BeneficiaryCollections_AllProvSBMBPrefixes.HIC LEFT OUTER JOIN
                      dbo.Contractors AS Contractors_AllProvSBMBPrefixes ON 
                      BeneficiaryCollections_AllProvSBMBPrefixes.ContractorId = Contractors_AllProvSBMBPrefixes.ContractorId LEFT OUTER JOIN
                      dbo.Representatives AS Representatives_AllProvSBMBPrefixes ON 
                      Appeals_AllProvSBMBPrefixes.RepresentativeId = Representatives_AllProvSBMBPrefixes.RepresentativeId LEFT OUTER JOIN
                      dbo.ALJs AS ALJs_AllProvSBMBPrefixes ON BeneficiaryCollections_AllProvSBMBPrefixes.ALJId = ALJs_AllProvSBMBPrefixes.ALJId LEFT OUTER JOIN
                      dbo.RedeterminationStates AS RedeterminationStates_AllProvSBMBPrefixes ON 
                      BeneficiaryCollections_AllProvSBMBPrefixes.RedeterminationState = RedeterminationStates_AllProvSBMBPrefixes.State LEFT OUTER JOIN
                      dbo.States AS States_AllProvSBMBPrefixes ON Providers_AllProvSBMBPrefixes.State = States_AllProvSBMBPrefixes.Prefix
WHERE     (Contexts_AllProvSBMBPrefixes.PrintFlag <> 0) AND (Letters_AllProvSBMBPrefixes.MailDate IS NULL) AND 
                      (Letters_AllProvSBMBPrefixes.AddresseeType = 'Provider') AND (LEFT(Letters_AllProvSBMBPrefixes.ContextId, 2) = 'MB') AND 
                      (Letters_AllProvSBMBPrefixes.AppealNumber IN
                          (SELECT     AppealNumber
                            FROM          dbo.BeneficiaryCollections AS BeneficiaryCollections_MB1
                            GROUP BY AppealNumber
                            HAVING      (COUNT(*) = 1))) OR
                      (Contexts_AllProvSBMBPrefixes.PrintFlag <> 0) AND (Letters_AllProvSBMBPrefixes.AddresseeType = 'Provider') AND 
                      (LEFT(Letters_AllProvSBMBPrefixes.ContextId, 2) = 'MB') AND (Letters_AllProvSBMBPrefixes.IndividualPrintedDate IS NULL) AND 
                      (Letters_AllProvSBMBPrefixes.AppealNumber IN
                          (SELECT     AppealNumber
                            FROM          dbo.BeneficiaryCollections AS BeneficiaryCollections_MB2
                            GROUP BY AppealNumber
                            HAVING      (COUNT(*) = 1)))