-- IDEMPIERE-7037
SELECT register_migration_script('202606191416_IDEMPIERE-7037.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jun 19, 2026, 2:16:26 PM BRT
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,IsReport,Value,IsDirectPrint,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,ShowHelp,CopyFromProcess,AD_Process_UU,AllowMultipleExecution) VALUES (200172,0,0,'Y',TO_TIMESTAMP('2026-06-19 14:16:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-06-19 14:16:26','YYYY-MM-DD HH24:MI:SS'),100,'Copy Customization','N','Copy_Customization_Process','N','3','D',0,0,'N','Y','N','019ee0e2-4836-7353-b10c-17f435156e5a','P')
;

-- Jun 19, 2026, 2:27:46 PM BRT
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200522,0,0,'Y',TO_TIMESTAMP('2026-06-19 14:27:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-06-19 14:27:45','YYYY-MM-DD HH24:MI:SS'),100,'User defined Window',200172,10,30,'N',22,'Y','AD_UserDef_Win_ID','Y','D',1645,'019ee0ec-a80a-7b89-8d20-519befb56233','N','N','D','N')
;

-- Jun 19, 2026, 2:32:27 PM BRT
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200210,'AD_UserDef_Win - Same Window','S','AD_Window_ID=@AD_Window_ID@ AND AD_UserDef_Win_ID<>@AD_UserDef_Win_ID@',0,0,'Y',TO_TIMESTAMP('2026-06-19 14:32:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-06-19 14:32:27','YYYY-MM-DD HH24:MI:SS'),100,'D','019ee0f0-f3ce-7fa7-baaa-67afb130c658')
;

-- Jun 19, 2026, 2:33:10 PM BRT
UPDATE AD_Process_Para SET AD_Val_Rule_ID=200210,Updated=TO_TIMESTAMP('2026-06-19 14:33:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200522
;

-- Jun 19, 2026, 2:39:58 PM BRT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,AD_ToolBarButton_ID,Name,Updated,UpdatedBy,IsCustomization,AD_ToolBarButton_UU,Action,AD_Tab_ID,AD_Process_ID,SeqNo,EntityType) VALUES (0,0,TO_TIMESTAMP('2026-06-19 14:39:57','YYYY-MM-DD HH24:MI:SS'),100,'CopyCustomization','Y',200140,'CopyCustomization',TO_TIMESTAMP('2026-06-19 14:39:57','YYYY-MM-DD HH24:MI:SS'),100,'N','019ee0f7-d259-79c6-b6b8-1dbcd44959d4','W',393,200172,10,'D')
;

-- Jun 19, 2026, 4:00:40 PM BRT
UPDATE AD_Process SET Classname='org.idempiere.process.CopyWindowCustomization',Updated=TO_TIMESTAMP('2026-06-19 16:00:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200172
;

-- Jun 19, 2026, 4:53:42 PM BRT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Source and target window customizations must belong to the same window',0,0,'Y',TO_TIMESTAMP('2026-06-19 16:53:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-06-19 16:53:40','YYYY-MM-DD HH24:MI:SS'),100,201042,'UserDefWinDifferentWindow','D','019ee172-41e6-70da-a5a0-af2de8e4f654')
;

