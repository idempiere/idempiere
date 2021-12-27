SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4949 Desktop tab enhancements
-- Sep 8, 2021, 11:58:54 AM MYT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200181,0,0,TO_DATE('2021-09-08 11:58:53','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2021-09-08 11:58:53','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZK_DESKTOP_TAB_MAX_TITLE_LENGTH','30','Define the maximum length of desktop tab title.','D','C','d658c5ed-c215-4e3d-ba99-cb9e0c005a0f')
;

-- Sep 8, 2021, 12:04:08 PM MYT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200182,0,0,TO_DATE('2021-09-08 12:04:08','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2021-09-08 12:04:08','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZK_DESKTOP_SHOW_HOME_BUTTON','Y','Y/N - Define if the Home toolbar button is show on desktop browser','D','C','2ff5aab3-79bf-41b7-bbf2-929f9ef3b3d2')
;

-- Sep 8, 2021, 12:33:31 PM MYT
UPDATE AD_SysConfig SET Description='Y/N - Define if the Home toolbar button is visible in desktop browser',Updated=TO_DATE('2021-09-08 12:33:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_SysConfig_ID=200182
;

-- Sep 8, 2021, 12:40:32 PM MYT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200183,0,0,TO_DATE('2021-09-08 12:40:30','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2021-09-08 12:40:30','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZK_DESKTOP_SHOW_TAB_LIST_BUTTON','Y','Y/N - Define if the Dropdown menu for open tabs is visible in desktop browser','D','C','7a37f592-1aae-4d13-8648-d8e3e8e88fc0')
;

-- Sep 8, 2021, 12:47:05 PM MYT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200184,0,0,TO_DATE('2021-09-08 12:47:04','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2021-09-08 12:47:04','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZK_DESKTOP_TAB_AUTO_SHRINK_TO_FIT','N','Y/N - Define if each desktop tab will auto shrink in size to fit more tabs on screen. When Y, the dropdown menu for open tabs is visible regardless of the setting for ZK_DESKTOP_SHOW_TAB_LIST_BUTTON','D','C','0fe51a4e-aa01-4787-8361-94c411c5e74d')
;

SELECT register_migration_script('202109080800_IDEMPIERE-4949.sql') FROM dual
;

