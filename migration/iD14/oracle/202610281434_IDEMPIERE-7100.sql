-- IDEMPIERE-7100 Web Client Desktop Refresh
SELECT register_migration_script('202610281434_IDEMPIERE-7100.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Oct 28, 2026, 2:34:07 PM CET
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200337,0,0,TO_TIMESTAMP('2026-10-28 14:34:07','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2026-10-28 14:34:07','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZK_USER_INITIALS_LENGTH','2','Length for users initials in user avatar button, can be set to 1 or 2','D','C','01a182b7-d45e-7440-b236-f4e54b9642a9')
;

