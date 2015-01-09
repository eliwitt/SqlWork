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
UNION
SELECT     Letters_AllProvSBAckStd.LetterId, Contexts_AllProvSBAckStd.ContextId AS Context, Contexts_AllProvSBAckStd.Heading, 
                      Letters_AllProvSBAckStd.SubmittedDate, Letters_AllProvSBAckStd.MailDate AS ConsolidatedPrintedDate, 
                      Letters_AllProvSBAckStd.IndividualPrintedDate AS PrintedDate, Appeals_AllProvSBAckStd.AppellantType, Letters_AllProvSBAckStd.AddresseeType, 
                      case when BeniCnt = 1 then
                            	dbo.GetBeneficiaryNameFirstInitialLast(Beneficiaries_AllProvSBAckStd.HIC)
                            else
                            	'MULTIPLE'
                            end	AS BeneficiaryName, 
                      Providers_AllProvSBAckStd.Name AS ProviderName,
                      case when BeniCnt = 1 then
                      		dbo.GetRepresentativeNameFirstLast(Representatives_AllProvSBAckStd.RepresentativeId)
                      	else
                      		'Representative'
                      end AS RepresentativeName, 
                      Providers_AllProvSBAckStd.Address1, COALESCE (Providers_AllProvSBAckStd.Address2, N'') AS Address2, Providers_AllProvSBAckStd.City, 
                      Providers_AllProvSBAckStd.State, Providers_AllProvSBAckStd.ZIP, BeneficiaryCollections_AllProvSBAckStd.AppealNumber, 
                      Appeals_AllProvSBAckStd.ContractNumber, Contractors_AllProvSBAckStd.ContractorId AS ContractorShortName, 
                      Contractors_AllProvSBAckStd.LongName AS ContractorLongName,
                      case when BeniCnt = 1 then
                      		dbo.HICMask(Beneficiaries_AllProvSBAckStd.HIC)
                      	else
                      		'MULTIPLE'
                      	end AS HIC, 
                      Appeals_AllProvSBAckStd.MultipleClaims, '' AS ClaimControlNumber, BeneficiaryCollections_AllProvSBAckStd.ClaimPaidDate, 
                      dbo.GetAcknowledgementMinBeginningDOS(BeneficiaryCollections_AllProvSBAckStd.AppealNumber) AS BeginningDOS, 
                      dbo.GetAcknowledgementMaxEndingDOS(BeneficiaryCollections_AllProvSBAckStd.AppealNumber) AS EndingDOS, 
                      case when BeniCnt = 1 then
                      		BeneficiaryCollections_AllProvSBAckStd.ServicesRendered
                      	else
                      		''
                      end as Expr1, 
                      BeneficiaryCollections_AllProvSBAckStd.DecisionServicesCovered AS ServicesCovered, 
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
                      case when BeniCnt = 1 then
                      		dbo.GetBeneficiaryDetailSingle(BeneficiaryCollections_AllProvSBAckStd.AppealNumber, BeneficiaryCollections_AllProvSBAckStd.HIC)
                      	else
                      		dbo.GetBeneficiariesDetail(BeneficiaryCollections_AllProvSBAckStd.AppealNumber)
                      end AS ClaimsDetail,
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
                      left join (SELECT     AppealNumber, Count(*) BeniCnt
                            FROM          dbo.BeneficiaryCollections AS BeneficiaryCollections_AKS
                            GROUP BY AppealNumber
                            HAVING      (COUNT(*) = 1)) BeniCntr on Letters_AllProvSBAckStd.AppealNumber = BeniCntr.AppealNumber
WHERE     (Contexts_AllProvSBAckStd.PrintFlag <> 0) AND (Letters_AllProvSBAckStd.MailDate IS NULL) AND 
                      (Letters_AllProvSBAckStd.AddresseeType = 'Provider') AND (Letters_AllProvSBAckStd.ContextId = 'Acknowledgement - Standard')  
