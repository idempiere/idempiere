-- IDEMPIERE-5225
SELECT register_migration_script('202203161513_IDEMPIERE-5225.sql') FROM dual;

-- Mar 16, 2022, 3:13:31 PM CET
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200197,0,0,TO_TIMESTAMP('2022-03-16 15:13:30','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2022-03-16 15:13:30','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','HTML_REPORT_MINIFY','Y','Enable/disable minification on HTML Reports','D','C','9f3e162c-653e-4f45-9b1c-8151caf0945e')
;

