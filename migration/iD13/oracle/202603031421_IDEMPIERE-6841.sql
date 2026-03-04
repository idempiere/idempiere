-- IDEMPIERE-6841 Add Fields to Select Document Types to improve the Bank Transfer Window
SELECT register_migration_script('202603031421_IDEMPIERE-6841.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Mar 3, 2026, 2:21:50 PM BRT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (204036,0,0,'Y',TO_TIMESTAMP('2026-03-03 14:21:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-03 14:21:50','YYYY-MM-DD HH24:MI:SS'),100,'From_DocType_ID','From Document Type','From Document Type','D','019cb4b8-6a94-7d7c-8fcb-aad068d131c6')
;

-- Mar 3, 2026, 2:22:10 PM BRT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (204037,0,0,'Y',TO_TIMESTAMP('2026-03-03 14:22:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-03 14:22:10','YYYY-MM-DD HH24:MI:SS'),100,'To_DocType_ID','To Document Type','To Document Type','D','019cb4b8-b8f3-7cb2-95b8-7fab872f300c')
;

-- Mar 3, 2026, 2:23:49 PM BRT
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200208,'C_DocType Payments','S','C_DocType.DocBaseType IN (''APP'')  AND C_DocType.AD_Client_ID=@#AD_Client_ID@',0,0,'Y',TO_TIMESTAMP('2026-03-03 14:23:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-03 14:23:49','YYYY-MM-DD HH24:MI:SS'),100,'D','019cb4ba-39f9-7fdc-834a-0965c4aea3ad')
;

-- Mar 3, 2026, 2:24:02 PM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,AD_Val_Rule_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217387,0,'From Document Type',200246,200208,'From_DocType_ID',22,'N','N','N','N','N',0,'N',30,170,0,0,'Y',TO_TIMESTAMP('2026-03-03 14:24:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-03 14:24:01','YYYY-MM-DD HH24:MI:SS'),100,204036,'Y','N','D','N','N','N','Y','019cb4ba-6c17-7ec6-95e2-cb06baf5bff3','Y',0,'N','N','N','N')
;

-- Mar 3, 2026, 2:24:38 PM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,AD_Val_Rule_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217388,0,'To Document Type',200246,200038,'To_DocType_ID',22,'N','N','N','N','N',0,'N',30,170,0,0,'Y',TO_TIMESTAMP('2026-03-03 14:24:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-03 14:24:38','YYYY-MM-DD HH24:MI:SS'),100,204037,'Y','N','D','N','N','N','Y','019cb4ba-f99e-7004-8053-b28a8c4cd3a3','Y',0,'N','N','N','N')
;

-- Mar 3, 2026, 2:25:26 PM BRT
UPDATE AD_Column SET FKConstraintName='FromDocType_CBankTransfer', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-03-03 14:25:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217387
;

-- Mar 3, 2026, 2:25:26 PM BRT
ALTER TABLE C_BankTransfer ADD From_DocType_ID NUMBER(10) DEFAULT NULL 
;

-- Mar 3, 2026, 2:25:26 PM BRT
ALTER TABLE C_BankTransfer ADD CONSTRAINT FromDocType_CBankTransfer FOREIGN KEY (From_DocType_ID) REFERENCES c_doctype(c_doctype_id) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 3, 2026, 2:25:27 PM BRT
UPDATE AD_Column SET FKConstraintName='ToDocType_CBankTransfer', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-03-03 14:25:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217388
;

-- Mar 3, 2026, 2:25:27 PM BRT
ALTER TABLE C_BankTransfer ADD To_DocType_ID NUMBER(10) DEFAULT NULL 
;

-- Mar 3, 2026, 2:25:27 PM BRT
ALTER TABLE C_BankTransfer ADD CONSTRAINT ToDocType_CBankTransfer FOREIGN KEY (To_DocType_ID) REFERENCES c_doctype(c_doctype_id) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 3, 2026, 2:25:43 PM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209012,'From Document Type',200255,217387,'Y',22,270,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-03-03 14:25:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-03 14:25:43','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019cb4bb-f8df-778c-9f6f-7e184c358638','Y',270,2)
;

-- Mar 3, 2026, 2:25:44 PM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209013,'To Document Type',200255,217388,'Y',22,280,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-03-03 14:25:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-03 14:25:43','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019cb4bb-fa4d-75e5-aaf1-c54f89f11f38','Y',280,2)
;

-- Mar 3, 2026, 2:26:06 PM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=140, XPosition=1,Updated=TO_TIMESTAMP('2026-03-03 14:26:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209012
;

-- Mar 3, 2026, 2:26:06 PM BRT
UPDATE AD_Field SET SeqNo=150,Updated=TO_TIMESTAMP('2026-03-03 14:26:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205698
;

-- Mar 3, 2026, 2:26:06 PM BRT
UPDATE AD_Field SET SeqNo=160,Updated=TO_TIMESTAMP('2026-03-03 14:26:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205699
;

-- Mar 3, 2026, 2:26:06 PM BRT
UPDATE AD_Field SET SeqNo=170,Updated=TO_TIMESTAMP('2026-03-03 14:26:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205705
;

-- Mar 3, 2026, 2:26:06 PM BRT
UPDATE AD_Field SET SeqNo=180,Updated=TO_TIMESTAMP('2026-03-03 14:26:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205700
;

-- Mar 3, 2026, 2:26:06 PM BRT
UPDATE AD_Field SET SeqNo=190,Updated=TO_TIMESTAMP('2026-03-03 14:26:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205701
;

-- Mar 3, 2026, 2:26:06 PM BRT
UPDATE AD_Field SET SeqNo=200,Updated=TO_TIMESTAMP('2026-03-03 14:26:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206946
;

-- Mar 3, 2026, 2:26:06 PM BRT
UPDATE AD_Field SET SeqNo=210,Updated=TO_TIMESTAMP('2026-03-03 14:26:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206948
;

-- Mar 3, 2026, 2:26:06 PM BRT
UPDATE AD_Field SET SeqNo=220,Updated=TO_TIMESTAMP('2026-03-03 14:26:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205703
;

-- Mar 3, 2026, 2:26:06 PM BRT
UPDATE AD_Field SET SeqNo=230,Updated=TO_TIMESTAMP('2026-03-03 14:26:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205702
;

-- Mar 3, 2026, 2:26:06 PM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=240, XPosition=1,Updated=TO_TIMESTAMP('2026-03-03 14:26:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205811
;

-- Mar 3, 2026, 2:26:06 PM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=250, XPosition=1,Updated=TO_TIMESTAMP('2026-03-03 14:26:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209013
;

-- Mar 3, 2026, 2:26:06 PM BRT
UPDATE AD_Field SET SeqNo=260,Updated=TO_TIMESTAMP('2026-03-03 14:26:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205686
;

-- Mar 3, 2026, 2:26:06 PM BRT
UPDATE AD_Field SET SeqNo=270,Updated=TO_TIMESTAMP('2026-03-03 14:26:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205685
;

-- Mar 3, 2026, 2:26:06 PM BRT
UPDATE AD_Field SET SeqNo=280,Updated=TO_TIMESTAMP('2026-03-03 14:26:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205690
;

