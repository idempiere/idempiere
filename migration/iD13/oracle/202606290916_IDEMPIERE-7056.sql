-- IDEMPIERE-7056
SELECT register_migration_script('202606290916_IDEMPIERE-7056.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jun 29, 2026, 9:16:26 AM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200315,0,0,TO_TIMESTAMP('2026-06-29 09:16:26','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2026-06-29 09:16:26','YYYY-MM-DD HH24:MI:SS'),10,10,'Y','ORACLE_SET_STRING_MAX_LENGTH','32766','Oracle setString() length limit. Longer strings use setClob()','D','S','019f123c-909e-75c5-90dc-09776f714471')
;

