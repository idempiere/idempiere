-- IDEMPIERE-6123 Query in search window causing slowness and load spikes in the database (FHCA-5356)
SELECT register_migration_script('202404302320_IDEMPIERE-6123.sql') FROM dual;

-- Apr 30, 2024, 11:20:08 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200244,0,0,TO_TIMESTAMP('2024-04-30 23:20:08','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2024-04-30 23:20:08','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','GRIDTABLE_INITIAL_COUNT_TIMEOUT_IN_SECONDS','1','Timeout for the initial count on windows','D','C','5fae1af7-74ca-41d8-bbd3-d506c6c23b6a')
;

-- Apr 30, 2024, 11:22:16 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200245,0,0,TO_TIMESTAMP('2024-04-30 23:22:16','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2024-04-30 23:22:16','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','GLOBAL_MAX_QUERY_RECORDS','100000','Maximum number of records allowed to search in a window, can be overriden per Role or  Tab','D','C','840fb67c-4609-41f2-9e20-e0ea9d839065')
;

-- Apr 30, 2024, 11:23:28 PM CEST
UPDATE AD_Message SET MsgText='The query returned more records than allowed, consider adding more filters.',Updated=TO_TIMESTAMP('2024-04-30 23:23:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=852
;

-- Apr 30, 2024, 11:24:06 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','The initial count query timed out, loading records ...',0,0,'Y',TO_TIMESTAMP('2024-04-30 23:24:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-04-30 23:24:06','YYYY-MM-DD HH24:MI:SS'),100,200887,'CountQueryTimeoutLoadBackground','D','988292d7-175f-41c2-b560-43d62b8326a9')
;

