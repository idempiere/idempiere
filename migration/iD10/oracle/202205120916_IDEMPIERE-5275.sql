-- IDEMPIERE-5275
SELECT register_migration_script('202205120916_IDEMPIERE-5275.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- May 12, 2022, 9:16:37 AM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200199,0,0,TO_TIMESTAMP('2022-05-12 09:16:36','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2022-05-12 09:16:36','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZK_REPORT_TABLE_OPEN_IN_NEW_TAB','N','If set to ''N'', the report opens in the same tab, if ''Y'', it opens a new tab','D','S','7d2126fa-f45a-4aeb-ad0f-21c6e096a2c3')
;

-- May 12, 2022, 10:12:31 AM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('M','ReQuery',0,0,'Y',TO_TIMESTAMP('2022-05-12 10:12:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-05-12 10:12:31','YYYY-MM-DD HH24:MI:SS'),100,200750,'ReRun','D','144c6c0e-e253-459f-acda-c23f55fa1962')
;

-- May 12, 2022, 10:13:08 AM CEST
UPDATE AD_Message SET MsgText='ReRun',Updated=TO_TIMESTAMP('2022-05-12 10:13:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200750
;

