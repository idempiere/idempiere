-- IDEMPIERE-3989
SELECT register_migration_script('202310061112_IDEMPIERE-3989.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Oct 6, 2023, 11:12:13 AM BRT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (nextidfunc(50009,'N'),0,0,TO_TIMESTAMP('2023-10-06 11:12:13','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2023-10-06 11:12:13','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZK_DISPLAY_ENTITYTYPE_INFORMATION','Y','If "Y" then shows information about dictionary element on Field Record Info, Help Window and Help Panel','D','C','8057c94a-1c55-460c-9722-f231a5bb550a')
;

