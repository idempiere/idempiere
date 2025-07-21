-- IDEMPIERE-6628 - Improve advanced options for Saved Queries on Find Window
SELECT register_migration_script('202507161744_IDEMPIERE-6628.sql') FROM dual;

-- Jul 16, 2025, 5:44:11 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Advanced options',0,0,'Y',TO_TIMESTAMP('2025-07-16 17:44:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-07-16 17:44:11','YYYY-MM-DD HH24:MI:SS'),100,200951,'AdvancedOptions','D','8c708159-ac18-47e9-92ba-a2684dbd2587')
;

-- Jul 16, 2025, 5:46:54 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Set as Default',0,0,'Y',TO_TIMESTAMP('2025-07-16 17:46:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-07-16 17:46:53','YYYY-MM-DD HH24:MI:SS'),100,200952,'SetDefault','D','1d93dfa1-6c76-45d4-b52e-7ea1e5a07994')
;

-- Jul 16, 2025, 5:49:00 PM CEST
UPDATE AD_Message SET MsgText='Share with all users',Updated=TO_TIMESTAMP('2025-07-16 17:49:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200581
;

-- Jul 16, 2025, 5:52:23 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','This query is now set as your default.',0,0,'Y',TO_TIMESTAMP('2025-07-16 17:52:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-07-16 17:52:23','YYYY-MM-DD HH24:MI:SS'),100,200953,'SetSavedQueryDefault','D','274a7c7c-3309-4123-b7cf-88a9925faa00')
;

-- Jul 16, 2025, 5:52:42 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Query removed as default.',0,0,'Y',TO_TIMESTAMP('2025-07-16 17:52:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-07-16 17:52:41','YYYY-MM-DD HH24:MI:SS'),100,200954,'RemoveSavedQueryDefault','D','93d409b0-47e4-4f12-bfb1-cfd6034cc899')
;

-- Jul 16, 2025, 5:54:12 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Query is now shared with all users.',0,0,'Y',TO_TIMESTAMP('2025-07-16 17:54:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-07-16 17:54:12','YYYY-MM-DD HH24:MI:SS'),100,200955,'SavedQueryShared','D','b508b370-6128-42b6-9007-de2cbe6c9263')
;

-- Jul 16, 2025, 5:54:34 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Query is no longer shared with other users.',0,0,'Y',TO_TIMESTAMP('2025-07-16 17:54:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-07-16 17:54:34','YYYY-MM-DD HH24:MI:SS'),100,200956,'UnshareSavedQuery','D','fbbd7b3e-b031-406e-9964-89eadb8409a6')
;

-- Jul 16, 2025, 5:55:29 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','The selected query has been removed.',0,0,'Y',TO_TIMESTAMP('2025-07-16 17:55:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-07-16 17:55:29','YYYY-MM-DD HH24:MI:SS'),100,200957,'DeleteSavedQuery','D','83ac280f-aef3-429e-97c5-cdb6395b7bbe')
;

-- Jul 16, 2025, 5:56:17 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','No saved query selected',0,0,'Y',TO_TIMESTAMP('2025-07-16 17:56:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-07-16 17:56:16','YYYY-MM-DD HH24:MI:SS'),100,200958,'NoSavedQuerySelected','D','658bf6e2-9519-4c8a-948b-991b94b1dcc9')
;

-- Jul 16, 2025, 5:58:42 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','A default query already exists: {0}. Do you want to replace it with the selected one?',0,0,'Y',TO_TIMESTAMP('2025-07-16 17:58:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-07-16 17:58:41','YYYY-MM-DD HH24:MI:SS'),100,200959,'ReplaceDefaultQuery','D','42d33d5f-37dd-463e-951c-b038697f7249')
;

-- Jul 16, 2025, 5:59:23 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Are you sure you want to delete this query? This action cannot be undone.',0,0,'Y',TO_TIMESTAMP('2025-07-16 17:59:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-07-16 17:59:23','YYYY-MM-DD HH24:MI:SS'),100,200960,'DeleteSavedQuery?','D','d12b3ae8-f451-4135-ba6f-9b78ff7a21dd')
;

