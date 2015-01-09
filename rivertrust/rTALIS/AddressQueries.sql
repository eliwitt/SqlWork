-- ================================================================
-- Beni address
-- ================================================================
SELECT     Benc.appealnumber, Benc.HIC,
	CASE  
		WHEN Benc.HIC is NULL THEN 
				'No HIC'
		else
			case 
				when Benc.Address1 is null then
					'Use Beni ' + Beni.Address1
				else
					'Use Col ' + Benc.Address1
			end
	end TestAddress
FROM         dbo.BeneficiaryCollections Benc
left join Beneficiaries Beni on Benc.HIC = Beni.HIC
-- ================================================================
-- Appeal Address
-- ================================================================
SELECT     App.appealnumber, App.Providerid, App.RepresentativeId,
	CASE  
		WHEN App.Providerid is NULL THEN 
			CASE 
				When App.RepresentativeId is null then
					'No Rep or Prov'
				else
					case 
						when App.Rep_Address1 is null then
							'Use Rep ' + Rep.Address1
						else
							'Use App ' + App.Rep_Address1
					end
			end
		else
			case 
				when App.Prov_Address1 is null then
					'Use Prov ' + Prov.Address1
				else
					'Use App ' + App.Prov_Address1
			end
	end TestAddress
FROM         dbo.Appeals App
left join providers Prov on App.ProviderId = Prov.ProviderId
left join representatives Rep on App.RepresentativeId = Rep.RepresentativeId