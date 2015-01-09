--
-- TPM 52 Week Statistic(a.k.a. Completion) Report for the shop.
--

DECLARE @ShowAll as Int,
 @CW1 as Int,
 @CW1Mon as Date,
 @totalwo as int,
 @closedontime as int,
 @closedoverdue as int,
 @openoverdue as int,
 @incomplete as int,
 @opengood as int,
 @dueCompWkHold as integer,
 @dueWkHold as integer,
 @CW as int,
 @Mon as date,
 @Plant as Integer, -- parsm passed in 
 @Line as Integer,
 @Group as Integer,
 @StartDate as Date,
 @Days as Integer,
 @debug as integer = 0
-- set the parms pasted in 
set @Plant = 1 
set @Line = 0
set @Group = 0
set @StartDate = '3/1/2012'
set @Days = 30 
set @ShowAll = @Plant
-- regular settings
set @totalwo = 0
set @closedontime = 0
set @closedoverdue = 0
set @openoverdue = 0
set @Incomplete = 0
set @opengood = 0
set @dueCompWkHold = 0
set @dueWkHold = 0
-- may want to set this to the original setting
SET @CW1 = wACom.GetCWFromDate(DateAdd(day,0,GetDate()));
SET @CW1Mon = wACom.GetCWMonDate(@CW1,DatePart(year,DateAdd(day,0,GetDate())));
--SET @CW1 = wACom.GetCWFromDate(DateAdd(day,0,@StartDate));
--SET @CW1Mon = wACom.GetCWMonDate(@CW1,DatePart(year,DateAdd(day,0,@StartDate)));
if @debug =1
begin
	select @CW1, @CW1Mon
end

DECLARE @faultTable TABLE
(
	faultCode INT
)

DECLARE @holdTable TABLE
(
	LIPlant  Int,
	LIID  Int,
	MLCellName  nVarChar(100),
	MLID  Int,
	MLPlantID  Int,
	LILineName  nVarChar(100),
	AAAreaname  nVarChar(100),
	AAID  Int,
	DISOpenDate  Date,
	DISCloseDate  Date,
	DISDueDate  Date,
	DISType  Int,
	DISTPMNumber  Int,
	DISID  int
	
);

DECLARE @resultTable TABLE
(
	TotalWorkOrders int,
	Closed Int,
	ClosedLate Int,
	OverDue Int,
	Incomplete Int,
	CurrentlyOpen Int,
	CompWklyPMs Int,
	PMDueTotal Int,	
	CW INT,
	CWD Date
);

DECLARE @CWTable TABLE
(
	GSCW INTEGER,
	GSCWMonDate DATE
);
-- GSCWMonDate between dateadd(day, -28, @CW1Mon) and @CW1Mon
INSERT INTO @CWTable 
	SELECT TOP 52 GSCW, GSCWMonDate
	FROM TPM.GrandSchedule
	WHERE GSCWMonDate < @CW1Mon
	ORDER BY GSCWMonDate DESC
if @debug = 1
begin
	select * from @CWTable
end

DECLARE cwTable CURSOR FAST_FORWARD FOR
	SELECT * FROM @CWTable

OPEN cwTable
FETCH NEXT FROM cwTable INTO @CW, @Mon
WHILE @@FETCH_STATUS = 0
BEGIN
	if @debug = 1 
	begin
		select @Mon
	end
-- Gather all of the WOs that are open for the wk
	INSERT INTO @holdTable 
			SELECT wACom.Lines.LIPlant, wACom.Lines.LIID, wACom.MachineList.MLCELLNAME, wACom.MachineList.MLID, 
                      wACom.MachineList.MLPlantID, wACom.Lines.LILineName, wACom.Areas.AAareaname, wACom.Areas.AAID, 
                      WO.WorkOrderMain.DISOpenDate, WO.WorkOrderMain.DISCloseDate, WO.WorkOrderMain.DISDueDate, 
                      WO.WorkOrderMain.DISType, WO.WorkOrderMain.DISTPMNumber,WO.WorkOrderMain.DISID
			FROM  WO.WorkOrderMain 
				LEFT OUTER JOIN wACom.Lines 
				LEFT OUTER JOIN wACom.Areas ON wACom.Lines.LISatellite = wACom.Areas.AAID 
				RIGHT OUTER JOIN wACom.MachineList ON wACom.Lines.LIID = wACom.MachineList.MLLINEID 
					ON WO.WorkOrderMain.DISLineNumber = wACom.MachineList.MLID
			WHERE DISOpenDate BETWEEN @Mon AND DateAdd(day,6,@Mon)
						AND (LIID = @Line OR AAID = @Group OR LIPlant = @showAll);
