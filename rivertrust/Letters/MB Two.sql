SELECT     Letters_AllProvMBMBPrefixes.LetterId, Contexts_AllProvMBMBPrefixes.ContextId AS Context, Contexts_AllProvMBMBPrefixes.Heading, 
                      Letters_AllProvMBMBPrefixes.SubmittedDate, Letters_AllProvMBMBPrefixes.MailDate AS ConsolidatedPrintedDate, 
                      Letters_AllProvMBMBPrefixes.IndividualPrintedDate AS PrintedDate, Appeals_AllProvMBMBPrefixes.AppellantType, 
                      Letters_AllProvMBMBPrefixes.AddresseeType, 'MULTIPLE' AS BeneficiaryName, Providers_AllProvMBMBPrefixes.Name AS ProviderName, 
                      dbo.GetRepresentativeNameFirstLast(Representatives_AllProvMBMBPrefixes.RepresentativeId) AS RepresentativeName, 
                      Providers_AllProvMBMBPrefixes.Address1, COALESCE (Providers_AllProvMBMBPrefixes.Address2, N'') AS Address2, 
                      Providers_AllProvMBMBPrefixes.City, Providers_AllProvMBMBPrefixes.State, Providers_AllProvMBMBPrefixes.ZIP, 
                      BeneficiaryCollections_AllProvMBMBPrefixes.AppealNumber, Appeals_AllProvMBMBPrefixes.ContractNumber, 
                      Contractors_AllProvMBMBPrefixes.ContractorId AS ContractorShortName, Contractors_AllProvMBMBPrefixes.LongName AS ContractorLongName, 
                      'MULTIPLE' AS HIC, Appeals_AllProvMBMBPrefixes.MultipleClaims, '' AS ClaimControlNumber, 
                      BeneficiaryCollections_AllProvMBMBPrefixes.ClaimPaidDate, dbo.GetMinBeginningDOS(BeneficiaryCollections_AllProvMBMBPrefixes.AppealNumber, 
                      BeneficiaryCollections_AllProvMBMBPrefixes.HIC) AS BeginningDOS, 
                      dbo.GetMaxEndingDOS(BeneficiaryCollections_AllProvMBMBPrefixes.AppealNumber, BeneficiaryCollections_AllProvMBMBPrefixes.HIC) 
                      AS EndingDOS, BeneficiaryCollections_AllProvMBMBPrefixes.ServicesRendered, 
                      BeneficiaryCollections_AllProvMBMBPrefixes.DecisionServicesCovered AS ServicesCovered, 
                      BeneficiaryCollections_AllProvMBMBPrefixes.DecisionServicesUncovered AS ServicesUncovered, 
                      BeneficiaryCollections_AllProvMBMBPrefixes.DecisionLiability AS ServicesUncoveredLiability, 
                      BeneficiaryCollections_AllProvMBMBPrefixes.DecisionExplanation, Appeals_AllProvMBMBPrefixes.ReconsiderationRequestSentDate, 
                      Appeals_AllProvMBMBPrefixes.ReconsiderationRequestReceivedDate, 
                      BeneficiaryCollections_AllProvMBMBPrefixes.ReconsiderationRequestWithdrawalSentDate, 
                      BeneficiaryCollections_AllProvMBMBPrefixes.ReconsiderationRequestWithdrawalReceivedDate, DATEADD(day, 
                      COALESCE (RedeterminationStates_AllProvMBMBPrefixes.DaysAllowedForTimeliness, 185), 
                      BeneficiaryCollections_AllProvMBMBPrefixes.RedeterminationLetterSentDate) AS ReconsiderationTimelinessDate, 
                      BeneficiaryCollections_AllProvMBMBPrefixes.InitialDenialDate, dbo.UnfavorableMultiBeneAggregation(Letters_AllProvMBMBPrefixes.AppealNumber, 
                      Contexts_AllProvMBMBPrefixes.ContextId) AS Expr1, BeneficiaryCollections_AllProvMBMBPrefixes.RedeterminationLetterSentDate, 
                      BeneficiaryCollections_AllProvMBMBPrefixes.RedeterminationDismissalReason, 
                      BeneficiaryCollections_AllProvMBMBPrefixes.RedeterminationSummaryOfFacts, 
                      dbo.GetSumAmountInControversy(BeneficiaryCollections_AllProvMBMBPrefixes.AppealNumber) AS AmountInControversy, 
                      BeneficiaryCollections_AllProvMBMBPrefixes.ReconsiderationSubmittedMaterial AS SubmittedDocumentation, 
                      BeneficiaryCollections_AllProvMBMBPrefixes.ReconsiderationUnsubmittedMaterial AS UnSubmittedDocumentation, '' AS ClaimsDetail, 
                      COALESCE (BeneficiaryCollections_AllProvMBMBPrefixes.DuplicateAppealNumber, N'') AS DuplicateAppealNumber, 
                      COALESCE (BeneficiaryCollections_AllProvMBMBPrefixes.DuplicateAppealAppellantName, N'') AS DuplicateAppealAppellantName, 
                      COALESCE (BeneficiaryCollections_AllProvMBMBPrefixes.DuplicateAppealReceivedDate, N'') AS DuplicateAppealReceivedDate, 
                      ALJs_AllProvMBMBPrefixes.Name AS ALJName, ALJs_AllProvMBMBPrefixes.Address1 AS ALJAddress1, 
                      ALJs_AllProvMBMBPrefixes.Address2 AS ALJAddress2, ALJs_AllProvMBMBPrefixes.City AS ALJCity, ALJs_AllProvMBMBPrefixes.State AS ALJState, 
                      ALJs_AllProvMBMBPrefixes.ZIP AS ALJZIP, Contexts_AllProvMBMBPrefixes.AppendAppealRightsAttachment, 
                      Contexts_AllProvMBMBPrefixes.AppendAppointmentOfRepresentativeStatement, Contexts_AllProvMBMBPrefixes.AppendWaiverOfLiabilityStatement, 
                      Contexts_AllProvMBMBPrefixes.PrintFlag, Contexts_AllProvMBMBPrefixes.AvailableToUsers, 
                      COALESCE (States_AllProvMBMBPrefixes.PrintSortOrder, - 999) AS PrintSortOrder
