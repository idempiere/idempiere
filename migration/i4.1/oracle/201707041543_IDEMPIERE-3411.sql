SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3411 : When lauching a report based on a report view, available print formats are not filtered
-- Jul 4, 2017 3:42:50 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200104,0,0,TO_DATE('2017-07-04 15:42:49','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2017-07-04 15:42:49','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZK_REPORT_ONLY_PRINTFORMAT_LINKEDTO_REPORTVIEW','N','If set to Yes, print formats will be filtered according to the current report view','U','C','18e6758b-db72-480e-b832-72080c8f2268')
;

SELECT register_migration_script('201707041543_IDEMPIERE-3411.sql') FROM dual
;