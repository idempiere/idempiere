-- IDEMPIERE-7118 Make KeiKai spreadsheet in Report window configurably editable
SELECT register_migration_script('202609221637_IDEMPIERE-7118.sql') FROM dual;

-- Sep 22, 2026, 4:37:02 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200324,0,0,TO_TIMESTAMP('2026-09-22 16:37:01','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2026-09-22 16:37:01','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','XLS_VIEWER_READONLY_ATTACHMENT','Y','Defines if the XLS/XLSX/CSV viewer is read-only in the attachment window   -   Y/N','D','C','01a0c98c-7b21-76ce-ba5f-1826d7d626ee')
;

-- Sep 22, 2026, 4:37:21 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200325,0,0,TO_TIMESTAMP('2026-09-22 16:37:21','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2026-09-22 16:37:21','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','XLS_VIEWER_READONLY_REPORT','Y','Defines if the XLS/XLSX/CSV viewer is read-only in the report viewer window   -   Y/N','D','C','01a0c98c-c64d-7b2d-bf64-78ef88ad3a5b')
;

-- Sep 22, 2026, 4:37:39 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200326,0,0,TO_TIMESTAMP('2026-09-22 16:37:38','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2026-09-22 16:37:38','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','XLS_VIEWER_READONLY_INFOWINDOW','N','Defines if the XLS/XLSX/CSV viewer is read-only in the info windows   -   Y/N','D','C','01a0c98d-0be0-7679-87d1-1407c75d79b0')
;

