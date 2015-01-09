USE [BSMS_test]
GO

/****** Object:  StoredProcedure [wAppDT].[topSomethingReport]    Script Date: 05/16/2013 13:01:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [wAppDT].[topSomethingReport]
	
	(
		@toplevel int = 5,
		@DateStart date = '5/10/2012',
		@DateEnd date = '5/10/2012',
		@Line integer = 0,
		@Cell Integer = 0,
		@Plant Integer = 0,
		@nameFilter nVarChar(max) = '%',
		@genFilter nVarChar(max) = '%',
		@TimeStart nVarChar(50) = '06:00:00',
		@TimeEnd nVarChar(50) = '18:00:00'
	)
	
AS
	DECLARE @combStart DateTime;
	DECLARE @combEnd DateTime;
	SET @combStart = (CONVERT(datetime,CONVERT(date,@DateStart,(0)),(0)) +	CONVERT(time,@TimeStart,(0)))
    SET @combEnd =   (CONVERT(datetime, CONVERT(date,@DateEnd ,(0)),(0)) +  CONVERT(time,@TimeEnd,(0)))

	IF (@Line > 0) AND (@Cell > 0 or @Plant > 0)  RETURN;
	IF (@Cell > 0) AND (@Line > 0 or @Plant > 0) RETURN;
	IF (@Plant > 0) AND (@Cell > 0 or @Line > 0) RETURN;
	--
	-- merge the Down time orders with the work orders and report
	--
	SELECT TOP (@toplevel) AAareaname, MLCELLNAME, DTID, 'D' rptType, TotalTime, MyName, DTMalfunction, DTSolution, PROCNUMBER, 
				DTLongTerm, DTNCDown, DTNCUp, RPName
		FROM wAppDT.Downtime_MainFormView
		WHERE (
				(Convert(DATETIME,Convert(date,DTNDateDown,(0)),(0)) + Convert(time,DTNTimeDown,(0))) BETWEEN @combStart and @combEnd
				and 
				((@Line = 0) or (LIID = @Line))
				and 
				((@Cell = 0) or (DTLine = @Cell))
				and 
				((@Plant = 0) or (MLPlantID = @Plant))
				AND MyName Like @nameFilter 
				AND (DTMalfunction Like @genFilter OR DTSolution Like @genFilter or DTlongTerm Like @GenFilter)
			   )
	union
	select TOP (@toplevel) AAareaname, MLCELLNAME, DISID, 'W' rptType,
			DATEDIFF(minute, (Convert(DATETIME,Convert(date,DISDownWentDate,(0)),(0)) + Convert(time,DISDownWentTime,(0))),
			(Convert(DATETIME,Convert(date,DISDownBackDate,(0)),(0)) + Convert(time,DISDownBackTime,(0))))
				AS TotalTime,
			 AllOne.MyName, 
			 case
				when DISDownCause IS null then DISWorkRequired
				when DISDownCause IS not null then DISDownCause 
				end as downreason,
			case 
				when DISDownSolution is null then DISWorkAccomp
				when DISDownSolution IS not null then DISDownSolution
				end as downfix, PROCNUMBER, DISDownFollowUp, DISDownWentTime, DISDownBackTime,
				 COM.ResponsibleParty.RPName
	from wo.WorkOrderMain WOMain
		left outer join wACom.MachineList ML on DISLineNumber = ml.MLID
		left outer join wACom.Lines Lines on ML.MLLINEID = Lines.LIID
		left outer join wACom.Areas Areas on Lines.LISatellite = Areas.AAID
		left outer join EQP.ProcNumbers ProcNu on DISEquip = ProcNu.PROCID
		left outer join  Team.BSMaintHourlyAllOne AllOne on WOMain.DISOriginator = TMID
		LEFT OUTER JOIN  COM.ResponsibleParty ON WOMain.DISResponsible = COM.ResponsibleParty.RPID
		where DISType = 27 and
		(
			(Convert(DATETIME,Convert(date,DISDownWentDate,(0)),(0)) + Convert(time,DISDownWentTime,(0))) BETWEEN @combStart and @combEnd
			and 
			((@Line = 0) or (Lines.LIID = @Line))
			and 
			((@Cell = 0) or (ml.MLID = @Cell))
			and 
			((@Plant = 0) or (MLPlantID = @Plant))
			AND MyName Like @nameFilter 
			AND (DISDownCause Like @genFilter OR DISDownSolution Like @genFilter or 
				DISDownFollowUp Like @GenFilter or DISWorkRequired like @genFilter or DISWorkAccomp like @genFilter)
		   )
	Order By TotalTime Desc

	RETURN
GO

