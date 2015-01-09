declare @myPolicy nvarchar(16), @theVeh	int, @ClaimPtr	int, @drvidx int, @mydate	datetime
set @ClaimPtr = 257
--set @mydate = '04/15/2010 12:00'
select @drvidx =OurDriverIndex from clm_claimvehicle where ClaimMasterPTR = @ClaimPtr  and VehicleNumber = 1
--set @drvidx = 0
select @myPolicy=PolicyNumber, @theVeh=cv.OurVehicleIndex, @mydate = dateofloss from clm_claimmaster cm
		join clm_ClaimVehicle cv on cm.id = cv.claimmasterptr and cv.vehiclenumber = 1
	where cm.id = @ClaimPtr 
select @myPolicy Policy, @mydate dol, @theVeh Vehicle, @drvidx OurDrv
select effectivedate, expirationdate from GoAutoProd.dbo.Policy where policynumber = @myPolicy
select GoAutoProd.dbo.F_Claims_IsPolicyActive(@myPolicy, @mydate) PolicyInForce,
GoAutoProd.dbo.F_Claims_IsCoverageActive(@myPolicy, @mydate, @theVeh, @drvidx, 1) LIPD, 
GoAutoProd.dbo.F_Claims_IsCoverageActive(@myPolicy, @mydate, @theVeh, @drvidx, 2) LIBI, 
GoAutoProd.dbo.F_Claims_IsCoverageActive(@myPolicy, @mydate, @theVeh, @drvidx, 4) COLL, 
GoAutoProd.dbo.F_Claims_IsCoverageActive(@myPolicy, @mydate, @theVeh, @drvidx, 5) TOWG, 
GoAutoProd.dbo.F_Claims_IsCoverageActive(@myPolicy, @mydate, @theVeh, @drvidx, 6) RENT, 
GoAutoProd.dbo.F_Claims_IsCoverageActive(@myPolicy, @mydate, @theVeh, @drvidx, 7) MED,
GoAutoProd.dbo.F_Claims_IsCoverageActive(@myPolicy, @mydate, @theVeh, @drvidx, 8) UMBI,
GoAutoProd.dbo.F_Claims_IsCoverageActive(@myPolicy, @mydate, @theVeh, @drvidx, 9) UMPD