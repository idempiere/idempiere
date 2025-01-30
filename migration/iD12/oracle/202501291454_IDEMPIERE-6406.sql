-- IDEMPIERE-6406
SELECT register_migration_script('202501291454_IDEMPIERE-6406.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jan 29, 2025, 2:54:17 PM BRT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Template/Mode not allowed for this role',0,0,'Y',TO_TIMESTAMP('2025-01-29 14:54:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-01-29 14:54:17','YYYY-MM-DD HH24:MI:SS'),100,200930,'TemplateNotAllowedRole','D','11d51d58-d83e-4e3e-a97b-768a97f4e989')
;

-- Jan 29, 2025, 3:02:31 PM BRT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','No Active Tab',0,0,'Y',TO_TIMESTAMP('2025-01-29 15:02:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-01-29 15:02:30','YYYY-MM-DD HH24:MI:SS'),100,200931,'NoActiveTab','D','8a299eb1-4e05-4c86-b32c-7faf5f1312f8')
;

-- Jan 29, 2025, 3:05:27 PM BRT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','No CSV importer',0,0,'Y',TO_TIMESTAMP('2025-01-29 15:05:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-01-29 15:05:26','YYYY-MM-DD HH24:MI:SS'),100,200932,'NoCSVImporter','D','1a9eab6a-1928-4eed-9dc9-afbef4acd063')
;

-- Jan 29, 2025, 3:06:28 PM BRT
UPDATE AD_Message SET MsgType='E',Updated=TO_TIMESTAMP('2025-01-29 15:06:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200932
;

-- Jan 29, 2025, 3:07:28 PM BRT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Table doesn''t match with updated tab',0,0,'Y',TO_TIMESTAMP('2025-01-29 15:07:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-01-29 15:07:28','YYYY-MM-DD HH24:MI:SS'),100,200933,'TableDoesntMatchWithUpdatedTab','D','e0e36f98-0e6a-4552-88ba-0495e7f4b4a8')
;

