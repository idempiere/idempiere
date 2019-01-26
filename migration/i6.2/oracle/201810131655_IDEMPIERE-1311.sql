SET SQLBLANKLINES ON
SET DEFINE OFF

-- Oct 13, 2018 4:35:41 PM IST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200146,0,0,TO_DATE('2018-10-13 16:35:40','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2018-10-13 16:35:40','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ALogin_ShowDate','Y','Defaulted to Y. If value changed to N, date field is not displayed on role window.','D','S','54085add-8245-4bfe-a978-3583bbe2cc2a')
;

SELECT register_migration_script('201810131655_IDEMPIERE-1311.sql') FROM dual
;