UNION
SELECT     Letters_AllProvNonAckStd.LetterId, Contexts_AllProvNonAckStd.ContextId AS Context, Contexts_AllProvNonAckStd.Heading, 
                      Letters_AllProvNonAckStd.SubmittedDate, Letters_AllProvNonAckStd.MailDate AS ConsolidatedPrintedDate, 
                      Letters_AllProvNonAckStd.IndividualPrintedDate AS PrintedDate, Appeals_AllProvNonAckStd.AppellantType, Letters_AllProvNonAckStd.AddresseeType, 
                      dbo.GetBeneficiaryNameFirstInitialLast(Beneficiaries_AllProvNonAckStd.HIC) AS BeneficiaryName, 
                      Providers_AllProvNonAckStd.Name AS ProviderName, dbo.GetRepresentativeNameFirstLast(Representatives_AllProvNonAckStd.RepresentativeId) 
                      AS RepresentativeName, Providers_AllProvNonAckStd.Address1, COALESCE (Providers_AllProvNonAckStd.Address2, N'') AS Address2, 
                      Providers_AllProvNonAckStd.City, Providers_AllProvNonAckStd.State, Providers_AllProvNonAckStd.ZIP, 
                      BeneficiaryCollections_AllProvNonAckStd.AppealNumber, Appeals_AllProvNonAckStd.ContractNumber, 
                      Contractors_AllProvNonAckStd.ContractorId AS ContractorShortName, Contractors_AllProvNonAckStd.LongName AS ContractorLongName, 
                      dbo.HICMask(Beneficiaries_AllProvNonAckStd.HIC) AS HIC, Appeals_AllProvNonAckStd.MultipleClaims, '' AS ClaimControlNumber, 
                      BeneficiaryCollections_AllProvNonAckStd.ClaimPaidDate, dbo.GetMinBeginningDOS(BeneficiaryCollections_AllProvNonAckStd.AppealNumber, 
                      BeneficiaryCollections_AllProvNonAckStd.HIC) AS BeginningDOS, dbo.GetMaxEndingDOS(BeneficiaryCollections_AllProvNonAckStd.AppealNumber, 
                      BeneficiaryCollections_AllProvNonAckStd.HIC) AS EndingDOS, BeneficiaryCollections_AllProvNonAckStd.ServicesRendered, 
                      BeneficiaryCollections_AllProvNonAckStd.DecisionServicesCovered AS ServicesCovered, 
                      BeneficiaryCollections_AllProvNonAckStd.DecisionServicesUncovered AS ServicesUncovered, 
                      BeneficiaryCollections_AllProvNonAckStd.DecisionLiability AS ServicesUncoveredLiability, 
                      BeneficiaryCollections_AllProvNonAckStd.DecisionExplanation, Appeals_AllProvNonAckStd.ReconsiderationRequestSentDate, 
                      Appeals_AllProvNonAckStd.ReconsiderationRequestReceivedDate, 
                      BeneficiaryCollections_AllProvNonAckStd.ReconsiderationRequestWithdrawalSentDate, 
                      BeneficiaryCollections_AllProvNonAckStd.ReconsiderationRequestWithdrawalReceivedDate, DATEADD(day, 
                      COALESCE (RedeterminationStates_AllProvNonAckStd.DaysAllowedForTimeliness, 185), 
                      BeneficiaryCollections_AllProvNonAckStd.RedeterminationLetterSentDate) AS ReconsiderationTimelinessDate, 
                      BeneficiaryCollections_AllProvNonAckStd.InitialDenialDate, BeneficiaryCollections_AllProvNonAckStd.InitialDenialSummaryOfFacts, 
                      BeneficiaryCollections_AllProvNonAckStd.RedeterminationLetterSentDate, 
                      BeneficiaryCollections_AllProvNonAckStd.RedeterminationDismissalReason, 
                      BeneficiaryCollections_AllProvNonAckStd.RedeterminationSummaryOfFacts, 
                      BeneficiaryCollections_AllProvNonAckStd.DecisionAmountInControversy AS AmountInControversy, 
                      BeneficiaryCollections_AllProvNonAckStd.ReconsiderationSubmittedMaterial AS SubmittedDocumentation, 
                      BeneficiaryCollections_AllProvNonAckStd.ReconsiderationUnsubmittedMaterial AS UnSubmittedDocumentation, 
                      dbo.GetBeneficiaryDetailSingle(BeneficiaryCollections_AllProvNonAckStd.AppealNumber, BeneficiaryCollections_AllProvNonAckStd.HIC) 
                      AS ClaimsDetail, COALESCE (BeneficiaryCollections_AllProvNonAckStd.DuplicateAppealNumber, N'') AS DuplicateAppealNumber, 
                      COALESCE (BeneficiaryCollections_AllProvNonAckStd.DuplicateAppealAppellantName, N'') AS DuplicateAppealAppellantName, 
                      COALESCE (BeneficiaryCollections_AllProvNonAckStd.DuplicateAppealReceivedDate, N'') AS DuplicateAppealReceivedDate, 
                      ALJs_AllProvNonAckStd.Name AS ALJName, ALJs_AllProvNonAckStd.Address1 AS ALJAddress1, ALJs_AllProvNonAckStd.Address2 AS ALJAddress2, 
                      ALJs_AllProvNonAckStd.City AS ALJCity, ALJs_AllProvNonAckStd.State AS ALJState, ALJs_AllProvNonAckStd.ZIP AS ALJZIP, 
                      Contexts_AllProvNonAckStd.AppendAppealRightsAttachment, Contexts_AllProvNonAckStd.AppendAppointmentOfRepresentativeStatement, 
                      Contexts_AllProvNonAckStd.AppendWaiverOfLiabilityStatement, Contexts_AllProvNonAckStd.PrintFlag, Contexts_AllProvNonAckStd.AvailableToUsers, 
                      COALESCE (States_AllProvNonAckStd.PrintSortOrder, - 999) AS PrintSortOrder
