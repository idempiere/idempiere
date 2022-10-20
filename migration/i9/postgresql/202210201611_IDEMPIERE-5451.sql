-- IDEMPIERE-5451 Create a form SQL Query - similar to SQL process to execute queries (FHCA-3849)
SELECT register_migration_script('202210201611_IDEMPIERE-5451.sql') FROM dual;

-- Oct 20, 2022, 4:11:00 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200210,0,0,TO_TIMESTAMP('2022-10-20 16:10:59','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2022-10-20 16:10:59','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','FORM_SQL_QUERY_ALLOWED_KEYWORDS','SELECT,WITH,SHOW','Comma separated list of commands allowed in the SQL Query form','D','S','acf9acf7-5cf5-4820-b4ec-57c7c6f205db')
;

-- Oct 20, 2022, 4:12:29 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200211,0,0,TO_TIMESTAMP('2022-10-20 16:12:28','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2022-10-20 16:12:28','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','FORM_SQL_QUERY_LOG_ISSUE','Y','Defines if the queries executed in SQL Query form are logged in System Issue','D','S','22f9e2e0-c70b-4412-b7d0-57ba0eac3dcc')
;

-- Oct 20, 2022, 4:13:00 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200212,0,0,TO_TIMESTAMP('2022-10-20 16:13:00','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2022-10-20 16:13:00','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','FORM_SQL_QUERY_MAX_RECORDS','500','Maximum number of records to be queried in the SQL Query form','D','S','24ec1a60-1032-4d35-afcb-693835d6405b')
;

-- Oct 20, 2022, 4:13:31 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200213,0,0,TO_TIMESTAMP('2022-10-20 16:13:31','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2022-10-20 16:13:31','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','FORM_SQL_QUERY_TIMEOUT_IN_SECONDS','120','Timeout in seconds to execute queries in the SQL Query form','D','S','d6dad71b-f369-47f4-8fbb-c66a87131073')
;

