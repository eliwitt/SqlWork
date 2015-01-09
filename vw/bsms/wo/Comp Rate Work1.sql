--
-- with this script we will determine for a given week the
-- Open work orders and the work orders that where closed.
--
--exec [wAppTPM].[TPMStatsReport2] 1, 0, 0, '10/01/2012'
--exec wAppTPM.TPMCompReport 1, 0, 0, '10/08/2012'
exec wAppTPM.TPMCompReport 1, 0, 0, '12/04/2012'
--===================================== TWO =================================
-- version TWO
--
--  Completed PMs in Wk# / PMs due >= Wk# = Ontime Completion Rate
--
-- Completed PMs in Wk# / Total Open PMs in Wk# = Total Completion
--
-- Completed late PMs Wk# / Total Open late PMs, due < wk#
--
Declare @closedontime as Integer,
 @DueInWkwo as Integer,
 @closedoverdue as Integer,
 @openoverdue as integer,
 @closed as integer,
 @dueCompWkHold as integer,
 @CW1Mon as Date,
 @CW1 as int,
 @CW as int,
 @Mon as date,
 @debug int,
 @dueWkHold as integer,
 @Plant as Integer = 1 ,
 @Line as Integer = 0,
 @Group as Integer = 0,
 @StartDate as Date = '3/1/2012',
 @Days as Integer = 30,
 @ShowAll as Int

set @closedontime = 0
set @DueInWkwo = 0
set @closedoverdue = 0
set @openoverdue = 0
set @closed = 0
set @dueCompWkHold = 0
set @dueWkHold = 0
set @debug = 1
-- sp parms
set @Plant = 1
set @Line = 0
set @Group = 0
set @StartDate = '2012-11-05'
set @Days = 0
--
set @ShowAll = @Plant
SET @CW1 = wACom.GetCWFromDate(DateAdd(day,0,@StartDate));
SET @CW1Mon = wACom.GetCWMonDate(@CW1,DatePart(year,DateAdd(day,0,@StartDate)));
-- get the date and grand schedule week nu
--
	SELECT @CW = GSCW, @Mon = GSCWMonDate
	FROM TPM.GrandSchedule
	WHERE GSCWMonDate = @CW1Mon
	ORDER BY GSCWMonDate DESC

select @CW CW, @Mon WkOf, DateAdd(day,-1,@Mon) SunB4, DateAdd(day,7,@Mon) WkAfter

--
-- collect all of the shops WOs
DECLARE @ShopTable TABLE
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
	DISInComplete  Date,
	DISDueDate  Date,
	DISType  Int,
	DISTPMNumber  Int,
	DISID  int
	
);
if (@Plant > 0 and @Line = 0 and @Group = 0)
begin
INSERT INTO @ShopTable 	
	SELECT wACom.Lines.LIPlant, wACom.Lines.LIID, wACom.MachineList.MLCELLNAME, wACom.MachineList.MLID, 
		wACom.MachineList.MLPlantID, wACom.Lines.LILineName, wACom.Areas.AAareaname, wACom.Areas.AAID, 
        WO.WorkOrderMain.DISOpenDate, WO.WorkOrderMain.DISCloseDate, wo.WorkOrderMain.DISClosedIncomplete, WO.WorkOrderMain.DISDueDate, 
		WO.WorkOrderMain.DISType, WO.WorkOrderMain.DISTPMNumber,WO.WorkOrderMain.DISID
	FROM  WO.WorkOrderMain 
		lefT OUTER JOIN wACom.MachineList ON WO.WorkOrderMain.DISLineNumber = wACom.MachineList.MLID				
		LEFT OUTER JOIN wACom.Lines on wACom.MachineList.MLLINEID = wACom.Lines.LIID
		LEFT OUTER JOIN wACom.Areas ON wACom.Lines.LISatellite = wACom.Areas.AAID 
	WHERE WO.WorkOrderMain.DISType = 3 and 
		LIPlant = @showAll
