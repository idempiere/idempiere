SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jun 22, 2017 5:41:04 PM CEST
-- Automatic Packin
INSERT INTO AD_SysConfig (AD_SysConfig_ID,ConfigurationLevel,Updated,Value,Description,AD_SysConfig_UU,IsActive,Name,Created,AD_Org_ID,CreatedBy,UpdatedBy,AD_Client_ID,EntityType) VALUES (200101,'S',TO_DATE('2017-06-22 17:41:03','YYYY-MM-DD HH24:MI:SS'),'120','Delay in seconds to start applying the external automatic packin - see AUTOMATIC_PACKIN_FOLDERS','7db52ef2-ce9e-4989-b583-b64429fca5c8','Y','AUTOMATIC_PACKIN_INITIAL_DELAY',TO_DATE('2017-06-22 17:41:03','YYYY-MM-DD HH24:MI:SS'),0,100,100,0,'D')
;

-- Jun 22, 2017 5:44:09 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,ConfigurationLevel,Updated,Value,Description,AD_SysConfig_UU,IsActive,Name,Created,AD_Org_ID,CreatedBy,UpdatedBy,AD_Client_ID,EntityType) VALUES (200102,'S',TO_DATE('2017-06-22 17:44:09','YYYY-MM-DD HH24:MI:SS'),' ','List of folders separated by semicolon (;) - allowed is .zip file or folder containing .zip files (recursive) - filename notation yyyymmddHHMM_ClientValue_InformationalDescription.zip','5468245a-0bb1-4357-b293-2ffb81c7cf2d','Y','AUTOMATIC_PACKIN_FOLDERS',TO_DATE('2017-06-22 17:44:09','YYYY-MM-DD HH24:MI:SS'),0,100,100,0,'D')
;

SELECT register_migration_script('201706221744_AutomaticExternalPackin.sql') FROM dual
;

