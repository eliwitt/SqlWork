--
-- this script will retrieve the last time the SAP2Champs successfully 
-- ran.
--
SELECT top 1 [JobName]   = JOB.name,
            [Step]      = HIST.step_id,
            [StepName]  = HIST.step_name,
            [Message]   = HIST.message,
            [Status]    = CASE WHEN HIST.run_status = 0 THEN 'Failed'
            WHEN HIST.run_status = 1 THEN 'Succeeded'
            WHEN HIST.run_status = 2 THEN 'Retry'
            WHEN HIST.run_status = 3 THEN 'Canceled'
            END,
            [RunDate]   = HIST.run_date, 
            CONVERT(DateTime, convert(varchar(8),HIST.run_date), 112) PartsUpDt,
            [RunTime]   = HIST.run_time,
            [Duration]  = HIST.run_duration
FROM        msdb..sysjobs JOB
INNER JOIN  msdb..sysjobhistory HIST ON HIST.job_id = JOB.job_id
WHERE    JOB.name = 'SAP2Champs' and HIST.run_status = 1 and HIST.step_id = 0
ORDER BY    HIST.run_date desc, HIST.run_time desc