FROM         dbo.Letters AS Letters_AllProvMBMBPrefixes INNER JOIN
                      dbo.Beneficiaries AS Beneficiaries_AllProvMBMBPrefixes ON 
                      Letters_AllProvMBMBPrefixes.HIC = Beneficiaries_AllProvMBMBPrefixes.HIC LEFT OUTER JOIN
                      dbo.Contexts AS Contexts_AllProvMBMBPrefixes ON 
                      Letters_AllProvMBMBPrefixes.ContextId = Contexts_AllProvMBMBPrefixes.ContextId LEFT OUTER JOIN
                      dbo.Appeals AS Appeals_AllProvMBMBPrefixes ON 
                      Letters_AllProvMBMBPrefixes.AppealNumber = Appeals_AllProvMBMBPrefixes.AppealNumber LEFT OUTER JOIN
                      dbo.Providers AS Providers_AllProvMBMBPrefixes ON 
                      Appeals_AllProvMBMBPrefixes.ProviderId = Providers_AllProvMBMBPrefixes.ProviderId FULL OUTER JOIN
                      dbo.BeneficiaryCollections AS BeneficiaryCollections_AllProvMBMBPrefixes ON 
                      Appeals_AllProvMBMBPrefixes.AppealNumber = BeneficiaryCollections_AllProvMBMBPrefixes.AppealNumber AND 
                      Beneficiaries_AllProvMBMBPrefixes.HIC = BeneficiaryCollections_AllProvMBMBPrefixes.HIC LEFT OUTER JOIN
                      dbo.Contractors AS Contractors_AllProvMBMBPrefixes ON 
                      BeneficiaryCollections_AllProvMBMBPrefixes.ContractorId = Contractors_AllProvMBMBPrefixes.ContractorId LEFT OUTER JOIN
                      dbo.Representatives AS Representatives_AllProvMBMBPrefixes ON 
                      Appeals_AllProvMBMBPrefixes.RepresentativeId = Representatives_AllProvMBMBPrefixes.RepresentativeId LEFT OUTER JOIN
                      dbo.ALJs AS ALJs_AllProvMBMBPrefixes ON 
                      BeneficiaryCollections_AllProvMBMBPrefixes.ALJId = ALJs_AllProvMBMBPrefixes.ALJId LEFT OUTER JOIN
                      dbo.RedeterminationStates AS RedeterminationStates_AllProvMBMBPrefixes ON 
                      BeneficiaryCollections_AllProvMBMBPrefixes.RedeterminationState = RedeterminationStates_AllProvMBMBPrefixes.State LEFT OUTER JOIN
                      dbo.States AS States_AllProvMBMBPrefixes ON Providers_AllProvMBMBPrefixes.State = States_AllProvMBMBPrefixes.Prefix
WHERE     (Contexts_AllProvMBMBPrefixes.PrintFlag <> 0) AND (Letters_AllProvMBMBPrefixes.MailDate IS NULL) AND 
                      (Letters_AllProvMBMBPrefixes.AddresseeType = 'Provider') AND (LEFT(Letters_AllProvMBMBPrefixes.ContextId, 2) = 'MB') AND 
                      (Letters_AllProvMBMBPrefixes.AppealNumber NOT IN
                          (SELECT     AppealNumber
                            FROM          dbo.BeneficiaryCollections AS BeneficiaryCollections_MB1
                            GROUP BY AppealNumber
                            HAVING      (COUNT(*) = 1))) OR
                      (Contexts_AllProvMBMBPrefixes.PrintFlag <> 0) AND (Letters_AllProvMBMBPrefixes.AddresseeType = 'Provider') AND 
                      (LEFT(Letters_AllProvMBMBPrefixes.ContextId, 2) = 'MB') AND (Letters_AllProvMBMBPrefixes.AppealNumber NOT IN
                          (SELECT     AppealNumber
                            FROM          dbo.BeneficiaryCollections AS BeneficiaryCollections_MB2
                            GROUP BY AppealNumber
                            HAVING      (COUNT(*) = 1))) AND (Letters_AllProvMBMBPrefixes.IndividualPrintedDate IS NULL)
