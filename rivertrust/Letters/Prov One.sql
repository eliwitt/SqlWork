SELECT     Letters_AllProvMBAckStd.LetterId, Contexts_AllProvMBAckStd.ContextId AS Context, Contexts_AllProvMBAckStd.Heading, 
                      Letters_AllProvMBAckStd.SubmittedDate, Letters_AllProvMBAckStd.MailDate AS ConsolidatedPrintedDate, 
                      Letters_AllProvMBAckStd.IndividualPrintedDate AS PrintedDate, Appeals_AllProvMBAckStd.AppellantType, Letters_AllProvMBAckStd.AddresseeType, 
                      'MULTIPLE' AS BeneficiaryName, Providers_AllProvMBAckStd.Name AS ProviderName, 'Representative' AS RepresentativeName, 
                      Providers_AllProvMBAckStd.Address1, COALESCE (Providers_AllProvMBAckStd.Address2, N'') AS Address2, Providers_AllProvMBAckStd.City, 
                      Providers_AllProvMBAckStd.State, Providers_AllProvMBAckStd.ZIP, BeneficiaryCollections_AllProvMBAckStd.AppealNumber, 
                      Appeals_AllProvMBAckStd.ContractNumber, Contractors_AllProvMBAckStd.ContractorId AS ContractorShortName, 
                      Contractors_AllProvMBAckStd.LongName AS ContractorLongName, 'MULTIPLE' AS HIC, Appeals_AllProvMBAckStd.MultipleClaims, 
                      '' AS ClaimControlNumber, BeneficiaryCollections_AllProvMBAckStd.ClaimPaidDate, 
                      dbo.GetAcknowledgementMinBeginningDOS(BeneficiaryCollections_AllProvMBAckStd.AppealNumber) AS BeginningDOS, 
                      dbo.GetAcknowledgementMaxEndingDOS(BeneficiaryCollections_AllProvMBAckStd.AppealNumber) AS EndingDOS, '' AS Expr1, 
                      BeneficiaryCollections_AllProvMBAckStd.DecisionServicesCovered AS ServicesCovered, 
                      BeneficiaryCollections_AllProvMBAckStd.DecisionServicesUncovered AS ServicesUncovered, 
                      BeneficiaryCollections_AllProvMBAckStd.DecisionLiability AS ServicesUncoveredLiability, 
                      BeneficiaryCollections_AllProvMBAckStd.DecisionExplanation, Appeals_AllProvMBAckStd.ReconsiderationRequestSentDate, 
                      Appeals_AllProvMBAckStd.ReconsiderationRequestReceivedDate, 
                      BeneficiaryCollections_AllProvMBAckStd.ReconsiderationRequestWithdrawalSentDate, 
                      BeneficiaryCollections_AllProvMBAckStd.ReconsiderationRequestWithdrawalReceivedDate, DATEADD(day, 
                      COALESCE (RedeterminationStates_AllProvMBAckStd.DaysAllowedForTimeliness, 185), 
                      BeneficiaryCollections_AllProvMBAckStd.RedeterminationLetterSentDate) AS ReconsiderationTimelinessDate, 
                      BeneficiaryCollections_AllProvMBAckStd.InitialDenialDate, BeneficiaryCollections_AllProvMBAckStd.InitialDenialSummaryOfFacts, 
                      BeneficiaryCollections_AllProvMBAckStd.RedeterminationLetterSentDate, BeneficiaryCollections_AllProvMBAckStd.RedeterminationDismissalReason, 
                      BeneficiaryCollections_AllProvMBAckStd.RedeterminationSummaryOfFacts, 
                      BeneficiaryCollections_AllProvMBAckStd.DecisionAmountInControversy AS AmountInControversy, 
                      BeneficiaryCollections_AllProvMBAckStd.ReconsiderationSubmittedMaterial AS SubmittedDocumentation, 
                      BeneficiaryCollections_AllProvMBAckStd.ReconsiderationUnsubmittedMaterial AS UnSubmittedDocumentation, 
                      dbo.GetBeneficiariesDetail(BeneficiaryCollections_AllProvMBAckStd.AppealNumber) AS ClaimsDetail, 
                      COALESCE (BeneficiaryCollections_AllProvMBAckStd.DuplicateAppealNumber, N'') AS DuplicateAppealNumber, 
                      COALESCE (BeneficiaryCollections_AllProvMBAckStd.DuplicateAppealAppellantName, N'') AS DuplicateAppealAppellantName, 
                      COALESCE (BeneficiaryCollections_AllProvMBAckStd.DuplicateAppealReceivedDate, N'') AS DuplicateAppealReceivedDate, 
                      ALJs_AllProvMBAckStd.Name AS ALJName, ALJs_AllProvMBAckStd.Address1 AS ALJAddress1, ALJs_AllProvMBAckStd.Address2 AS ALJAddress2, 
                      ALJs_AllProvMBAckStd.City AS ALJCity, ALJs_AllProvMBAckStd.State AS ALJState, ALJs_AllProvMBAckStd.ZIP AS ALJZIP, 
                      Contexts_AllProvMBAckStd.AppendAppealRightsAttachment, Contexts_AllProvMBAckStd.AppendAppointmentOfRepresentativeStatement, 
                      Contexts_AllProvMBAckStd.AppendWaiverOfLiabilityStatement, Contexts_AllProvMBAckStd.PrintFlag, Contexts_AllProvMBAckStd.AvailableToUsers, 
                      COALESCE (States_AllProvMBAckStd.PrintSortOrder, - 999) AS PrintSortOrder
