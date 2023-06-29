-- IDEMPIERE-5743 Info Window: Add Optional Auto Collapsed Parameter Panel option
SELECT register_migration_script('202305291035_IDEMPIERE-5743.sql') FROM dual;

-- May 29, 2023, 10:35:50 AM MYT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200229,0,0,TO_TIMESTAMP('2023-05-29 10:35:48','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2023-05-29 10:35:48','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZK_INFO_AUTO_COLLAPSED_PARAMETER_PANEL','N','Y/N. When Set to Y,  Info Window will auto collaped parameter panel after query execution return one or more records.','D','C','2dd62df4-feac-4f93-8299-a0798a4aed8d')
;

