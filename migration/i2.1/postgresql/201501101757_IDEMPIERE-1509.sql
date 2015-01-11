-- Oct 21, 2010 12:48:27 PM COT
-- Default Housekeeping for T_ tables
INSERT INTO AD_HouseKeeping (AD_Client_ID,AD_HouseKeeping_ID,AD_Org_ID,AD_Table_ID,Created,CreatedBy,IsActive,IsExportXMLBackup,IsSaveInHistoric,LastDeleted,Name,Processing,Updated,UpdatedBy,Value,WhereClause) VALUES (0,50000,0,631,TO_TIMESTAMP('2010-10-21 12:48:25','YYYY-MM-DD HH24:MI:SS'),100,'Y','N','N',0,'Delete T_Aging records preserving last week','N',TO_TIMESTAMP('2010-10-21 12:48:25','YYYY-MM-DD HH24:MI:SS'),100,'T_Aging','AD_PInstance_ID IN (SELECT AD_PInstance_ID FROM AD_PInstance WHERE Created <= SYSDATE - 7)')
;

-- Oct 21, 2010 12:49:46 PM COT
INSERT INTO AD_HouseKeeping (AD_Client_ID,AD_HouseKeeping_ID,AD_Org_ID,AD_Table_ID,Created,CreatedBy,IsActive,IsExportXMLBackup,IsSaveInHistoric,LastDeleted,Name,Processing,Updated,UpdatedBy,Value,WhereClause) VALUES (0,50002,0,478,TO_TIMESTAMP('2010-10-21 12:49:45','YYYY-MM-DD HH24:MI:SS'),100,'Y','N','N',0,'Delete T_InventoryValue records preserving last week','N',TO_TIMESTAMP('2010-10-21 12:49:45','YYYY-MM-DD HH24:MI:SS'),100,'T_InventoryValue','AD_PInstance_ID IN (SELECT AD_PInstance_ID FROM AD_PInstance WHERE Created <= SYSDATE - 7)')
;

-- Oct 21, 2010 12:50:13 PM COT
INSERT INTO AD_HouseKeeping (AD_Client_ID,AD_HouseKeeping_ID,AD_Org_ID,AD_Table_ID,Created,CreatedBy,IsActive,IsExportXMLBackup,IsSaveInHistoric,LastDeleted,Name,Processing,Updated,UpdatedBy,Value,WhereClause) VALUES (0,50003,0,803,TO_TIMESTAMP('2010-10-21 12:50:12','YYYY-MM-DD HH24:MI:SS'),100,'Y','N','N',0,'Delete T_InvoiceGL records preserving last week','N',TO_TIMESTAMP('2010-10-21 12:50:12','YYYY-MM-DD HH24:MI:SS'),100,'T_InvoiceGL','AD_PInstance_ID IN (SELECT AD_PInstance_ID FROM AD_PInstance WHERE Created <= SYSDATE - 7)')
;

-- Oct 21, 2010 12:50:40 PM COT
INSERT INTO AD_HouseKeeping (AD_Client_ID,AD_HouseKeeping_ID,AD_Org_ID,AD_Table_ID,Created,CreatedBy,IsActive,IsExportXMLBackup,IsSaveInHistoric,LastDeleted,Name,Processing,Updated,UpdatedBy,Value,WhereClause) VALUES (0,50004,0,364,TO_TIMESTAMP('2010-10-21 12:50:40','YYYY-MM-DD HH24:MI:SS'),100,'Y','N','N',0,'Delete T_Replenish records preserving last week','N',TO_TIMESTAMP('2010-10-21 12:50:40','YYYY-MM-DD HH24:MI:SS'),100,'T_Replenish','AD_PInstance_ID IN (SELECT AD_PInstance_ID FROM AD_PInstance WHERE Created <= SYSDATE - 7)')
;

