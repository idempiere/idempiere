-- IDEMPIERE-5056 Order and Invoice: Tax lookup interface
SELECT register_migration_script('202203171454_IDEMPIERE-5056.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Mar 17, 2022, 2:54:31 PM MYT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200198,0,0,TO_TIMESTAMP('2022-03-17 14:54:30','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2022-03-17 14:54:30','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','TAX_LOOKUP_SERVICE','50001','D','S','1161c587-6449-448a-9cb9-2fb600cf2b35')
;

-- Mar 17, 2022, 2:56:49 PM MYT
UPDATE AD_SysConfig SET Value='org.adempiere.base.DefaultTaxLookup', Description='OSGi component name of tax lookup service', ConfigurationLevel='C',Updated=TO_TIMESTAMP('2022-03-17 14:56:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_SysConfig_ID=200198
;

