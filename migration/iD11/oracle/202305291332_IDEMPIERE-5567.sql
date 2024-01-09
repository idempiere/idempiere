-- IDEMPIERE-5567 Support of UUID as Key (FHCA-4195)
SELECT register_migration_script('202305291332_IDEMPIERE-5567.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- May 29, 2023, 1:32:46 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215842,1,'Record UUID',254,'Record_UU',36,'N','N','N','N','N',0,'N',200240,0,0,'Y',TO_TIMESTAMP('2023-05-29 13:32:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-05-29 13:32:46','YYYY-MM-DD HH24:MI:SS'),100,203804,'N','N','D','N','N','N','Y','82a502a9-7d34-4024-adce-7d4f6537d9e9','Y','N','N','M','N')
;

-- May 29, 2023, 1:33:09 PM CEST
ALTER TABLE AD_Attachment ADD Record_UU VARCHAR2(36 CHAR) DEFAULT NULL 
;

-- May 29, 2023, 1:33:42 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207627,'Record UUID',173,215842,'Y',36,90,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-05-29 13:33:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-05-29 13:33:42','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f61f312c-8b91-4000-8f06-8cf0eb394bfa','Y',110,2)
;

-- May 29, 2023, 1:34:28 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=50, XPosition=4,Updated=TO_TIMESTAMP('2023-05-29 13:34:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207627
;

-- May 29, 2023, 1:34:28 PM CEST
UPDATE AD_Field SET SeqNo=60,Updated=TO_TIMESTAMP('2023-05-29 13:34:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3819
;

-- May 29, 2023, 1:34:28 PM CEST
UPDATE AD_Field SET SeqNo=70,Updated=TO_TIMESTAMP('2023-05-29 13:34:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10074
;

-- May 29, 2023, 1:34:28 PM CEST
UPDATE AD_Field SET SeqNo=80,Updated=TO_TIMESTAMP('2023-05-29 13:34:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206604
;

-- May 29, 2023, 1:34:28 PM CEST
UPDATE AD_Field SET SeqNo=90,Updated=TO_TIMESTAMP('2023-05-29 13:34:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=961
;

-- May 29, 2023, 1:35:34 PM CEST
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2023-05-29 13:35:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=2097
;

-- May 29, 2023, 1:35:36 PM CEST
ALTER TABLE AD_Attachment MODIFY Record_ID NUMBER(10) DEFAULT NULL 
;

-- May 29, 2023, 1:35:36 PM CEST
ALTER TABLE AD_Attachment MODIFY Record_ID NULL
;

-- May 29, 2023, 1:36:50 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201249,'38483bb0-dc89-4202-b098-e600bb71e448',TO_TIMESTAMP('2023-05-29 13:36:50','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ad_attachment_record_uu',TO_TIMESTAMP('2023-05-29 13:36:50','YYYY-MM-DD HH24:MI:SS'),100,254,'N','N','N','N')
;

-- May 29, 2023, 1:36:58 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201689,'caebdbe7-e600-49fa-82d6-fc9c952e3f07',TO_TIMESTAMP('2023-05-29 13:36:58','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-05-29 13:36:58','YYYY-MM-DD HH24:MI:SS'),100,215842,201249,10)
;

-- May 29, 2023, 1:37:02 PM CEST
CREATE INDEX ad_attachment_record_uu ON AD_Attachment (Record_UU)
;

-- May 29, 2023, 3:53:58 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,IsHtml,FKConstraintType) VALUES (215843,0,'Record UUID',876,'Record_UU',36,'N','N','N','N','N',0,'N',200240,0,0,'Y',TO_TIMESTAMP('2023-05-29 15:53:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-05-29 15:53:58','YYYY-MM-DD HH24:MI:SS'),100,203804,'N','N','D','N','N','N','Y','6ff5f5d7-73e0-40ad-b0fb-24c7fa905bed','Y','N','N','N','O')
;

-- May 29, 2023, 5:14:56 PM CEST
ALTER TABLE CM_Chat ADD Record_UU VARCHAR2(36 CHAR) DEFAULT NULL 
;

-- May 29, 2023, 5:14:31 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201250,'79030873-e8df-4b29-bb22-78f8cab89eab',TO_TIMESTAMP('2023-05-29 17:14:30','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','cm_chat_record_uu',TO_TIMESTAMP('2023-05-29 17:14:30','YYYY-MM-DD HH24:MI:SS'),100,876,'N','Y','N','N')
;

-- May 29, 2023, 5:14:36 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201690,'e1dd3f51-921e-44bb-bada-1f047a4b1629',TO_TIMESTAMP('2023-05-29 17:14:36','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-05-29 17:14:36','YYYY-MM-DD HH24:MI:SS'),100,215843,201250,10)
;

-- May 29, 2023, 5:15:06 PM CEST
CREATE UNIQUE INDEX cm_chat_record_uu ON CM_Chat (Record_UU)
;

-- May 29, 2023, 3:54:59 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207628,'Record UUID',821,215843,'Y',36,100,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-05-29 15:54:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-05-29 15:54:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d5e76de8-7b65-46c3-b168-192f78e30b29','Y',100,2)
;

-- May 29, 2023, 3:55:18 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=100, XPosition=4,Updated=TO_TIMESTAMP('2023-05-29 15:55:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207628
;

-- May 29, 2023, 3:55:18 PM CEST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2023-05-29 15:55:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204751
;

-- May 29, 2023, 3:56:02 PM CEST
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2023-05-29 15:56:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=15514
;

-- May 29, 2023, 3:56:04 PM CEST
ALTER TABLE CM_Chat MODIFY Record_ID NUMBER(10) DEFAULT NULL 
;

-- May 29, 2023, 3:56:04 PM CEST
ALTER TABLE CM_Chat MODIFY Record_ID NULL
;

-- May 29, 2023, 5:23:31 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215844,0,'Record UUID',200215,'Record_UU',36,'N','N','N','N','N',0,'N',200240,0,0,'Y',TO_TIMESTAMP('2023-05-29 17:23:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-05-29 17:23:31','YYYY-MM-DD HH24:MI:SS'),100,203804,'Y','N','D','Y','N','N','Y','a3fa71ca-eb2c-47eb-b388-d3da2a6989ee','Y',0,'N','N','M','N')
;

-- May 29, 2023, 5:23:33 PM CEST
ALTER TABLE AD_PostIt ADD Record_UU VARCHAR2(36 CHAR) DEFAULT NULL 
;

-- May 29, 2023, 5:23:52 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201251,'652cadb1-d5dc-4fa8-86d6-a8ff7718551c',TO_TIMESTAMP('2023-05-29 17:23:52','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_PostIt_Record_UU',TO_TIMESTAMP('2023-05-29 17:23:52','YYYY-MM-DD HH24:MI:SS'),100,200215,'N','Y','N','N','N')
;

-- May 29, 2023, 5:23:58 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201691,'797e1821-2972-47be-a881-bba8f3f993a6',TO_TIMESTAMP('2023-05-29 17:23:58','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-05-29 17:23:58','YYYY-MM-DD HH24:MI:SS'),100,215844,201251,10)
;

-- May 29, 2023, 5:24:01 PM CEST
CREATE UNIQUE INDEX AD_PostIt_Record_UU ON AD_PostIt (Record_UU)
;

-- May 29, 2023, 5:24:27 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (207629,'AD_PostIt_UU',200220,212933,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-05-29 17:24:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-05-29 17:24:26','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','514955cd-1967-403f-baf0-ef2f7ae05d37','N',2)
;

-- May 29, 2023, 5:24:27 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207630,'Record UUID',200220,215844,'Y',36,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-05-29 17:24:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-05-29 17:24:27','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','3f4dd6e1-1e7e-47a5-984e-a88c7f9ab349','Y',50,2)
;

-- May 29, 2023, 5:24:54 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=50, XPosition=4,Updated=TO_TIMESTAMP('2023-05-29 17:24:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207630
;

-- May 29, 2023, 5:24:54 PM CEST
UPDATE AD_Field SET SeqNo=60,Updated=TO_TIMESTAMP('2023-05-29 17:24:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204349
;

-- May 29, 2023, 5:24:54 PM CEST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2023-05-29 17:24:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207629
;

-- May 29, 2023, 5:26:00 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215845,0,'Record UUID',200347,'Record_UU',36,'N','N','N','N','N',0,'N',200240,0,0,'Y',TO_TIMESTAMP('2023-05-29 17:25:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-05-29 17:25:59','YYYY-MM-DD HH24:MI:SS'),100,203804,'N','N','D','N','N','N','Y','8a9d216d-4e90-4c52-aa15-f8beefcb7d84','Y',0,'N','N','M','N')
;

-- May 29, 2023, 5:26:02 PM CEST
ALTER TABLE AD_LabelAssignment ADD Record_UU VARCHAR2(36 CHAR) DEFAULT NULL 
;

-- May 29, 2023, 5:26:07 PM CEST
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2023-05-29 17:26:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214903
;

-- May 29, 2023, 5:26:09 PM CEST
ALTER TABLE AD_LabelAssignment MODIFY Record_ID NUMBER(10) DEFAULT NULL 
;

-- May 29, 2023, 5:26:09 PM CEST
ALTER TABLE AD_LabelAssignment MODIFY Record_ID NULL
;

-- May 29, 2023, 5:26:27 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201252,'7e1b1e58-f2e6-4b2d-be6d-7fcbce5da426',TO_TIMESTAMP('2023-05-29 17:26:26','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ad_labelassignment_record_uu',TO_TIMESTAMP('2023-05-29 17:26:26','YYYY-MM-DD HH24:MI:SS'),100,200347,'N','N','N','N','N')
;

-- May 29, 2023, 5:26:33 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201692,'daba3554-2805-465b-afd5-0ad29fe9bd79',TO_TIMESTAMP('2023-05-29 17:26:32','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-05-29 17:26:32','YYYY-MM-DD HH24:MI:SS'),100,215845,201252,10)
;

-- May 29, 2023, 5:26:36 PM CEST
CREATE INDEX ad_labelassignment_record_uu ON AD_LabelAssignment (Record_UU)
;

-- May 29, 2023, 7:20:16 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207631,'Record UUID',200324,215845,'Y',36,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-05-29 19:20:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-05-29 19:20:16','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','989dacd0-f98d-410f-a43a-6eb5ff27bea0','Y',80,2)
;

-- May 29, 2023, 7:20:28 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=80, XPosition=4,Updated=TO_TIMESTAMP('2023-05-29 19:20:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207631
;

-- May 29, 2023, 7:30:02 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', DisplayLogic='@Record_UU@!''''', SeqNo=70, XPosition=4,Updated=TO_TIMESTAMP('2023-05-29 19:30:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207631
;

-- May 29, 2023, 7:30:02 PM CEST
UPDATE AD_Field SET DisplayLogic='@Record_UU@=''''', SeqNo=80,Updated=TO_TIMESTAMP('2023-05-29 19:30:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207107
;

-- May 29, 2023, 7:33:52 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', DisplayLogic='@Record_UU@!''''', SeqNo=40, XPosition=4,Updated=TO_TIMESTAMP('2023-05-29 19:33:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207630
;

-- May 29, 2023, 7:33:52 PM CEST
UPDATE AD_Field SET DisplayLogic='@Record_UU@=''''', SeqNo=50,Updated=TO_TIMESTAMP('2023-05-29 19:33:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204348
;

-- May 29, 2023, 7:35:06 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', DisplayLogic='@Record_UU@!''''', SeqNo=80, XPosition=4,Updated=TO_TIMESTAMP('2023-05-29 19:35:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207628
;

-- May 29, 2023, 7:35:06 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', DisplayLogic='@Record_UU@=''''', SeqNo=100, XPosition=4,Updated=TO_TIMESTAMP('2023-05-29 19:35:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13396
;

-- May 29, 2023, 7:35:49 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', DisplayLogic='@Record_UU@!''''', SeqNo=40, XPosition=4,Updated=TO_TIMESTAMP('2023-05-29 19:35:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207627
;

-- May 29, 2023, 7:35:49 PM CEST
UPDATE AD_Field SET DisplayLogic='@Record_UU@=''''', SeqNo=50,Updated=TO_TIMESTAMP('2023-05-29 19:35:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=964
;

-- May 29, 2023, 7:37:52 PM CEST
UPDATE AD_Field SET DisplayLogic='@Record_UU@=''''', SeqNo=90,Updated=TO_TIMESTAMP('2023-05-29 19:37:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6781
;

-- May 29, 2023, 7:37:52 PM CEST
UPDATE AD_Field SET SeqNo=100,Updated=TO_TIMESTAMP('2023-05-29 19:37:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6779
;

-- May 29, 2023, 7:37:52 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', DisplayLogic='@Record_UU@!''''', SeqNo=110, XPosition=4,Updated=TO_TIMESTAMP('2023-05-29 19:37:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207619
;

-- May 29, 2023, 7:38:12 PM CEST
UPDATE AD_Field SET DisplayLogic='@Record_UU@=''''', SeqNo=90,Updated=TO_TIMESTAMP('2023-05-29 19:38:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6771
;

-- May 29, 2023, 7:38:12 PM CEST
UPDATE AD_Field SET SeqNo=100,Updated=TO_TIMESTAMP('2023-05-29 19:38:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6769
;

-- May 29, 2023, 7:38:12 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', DisplayLogic='@Record_UU@!''''', SeqNo=110, XPosition=4,Updated=TO_TIMESTAMP('2023-05-29 19:38:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207620
;

SET SERVEROUTPUT on;

-- Set Record_UU for existing records
DECLARE
  cmd varchar2(2000);
  v_cnt numeric;
BEGIN
  FOR r IN (
    SELECT DISTINCT t.TableName, at.AD_Table_ID
      FROM AD_Attachment at
	JOIN AD_Table t ON (at.AD_Table_ID=t.AD_Table_ID AND EXISTS (SELECT 1 FROM AD_Column WHERE ColumnName=t.TableName||'_ID'))
      WHERE at.Record_UU IS NULL AND at.Record_ID IS NOT NULL
  ) LOOP
    cmd := 'UPDATE AD_Attachment SET Record_UU=(SELECT ' || r.TableName || '_UU FROM ' || r.TableName
      || ' WHERE ' || r.TableName || '_ID=AD_Attachment.Record_ID) WHERE AD_Table_ID=' || r.AD_Table_ID
      || ' AND Record_ID IS NOT NULL AND Record_UU IS NULL';
    EXECUTE IMMEDIATE cmd;
    DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT || ' AD_Attachment.Record_UU set in ' || r.TableName);
  END LOOP;
  FOR r IN (
    SELECT DISTINCT t.TableName, ch.AD_Table_ID
      FROM CM_Chat ch
	JOIN AD_Table t ON (ch.AD_Table_ID=t.AD_Table_ID AND EXISTS (SELECT 1 FROM AD_Column WHERE ColumnName=t.TableName||'_ID'))
      WHERE ch.Record_UU IS NULL AND ch.Record_ID IS NOT NULL
  ) LOOP
    cmd := 'UPDATE CM_Chat SET Record_UU=(SELECT ' || r.TableName || '_UU FROM ' || r.TableName
      || ' WHERE ' || r.TableName || '_ID=CM_Chat.Record_ID) WHERE AD_Table_ID=' || r.AD_Table_ID
      || ' AND Record_ID IS NOT NULL AND Record_UU IS NULL';
    EXECUTE IMMEDIATE cmd;
    DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT || ' CM_Chat.Record_UU set in ' || r.TableName);
  END LOOP;
  FOR r IN (
    SELECT DISTINCT t.TableName, po.AD_Table_ID
      FROM AD_PostIt po
	JOIN AD_Table t ON (po.AD_Table_ID=t.AD_Table_ID AND EXISTS (SELECT 1 FROM AD_Column WHERE ColumnName=t.TableName||'_ID'))
      WHERE po.Record_UU IS NULL AND po.Record_ID IS NOT NULL
  ) LOOP
    cmd := 'UPDATE AD_PostIt SET Record_UU=(SELECT ' || r.TableName || '_UU FROM ' || r.TableName
      || ' WHERE ' || r.TableName || '_ID=AD_PostIt.Record_ID) WHERE AD_Table_ID=' || r.AD_Table_ID
      || ' AND Record_ID IS NOT NULL AND Record_UU IS NULL';
    EXECUTE IMMEDIATE cmd;
    DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT || ' AD_PostIt.Record_UU set in ' || r.TableName);
  END LOOP;
  FOR r IN (
    SELECT DISTINCT t.TableName, la.AD_Table_ID
      FROM AD_LabelAssignment la
	JOIN AD_Table t ON (la.AD_Table_ID=t.AD_Table_ID AND EXISTS (SELECT 1 FROM AD_Column WHERE ColumnName=t.TableName||'_ID'))
      WHERE la.Record_UU IS NULL AND la.Record_ID IS NOT NULL
  ) LOOP
    cmd := 'UPDATE AD_LabelAssignment SET Record_UU=(SELECT ' || r.TableName || '_UU FROM ' || r.TableName
      || ' WHERE ' || r.TableName || '_ID=AD_LabelAssignment.Record_ID) WHERE AD_Table_ID=' || r.AD_Table_ID
      || ' AND Record_ID IS NOT NULL AND Record_UU IS NULL';
    EXECUTE IMMEDIATE cmd;
    DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT || ' AD_LabelAssignment.Record_UU set in ' || r.TableName);
  END LOOP;
END;
/

