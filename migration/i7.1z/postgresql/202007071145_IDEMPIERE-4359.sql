-- IDEMPIERE-4359 : EMailTest process : customization of email sent
-- Jul 7, 2020, 11:49:12 AM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200155,0,0,TO_TIMESTAMP('2020-07-07 11:49:12','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2020-07-07 11:49:12','YYYY-MM-DD HH24:MI:SS'),0,0,'Y','EMAIL_TEST_MAILTEXT_ID','0','Mail template used by EMailTest process (see https://idempiere.atlassian.net/browse/IDEMPIERE-4359) ; if 0, content of email is hardcoded','D','C','44d88d3b-d74a-43ca-b9b7-1ba8c0255dda')
;

SELECT register_migration_script('202007071145_IDEMPIERE-4359.sql') FROM dual
;