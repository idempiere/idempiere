-- IDEMPIERE-6841 - Add Fields to Select Document Types to improve the Bank Transfer Window
SELECT register_migration_script('202603031007_IDEMPIERE-6841.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Mar 3, 2026, 10:07:19 AM BRT
UPDATE AD_SysConfig SET Value='muriloht',Updated=TO_TIMESTAMP('2026-03-03 10:07:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_SysConfig_ID=50001
;

-- Mar 3, 2026, 10:07:31 AM BRT
UPDATE AD_SysConfig SET Value='ugEnsG3r',Updated=TO_TIMESTAMP('2026-03-03 10:07:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_SysConfig_ID=50002
;

-- Mar 3, 2026, 10:10:29 AM BRT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (204034,0,0,'Y',TO_TIMESTAMP('2026-03-03 10:10:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-03 10:10:28','YYYY-MM-DD HH24:MI:SS'),100,'From_DocType_ID','From Document Type','From Document Type','D','019cb3d2-4a2c-7cf2-933b-ade7ec489114')
;

-- Mar 3, 2026, 10:10:53 AM BRT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (204035,0,0,'Y',TO_TIMESTAMP('2026-03-03 10:10:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-03 10:10:53','YYYY-MM-DD HH24:MI:SS'),100,'To_DocType_ID','To Document Type','To Document Type','D','019cb3d2-a8f0-7641-b0b2-7738ad8da2d0')
;

-- Mar 3, 2026, 10:19:37 AM BRT
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200207,'C_DocType Payments','S','C_DocType.DocBaseType IN (''APP'')  AND C_DocType.AD_Client_ID=@#AD_Client_ID@',0,0,'Y',TO_TIMESTAMP('2026-03-03 10:19:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-03 10:19:37','YYYY-MM-DD HH24:MI:SS'),100,'D','019cb3da-a98b-7c45-a7a5-3653430dc92b')
;

-- Mar 3, 2026, 10:21:09 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,AD_Val_Rule_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217385,0,'From Document Type',200246,200207,'From_DocType_ID',22,'N','N','N','N','N',0,'N',30,0,0,'Y',TO_TIMESTAMP('2026-03-03 10:21:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-03 10:21:09','YYYY-MM-DD HH24:MI:SS'),100,204034,'Y','N','D','N','N','N','Y','019cb3dc-1079-70d2-98f0-4f8006464445','Y',0,'N','N','N','N')
;

-- Mar 3, 2026, 10:22:35 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,AD_Val_Rule_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217386,0,'To Document Type',200246,200038,'To_DocType_ID',22,'N','N','N','N','N',0,'N',30,0,0,'Y',TO_TIMESTAMP('2026-03-03 10:22:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-03 10:22:35','YYYY-MM-DD HH24:MI:SS'),100,204035,'Y','N','D','N','N','N','Y','019cb3dd-5f10-7186-b4b7-a960967b25eb','Y',0,'N','N','N','N')
;

-- Mar 3, 2026, 10:22:45 AM BRT
ALTER TABLE C_BankTransfer ADD From_DocType_ID NUMBER(10) DEFAULT NULL 
;

-- Mar 3, 2026, 10:22:45 AM BRT
ALTER TABLE C_BankTransfer ADD To_DocType_ID NUMBER(10) DEFAULT NULL 
;

-- Mar 3, 2026, 10:24:59 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209010,'From Document Type',200255,217385,'Y',22,270,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-03-03 10:24:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-03 10:24:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019cb3df-936b-704b-abb3-b7f1730d7e38','Y',270,2)
;

-- Mar 3, 2026, 10:25:00 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209011,'To Document Type',200255,217386,'Y',22,280,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-03-03 10:24:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-03 10:24:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019cb3df-94c6-7543-9f0a-9b33c221ed19','Y',280,2)
;

