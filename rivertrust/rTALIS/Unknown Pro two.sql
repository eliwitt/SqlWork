SELECT     ProviderId, AppealNumber, 
                      PriorAppealNumber, ContractNumber, OpenedDate, ClosedDate
FROM        dbo.Appeals
WHERE     ProviderId in (select ProviderID
							from providers where (Name LIKE 'Unk%') OR (Address1 LIKE 'Unk%'))