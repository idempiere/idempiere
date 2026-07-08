-- IDEMPIERE-7060 - New Sysconfigs
SELECT register_migration_script('202607082008_IDEMPIERE-7060.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jul 8, 2026, 8:08:03 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200321,0,0,TO_TIMESTAMP('2026-07-08 20:08:03','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2026-07-08 20:08:03','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','PASSWORD_RESET_SERVICE_CLASS','org.adempiere.base.DefaultPasswordResetService','DS component name of the IPasswordResetService provider used for the code-based password reset. ','D','S','019f42ea-5d55-7e30-99bf-15daf39a93fc')
;

