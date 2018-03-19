-- Mar 26, 2013 8:15:58 PM MYT
-- IDEMPIERE-800 Zk: Add API for consistent button style
INSERT INTO AD_SysConfig (AD_SysConfig_ID,EntityType,ConfigurationLevel,Value,Description,AD_SysConfig_UU,Created,Updated,AD_Client_ID,AD_Org_ID,CreatedBy,IsActive,UpdatedBy,Name) VALUES (200029,'D','S','I','T-Text, I-Image, IT-Image and Text','c86d55be-3ae7-425e-a828-8f6cb1a6977c',TO_DATE('2013-03-26 20:15:56','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-03-26 20:15:56','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Y',100,'ZK_BUTTON_STYLE')
;

SELECT register_migration_script('201303261217_IDEMPIERE-800.sql') FROM dual
;

