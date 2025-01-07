-- IDEMPIERE-5913 Delete Trace Logs Periodically
SELECT register_migration_script('202311051436_IDEMPIERE-5913.sql') FROM dual;

-- Nov 5, 2023, 2:37:19 PM WIB
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,IsReport,Value,IsDirectPrint,Classname,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,ShowHelp,CopyFromProcess,AD_Process_UU,AllowMultipleExecution) VALUES (200156,0,0,'Y',TO_TIMESTAMP('2023-11-05 14:37:18','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-11-05 14:37:18','YYYY-MM-DD HH24:MI:SS'),10,'Delete Trace Logs','delete log files with last modified older than n days of current time','N','DeleteTraceLogs','N','org.idempiere.process.DeleteTraceLogs','4','D',0,0,'N','Y','N','5a390947-e117-4616-a4da-64ada7c19211','P')
;

-- Nov 5, 2023, 2:37:45 PM WIB
INSERT INTO AD_Scheduler (AD_Client_ID,Supervisor_ID,IsActive,Processing,AD_Scheduler_ID,AD_Process_ID,CreatedBy,Updated,DateNextRun,AD_Org_ID,UpdatedBy,Created,Name,KeepLogDays,AD_Scheduler_UU,AD_Schedule_ID) VALUES (0,10,'N','N',200002,200156,10,TO_TIMESTAMP('2023-11-05 14:37:45','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2023-11-06 14:37:45','YYYY-MM-DD HH24:MI:SS'),0,10,TO_TIMESTAMP('2023-11-05 14:37:45','YYYY-MM-DD HH24:MI:SS'),'Delete Trace Logs',7,'36f8954a-20b9-40f5-994b-62270c273117',200000)
;

-- Nov 7, 2023, 11:30:09 AM WIB
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ValueMin,ColumnName,IsCentrallyMaintained,EntityType,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200447,0,0,'Y',TO_TIMESTAMP('2023-11-07 11:30:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-11-07 11:30:08','YYYY-MM-DD HH24:MI:SS'),100,'Keep Log Days',200156,10,11,'N',0,'Y','7','0','KeepLogDays','N','D','05b81f27-19df-4758-9a49-ffaeab4d6287','N','N','D','N')
;

-- Nov 7, 2023, 11:39:19 AM WIB
INSERT INTO AD_Scheduler_Para (AD_Process_Para_ID,IsActive,AD_Org_ID,CreatedBy,UpdatedBy,Created,Updated,ParameterDefault,AD_Client_ID,AD_Scheduler_ID,AD_Scheduler_Para_UU) VALUES (200447,'Y',0,100,100,TO_TIMESTAMP('2023-11-07 11:39:19','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2023-11-07 11:39:19','YYYY-MM-DD HH24:MI:SS'),'7',0,200002,'8b2ddb62-f7c0-4205-b827-d4ddbe9bd12c')
;

-- Nov 10, 2023, 3:25:04 PM CET
INSERT INTO AD_Menu (AD_Menu_ID,Name,"action",AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,AD_Process_ID,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200229,'Delete Trace Logs','P',0,0,'Y',TO_TIMESTAMP('2023-11-10 15:25:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-11-10 15:25:03','YYYY-MM-DD HH24:MI:SS'),100,'N',200156,'Y','N','D','Y','69b22485-6a5f-4566-98f5-1f0bb54be222')
;

-- Nov 10, 2023, 3:25:04 PM CET
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', statement_timestamp(), 100, statement_timestamp(), 100,t.AD_Tree_ID, 200229, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200229)
;

-- Nov 10, 2023, 3:25:43 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=456, SeqNo=12,Updated=TO_TIMESTAMP('2023-11-10 15:25:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200229
;
