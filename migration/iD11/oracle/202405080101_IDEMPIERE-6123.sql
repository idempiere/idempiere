-- IDEMPIERE-6123 Query in search window causing slowness and load spikes in the database (FHCA-5356)
SELECT register_migration_script('202405080101_IDEMPIERE-6123.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- May 8, 2024, 1:01:16 AM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200247,0,0,TO_TIMESTAMP('2024-05-08 01:01:16','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2024-05-08 01:01:16','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','REPORT_LOAD_TIMEOUT_IN_SECONDS','120','Timeout in seconds when loading a report','D','C','14e838b1-c25c-400e-b39c-61da9bf92099')
;

-- May 8, 2024, 1:01:42 AM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200248,0,0,TO_TIMESTAMP('2024-05-08 01:01:41','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2024-05-08 01:01:41','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','GLOBAL_MAX_REPORT_RECORDS','100000','Max number of records allowed in a report','D','C','7030640a-1aa7-4ac7-a894-b4fe0dfde530')
;

-- May 8, 2024, 1:06:19 AM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','The data query for the report took too much time to execute (over {0} seconds) exceeding the allowed limit',0,0,'Y',TO_TIMESTAMP('2024-05-08 01:06:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-05-08 01:06:18','YYYY-MM-DD HH24:MI:SS'),100,200893,'ReportQueryTimeout','D','5f17f55f-adbe-4d97-bf83-9447983b4946')
;

-- May 8, 2024, 1:07:10 AM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','The report data exceeds the maximum limit of {0} rows',0,0,'Y',TO_TIMESTAMP('2024-05-08 01:07:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-05-08 01:07:09','YYYY-MM-DD HH24:MI:SS'),100,200894,'ReportMaxRowsReached','D','a4b55c31-0df0-4302-a62a-91cb7e79be0d')
;

