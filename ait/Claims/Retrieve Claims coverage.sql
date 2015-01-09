declare @myPolicy nvarchar(16), @theVeh	int, @ClaimPtr	int, @drvidx int, @mydate	datetime
select top 1 @ClaimPtr = id from CLM_ClaimMaster where PolicyNumber = '10068'
if @ClaimPtr is null
begin
	print 'Pick a different policy'
	return
end
--select * from CLM_ClaimMaster where ID = @ClaimPtr
--set @ClaimPtr = 5657
--set @mydate = '04/15/2010 12:00'
--select * from clm_vehiclepassenger where ClaimMasterPTR = @ClaimPtr 
-- and VehicleNumber = 1 and (disabled = 0 or disabled is null)
select @drvidx =OurDriverIndex from clm_vehiclepassenger where ClaimMasterPTR = @ClaimPtr 
 and VehicleNumber = 1 and (disabled = 0 or disabled is null)
--set @drvidx = 2
select @myPolicy=PolicyNumber, @theVeh=cv.OurVehicleIndex, @mydate = dateofloss from clm_claimmaster cm
		left join clm_ClaimVehicle cv on cm.id = cv.claimmasterptr and cv.vehiclenumber = 1
	where cm.id = @ClaimPtr 
select @ClaimPtr id, @myPolicy Policy, @mydate dol, @theVeh Vehicle, @drvidx OurDrv
select effectivedate, expirationdate from GoAutoProd.dbo.Policy where policynumber = @myPolicy
declare @DriverEx tinyint
select GoAutoProd.dbo.F_Claims_IsDriverExcluded(@myPolicy, @mydate, @theVeh, @drvidx) DrvExcluded
select GoAutoProd.dbo.F_Claims_IsPolicyActive(@myPolicy, @mydate) PolicyInForce,
GoAutoProd.dbo.F_Claims_IsCoverageActive(@myPolicy, @mydate, @theVeh, @drvidx, 1) LIPD, 
GoAutoProd.dbo.F_Claims_IsCoverageActive(@myPolicy, @mydate, @theVeh, @drvidx, 2) LIBI, 
GoAutoProd.dbo.F_Claims_IsCoverageActive(@myPolicy, @mydate, @theVeh, @drvidx, 4) COLL, 
GoAutoProd.dbo.F_Claims_IsCoverageActive(@myPolicy, @mydate, @theVeh, @drvidx, 5) TOWG, 
GoAutoProd.dbo.F_Claims_IsCoverageActive(@myPolicy, @mydate, @theVeh, @drvidx, 6) RENT, 
GoAutoProd.dbo.F_Claims_IsCoverageActive(@myPolicy, @mydate, @theVeh, @drvidx, 7) MED,
GoAutoProd.dbo.F_Claims_IsCoverageActive(@myPolicy, @mydate, @theVeh, @drvidx, 8) UMBI,
GoAutoProd.dbo.F_Claims_IsCoverageActive(@myPolicy, @mydate, @theVeh, @drvidx, 9) UMPD