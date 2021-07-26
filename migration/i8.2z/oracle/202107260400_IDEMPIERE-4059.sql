SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jul 25, 2021, 12:17:29 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,MsgTip,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Print Format Editor','Visual editor for print format',0,0,'Y',TO_DATE('2021-07-25 12:17:28','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-07-25 12:17:28','YYYY-MM-DD HH24:MI:SS'),100,200713,'org.idempiere.printformat.editor.action.EditorAction.label','D','8c59d7b9-d69a-49a2-9031-e62696efc8ff')
;

-- Jul 25, 2021, 12:22:16 PM MYT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,AD_ToolBarButton_ID,Name,Updated,UpdatedBy,IsCustomization,ActionClassName,KeyStroke_KeyCode,KeyStroke_Modifiers,AD_ToolBarButton_UU,Action,DisplayLogic,SeqNo,IsAdvancedButton,IsAddSeparator,EntityType,IsShowMore) VALUES (0,0,TO_DATE('2021-07-25 12:22:15','YYYY-MM-DD HH24:MI:SS'),100,'PrintFormatEditor','Y',200115,'Print Format Editor',TO_DATE('2021-07-25 12:22:15','YYYY-MM-DD HH24:MI:SS'),100,'Y','org.idempiere.printformat.editor.action.EditorAction',0,0,'cc75241b-291f-4a05-8719-5a245b4ff943','W','@_WinInfo_AD_Window_ID@=240 & @AD_Client_ID@=@#AD_Client_ID@ & @AD_PrintFormat_ID@>0',0,'N','N','D','N')
;

SELECT register_migration_script('202107260400_IDEMPIERE-4059.sql') FROM dual
;