-- Mar 3, 2026, 10:25:34 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=140, XPosition=1,Updated=TO_TIMESTAMP('2026-03-03 10:25:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209010
;

-- Mar 3, 2026, 10:25:34 AM BRT
UPDATE AD_Field SET SeqNo=150,Updated=TO_TIMESTAMP('2026-03-03 10:25:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205698
;

-- Mar 3, 2026, 10:25:34 AM BRT
UPDATE AD_Field SET SeqNo=160,Updated=TO_TIMESTAMP('2026-03-03 10:25:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205699
;

-- Mar 3, 2026, 10:25:34 AM BRT
UPDATE AD_Field SET SeqNo=170,Updated=TO_TIMESTAMP('2026-03-03 10:25:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205705
;

-- Mar 3, 2026, 10:25:34 AM BRT
UPDATE AD_Field SET SeqNo=180,Updated=TO_TIMESTAMP('2026-03-03 10:25:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205700
;

-- Mar 3, 2026, 10:25:34 AM BRT
UPDATE AD_Field SET SeqNo=190,Updated=TO_TIMESTAMP('2026-03-03 10:25:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205701
;

-- Mar 3, 2026, 10:25:34 AM BRT
UPDATE AD_Field SET SeqNo=200,Updated=TO_TIMESTAMP('2026-03-03 10:25:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206946
;

-- Mar 3, 2026, 10:25:34 AM BRT
UPDATE AD_Field SET SeqNo=210,Updated=TO_TIMESTAMP('2026-03-03 10:25:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206948
;

-- Mar 3, 2026, 10:25:34 AM BRT
UPDATE AD_Field SET SeqNo=220,Updated=TO_TIMESTAMP('2026-03-03 10:25:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205703
;

-- Mar 3, 2026, 10:25:34 AM BRT
UPDATE AD_Field SET SeqNo=230,Updated=TO_TIMESTAMP('2026-03-03 10:25:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205702
;

-- Mar 3, 2026, 10:25:34 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=240, XPosition=1,Updated=TO_TIMESTAMP('2026-03-03 10:25:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205811
;

-- Mar 3, 2026, 10:25:34 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=250, XPosition=1,Updated=TO_TIMESTAMP('2026-03-03 10:25:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209011
;

-- Mar 3, 2026, 10:25:34 AM BRT
UPDATE AD_Field SET SeqNo=260,Updated=TO_TIMESTAMP('2026-03-03 10:25:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205686
;

-- Mar 3, 2026, 10:25:34 AM BRT
UPDATE AD_Field SET SeqNo=270,Updated=TO_TIMESTAMP('2026-03-03 10:25:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205685
;

-- Mar 3, 2026, 10:25:34 AM BRT
UPDATE AD_Field SET SeqNo=280,Updated=TO_TIMESTAMP('2026-03-03 10:25:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205690
;

-- Mar 3, 2026, 10:33:51 AM BRT
UPDATE AD_Column SET AD_Reference_Value_ID=170,Updated=TO_TIMESTAMP('2026-03-03 10:33:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217385
;

-- Mar 3, 2026, 10:34:02 AM BRT
UPDATE AD_Column SET AD_Reference_Value_ID=170,Updated=TO_TIMESTAMP('2026-03-03 10:34:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217386
;

-- Mar 3, 2026, 10:34:07 AM BRT
UPDATE AD_Column SET FKConstraintName='FromDocType_CBankTransfer', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-03-03 10:34:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217385
;

-- Mar 3, 2026, 10:34:07 AM BRT
ALTER TABLE C_BankTransfer MODIFY From_DocType_ID NUMBER(10) DEFAULT NULL 
;

-- Mar 3, 2026, 10:34:07 AM BRT
ALTER TABLE C_BankTransfer ADD CONSTRAINT FromDocType_CBankTransfer FOREIGN KEY (From_DocType_ID) REFERENCES c_doctype(c_doctype_id) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 3, 2026, 10:34:07 AM BRT
UPDATE AD_Column SET FKConstraintName='ToDocType_CBankTransfer', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-03-03 10:34:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217386
;

-- Mar 3, 2026, 10:34:07 AM BRT
ALTER TABLE C_BankTransfer MODIFY To_DocType_ID NUMBER(10) DEFAULT NULL 
;

-- Mar 3, 2026, 10:34:07 AM BRT
ALTER TABLE C_BankTransfer ADD CONSTRAINT ToDocType_CBankTransfer FOREIGN KEY (To_DocType_ID) REFERENCES c_doctype(c_doctype_id) DEFERRABLE INITIALLY DEFERRED
;

