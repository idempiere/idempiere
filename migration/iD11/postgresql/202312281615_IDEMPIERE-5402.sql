-- IDEMPIERE-5402 Replace Jfree Chart with Billboard
SELECT register_migration_script('202312281615_IDEMPIERE-5402.sql') FROM dual;

-- Dec 28, 2023, 4:15:58 PM CET
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200241,0,0,TO_TIMESTAMP('2023-12-28 16:15:57','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2023-12-28 16:15:57','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','CHART_MIN_WIDTH_3_PERIOD','230','D','C','7476f049-f648-4e25-8ab6-f975e5d0a875')
;

-- Dec 28, 2023, 4:16:09 PM CET
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200242,0,0,TO_TIMESTAMP('2023-12-28 16:16:09','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2023-12-28 16:16:09','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','CHART_MIN_WIDTH_6_PERIOD','320','D','C','16da07e3-5862-4cbd-9dd5-78f4e3095905')
;

