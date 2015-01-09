Declare
@Plant as Integer = 1 ,
@Line as Integer = 0,
@Group as Integer = 0,
@StartDate as Date = '09/24/2012',
@Days as Integer = 30,
@ARG as Integer = 0


declare @debug as int = 1;
DECLARE @ShowAll as Int = @Plant;
DECLARE @CW1 as Int
DECLARE @CW1Mon as Date;
DECLARE @totalwo as int;
DECLARE @closedontime as int;
DECLARE @closedoverdue as int;
DECLARE @openoverdue as int;
DECLARE @incomplete as int;
DECLARE @opengood as int;
declare @PerWO decimal(4,2);


DECLARE @CW as int
DECLARE @Mon as date;

SET @CW1 = wACom.GetCWFromDate(DateAdd(day,0,@StartDate));
SET @CW1Mon = wACom.GetCWMonDate(@CW1,DatePart(year,DateAdd(day,0,@StartDate)));
if @debug = 1
begin
		print 'CW1 = ' + cast(@CW1 as varchar(5))
		print 'CW1Mon = ' + cast(@CW1Mon as varchar(20))
end

DECLARE @faultTable TABLE
(
	faultCode INT

)

DECLARE @holdTable TABLE
(

	LIPlant  Int,
	PNID Int,
	PNName  nVarChar(100),
	LIID  Int,
	MLCellName  nVarChar(100),
	MLID  Int,
	MLPlantID  Int,
	LILineName  nVarChar(100),
	AAAreaname  nVarChar(100),
	AAID  Int,
	TPMProcID  Int,
	TPMProcTitle  nVarChar(100),
	TPMProcModelLink  Int,
	TPMFreqFrequency  nVarChar(100),
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
	PercentageWO decimal(4,2),
	CW INT,
	CWD Date

);

DECLARE @CWTable TABLE
(
	GSCW INTEGER,
	GSCWMonDate DATE
);

if @debug = 1
begin
		print 'Reset tables '
end

BEGIN TRY
    -- Reset the tables just in case.
    DELETE FROM @CWTable;
    delete from @faultTable;
    delete from @resultTable;
    if @debug = 1
	begin
		select COUNT(*) from @CWTable
		select COUNT(*) from @faultTable
		select COUNT(*) from @resultTable
	end
END TRY
BEGIN CATCH
	if @debug = 1
	begin
		print 'Should not make it here'
	end
END CATCH;


	SELECT @Mon = GSCWMonDate
	FROM TPM.GrandSchedule
	WHERE GSCWMonDate = @CW1Mon
	ORDER BY GSCWMonDate DESC
	

	if @debug = 1
	begin
			print 'CW = (' + cast(@CW as varchar(5)) + ')'
			print 'Mon = (' + cast(@Mon as varchar(20)) + ')'
	end
	--(Disclosedate is null) or 
	-- original version from Paul 08/21/2012
	--INSERT INTO @holdTable SELECT * FROM wAppWorkOrder.TPMReportingViewOne WHERE (DISOpenDate < DateAdd(day,7,@Mon)) AND (DISCloseDate > DateAdd(day, -1, @Mon))
	--					AND (MLID = @ARG OR LIID = @Line OR AAID = @Group OR LIPlant = @showAll);

	INSERT INTO @holdTable 
SELECT * FROM wAppWorkOrder.TPMReportingViewOne 
		WHERE ((DISOpenDate < DateAdd(day,7,@Mon)) AND (DISOpenDate > DateAdd(day,-1,@Mon)))
		and DISCloseDate <> '02/07/1977' -- remove those tpms that where closed because they went past the cycle
		AND (LIPlant = 1)
union
	(SELECT * FROM wAppWorkOrder.TPMReportingViewOne 
		WHERE ((Disclosedate < DateAdd(day,7,@Mon)) AND (DISCloseDate > DateAdd(day, -1, @Mon)))
		AND (LIPlant = 1))
order by Disclosedate


	-- Count the total number of records for the calander week. Gives the percentage.
	SET @totalwo = (SELECT Count(DISID) FROM @holdtable);

	-- Count the number of WO's closed during that calander week that were at or under thier due date
	SET @closedontime = (SELECT Count(DISID) FROM @holdtable WHERE DISCloseDate BETWEEN @Mon AND DateAdd(day,6,@Mon))
	if @debug = 1
	begin
			print 'totalwo = ' + cast(@totalwo as varchar(5))
			print 'closedontime = ' + cast(@closedontime as varchar(5))
			set @PerWO = ((@closedontime*1.0/@totalwo)*100)
			print 'percentage = ' + cast(@PerWO as varchar(10))
	end
	
	INSERT INTO @resultTable
		(
			TotalWorkOrders,
			Closed,
			PercentageWO,
			CW,
			CWD
		)
		VALUES
		(
			@totalwo, 
			@closedontime,
			(@closedontime*1.0/@totalwo)*100,
			@CW,
			@Mon
		)
SELECT * FROM @resultTable
