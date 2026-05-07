-- IDEMPIERE-6908 Implement iDempiere Extension Management
SELECT register_migration_script('202603271424_IDEMPIERE-6908.sql') FROM dual;

-- Mar 27, 2026, 2:24:49 PM GMT+08:00
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,IsReport,Value,IsDirectPrint,Classname,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,ShowHelp,CopyFromProcess,AD_Process_UU,AllowMultipleExecution) VALUES (200165,0,0,'Y',TO_TIMESTAMP('2026-03-27 14:24:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-27 14:24:46','YYYY-MM-DD HH24:MI:SS'),100,'Uninstall Extension','Process to uninstall extension','N','UninstallExtension','N','org.idempiere.extension.manager.process.UninstallExtension','4','D',0,0,'N','S','N','019d2df7-83f7-75d4-b879-92a618aea100','P')
;

-- Mar 27, 2026, 2:25:35 PM GMT+08:00
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,IsReport,Value,IsDirectPrint,Classname,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,ShowHelp,CopyFromProcess,AD_Process_UU,AllowMultipleExecution) VALUES (200166,0,0,'Y',TO_TIMESTAMP('2026-03-27 14:25:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-27 14:25:33','YYYY-MM-DD HH24:MI:SS'),100,'Enable Extension','Process to enable an extension','N','EnableExtension','N','org.idempiere.extension.manager.process.EnableExtension','4','D',0,0,'N','S','N','019d2df8-374d-7721-bd8b-7da44c5c1296','P')
;

-- Mar 27, 2026, 2:26:07 PM GMT+08:00
UPDATE AD_Process SET Name='Disable Extension', Description='Process to disable an extension', Value='DisableExtension', Classname='org.idempiere.extension.manager.process.DisableExtension',Updated=TO_TIMESTAMP('2026-03-27 14:26:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200166
;

-- Mar 27, 2026, 2:30:04 PM GMT+08:00
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,IsReport,Value,IsDirectPrint,Classname,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,ShowHelp,CopyFromProcess,AD_Process_UU,AllowMultipleExecution) VALUES (200167,0,0,'Y',TO_TIMESTAMP('2026-03-27 14:30:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-27 14:30:03','YYYY-MM-DD HH24:MI:SS'),100,'Enable Extension','Process to enable an extension','N','EnableExtension','N','org.idempiere.extension.manager.process.EnableExtension','4','D',0,0,'N','S','N','019d2dfc-54a3-7a5d-92bb-5ed59fb868e0','P')
;

-- Mar 27, 2026, 2:32:27 PM GMT+08:00
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,AD_ToolBarButton_ID,Name,Updated,UpdatedBy,IsCustomization,AD_ToolBarButton_UU,"action",AD_Tab_ID,AD_Process_ID,DisplayLogic,SeqNo,EntityType) VALUES (0,0,TO_TIMESTAMP('2026-03-27 14:32:26','YYYY-MM-DD HH24:MI:SS'),100,'EnableExtension','Y',200136,'Enable Extension',TO_TIMESTAMP('2026-03-27 14:32:26','YYYY-MM-DD HH24:MI:SS'),100,'N','019d2dfe-8433-7219-8604-d18136ec0976','W',200416,200167,'@ExtensionState@=''DI''',10,'D')
;

-- Mar 27, 2026, 2:33:57 PM GMT+08:00
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,AD_ToolBarButton_ID,Name,Updated,UpdatedBy,IsCustomization,AD_ToolBarButton_UU,"action",AD_Tab_ID,AD_Process_ID,DisplayLogic,SeqNo,EntityType) VALUES (0,0,TO_TIMESTAMP('2026-03-27 14:33:56','YYYY-MM-DD HH24:MI:SS'),100,'DisableExtension','Y',200137,'Disable Extension',TO_TIMESTAMP('2026-03-27 14:33:56','YYYY-MM-DD HH24:MI:SS'),100,'N','019d2dff-e08e-70d7-ab71-f7450d0f49fe','W',200416,200166,'@ExtensionState@=''IN''',10,'D')
;

-- Mar 27, 2026, 2:34:56 PM GMT+08:00
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,AD_ToolBarButton_ID,Name,Updated,UpdatedBy,IsCustomization,AD_ToolBarButton_UU,"action",AD_Tab_ID,AD_Process_ID,DisplayLogic,SeqNo,EntityType) VALUES (0,0,TO_TIMESTAMP('2026-03-27 14:34:55','YYYY-MM-DD HH24:MI:SS'),100,'InstallExtension','Y',200138,'Install Extension',TO_TIMESTAMP('2026-03-27 14:34:55','YYYY-MM-DD HH24:MI:SS'),100,'N','019d2e00-c9c0-7884-b539-9c77fe6fb86f','W',200416,200164,'@ExtensionState@=''UN''|@ExtensionState@=''ER''',30,'D')
;

-- Mar 27, 2026, 2:37:56 PM GMT+08:00
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,AD_ToolBarButton_ID,Name,Updated,UpdatedBy,IsCustomization,AD_ToolBarButton_UU,"action",AD_Tab_ID,AD_Process_ID,DisplayLogic,SeqNo,EntityType) VALUES (0,0,TO_TIMESTAMP('2026-03-27 14:37:54','YYYY-MM-DD HH24:MI:SS'),100,'UninstallExtension','Y',200139,'Uninstall Extension',TO_TIMESTAMP('2026-03-27 14:37:54','YYYY-MM-DD HH24:MI:SS'),100,'N','019d2e03-88e5-7afa-b717-645835f19e28','W',200416,200165,'(@ExtensionState@=''IN''|@ExtensionState@=''DI'')&@IsBundled@=''N''',40,'D')
;

-- Mar 27, 2026, 2:38:22 PM GMT+08:00
UPDATE AD_ToolBarButton SET DisplayLogic='(@ExtensionState@=''UN''|@ExtensionState@=''ER'')&@IsBundled@=''N''',Updated=TO_TIMESTAMP('2026-03-27 14:38:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ToolBarButton_ID=200138
;

-- Mar 27, 2026, 2:46:58 PM GMT+08:00
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Extension disabled',0,0,'Y',TO_TIMESTAMP('2026-03-27 14:46:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-27 14:46:57','YYYY-MM-DD HH24:MI:SS'),100,201027,'ExtensionDisableSuccessfully','D','019d2e0b-cbd3-7ccd-8f51-0ab540a3558c')
;

-- Mar 27, 2026, 2:47:53 PM GMT+08:00
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Extension enabled',0,0,'Y',TO_TIMESTAMP('2026-03-27 14:47:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-27 14:47:52','YYYY-MM-DD HH24:MI:SS'),100,201028,'ExtensionEnableSuccessfully','D','019d2e0c-a24a-7ff9-83f4-7e95b6963c54')
;

-- Mar 27, 2026, 2:49:42 PM GMT+08:00
UPDATE AD_Message SET MsgText='Extension Installed',Updated=TO_TIMESTAMP('2026-03-27 14:49:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=201024
;

-- Mar 27, 2026, 2:51:11 PM GMT+08:00
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Extension Uninstalled',0,0,'Y',TO_TIMESTAMP('2026-03-27 14:51:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-27 14:51:10','YYYY-MM-DD HH24:MI:SS'),100,201029,'ExtensionUninstallSuccessfully','D','019d2e0f-a9d5-7c51-adca-189a7ebfbd75')
;

