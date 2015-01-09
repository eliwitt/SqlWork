SELECT  
	case 
		when App.Rep_FristName is null then
			Rep.FirstName
		else
			App.Rep_FristName
	end [FirstName], 
	case 
		when App.Rep_LastName is null then
			Rep.LastName
		else
			App.Rep_LastName
	end [LastName], 
	CASE  
		when App.Rep_Address1 is null then
			Rep.Address1
		else
			App.Rep_Address1
	end [Address1], 
	CASE  
		when App.Rep_Address2 is null then
			Rep.Address2
		else
			App.Rep_Address2
	end [Address2], 
	CASE  
		when App.Rep_City is null then
			Rep.City
		else
			App.Rep_City
	end [City], 
    CASE  
		when App.Rep_State is null then
			Rep.State
		else
			App.Rep_State
	end [State], 
    CASE  
		when App.Rep_ZIP is null then
			Rep.ZIP
		else
			App.Rep_ZIP
	end [ZIP]
FROM         dbo.Appeals App
left join representatives Rep on App.RepresentativeId = Rep.RepresentativeId
where App.AppealNumber = '1-413981587'