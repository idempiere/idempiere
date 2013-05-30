-- May 29, 2013 12:13:00 PM COT
-- IDEMPIERE-970  Role with the "can Export" option deselected would actually be able to export
INSERT INTO AD_SysConfig (AD_SysConfig_ID,ConfigurationLevel,Value,Description,AD_SysConfig_UU,Created,Updated,AD_Org_ID,CreatedBy,IsActive,UpdatedBy,Name,AD_Client_ID,EntityType) VALUES (200030,'O','PDF','Sets default jasper output type','7dbe0a07-d566-419e-9f81-003cf0be6b52',TO_DATE('2013-05-29 12:13:00','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-05-29 12:13:00','YYYY-MM-DD HH24:MI:SS'),0,100,'Y',100,'ZK_REPORT_JASPER_OUTPUT_TYPE',0,'D')
;

SELECT register_migration_script('20130529121300_IDEMPIERE-970.sql') FROM dual
;