end
if (@Plant > 0 and @Line > 0 and @Group = 0)
begin
INSERT INTO @ShopTable 	
	SELECT wACom.Lines.LIPlant, wACom.Lines.LIID, wACom.MachineList.MLCELLNAME, wACom.MachineList.MLID, 
		wACom.MachineList.MLPlantID, wACom.Lines.LILineName, wACom.Areas.AAareaname, wACom.Areas.AAID, 
        WO.WorkOrderMain.DISOpenDate, WO.WorkOrderMain.DISCloseDate, wo.WorkOrderMain.DISClosedIncomplete, WO.WorkOrderMain.DISDueDate, 
		WO.WorkOrderMain.DISType, WO.WorkOrderMain.DISTPMNumber,WO.WorkOrderMain.DISID
	FROM  WO.WorkOrderMain 
		lefT OUTER JOIN wACom.MachineList ON WO.WorkOrderMain.DISLineNumber = wACom.MachineList.MLID				
		LEFT OUTER JOIN wACom.Lines on wACom.MachineList.MLLINEID = wACom.Lines.LIID
		LEFT OUTER JOIN wACom.Areas ON wACom.Lines.LISatellite = wACom.Areas.AAID 
	WHERE WO.WorkOrderMain.DISType = 3 and 
		LIPlant = @showAll and LIID = @Line 
end
if (@Plant > 0 and @Line = 0 and @Group >0)
begin
INSERT INTO @ShopTable 	
	SELECT wACom.Lines.LIPlant, wACom.Lines.LIID, wACom.MachineList.MLCELLNAME, wACom.MachineList.MLID, 
		wACom.MachineList.MLPlantID, wACom.Lines.LILineName, wACom.Areas.AAareaname, wACom.Areas.AAID, 
        WO.WorkOrderMain.DISOpenDate, WO.WorkOrderMain.DISCloseDate, wo.WorkOrderMain.DISClosedIncomplete, WO.WorkOrderMain.DISDueDate, 
		WO.WorkOrderMain.DISType, WO.WorkOrderMain.DISTPMNumber,WO.WorkOrderMain.DISID
	FROM  WO.WorkOrderMain 
		lefT OUTER JOIN wACom.MachineList ON WO.WorkOrderMain.DISLineNumber = wACom.MachineList.MLID				
		LEFT OUTER JOIN wACom.Lines on wACom.MachineList.MLLINEID = wACom.Lines.LIID
		LEFT OUTER JOIN wACom.Areas ON wACom.Lines.LISatellite = wACom.Areas.AAID 
	WHERE WO.WorkOrderMain.DISType = 3 and 
		LIPlant = @showAll and AAID = @Group
end		
--
-- begin the counts
--
if @debug = 0 or @debug = 1
begin
	--
	-- Count the number of WO's due during that calander week 
	SET @DueInWkwo = (SELECT Count(DISID) 
							FROM  @ShopTable
				WHERE DISInComplete is null and 
				DISDueDate BETWEEN @Mon AND DateAdd(day,6,@Mon))
	if @debug = 1
	begin
	select 'Due this week'
	SELECT * 
		FROM  @ShopTable
				WHERE DISInComplete is null and 
				DISDueDate BETWEEN @Mon AND DateAdd(day,6,@Mon)
	end									
end
if @debug = 0 or @debug = 2
begin
	--
	-- Count the total number of closed for the calander week.
	SET @closed = (SELECT Count(DISID) FROM @ShopTable st
						WHERE DISInComplete is null and 
						DISCloseDate BETWEEN @Mon AND DateAdd(day,6,@Mon))
	if @debug = 2
	begin
	select 'Closed'
	SELECT *
		FROM @ShopTable
			WHERE DISInComplete is null and 
			DISCloseDate BETWEEN @Mon AND DateAdd(day,6,@Mon)
	end

end

if @debug = 0 or @debug = 3 
begin
	--
	-- Closed on time work orders that were closed but closed past thier due date.
	SET @closedontime = (SELECT Count(DISID) FROM @ShopTable
						WHERE DISInComplete is null and 
						DISCloseDate BETWEEN @Mon AND DateAdd(day,6,@Mon) and
						(DISCloseDate <= DISDueDate))
	if @debug = 3
	begin
	select 'Closed on time'
	SELECT * 
		FROM @ShopTable
			WHERE DISInComplete is null and 
			DISCloseDate BETWEEN @Mon AND DateAdd(day,6,@Mon) and
			(DISCloseDate <= DISDueDate)
	end
end
if @debug = 0 or @debug = 4
begin
	--
