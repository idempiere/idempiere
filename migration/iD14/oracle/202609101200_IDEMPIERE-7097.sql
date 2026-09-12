-- IDEMPIERE-7097 Workflow editor: missing transition messages and label normalization
SELECT register_migration_script('202609101200_IDEMPIERE-7097.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- normalize capitalization to sentence case like the ZoomOut entry
UPDATE AD_Message SET MsgText='Zoom in', Updated=TO_TIMESTAMP('2026-09-10 12:00:00','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE Value='ZoomIn' AND MsgText='Zoom In'
;

-- Sep 10, 2026, 12:00:00 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Pin position',0,0,'Y',TO_TIMESTAMP('2026-09-10 12:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-09-10 12:00:00','YYYY-MM-DD HH24:MI:SS'),100,201064,'WFPinPosition','D','0d4359a3-18ff-4cd9-bc21-bd8a89172ef2')
;

-- Sep 10, 2026, 12:00:00 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Release position',0,0,'Y',TO_TIMESTAMP('2026-09-10 12:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-09-10 12:00:00','YYYY-MM-DD HH24:MI:SS'),100,201065,'WFUnpinPosition','D','c57ca155-6855-4ea4-8363-1f39e84c7d3c')
;

-- Sep 10, 2026, 12:00:00 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Pinned position',0,0,'Y',TO_TIMESTAMP('2026-09-10 12:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-09-10 12:00:00','YYYY-MM-DD HH24:MI:SS'),100,201066,'WFPinnedPosition','D','ad257302-9702-40d4-8088-46515bcf8981')
;

-- Sep 11, 2026, 3:00:00 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Only valid when Complete is selected in the document',0,0,'Y',TO_TIMESTAMP('2026-09-11 15:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-09-11 15:00:00','YYYY-MM-DD HH24:MI:SS'),100,201067,'WFStdUserWorkflowOnly','D','49b1e92d-c272-4a98-b6c4-dfb483f33a06')
;