FROM         dbo.Letters AS Letters_AllProvNonAckStd INNER JOIN
                      dbo.Beneficiaries AS Beneficiaries_AllProvNonAckStd ON Letters_AllProvNonAckStd.HIC = Beneficiaries_AllProvNonAckStd.HIC LEFT OUTER JOIN
                      dbo.Contexts AS Contexts_AllProvNonAckStd ON Letters_AllProvNonAckStd.ContextId = Contexts_AllProvNonAckStd.ContextId LEFT OUTER JOIN
                      dbo.Appeals AS Appeals_AllProvNonAckStd ON Letters_AllProvNonAckStd.AppealNumber = Appeals_AllProvNonAckStd.AppealNumber LEFT OUTER JOIN
                      dbo.Providers AS Providers_AllProvNonAckStd ON Appeals_AllProvNonAckStd.ProviderId = Providers_AllProvNonAckStd.ProviderId FULL OUTER JOIN
                      dbo.BeneficiaryCollections AS BeneficiaryCollections_AllProvNonAckStd ON 
                      Appeals_AllProvNonAckStd.AppealNumber = BeneficiaryCollections_AllProvNonAckStd.AppealNumber AND 
                      Beneficiaries_AllProvNonAckStd.HIC = BeneficiaryCollections_AllProvNonAckStd.HIC LEFT OUTER JOIN
                      dbo.Contractors AS Contractors_AllProvNonAckStd ON 
                      BeneficiaryCollections_AllProvNonAckStd.ContractorId = Contractors_AllProvNonAckStd.ContractorId LEFT OUTER JOIN
                      dbo.Representatives AS Representatives_AllProvNonAckStd ON 
                      Appeals_AllProvNonAckStd.RepresentativeId = Representatives_AllProvNonAckStd.RepresentativeId LEFT OUTER JOIN
                      dbo.ALJs AS ALJs_AllProvNonAckStd ON BeneficiaryCollections_AllProvNonAckStd.ALJId = ALJs_AllProvNonAckStd.ALJId LEFT OUTER JOIN
                      dbo.RedeterminationStates AS RedeterminationStates_AllProvNonAckStd ON 
                      BeneficiaryCollections_AllProvNonAckStd.RedeterminationState = RedeterminationStates_AllProvNonAckStd.State LEFT OUTER JOIN
                      dbo.States AS States_AllProvNonAckStd ON Providers_AllProvNonAckStd.State = States_AllProvNonAckStd.Prefix
WHERE     (Contexts_AllProvNonAckStd.PrintFlag <> 0) AND (Letters_AllProvNonAckStd.MailDate IS NULL) AND 
                      (Letters_AllProvNonAckStd.AddresseeType = 'Provider') AND (Letters_AllProvNonAckStd.ContextId <> 'Acknowledgement - Standard') AND 
                      (LEFT(Letters_AllProvNonAckStd.ContextId, 2) <> 'MB') OR
                      (Contexts_AllProvNonAckStd.PrintFlag <> 0) AND (Letters_AllProvNonAckStd.AddresseeType = 'Provider') AND 
                      (Letters_AllProvNonAckStd.ContextId <> 'Acknowledgement - Standard') AND (Letters_AllProvNonAckStd.IndividualPrintedDate IS NULL) AND 
                      (LEFT(Letters_AllProvNonAckStd.ContextId, 2) <> 'MB')
