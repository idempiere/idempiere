SET SQLBLANKLINES ON
SET DEFINE OFF

-- Sep 5, 2014 8:37:41 AM COT
-- IDEMPIERE-2188 Make hardcoded load timeout configurable
INSERT INTO AD_SysConfig (AD_SysConfig_ID,ConfigurationLevel,Value,Description,AD_SysConfig_UU,AD_Org_ID,CreatedBy,IsActive,UpdatedBy,Name,AD_Client_ID,EntityType,Created,Updated) VALUES (200059,'C','30','Load timeout for GridTable','0a5a3606-f25d-4ab2-9e50-a75e50dc931a',0,100,'Y',100,'GRIDTABLE_LOAD_TIMEOUT_IN_SECONDS',0,'D',TO_DATE('2014-09-05 08:37:41','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2014-09-05 08:37:41','YYYY-MM-DD HH24:MI:SS'))
;

SELECT register_migration_script('201409050839_IDEMPIERE-2188.sql') FROM dual
;

