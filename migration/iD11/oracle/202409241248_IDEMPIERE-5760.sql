-- IDEMPIERE-5760 Manage mail.smtp.timeout using SysConfig
SELECT register_migration_script('202409241248_IDEMPIERE-5760.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Sep 24, 2024, 12:48:56 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200253,0,0,TO_TIMESTAMP('2024-09-24 12:48:55','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2024-09-24 12:48:55','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','MAIL_SMTP_CONNECTIONTIMEOUT','-1','Timeout in milliseconds to wait for SMTP connection, -1 leaves the java default','D','C','36be68b7-7b4b-4725-9a51-aeb11bb7b699')
;

-- Sep 24, 2024, 12:49:10 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200254,0,0,TO_TIMESTAMP('2024-09-24 12:49:09','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2024-09-24 12:49:09','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','MAIL_SMTP_WRITETIMEOUT','-1','Timeout in milliseconds to wait for writing on SMTP connection, -1 leaves the java default','D','C','e11d83c4-8500-400a-b9d2-358c30c910fb')
;

