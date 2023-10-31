-- IDEMPIERE-5760
SELECT register_migration_script('202308280920_IDEMPIERE-5760.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Aug 28, 2023, 9:20:09 AM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200233,0,0,TO_TIMESTAMP('2023-08-28 09:20:09','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2023-08-28 09:20:09','YYYY-MM-DD HH24:MI:SS'),10,10,'Y','MAIL_SMTP_TIMEOUT','20000','Timeout in milliseconds to send an email','D','C','66c84808-15eb-4f26-ad23-25d9ea0d96fc')
;