-- Oct 21, 2010 12:50:53 PM COT
INSERT INTO AD_HouseKeeping (AD_Client_ID,AD_HouseKeeping_ID,AD_Org_ID,AD_Table_ID,Created,CreatedBy,IsActive,IsExportXMLBackup,IsSaveInHistoric,LastDeleted,Name,Processing,Updated,UpdatedBy,Value,WhereClause) VALUES (0,50005,0,545,TO_TIMESTAMP('2010-10-21 12:50:52','YYYY-MM-DD HH24:MI:SS'),100,'Y','N','N',0,'Delete T_ReportStatement records preserving last week','N',TO_TIMESTAMP('2010-10-21 12:50:52','YYYY-MM-DD HH24:MI:SS'),100,'T_ReportStatement','AD_PInstance_ID IN (SELECT AD_PInstance_ID FROM AD_PInstance WHERE Created <= SYSDATE - 7)')
;

-- Oct 21, 2010 12:51:06 PM COT
INSERT INTO AD_HouseKeeping (AD_Client_ID,AD_HouseKeeping_ID,AD_Org_ID,AD_Table_ID,Created,CreatedBy,IsActive,IsExportXMLBackup,IsSaveInHistoric,LastDeleted,Name,Processing,Updated,UpdatedBy,Value,WhereClause) VALUES (0,50006,0,544,TO_TIMESTAMP('2010-10-21 12:51:05','YYYY-MM-DD HH24:MI:SS'),100,'Y','N','N',0,'Delete T_Report records preserving last week','N',TO_TIMESTAMP('2010-10-21 12:51:05','YYYY-MM-DD HH24:MI:SS'),100,'T_Report','AD_PInstance_ID IN (SELECT AD_PInstance_ID FROM AD_PInstance WHERE Created <= SYSDATE - 7)')
;

-- Oct 21, 2010 12:51:29 PM COT
INSERT INTO AD_HouseKeeping (AD_Client_ID,AD_HouseKeeping_ID,AD_Org_ID,AD_Table_ID,Created,CreatedBy,IsActive,IsExportXMLBackup,IsSaveInHistoric,LastDeleted,Name,Processing,Updated,UpdatedBy,Value,WhereClause) VALUES (0,50007,0,365,TO_TIMESTAMP('2010-10-21 12:51:25','YYYY-MM-DD HH24:MI:SS'),100,'Y','N','N',0,'Delete T_Spool records preserving last 2 days','N',TO_TIMESTAMP('2010-10-21 12:51:25','YYYY-MM-DD HH24:MI:SS'),100,'T_Spool','AD_PInstance_ID IN (SELECT AD_PInstance_ID FROM AD_PInstance WHERE Created <= SYSDATE - 2)')
;

-- Oct 21, 2010 12:51:56 PM COT
INSERT INTO AD_HouseKeeping (AD_Client_ID,AD_HouseKeeping_ID,AD_Org_ID,AD_Table_ID,Created,CreatedBy,IsActive,IsExportXMLBackup,IsSaveInHistoric,LastDeleted,Name,Processing,Updated,UpdatedBy,Value,WhereClause) VALUES (0,50008,0,758,TO_TIMESTAMP('2010-10-21 12:51:55','YYYY-MM-DD HH24:MI:SS'),100,'Y','N','N',0,'Delete T_Transaction records preserving last week','N',TO_TIMESTAMP('2010-10-21 12:51:55','YYYY-MM-DD HH24:MI:SS'),100,'T_Transaction','AD_PInstance_ID IN (SELECT AD_PInstance_ID FROM AD_PInstance WHERE Created <= SYSDATE - 7)')
;

-- Oct 21, 2010 12:52:13 PM COT
INSERT INTO AD_HouseKeeping (AD_Client_ID,AD_HouseKeeping_ID,AD_Org_ID,AD_Table_ID,Created,CreatedBy,IsActive,IsExportXMLBackup,IsSaveInHistoric,LastDeleted,Name,Processing,Updated,UpdatedBy,Value,WhereClause) VALUES (0,50009,0,753,TO_TIMESTAMP('2010-10-21 12:52:09','YYYY-MM-DD HH24:MI:SS'),100,'Y','N','N',0,'Delete T_TrialBalance records preserving last week','N',TO_TIMESTAMP('2010-10-21 12:52:09','YYYY-MM-DD HH24:MI:SS'),100,'T_TrialBalance','AD_PInstance_ID IN (SELECT AD_PInstance_ID FROM AD_PInstance WHERE Created <= SYSDATE - 7)')
;

