-- Nov 5, 2023, 2:37:19 PM WIB
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,IsReport,Value,IsDirectPrint,Classname,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,ShowHelp,CopyFromProcess,AD_Process_UU,AllowMultipleExecution) VALUES (200156,0,0,'Y',TO_TIMESTAMP('2023-11-05 14:37:18','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-11-05 14:37:18','YYYY-MM-DD HH24:MI:SS'),10,'Delete Trace Logs','delete log files with last modified older than n days of current time','N','DeleteTraceLogs','N','org.idempiere.process.DeleteTraceLogs','4','D',0,0,'N','Y','N','5a390947-e117-4616-a4da-64ada7c19211','P')
;

-- Nov 5, 2023, 2:37:45 PM WIB
INSERT INTO AD_Scheduler (AD_Client_ID,Supervisor_ID,IsActive,Processing,AD_Scheduler_ID,AD_Process_ID,CreatedBy,Updated,DateNextRun,AD_Org_ID,UpdatedBy,Created,Name,KeepLogDays,AD_Scheduler_UU,AD_Schedule_ID) VALUES (0,10,'N','N',200002,toRecordId('AD_Process','877068e7-ee18-4efb-b3ef-f6b341ce2189'),10,TO_TIMESTAMP('2023-11-05 14:37:45','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2023-11-06 14:37:45','YYYY-MM-DD HH24:MI:SS'),0,10,TO_TIMESTAMP('2023-11-05 14:37:45','YYYY-MM-DD HH24:MI:SS'),'Delete Trace Logs',7,'36f8954a-20b9-40f5-994b-62270c273117',200000)
;

-- IDEMPIERE-5913
SELECT register_migration_script('202311051436_IDEMPIERE-5913.sql') FROM dual;