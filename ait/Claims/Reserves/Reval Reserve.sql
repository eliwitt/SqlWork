declare @myPolicy nvarchar(16), @theVeh	int, @ClaimPtr	int, @drvidx int, @mydate	datetime
set @ClaimPtr = 713
--set @mydate = '04/15/2010 12:00'
select @drvidx =OurDriverIndex from clm_vehiclepassenger where ClaimMasterPTR = @ClaimPtr  and VehicleNumber = 1
--set @drvidx = 0
select @myPolicy=PolicyNumber, @theVeh=cv.OurVehicleIndex, @mydate = dateofloss from clm_claimmaster cm
		left join clm_ClaimVehicle cv on cm.id = cv.claimmasterptr and cv.vehiclenumber = 1
	where cm.id = @ClaimPtr 
select @myPolicy Policy, @mydate dol, @theVeh Vehicle, @drvidx OurDrv
select effectivedate, expirationdate from GoAutoProdJuly10.dbo.Policy where policynumber = @myPolicy
select GoAutoProdJuly10.dbo.F_Claims_IsPolicyActive(@myPolicy, @mydate) PolicyInForce,
GoAutoProdJuly10.dbo.F_Claims_IsCoverageActive(@myPolicy, @mydate, @theVeh, @drvidx, 1) LIPD, 
GoAutoProdJuly10.dbo.F_Claims_IsCoverageActive(@myPolicy, @mydate, @theVeh, @drvidx, 2) LIBI, 
GoAutoProdJuly10.dbo.F_Claims_IsCoverageActive(@myPolicy, @mydate, @theVeh, @drvidx, 4) COLL, 
GoAutoProdJuly10.dbo.F_Claims_IsCoverageActive(@myPolicy, @mydate, @theVeh, @drvidx, 5) TOWG, 
GoAutoProdJuly10.dbo.F_Claims_IsCoverageActive(@myPolicy, @mydate, @theVeh, @drvidx, 6) RENT, 
GoAutoProdJuly10.dbo.F_Claims_IsCoverageActive(@myPolicy, @mydate, @theVeh, @drvidx, 7) MED,
GoAutoProdJuly10.dbo.F_Claims_IsCoverageActive(@myPolicy, @mydate, @theVeh, @drvidx, 8) UMBI,
GoAutoProdJuly10.dbo.F_Claims_IsCoverageActive(@myPolicy, @mydate, @theVeh, @drvidx, 9) UMPD