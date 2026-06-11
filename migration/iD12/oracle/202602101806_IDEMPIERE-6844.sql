-- IDEMPIERE-6844 CSV Injection in iDempiere WebUI
SELECT register_migration_script('202602101806_IDEMPIERE-6844.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Feb 10, 2026, 6:06:29 PM CET
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200297,0,0,TO_TIMESTAMP('2026-02-10 18:06:28','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2026-02-10 18:06:28','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','CSV_EXPORT_SANITIZATION','Y','Sanitize the reports exported to CSV, SSV, TSV','D','C','019c4884-ce1e-76af-aa11-5d87c2857a80')
;

