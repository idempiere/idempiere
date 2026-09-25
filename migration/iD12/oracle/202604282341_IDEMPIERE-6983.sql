-- IDEMPIERE-6983 Oracle issue - cannot create attachments in UUID based tables
SELECT register_migration_script('202604282341_IDEMPIERE-6983.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Apr 28, 2026, 11:41:53 PM CEST
UPDATE AD_IndexColumn SET AD_Column_ID=215842,Updated=TO_TIMESTAMP('2026-04-28 23:41:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_IndexColumn_ID=201485
;

-- Apr 28, 2026, 11:42:17 PM CEST
DROP INDEX ad_attachment_record
;

-- Apr 28, 2026, 11:42:18 PM CEST
CREATE UNIQUE INDEX ad_attachment_record ON AD_Attachment (AD_Table_ID,Record_ID,Record_UU)
;

-- Apr 28, 2026, 11:43:20 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201813,'019dd60b-f14a-763c-b8df-bc8835e1d5d3',TO_TIMESTAMP('2026-04-28 23:43:19','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2026-04-28 23:43:19','YYYY-MM-DD HH24:MI:SS'),100,215844,201115,30)
;

-- Apr 28, 2026, 11:43:31 PM CEST
DROP INDEX AD_PostIt_Record_ID_AD_Table_ID
;

-- Apr 28, 2026, 11:43:31 PM CEST
CREATE UNIQUE INDEX AD_PostIt_Record_ID_AD_Table_ID ON AD_PostIt (Record_ID,AD_Table_ID,Record_UU)
;

-- Apr 28, 2026, 11:44:13 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201814,'019dd60c-c029-7b3b-8190-e221ef70e427',TO_TIMESTAMP('2026-04-28 23:44:12','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2026-04-28 23:44:12','YYYY-MM-DD HH24:MI:SS'),100,215843,200582,12)
;

-- Apr 28, 2026, 11:44:27 PM CEST
UPDATE AD_IndexColumn SET SeqNo=30,Updated=TO_TIMESTAMP('2026-04-28 23:44:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_IndexColumn_ID=201814
;

-- Apr 28, 2026, 11:44:32 PM CEST
UPDATE AD_IndexColumn SET SeqNo=10,Updated=TO_TIMESTAMP('2026-04-28 23:44:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_IndexColumn_ID=200694
;

-- Apr 28, 2026, 11:44:36 PM CEST
UPDATE AD_IndexColumn SET SeqNo=20,Updated=TO_TIMESTAMP('2026-04-28 23:44:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_IndexColumn_ID=200695
;

-- Apr 28, 2026, 11:44:41 PM CEST
DROP INDEX cm_chat_record
;

-- Apr 28, 2026, 11:44:41 PM CEST
CREATE UNIQUE INDEX cm_chat_record ON CM_Chat (AD_Table_ID,Record_ID,Record_UU)
;

