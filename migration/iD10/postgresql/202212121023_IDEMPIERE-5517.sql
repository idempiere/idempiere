-- IDEMPIERE-5517
SELECT register_migration_script('202212121023_IDEMPIERE-5517.sql') FROM dual;

-- Dec 12, 2022, 10:23:47 AM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Your text is too long and exceed maximum size ({0} / {1}) ; please reduce it before proceeding',0,0,'Y',TO_TIMESTAMP('2022-12-12 10:23:46','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-12-12 10:23:46','YYYY-MM-DD HH24:MI:SS'),10,200806,'TextEditorDialogCurrentSizeExceedMaxSize','D','8c6b6bac-9050-4abb-bdb7-3698f14a4ef3')
;

-- Dec 12, 2022, 10:23:55 AM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','You''ll lose all your unsaved changes ; proceed?',0,0,'Y',TO_TIMESTAMP('2022-12-12 10:23:54','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-12-12 10:23:54','YYYY-MM-DD HH24:MI:SS'),10,200807,'TextEditorDialogResetConfirmation','D','be8f0bc2-a758-43b2-8fad-8da3f95351f7')
;

-- Dec 14, 2022, 1:58:58 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Text',0,0,'Y',TO_TIMESTAMP('2022-12-14 13:58:57','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-12-14 13:58:57','YYYY-MM-DD HH24:MI:SS'),10,200808,'Text','D','4306a604-0bfe-4aee-b719-bff41279cf5c')
;

