-- IDEMPIERE-7157 Add AD_SysConfig option for the rendering of report parameters in Excel format
SELECT register_migration_script('202610112016_IDEMPIERE-7157.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Oct 11, 2026, 8:16:33 PM MYT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200334,0,0,TO_TIMESTAMP('2026-10-11 20:16:32','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2026-10-11 20:16:32','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','SHOW_REPORT_PARAMETER_IN_XLS_REPORT','Y','Determines whether report parameters are inserted as header rows above the data in Excel exports. Options: Y (Yes, default), N (No).','D','C','01a12ae4-b276-77b0-a52b-80652f443bb8')
;

