-- IDEMPIERE-6563 Attach stacktrace and Unresolved to the 2pack as error_yyyymmddhhmmss.log (FHCA)
SELECT register_migration_script('202505292158_IDEMPIERE-6563.sql') FROM dual;

-- May 29, 2025, 9:58:12 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200274,0,0,TO_TIMESTAMP('2025-05-29 21:58:11','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2025-05-29 21:58:11','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ATTACH_NOTIFY_2PACK','N','Attach result of the Pack In process','D','C','93fc36ae-5df0-4cd1-aff0-1f299d856d88')
;

