-- IDEMPIERE-7125 Hardcoded timeouts
SELECT register_migration_script('202609271733_IDEMPIERE-7125.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Sep 27, 2026, 5:33:04 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200328,0,0,TO_TIMESTAMP('2026-09-27 17:33:04','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2026-09-27 17:33:04','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','DB_LOCK_TIMEOUT','60','Timeout in seconds for locking records in general - 0 for no timeout (not recommended)','D','C','01a0e37f-9697-75b9-be88-770b07f307d2')
;

-- Sep 27, 2026, 5:33:25 PM CEST
UPDATE AD_SysConfig SET Description='Timeout in seconds for locking the M_StorageOnHand table - when set to zero the DB_LOCK_TIMEOUT applies',Updated=TO_TIMESTAMP('2026-09-27 17:33:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_SysConfig_ID=200327
;

