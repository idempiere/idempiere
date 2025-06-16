-- IDEMPIERE-6526 Performance improvement exporting to XLSX
SELECT register_migration_script('202505011526_IDEMPIERE-6526.sql') FROM dual;

-- May 1, 2025, 3:26:37 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200271,0,0,TO_TIMESTAMP('2025-05-01 15:26:37','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2025-05-01 15:26:37','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','XLSX_EXPORT_USE_FAST_METHOD','Y','Defines if exporting to XLSX uses the streaming method (less memory intensive)','D','S','2d1b3c19-aee1-44d2-8d7e-a3ae7d92086c')
;

