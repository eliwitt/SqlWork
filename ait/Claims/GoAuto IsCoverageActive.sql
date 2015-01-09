declare   @PolicyNumber varchar(32),
   @PointInTime datetime,
   @OurVehicleIndex int,
   @OurDriverIndex int,
   @debug			int,
   @CovID int

	declare @RetResult tinyint
	declare @FinanceStatusID tinyint
	declare @NextPaymentDate datetime
	declare @CancelDate datetime
	declare @ExpirationDate datetime
    declare @EffectiveDate datetime
    declare @GapCount int
    -- start of the script
	set @debug = 1
	set @RetResult = 1
	set @PolicyNumber = '45517'
	set @PointInTime = '2011-03-16 10:00:00.000'
	set @OurVehicleIndex = 1
	set @OurDriverIndex = 1
	set @CovID = 5

	set @ExpirationDate = (select ExpirationDate FROM Policy WHERE ID = (select max(id) FROM Policy WHERE PolicyNumber = @PolicyNumber) )
	set @EffectiveDate = (select EffectiveDate FROM Policy WHERE ID = (select max(id) FROM Policy WHERE PolicyNumber = @PolicyNumber) )

    if @ExpirationDate < @PointInTime
    begin
		set @RetResult = 0
	end
    else
    if @EffectiveDate > @PointInTime
    begin
		set @RetResult = 0
	end
    else
    begin

		select @FinanceStatusID = FinanceStatusID, @NextPaymentDate = NextPaymentDate, @CancelDate = CancelDate
			FROM FinanceMaster WHERE PolicyNumber = @PolicyNumber
		if @debug = 1 
		begin
			print 'Finance Status ' + cast(@FinanceStatusID as varchar(3))
			print 'Payment Date ' + cast(@NextPaymentDate as varchar(23))
			print 'Cancel Date ' + cast(@CancelDate as varchar(23))
		end
		if @FinanceStatusID is not null and @NextPaymentDate is not null
		begin
			if (@FinanceStatusID = 5) and @CancelDate < @PointInTime
			begin
				set @RetResult = 0
			end
		    else if (@FinanceStatusID = 10)
            begin
               set @RetResult = 0
            end
		end
        set @GapCount = (select count(*) from PolicyCoverageGaps where PolicyNumber = @PolicyNumber and GapStartDate <= @PointInTime and GapEndDate >= @PointInTime)
		if @GapCount > 0 
		begin
			set @RetResult = 0
		end
 
    end
if @debug = 1 print 'the results ' + cast(@RetResult as varchar(3))
declare @PolicyID int
declare @VehicleID int
declare @CovCT int
declare @GoAutoCovID int

if @CovID <= 4
   set @GoAutoCovID = @CovID
else if @CovID = 5
   set @GoAutoCovID = 8
else if @CovID = 6
   set @GoAutoCovID = 9
else if @CovID = 7
   set @GoAutoCovID = 7
else if @CovID = 8
   set @GoAutoCovID = 5
else if @CovID = 9
   set @GoAutoCovID = 6
if @debug = 1 print 'Claim ' + cast(@CovID as varchar(3)) + ' GoAuto ' + cast(@GoAutoCovID as varchar(3))
    if @RetResult = 1
    begin
       if @CovID > 2
       begin
	      set @PolicyID = (select top 1 ID from policy where PolicyNumber = @PolicyNumber and ModificationDate <= @PointInTime order by id desc) 
	      set @VehicleID = (select ID from Vehicle where PolicyPTR = @PolicyID and [Index] = @OurVehicleIndex ) 
          set @CovCT = (select count(*) from PolicyCoverages where VehiclePTR = @VehicleID and CovIndex = @GoAutoCovID and CovOptIndex > 0)
          print 'CovCT ' + cast(@CovCT as varchar(3))
		  if @CovCT = 0
		  begin
		     set @RetResult = 0
		  end
       end
    end

if @RetResult = 1
begin
declare @DriverEx tinyint
select @DriverEx = dbo.F_Claims_IsDriverExcluded(
   @PolicyNumber,
   @PointInTime,
   @OurVehicleIndex,
   @OurDriverIndex
)
if @debug = 1 print 'Driver Ex ' + cast(@DriverEx as varchar(3))
if @DriverEx = 1 set @RetResult = 0 
end

print 'the results ' + cast(@RetResult as varchar(3))