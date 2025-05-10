-- IDEMPIERE-6533
SELECT register_migration_script('202505071311_IDEMPIERE-6533.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- May 7, 2025, 1:11:27 PM WIB
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200273,0,0,TO_TIMESTAMP('2025-05-07 13:11:26','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2025-05-07 13:11:26','YYYY-MM-DD HH24:MI:SS'),10,10,'Y','ACCOUNT_INFO_FORM_ID','200020','AD_Form_ID for Account Info Window','D','S','ed33c52a-81b0-4d32-bf8f-63d92fb2f2b7')
;