UNION
SELECT     Letters_AllProvSBMBPrefixes.LetterId, Contexts_AllProvSBMBPrefixes.ContextId AS Context, Contexts_AllProvSBMBPrefixes.Heading, 
                      Letters_AllProvSBMBPrefixes.SubmittedDate, Letters_AllProvSBMBPrefixes.MailDate AS ConsolidatedPrintedDate, 
                      Letters_AllProvSBMBPrefixes.IndividualPrintedDate AS PrintedDate, Appeals_AllProvSBMBPrefixes.AppellantType, 
                      Letters_AllProvSBMBPrefixes.AddresseeType, 
                      case when BeniCnt = 1 then
                      		dbo.GetBeneficiaryNameFirstInitialLast(Beneficiaries_AllProvSBMBPrefixes.HIC)
                      	else
                      		'MULTIPLE'
                      	end AS BeneficiaryName, 
                      Providers_AllProvSBMBPrefixes.Name AS ProviderName, 
                      dbo.GetRepresentativeNameFirstLast(Representatives_AllProvSBMBPrefixes.RepresentativeId) AS RepresentativeName, 
                      Providers_AllProvSBMBPrefixes.Address1, COALESCE (Providers_AllProvSBMBPrefixes.Address2, N'') AS Address2, 
                      Providers_AllProvSBMBPrefixes.City, Providers_AllProvSBMBPrefixes.State, Providers_AllProvSBMBPrefixes.ZIP, 
                      BeneficiaryCollections_AllProvSBMBPrefixes.AppealNumber, Appeals_AllProvSBMBPrefixes.ContractNumber, 
                      Contractors_AllProvSBMBPrefixes.ContractorId AS ContractorShortName, Contractors_AllProvSBMBPrefixes.LongName AS ContractorLongName, 
                      case when BeniCnt = 1 then
                      		dbo.HICMask(Beneficiaries_AllProvSBMBPrefixes.HIC)
                      	else
                      		'MULTIPLE'
                      	end AS HIC, 
                      Appeals_AllProvSBMBPrefixes.MultipleClaims, '' AS ClaimControlNumber, 
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
                      BeneficiaryCollections_AllProvSBMBPrefixes.InitialDenialDate, 
                      case when BeniCnt = 1 then
			      BeneficiaryCollections_AllProvSBMBPrefixes.InitialDenialSummaryOfFacts
			else
			      dbo.UnfavorableMultiBeneAggregation(Letters_AllProvSBMBPrefixes.AppealNumber, Contexts_AllProvSBMBPrefixes.ContextId)
			end AS Expr1,      
                      BeneficiaryCollections_AllProvSBMBPrefixes.RedeterminationLetterSentDate, 
                      BeneficiaryCollections_AllProvSBMBPrefixes.RedeterminationDismissalReason, 
                      BeneficiaryCollections_AllProvSBMBPrefixes.RedeterminationSummaryOfFacts,
                      case when BeniCnt = 1 then
                      		BeneficiaryCollections_AllProvSBMBPrefixes.DecisionAmountInControversy
                      	else
                      		dbo.GetSumAmountInControversy(BeneficiaryCollections_AllProvSBMBPrefixes.AppealNumber)
                      end AS AmountInControversy, 
                      BeneficiaryCollections_AllProvSBMBPrefixes.ReconsiderationSubmittedMaterial AS SubmittedDocumentation, 
                      BeneficiaryCollections_AllProvSBMBPrefixes.ReconsiderationUnsubmittedMaterial AS UnSubmittedDocumentation,
                      case when BeniCnt = 1 then
                      		dbo.GetBeneficiaryDetailSingle(BeneficiaryCollections_AllProvSBMBPrefixes.AppealNumber, BeneficiaryCollections_AllProvSBMBPrefixes.HIC) 
                      	else
                      		''
                      end AS ClaimsDetail, COALESCE (BeneficiaryCollections_AllProvSBMBPrefixes.DuplicateAppealNumber, N'') AS DuplicateAppealNumber, 
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
                      left join (SELECT     AppealNumber, Count(*) BeniCnt
                            FROM          dbo.BeneficiaryCollections AS BeneficiaryCollections_MB2
                            GROUP BY AppealNumber
                            HAVING      (COUNT(*) = 1))  BeniCntr on Letters_AllProvSBMBPrefixes.AppealNumber = BeniCntr.AppealNumber
WHERE     (Contexts_AllProvSBMBPrefixes.PrintFlag <> 0) AND (Letters_AllProvSBMBPrefixes.MailDate IS NULL) AND 
                      (Letters_AllProvSBMBPrefixes.AddresseeType = 'Provider') AND (LEFT(Letters_AllProvSBMBPrefixes.ContextId, 2) = 'MB')