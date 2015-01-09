USE [CHAMPS]
GO
/****** Object:  Trigger [WO].[ChampsSchUpt]    Script Date: 06/27/2013 12:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		J. Steve Witt
-- Create date: 06/27/2013
-- Description:	When the closed date is updated then update the lastcompleted
-- date for the schedule this WO is for.
-- =============================================
ALTER TRIGGER [WO].[ChampsSchUpt] 
   ON  [WO].[WorkOrderMain] 
   AFTER UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
--
-- was the close date updated if so then set the schedules lastcompleted date
--
declare @newCloseDT datetime,
	@newCloseBy int,
	@newWOID int,
	@schDate datetime,
	@wasteoftime nvarchar(max)
IF UPDATE(DISCloseDate)
	BEGIN
		select @newWOID = inserted.DISID, @newCloseBy = inserted.DisClosedBy, @newCloseDT = inserted.DisCloseDate from inserted
		select @schDate = schLastCompleteDT from Scheduler.ChampsSchedules
			WHERE schKey in  (SELECT Inserted.DISSchID
			   FROM Inserted LEFT JOIN Deleted ON Inserted.DISID = Deleted.DISID
			   WHERE COALESCE(Inserted.DisCloseDate, '') <> COALESCE(Deleted.DisCloseDate, ''))
		-- is this newer if so then update
		--
		if (@newCloseDT > @schDate)
			begin
				set @wasteoftime = 'WO  ' + cast(@newWOID as nvarchar(10)) + ' closed date was changed to ' + cast(Convert(Date,@newCloseDT) as nvarchar(20)) + ' by ' + CAST(@newCloseBy as nvarchar(10))
				exec wACom.LogIt 99888, 'Scheduler Trigger', 'LastCompleted', @wasteoftime
				UPDATE Scheduler.ChampsSchedules
					SET schLastCompleteDT = @newCloseDT, schUptDT = GETDATE(), schUptId = @newCloseBy
				WHERE schKey in  (SELECT Inserted.DISSchID
				   FROM Inserted LEFT JOIN Deleted ON Inserted.DISID = Deleted.DISID
				   WHERE COALESCE(Inserted.DisCloseDate, '') <> COALESCE(Deleted.DisCloseDate, ''))
           end
	END
END
