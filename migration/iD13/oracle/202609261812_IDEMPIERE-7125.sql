-- IDEMPIERE-7125 Hardcoded timeout locking MStorageOnHand
SELECT register_migration_script('202609261812_IDEMPIERE-7125.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Sep 26, 2026, 6:12:35 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200327,0,0,TO_TIMESTAMP('2026-09-26 18:12:35','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2026-09-26 18:12:35','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','MSTORAGEONHAND_LOCK_TIMEOUT','120','Timeout in seconds for locking the M_StorageOnHand table','D','C','01a0de7d-677a-700c-973d-253473f068d0')
;

