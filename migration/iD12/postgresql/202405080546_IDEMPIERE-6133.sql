-- May 8, 2024, 5:46:45 AM WIB
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200246,0,0,TO_TIMESTAMP('2024-05-08 05:46:45','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2024-05-08 05:46:45','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','EXPORT_BLOB_COLUMN_FOR_INSERT','Y','include blob column when export record using sql insert script option','D','C','c63dc8f1-c098-4f93-b84a-0897c0cf9c6a')
;

-- May 8, 2024, 12:16:14 PM CEST
UPDATE AD_Column SET FieldLength=0, AD_Reference_ID=23,Updated=TO_TIMESTAMP('2024-05-08 12:16:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=10011
;

-- IDEMPIERE-6133
SELECT register_migration_script('202405080546_IDEMPIERE-6133.sql') FROM dual;
