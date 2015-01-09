exec [wAppDT].[StatsReportThree] 1, 0, 31, '01/03/2013'
exec [wAppTPM].[TPMCompReport] 1,0,31,'01/03/2013', 0
plantpass = userID.DBPlantID;
--
-- warning the reports rely on the granschedule dates and week number
-- when running reports the routines try to use the schedule to determine 
-- what week we are in and retrieve the data.
--
--  An example 1/3/2013 is really in week 53 12/31/2012 but the routine uses the 
-- the year in which you are running from GETDATE so if you run it does not found 
-- week 53 with a year of 2013.
--
DECLARE @CW1 as Int
DECLARE @CW1Mon as Date;
SET @CW1 = wACom.GetCWFromDate(DateAdd(day,0,GetDate()));
print @CW1
SET @CW1Mon = wACom.GetCWMonDate(@CW1,DatePart(year,DateAdd(day,0,GetDate())));
print @CW1Mon
SELECT * FROM TPM.GrandSchedule
SELECT GSCWMonDate FROM TPM.GrandSchedule WHERE GSCW = 53 AND DATEPART(Year,GSCWMonDate) = '2013'
	SELECT TOP 52 GSCW, GSCWMonDate
	FROM TPM.GrandSchedule
	WHERE GSCWMonDate < @CW1Mon
	ORDER BY GSCWMonDate DESC
