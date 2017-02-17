-- IBAN validation IDEMPIERE-1200
-- Jan 19, 2017 10:54:38 AM CET
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200086,0,0,TO_TIMESTAMP('2017-01-19 10:54:37','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2017-01-19 10:54:37','YYYY-MM-DD HH24:MI:SS'),0,0,'Y','IBAN_VALIDATION','Y','Enables the validation of IBAN fields','D','C','1b324142-ae32-4cff-9ea9-792df3e4d142')
;

SELECT register_migration_script('201701191158_IDEMPIERE-1200.sql') FROM dual
;
