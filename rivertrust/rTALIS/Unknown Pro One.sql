SELECT     Pro.ProviderId, Pro.Name, Pro.Address1, Pro.Address2, Pro.City, Pro.State, Pro.ZIP, Pro.Country, 'Appeal' AS Appeal, app.AppealNumber, 
                      app.PriorAppealNumber, app.ContractNumber, app.OpenedDate, app.ClosedDate
FROM         dbo.Providers AS Pro INNER JOIN
                      dbo.Appeals AS app ON Pro.ProviderId = app.ProviderId
WHERE     (Pro.Name LIKE 'Unk%') OR
                      (Pro.Address1 LIKE 'Unk%')
order by Pro.ProviderId