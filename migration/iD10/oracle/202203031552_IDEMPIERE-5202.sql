-- IDEMPIERE-5202 Implement auto save of current tab
SELECT register_migration_script('202203031552_IDEMPIERE-5202.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Mar 3, 2022, 3:53:48 PM CET
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200196,0,0,TO_TIMESTAMP('2022-03-03 15:53:47','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2022-03-03 15:53:47','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZK_AUTO_SAVE_TABS_EXCLUDED','344,402','D','C','7c2fe8a9-c627-465e-a639-d6b051916410')
;

-- Mar 3, 2022, 3:55:43 PM CET
UPDATE AD_SysConfig SET Description='Comma separated list of tabs (ID or UUID) excluded from the auto save feature',Updated=TO_TIMESTAMP('2022-03-03 15:55:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_SysConfig_ID=200196
;

