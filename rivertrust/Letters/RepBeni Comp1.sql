--   this query pulled the correct amount of rows from both AddresseeType's
--
SELECT     Letters_AllReps.LetterId, Contexts_AllReps.ContextId AS Context, Contexts_AllReps.Heading, Letters_AllReps.SubmittedDate, 
                      Letters_AllReps.MailDate AS ConsolidatedPrintedDate, Letters_AllReps.IndividualPrintedDate AS PrintedDate, Appeals_AllReps.AppellantType, 
                      Letters_AllReps.AddresseeType, dbo.GetBeneficiaryNameFirstInitialLast(Beneficiaries_AllReps.HIC) AS BeneficiaryName, 
                      Providers_AllReps.Name AS ProviderName, dbo.GetRepresentativeNameFirstLast(Representatives_AllReps.RepresentativeId) 
                      AS RepresentativeName, Representatives_AllReps.Address1, COALESCE (Representatives_AllReps.Address2, N'') AS Address2, 
                      Representatives_AllReps.City, Representatives_AllReps.State, Representatives_AllReps.ZIP, BeneficiaryCollections_AllReps.AppealNumber, 
                      Appeals_AllReps.ContractNumber, Contractors_AllReps.ContractorId AS ContractorShortName, Contractors_AllReps.LongName AS ContractorLongName,
                       dbo.HICMask(Beneficiaries_AllReps.HIC) AS HIC, Appeals_AllReps.MultipleClaims, '' AS ClaimControlNumber, 
                      BeneficiaryCollections_AllReps.ClaimPaidDate, dbo.GetMinBeginningDOS(BeneficiaryCollections_AllReps.AppealNumber, 
                      BeneficiaryCollections_AllReps.HIC) AS BeginningDOS, dbo.GetMaxEndingDOS(BeneficiaryCollections_AllReps.AppealNumber, 
                      BeneficiaryCollections_AllReps.HIC) AS EndingDOS, BeneficiaryCollections_AllReps.ServicesRendered, 
                      BeneficiaryCollections_AllReps.DecisionServicesCovered AS ServicesCovered, 
                      BeneficiaryCollections_AllReps.DecisionServicesUncovered AS ServicesUncovered, 
                      BeneficiaryCollections_AllReps.DecisionLiability AS ServicesUncoveredLiability, BeneficiaryCollections_AllReps.DecisionExplanation, 
                      Appeals_AllReps.ReconsiderationRequestSentDate, Appeals_AllReps.ReconsiderationRequestReceivedDate, 
                      BeneficiaryCollections_AllReps.ReconsiderationRequestWithdrawalSentDate, 
                      BeneficiaryCollections_AllReps.ReconsiderationRequestWithdrawalReceivedDate, DATEADD(day, 
                      COALESCE (RedeterminationStates_AllReps.DaysAllowedForTimeliness, 185), BeneficiaryCollections_AllReps.RedeterminationLetterSentDate) 
                      AS ReconsiderationTimelinessDate, BeneficiaryCollections_AllReps.InitialDenialDate, BeneficiaryCollections_AllReps.InitialDenialSummaryOfFacts, 
                      BeneficiaryCollections_AllReps.RedeterminationLetterSentDate, BeneficiaryCollections_AllReps.RedeterminationDismissalReason, 
                      BeneficiaryCollections_AllReps.RedeterminationSummaryOfFacts, 
                      BeneficiaryCollections_AllReps.DecisionAmountInControversy AS AmountInControversy, 
                      BeneficiaryCollections_AllReps.ReconsiderationSubmittedMaterial AS SubmittedDocumentation, 
                      BeneficiaryCollections_AllReps.ReconsiderationUnsubmittedMaterial AS UnSubmittedDocumentation, 
                      dbo.GetBeneficiaryDetailSingle(BeneficiaryCollections_AllReps.AppealNumber, BeneficiaryCollections_AllReps.HIC) AS ClaimsDetail, 
                      COALESCE (BeneficiaryCollections_AllReps.DuplicateAppealNumber, N'') AS DuplicateAppealNumber, 
                      COALESCE (BeneficiaryCollections_AllReps.DuplicateAppealAppellantName, N'') AS DuplicateAppealAppellantName, 
                      COALESCE (BeneficiaryCollections_AllReps.DuplicateAppealReceivedDate, N'') AS DuplicateAppealReceivedDate, ALJs_AllReps.Name AS ALJName, 
                      ALJs_AllReps.Address1 AS ALJAddress1, ALJs_AllReps.Address2 AS ALJAddress2, ALJs_AllReps.City AS ALJCity, ALJs_AllReps.State AS ALJState, 
                      ALJs_AllReps.ZIP AS ALJZIP, Contexts_AllReps.AppendAppealRightsAttachment, Contexts_AllReps.AppendAppointmentOfRepresentativeStatement, 
                      Contexts_AllReps.AppendWaiverOfLiabilityStatement, Contexts_AllReps.PrintFlag, Contexts_AllReps.AvailableToUsers, 
                      COALESCE (States_AllReps.PrintSortOrder, - 999) AS PrintSortOrder
FROM         dbo.Letters AS Letters_AllReps INNER JOIN
                      dbo.Beneficiaries AS Beneficiaries_AllReps ON Letters_AllReps.HIC = Beneficiaries_AllReps.HIC LEFT OUTER JOIN
                      dbo.Contexts AS Contexts_AllReps ON Letters_AllReps.ContextId = Contexts_AllReps.ContextId LEFT OUTER JOIN
                      dbo.Appeals AS Appeals_AllReps ON Letters_AllReps.AppealNumber = Appeals_AllReps.AppealNumber LEFT OUTER JOIN
                      dbo.Providers AS Providers_AllReps ON Appeals_AllReps.ProviderId = Providers_AllReps.ProviderId FULL OUTER JOIN
                      dbo.BeneficiaryCollections AS BeneficiaryCollections_AllReps ON 
                      Appeals_AllReps.AppealNumber = BeneficiaryCollections_AllReps.AppealNumber AND 
                      Beneficiaries_AllReps.HIC = BeneficiaryCollections_AllReps.HIC LEFT OUTER JOIN
                      dbo.Contractors AS Contractors_AllReps ON BeneficiaryCollections_AllReps.ContractorId = Contractors_AllReps.ContractorId LEFT OUTER JOIN
                      dbo.Representatives AS Representatives_AllReps ON 
                      Appeals_AllReps.RepresentativeId = Representatives_AllReps.RepresentativeId LEFT OUTER JOIN
                      dbo.ALJs AS ALJs_AllReps ON BeneficiaryCollections_AllReps.ALJId = ALJs_AllReps.ALJId LEFT OUTER JOIN
                      dbo.RedeterminationStates AS RedeterminationStates_AllReps ON 
                      BeneficiaryCollections_AllReps.RedeterminationState = RedeterminationStates_AllReps.State LEFT OUTER JOIN
                      dbo.States AS States_AllReps ON Representatives_AllReps.State = States_AllReps.Prefix
WHERE     (Contexts_AllReps.PrintFlag <> 0) AND (Letters_AllReps.MailDate IS NULL) AND (Letters_AllReps.AddresseeType in ('Representative','Beneficiary')) OR
                      (Contexts_AllReps.PrintFlag <> 0) AND (Letters_AllReps.AddresseeType in ('Representative','Beneficiary')) AND (Letters_AllReps.IndividualPrintedDate IS NULL)                   