--
-- Count the total number of records for the calander week. Gives the percentage.
	SET @totalwo = (SELECT Count(DISID) FROM @holdtable);
--
-- Count the number of WO's closed during that calander week that were at or under thier due date
	SET @closedontime = (SELECT Count(DISID) FROM @holdtable WHERE
						(DISCloseDate <= DISDueDate) AND (DISCloseDate >= DISOpenDate))
--
-- Closed Overdue: work orders that were closed but closed past thier due date.
	SET @closedoverdue =  (SELECT Count(DISID) FROM @holdtable WHERE
					(DISCloseDate > DISDueDate))
--
-- Work orders from that calander week that are still open and overdue
	SET @openoverdue = 	(SELECT Count(DISID) FROM @holdtable WHERE
					DISCloseDate IS NULL
					AND	GetDate() > DISDueDate)
--
-- Incomplete: Work orders that were closed by the system.
	SET @incomplete = (SELECT Count(DISID) FROM @holdtable WHERE
					DISCloseDate < DISOpenDate)
--
--Currently Open but not overdue.
	SET @opengood = 	(SELECT Count(DISID) FROM @holdtable WHERE
					DISCLoseDate IS NULL AND GetDate() < DISDueDate)
--
-- The Weekly Work orders completed in the week that where due within the week
	SET @dueCompWkHold = (SELECT Count(DISID) 
				FROM  WO.WorkOrderMain 
				LEFT OUTER JOIN wACom.Lines 
				LEFT OUTER JOIN wACom.Areas ON wACom.Lines.LISatellite = wACom.Areas.AAID 
				RIGHT OUTER JOIN wACom.MachineList ON wACom.Lines.LIID = wACom.MachineList.MLLINEID 
					ON WO.WorkOrderMain.DISLineNumber = wACom.MachineList.MLID
				WHERE DISDueDate BETWEEN @Mon AND DateAdd(day,6,@Mon)
				AND (DISCloseDate <= DISDueDate) AND (DISCloseDate >= DISOpenDate)
				AND (LIID = @Line OR AAID = @Group OR LIPlant = @showAll))					
--
-- The total PM WOs that are still over due
	SET @dueWkHold = (SELECT Count(DISID) 
				FROM  WO.WorkOrderMain 
				LEFT OUTER JOIN wACom.Lines 
				LEFT OUTER JOIN wACom.Areas ON wACom.Lines.LISatellite = wACom.Areas.AAID 
				RIGHT OUTER JOIN wACom.MachineList ON wACom.Lines.LIID = wACom.MachineList.MLLINEID 
					ON WO.WorkOrderMain.DISLineNumber = wACom.MachineList.MLID
				WHERE DISDueDate > @Mon and DISCloseDate is null
				AND (LIID = @Line OR AAID = @Group OR LIPlant = @showAll))					
--
-- check the divisors for zeros
--
if (@dueWkHold = 0) set @dueWkHold = 100
if (@totalwo = 0) set @totalwo = 100
if (@openoverdue = 0) set @openoverdue = 100
if (@closedontime = 0) set @closedontime = 1
if (@closedoverdue = 0) set @closedoverdue = 1
if (@dueCompWkHold = 0) set @dueCompWkHold = 1
--
-- insert this data into a table
	INSERT INTO @resultTable
		(
			TotalWorkOrders,
			Closed,
			ClosedLate,
			Overdue,
			Incomplete,
			CurrentlyOpen,
			CompWklyPMs,
			PMDueTotal,	
			CW,
			CWD
		)
		VALUES
		(
			@totalwo, 
			@closedontime,
			@closedoverdue,
			@openoverdue,
			@incomplete,
			@opengood,
			@dueCompWkHold,
			@dueWkHold,
			@CW,
			@Mon
		)

	DELETE FROM @holdtable;
	FETCH NEXT FROM cwTable INTO @CW, @Mon
END
CLOSE cwTable
DEALLOCATE cwTable
SELECT * FROM @resultTable ORDER BY CWD ASC