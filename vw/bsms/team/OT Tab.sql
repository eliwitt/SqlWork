--
--  OT tab work
--

-- for some reason I could not get the OT tab to display date until I insert one row into the
-- NOvertimeHours table.
-- 
	SELECT * FROM wAppTeam.OverTimeOneView
	WHERE OTTeamMember = 325 AND OTPayPeriod = '2013-03-18'
	
	
	          --   Team.NOvertimeHours ON Team.TimeCodes.TCID = Team.NOvertimeHours.OTTCodeMon LEFT OUTER JOIN
          --Team.teammembers ON Team.NOvertimeHours.OTTeamMember = Team.teammembers.TMID LEFT OUTER JOIN
          --Team.TimeCodes AS TimeCodes_1 ON Team.NOvertimeHours.OTTCodeTue = TimeCodes_1.TCID LEFT OUTER JOIN
          --Team.TimeCodes AS TimeCodes_2 ON Team.NOvertimeHours.OTTCodeWed = TimeCodes_2.TCID LEFT OUTER JOIN
          --Team.TimeCodes AS TimeCodes_5 ON Team.NOvertimeHours.OTTCodeFri = TimeCodes_5.TCID LEFT OUTER JOIN
          --Team.TimeCodes AS TimeCodes_3 ON Team.NOvertimeHours.OTTCodeThur = TimeCodes_3.TCID LEFT OUTER JOIN
          --Team.TimeCodes AS TimeCodes_6 ON Team.NOvertimeHours.OTTCodeSat = TimeCodes_6.TCID LEFT OUTER JOIN
          --Team.TimeCodes AS TimeCodes_4 ON Team.NOvertimeHours.OTTCodeSun = TimeCodes_4.TCID
	
	select * from Team.NOvertimeHours where OTTeamMember = 325
	
--insert into Team.NOvertimeHours (OTTeamMember, OTPayPeriod, OTLastChange, OTLastEdit) values(325,'03-18-2013','03-18-2013',22)