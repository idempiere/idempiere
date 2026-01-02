-- IDEMPIERE-6730 Add READ_TABLES_NOT_IN_TABLE_ACCESS_INCLUDE_LIST AD_SysConfig flag for Role Table Access
SELECT register_migration_script('202601021553_IDEMPIERE-6730.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jan 2, 2026, 3:53:18 PM MYT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200290,0,0,TO_TIMESTAMP('2026-01-02 15:53:18','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2026-01-02 15:53:18','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','READ_TABLES_NOT_IN_TABLE_ACCESS_INCLUDE_LIST','N','Y/N. Y - The role has read-only access to any table that is not included in the Role Table Access list. N - The role can only access tables that are included in the Role Table Access list. Default is N.','D','S','019b7db2-58b3-79ad-9694-ac0e31e20c5a')
;