-- Closed Overdue: work orders that were closed but closed past their due date.
	SET @closedoverdue =  (SELECT Count(DISID) FROM @ShopTable
							WHERE DISInComplete is null and 
							DISCloseDate BETWEEN @Mon AND DateAdd(day,6,@Mon) and
							(DISCloseDate > DISDueDate))
	if @debug = 4
	begin
	select 'Closed Late'
	SELECT * 
		FROM @ShopTable
			WHERE DISInComplete is null and 
			DISCloseDate BETWEEN @Mon AND DateAdd(day,6,@Mon) and
			(DISCloseDate > DISDueDate)
	end						
end
--
-- show the counts
--
select @CW CW, @DueInWkwo 'Due this WK', @closed 'Closed', @closedontime ClosedOnTime,  @closedoverdue ClosedOverDue
--
-- view the detail rows for each of the counts
--



--================================ TWO ======================================
--================================ ONE =========================================
--  version ONE
-- retrieve the work orders
-- Open only
--SELECT * FROM wAppWorkOrder.TPMReportingViewOne 
--WHERE ((DISOpenDate < DateAdd(day,7,@Mon)) AND (DISOpenDate > DateAdd(day,-1,@Mon)))
--		AND (LIPlant = 1);
--					AND (MLID = @ARG OR LIID = @Line OR AAID = @Group OR LIPlant = @showAll);
-- retrieve the work orders
-- Close only
--SELECT * FROM wAppWorkOrder.TPMReportingViewOne 
--WHERE ((Disclosedate < DateAdd(day,7,@Mon)) AND (DISCloseDate > DateAdd(day, -1, @Mon)))
--		AND (LIPlant = 1);
-- retrieve the work orders
--
--  current version of ONE below
-- Total
--SELECT * FROM wAppWorkOrder.TPMReportingViewOne 
--		WHERE ((DISOpenDate < DateAdd(day,7,@Mon)) AND (DISOpenDate > DateAdd(day,-1,@Mon)))
--		and DISCloseDate <> '02/07/1977'
--		AND (LIPlant = 1)
--union
--	(SELECT * FROM wAppWorkOrder.TPMReportingViewOne 
--		WHERE ((Disclosedate < DateAdd(day,7,@Mon)) AND (DISCloseDate > DateAdd(day, -1, @Mon)))
--		AND (LIPlant = 1))
--order by DISID
--====================================  ONE  =================================
--
--  there are WOs with a close date of DISCloseDate <> '02/07/1977' how many do we have? 8619
--select COUNT(*) from wAppWorkOrder.TPMReportingViewOne where DISCloseDate = '02/07/1977' --order by DISOpenDate
--select * from wo.WorkOrderMain where DISCloseDate = '02/07/1977' order by DISClosedIncomplete
--
--
--==========================================  StatReport ====================================
--SELECT Count(DISID) FROM WO.WorkOrderMain WHERE DISOpenDate BETWEEN @Mon AND DateAdd(day,6,@Mon) AND DISType = 3
--		-- Closed not overdue
--SELECT Count(DISID) FROM WO.WorkOrderMain WHERE
--			DISOpenDate BETWEEN @Mon AND DateAdd(day,6,@Mon)
--			AND 
--			(DISCloseDate <= DISDueDate) AND (DISCloseDate >= DISOpenDate) AND (DISType = 3)
--		-- Closed Overdue
--SELECT Count(DISID) FROM WO.WorkOrderMain WHERE
--			DISCloseDate BETWEEN @Mon AND DateAdd(day,6,@Mon)
--			AND 
--			(DISCloseDate > DISDueDate) AND (DISCloseDate >= DISOpenDate) AND (DISType = 3)
--		--Open but Overdue
--SELECT Count(DISID) FROM WO.WorkOrderMain WHERE
--		DISOpenDate BETWEEN @Mon AND DateAdd(day,6,@Mon)
--		AND
--		DISCloseDate IS NULL
--		AND
--		GetDate() > DISDueDate AND DISType = 3
--		-- Incomplete
--SELECT Count(DISID) FROM WO.WorkOrderMain WHERE
--		DISOpenDate BETWEEN @Mon AND DateAdd(day,6,@Mon)
--		AND
--		DISCloseDate < DISOpenDate AND DISType = 3
--===================================================================================