-- Oct 21, 2010 12:54:40 PM COT
INSERT INTO AD_Scheduler (AD_Schedule_ID, AD_Client_ID,AD_Org_ID,AD_Process_ID,AD_Scheduler_ID,Created,CreatedBy,Frequency,FrequencyType,IsActive,IsIgnoreProcessingTime,KeepLogDays,Name,Processing,ScheduleType,Supervisor_ID,Updated,UpdatedBy) VALUES (200001, 0,0,53154,50000,TO_TIMESTAMP('2010-10-21 12:54:36','YYYY-MM-DD HH24:MI:SS'),100,1,'D','Y','N',7,'Housekeeping T_Aging','N','F',0,TO_TIMESTAMP('2010-10-21 12:54:36','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 21, 2010 12:55:02 PM COT
INSERT INTO AD_Scheduler (AD_Schedule_ID, AD_Client_ID,AD_Org_ID,AD_Process_ID,AD_Scheduler_ID,Created,CreatedBy,Frequency,FrequencyType,IsActive,IsIgnoreProcessingTime,KeepLogDays,Name,Processing,ScheduleType,Supervisor_ID,Updated,UpdatedBy) VALUES (200001, 0,0,53154,50002,TO_TIMESTAMP('2010-10-21 12:54:58','YYYY-MM-DD HH24:MI:SS'),100,1,'D','Y','N',7,'Housekeeping T_InventoryValue','N','F',0,TO_TIMESTAMP('2010-10-21 12:54:58','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 21, 2010 12:55:10 PM COT
INSERT INTO AD_Scheduler (AD_Schedule_ID, AD_Client_ID,AD_Org_ID,AD_Process_ID,AD_Scheduler_ID,Created,CreatedBy,Frequency,FrequencyType,IsActive,IsIgnoreProcessingTime,KeepLogDays,Name,Processing,ScheduleType,Supervisor_ID,Updated,UpdatedBy) VALUES (200001, 0,0,53154,50003,TO_TIMESTAMP('2010-10-21 12:55:09','YYYY-MM-DD HH24:MI:SS'),100,1,'D','Y','N',7,'Housekeeping T_InvoiceGL','N','F',0,TO_TIMESTAMP('2010-10-21 12:55:09','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 21, 2010 12:55:21 PM COT
INSERT INTO AD_Scheduler (AD_Schedule_ID, AD_Client_ID,AD_Org_ID,AD_Process_ID,AD_Scheduler_ID,Created,CreatedBy,Frequency,FrequencyType,IsActive,IsIgnoreProcessingTime,KeepLogDays,Name,Processing,ScheduleType,Supervisor_ID,Updated,UpdatedBy) VALUES (200001, 0,0,53154,50004,TO_TIMESTAMP('2010-10-21 12:55:16','YYYY-MM-DD HH24:MI:SS'),100,1,'D','Y','N',7,'Housekeeping T_Replenish','N','F',0,TO_TIMESTAMP('2010-10-21 12:55:16','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 21, 2010 12:55:31 PM COT
INSERT INTO AD_Scheduler (AD_Schedule_ID, AD_Client_ID,AD_Org_ID,AD_Process_ID,AD_Scheduler_ID,Created,CreatedBy,Frequency,FrequencyType,IsActive,IsIgnoreProcessingTime,KeepLogDays,Name,Processing,ScheduleType,Supervisor_ID,Updated,UpdatedBy) VALUES (200001, 0,0,53154,50005,TO_TIMESTAMP('2010-10-21 12:55:30','YYYY-MM-DD HH24:MI:SS'),100,1,'D','Y','N',7,'Housekeeping T_ReportStatement','N','F',0,TO_TIMESTAMP('2010-10-21 12:55:30','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 21, 2010 12:55:41 PM COT
INSERT INTO AD_Scheduler (AD_Schedule_ID, AD_Client_ID,AD_Org_ID,AD_Process_ID,AD_Scheduler_ID,Created,CreatedBy,Frequency,FrequencyType,IsActive,IsIgnoreProcessingTime,KeepLogDays,Name,Processing,ScheduleType,Supervisor_ID,Updated,UpdatedBy) VALUES (200001, 0,0,53154,50006,TO_TIMESTAMP('2010-10-21 12:55:40','YYYY-MM-DD HH24:MI:SS'),100,1,'D','Y','N',7,'Housekeeping T_Report','N','F',0,TO_TIMESTAMP('2010-10-21 12:55:40','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 21, 2010 12:55:48 PM COT
INSERT INTO AD_Scheduler (AD_Schedule_ID, AD_Client_ID,AD_Org_ID,AD_Process_ID,AD_Scheduler_ID,Created,CreatedBy,Frequency,FrequencyType,IsActive,IsIgnoreProcessingTime,KeepLogDays,Name,Processing,ScheduleType,Supervisor_ID,Updated,UpdatedBy) VALUES (200001, 0,0,53154,50007,TO_TIMESTAMP('2010-10-21 12:55:48','YYYY-MM-DD HH24:MI:SS'),100,1,'D','Y','N',7,'Housekeeping T_Spool','N','F',0,TO_TIMESTAMP('2010-10-21 12:55:48','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 21, 2010 12:55:55 PM COT
INSERT INTO AD_Scheduler (AD_Schedule_ID, AD_Client_ID,AD_Org_ID,AD_Process_ID,AD_Scheduler_ID,Created,CreatedBy,Frequency,FrequencyType,IsActive,IsIgnoreProcessingTime,KeepLogDays,Name,Processing,ScheduleType,Supervisor_ID,Updated,UpdatedBy) VALUES (200001, 0,0,53154,50008,TO_TIMESTAMP('2010-10-21 12:55:54','YYYY-MM-DD HH24:MI:SS'),100,1,'D','Y','N',7,'Housekeeping T_Transaction','N','F',0,TO_TIMESTAMP('2010-10-21 12:55:54','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 21, 2010 12:56:05 PM COT
INSERT INTO AD_Scheduler (AD_Schedule_ID, AD_Client_ID,AD_Org_ID,AD_Process_ID,AD_Scheduler_ID,Created,CreatedBy,Frequency,FrequencyType,IsActive,IsIgnoreProcessingTime,KeepLogDays,Name,Processing,ScheduleType,Supervisor_ID,Updated,UpdatedBy) VALUES (200001, 0,0,53154,50009,TO_TIMESTAMP('2010-10-21 12:56:01','YYYY-MM-DD HH24:MI:SS'),100,1,'D','Y','N',7,'Housekeeping T_TrialBalance','N','F',0,TO_TIMESTAMP('2010-10-21 12:56:01','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 21, 2010 12:56:42 PM COT
INSERT INTO AD_Scheduler_Para (AD_Client_ID,AD_Org_ID,AD_Process_Para_ID,AD_Scheduler_ID,Created,CreatedBy,Description,IsActive,ParameterDefault,Updated,UpdatedBy) VALUES (0,0,53257,50000,TO_TIMESTAMP('2010-10-21 12:56:42','YYYY-MM-DD HH24:MI:SS'),100,'AD_HouseKeeping_ID=T_Aging','Y','50000',TO_TIMESTAMP('2010-10-21 12:56:42','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 21, 2010 12:57:40 PM COT
INSERT INTO AD_Scheduler_Para (AD_Client_ID,AD_Org_ID,AD_Process_Para_ID,AD_Scheduler_ID,Created,CreatedBy,Description,IsActive,ParameterDefault,Updated,UpdatedBy) VALUES (0,0,53257,50002,TO_TIMESTAMP('2010-10-21 12:57:40','YYYY-MM-DD HH24:MI:SS'),100,'AD_HouseKeeping_ID=T_InventoryValue','Y','50002',TO_TIMESTAMP('2010-10-21 12:57:40','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 21, 2010 12:57:58 PM COT
INSERT INTO AD_Scheduler_Para (AD_Client_ID,AD_Org_ID,AD_Process_Para_ID,AD_Scheduler_ID,Created,CreatedBy,Description,IsActive,ParameterDefault,Updated,UpdatedBy) VALUES (0,0,53257,50003,TO_TIMESTAMP('2010-10-21 12:57:58','YYYY-MM-DD HH24:MI:SS'),100,'AD_HouseKeeping_ID=T_InvoiceGL','Y','50003',TO_TIMESTAMP('2010-10-21 12:57:58','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 21, 2010 12:58:37 PM COT
INSERT INTO AD_Scheduler_Para (AD_Client_ID,AD_Org_ID,AD_Process_Para_ID,AD_Scheduler_ID,Created,CreatedBy,Description,IsActive,ParameterDefault,Updated,UpdatedBy) VALUES (0,0,53257,50004,TO_TIMESTAMP('2010-10-21 12:58:37','YYYY-MM-DD HH24:MI:SS'),100,'AD_HouseKeeping_ID=T_Replenish','Y','50004',TO_TIMESTAMP('2010-10-21 12:58:37','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 21, 2010 12:58:58 PM COT
INSERT INTO AD_Scheduler_Para (AD_Client_ID,AD_Org_ID,AD_Process_Para_ID,AD_Scheduler_ID,Created,CreatedBy,Description,IsActive,ParameterDefault,Updated,UpdatedBy) VALUES (0,0,53257,50006,TO_TIMESTAMP('2010-10-21 12:58:58','YYYY-MM-DD HH24:MI:SS'),100,'AD_HouseKeeping_ID=T_Report','Y','50006',TO_TIMESTAMP('2010-10-21 12:58:58','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 21, 2010 12:59:17 PM COT
INSERT INTO AD_Scheduler_Para (AD_Client_ID,AD_Org_ID,AD_Process_Para_ID,AD_Scheduler_ID,Created,CreatedBy,Description,IsActive,ParameterDefault,Updated,UpdatedBy) VALUES (0,0,53257,50005,TO_TIMESTAMP('2010-10-21 12:59:17','YYYY-MM-DD HH24:MI:SS'),100,'AD_HouseKeeping_ID=T_ReportStatement','Y','50005',TO_TIMESTAMP('2010-10-21 12:59:17','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 21, 2010 12:59:34 PM COT
INSERT INTO AD_Scheduler_Para (AD_Client_ID,AD_Org_ID,AD_Process_Para_ID,AD_Scheduler_ID,Created,CreatedBy,Description,IsActive,ParameterDefault,Updated,UpdatedBy) VALUES (0,0,53257,50007,TO_TIMESTAMP('2010-10-21 12:59:34','YYYY-MM-DD HH24:MI:SS'),100,'AD_HouseKeeping_ID=T_Spool','Y','50007',TO_TIMESTAMP('2010-10-21 12:59:34','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 21, 2010 12:59:54 PM COT
INSERT INTO AD_Scheduler_Para (AD_Client_ID,AD_Org_ID,AD_Process_Para_ID,AD_Scheduler_ID,Created,CreatedBy,Description,IsActive,ParameterDefault,Updated,UpdatedBy) VALUES (0,0,53257,50008,TO_TIMESTAMP('2010-10-21 12:59:54','YYYY-MM-DD HH24:MI:SS'),100,'AD_HouseKeeping_ID=T_Transaction','Y','50008',TO_TIMESTAMP('2010-10-21 12:59:54','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 21, 2010 1:00:11 PM COT
INSERT INTO AD_Scheduler_Para (AD_Client_ID,AD_Org_ID,AD_Process_Para_ID,AD_Scheduler_ID,Created,CreatedBy,Description,IsActive,ParameterDefault,Updated,UpdatedBy) VALUES (0,0,53257,50009,TO_TIMESTAMP('2010-10-21 13:00:11','YYYY-MM-DD HH24:MI:SS'),100,'AD_HouseKeeping_ID=T_TrialBalance','Y','50009',TO_TIMESTAMP('2010-10-21 13:00:11','YYYY-MM-DD HH24:MI:SS'),100)
;

SELECT register_migration_script('201501101757_IDEMPIERE-1509.sql') FROM dual
;

