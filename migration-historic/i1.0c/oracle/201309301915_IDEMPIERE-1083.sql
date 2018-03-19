SET SQLBLANKLINES ON
SET DEFINE OFF

-- Sep 30, 2013 7:12:21 PM SGT
-- IDEMPIERE-1083 Print shipping label applet is not working
INSERT INTO AD_SysConfig (AD_SysConfig_ID,ConfigurationLevel,Value,AD_SysConfig_UU,Created,Updated,AD_Org_ID,CreatedBy,IsActive,UpdatedBy,Name,AD_Client_ID,EntityType) VALUES (200036,'S',' ','3d792b55-0ca5-467c-b666-c642103efb28',TO_DATE('2013-09-30 19:12:20','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-09-30 19:12:20','YYYY-MM-DD HH24:MI:SS'),0,100,'Y',100,'ZK_PRINT_SHIPPING_LABEL_SHARED_TEMP_FOLDER',0,'D')
;

SELECT register_migration_script('201309301915_IDEMPIERE-1083.sql') FROM dual
;