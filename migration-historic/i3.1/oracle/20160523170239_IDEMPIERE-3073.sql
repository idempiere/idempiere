SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3073 improve set of max text lenght on grid panel
-- May 23, 2016 5:02:39 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200077,0,0,TO_DATE('2016-05-23 17:02:39','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2016-05-23 17:02:39','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','MAX_TEXT_LENGTH_ON_GRID_VIEW','60','Max length of a text in grid view after wihich it is cut off (IDEMPIERE-3073)','D','C','092aeedc-22d9-4a70-9c90-d27aa68d47e7')
;

SELECT register_migration_script('20160523170239_IDEMPIERE-3073.sql') FROM dual
;

