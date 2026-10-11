-- 
SELECT register_migration_script('202511171122_IDEMPIERE-6724.sql') FROM dual;

-- Nov 26, 2025, 9:21:13 AM BRT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200287,0,0,TO_TIMESTAMP('2025-11-26 09:21:13','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2025-11-26 09:21:13','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','TRUNC_REPORT_DATE_FIELD','Y','Y/N - Defines if TRUNC will be used in the Date type field of the report','D','S','019ac01c-55cc-7b55-850c-05d5327c7276')
;