FROM         dbo.Letters AS Letters_AllProvMBAckStd INNER JOIN
                      dbo.Beneficiaries AS Beneficiaries_AllProvMBAckStd ON Letters_AllProvMBAckStd.HIC = Beneficiaries_AllProvMBAckStd.HIC LEFT OUTER JOIN
                      dbo.Contexts AS Contexts_AllProvMBAckStd ON Letters_AllProvMBAckStd.ContextId = Contexts_AllProvMBAckStd.ContextId LEFT OUTER JOIN
                      dbo.Appeals AS Appeals_AllProvMBAckStd ON Letters_AllProvMBAckStd.AppealNumber = Appeals_AllProvMBAckStd.AppealNumber LEFT OUTER JOIN
                      dbo.Providers AS Providers_AllProvMBAckStd ON Appeals_AllProvMBAckStd.ProviderId = Providers_AllProvMBAckStd.ProviderId FULL OUTER JOIN
                      dbo.BeneficiaryCollections AS BeneficiaryCollections_AllProvMBAckStd ON 
                      Appeals_AllProvMBAckStd.AppealNumber = BeneficiaryCollections_AllProvMBAckStd.AppealNumber AND 
                      Beneficiaries_AllProvMBAckStd.HIC = BeneficiaryCollections_AllProvMBAckStd.HIC LEFT OUTER JOIN
                      dbo.Contractors AS Contractors_AllProvMBAckStd ON 
                      BeneficiaryCollections_AllProvMBAckStd.ContractorId = Contractors_AllProvMBAckStd.ContractorId LEFT OUTER JOIN
                      dbo.Representatives AS Representatives_AllProvMBAckStd ON 
                      Appeals_AllProvMBAckStd.RepresentativeId = Representatives_AllProvMBAckStd.RepresentativeId LEFT OUTER JOIN
                      dbo.ALJs AS ALJs_AllProvMBAckStd ON BeneficiaryCollections_AllProvMBAckStd.ALJId = ALJs_AllProvMBAckStd.ALJId LEFT OUTER JOIN
                      dbo.RedeterminationStates AS RedeterminationStates_AllProvMBAckStd ON 
                      BeneficiaryCollections_AllProvMBAckStd.RedeterminationState = RedeterminationStates_AllProvMBAckStd.State LEFT OUTER JOIN
                      dbo.States AS States_AllProvMBAckStd ON Providers_AllProvMBAckStd.State = States_AllProvMBAckStd.Prefix
WHERE     (Contexts_AllProvMBAckStd.PrintFlag <> 0) AND (Letters_AllProvMBAckStd.MailDate IS NULL) AND 
                      (Letters_AllProvMBAckStd.AddresseeType = 'Provider') AND (Letters_AllProvMBAckStd.ContextId = 'Acknowledgement - Standard') AND 
                      (Letters_AllProvMBAckStd.AppealNumber NOT IN
                          (SELECT     AppealNumber
                            FROM          dbo.BeneficiaryCollections AS BeneficiaryCollections_AKM
                            GROUP BY AppealNumber
                            HAVING      (COUNT(*) = 1))) OR
                      (Contexts_AllProvMBAckStd.PrintFlag <> 0) AND (Letters_AllProvMBAckStd.AddresseeType = 'Provider') AND 
                      (Letters_AllProvMBAckStd.IndividualPrintedDate IS NULL) AND (Letters_AllProvMBAckStd.ContextId = 'Acknowledgement - Standard') AND 
                      (Letters_AllProvMBAckStd.AppealNumber NOT IN
                          (SELECT     AppealNumber
                            FROM          dbo.BeneficiaryCollections AS BeneficiaryCollections_AKM2
                            GROUP BY AppealNumber
                            HAVING      (COUNT(*) = 1))) AND (Letters_AllProvMBAckStd.IndividualPrintedDate IS NULL)