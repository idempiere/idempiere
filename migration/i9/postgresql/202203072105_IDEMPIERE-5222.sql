-- IDEMPIERE-5222 Add Attach button to report viewer (similar to Archive but with Attachment)
SELECT register_migration_script('202203072105_IDEMPIERE-5222.sql') FROM dual;

-- Mar 7, 2022, 9:05:46 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Document Attached',0,0,'Y',TO_TIMESTAMP('2022-03-07 21:05:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-07 21:05:46','YYYY-MM-DD HH24:MI:SS'),100,200738,'DocumentAttached','D','40056a6d-100f-4c1f-9748-1d0ccdda901a')
;

-- Mar 7, 2022, 9:05:59 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Attach Error',0,0,'Y',TO_TIMESTAMP('2022-03-07 21:05:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-07 21:05:59','YYYY-MM-DD HH24:MI:SS'),100,200739,'AttachError','D','55248ed3-7703-41f3-821a-753fbcc1c06b')
;

-- Mar 7, 2022, 9:06:54 PM CET
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,AD_ToolBarButton_ID,Name,Updated,UpdatedBy,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers,AD_ToolBarButton_UU,"action",IsAdvancedButton,IsAddSeparator,EntityType,IsShowMore) VALUES (0,0,TO_TIMESTAMP('2022-03-07 21:06:54','YYYY-MM-DD HH24:MI:SS'),100,'Attachment','Y',200117,'Report - Attach',TO_TIMESTAMP('2022-03-07 21:06:54','YYYY-MM-DD HH24:MI:SS'),100,'N',0,0,'4e060cb2-f2a7-496c-b882-604814506b5b','R','N','N','D','N')
;

