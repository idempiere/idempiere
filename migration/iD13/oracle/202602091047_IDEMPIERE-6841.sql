-- IDEMPIERE-6841 - Add Fields to Select Document Types to improve the Bank Transfer Window
SELECT register_migration_script('202602091047_IDEMPIERE-6841.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Feb 9, 2026, 10:47:31 AM BRT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (nextidfunc(188,'N'),0,0,'Y',TO_TIMESTAMP('2026-02-09 10:47:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-02-09 10:47:30','YYYY-MM-DD HH24:MI:SS'),100,'From_DocType_ID','From Document Type','From Document Type','D','019c42a8-4928-7216-b726-b2352ce1d1cd')
;

-- Feb 9, 2026, 10:47:44 AM BRT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (nextidfunc(188,'N'),0,0,'Y',TO_TIMESTAMP('2026-02-09 10:47:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-02-09 10:47:44','YYYY-MM-DD HH24:MI:SS'),100,'To_DocType_ID','To Document Type','To Document Type','D','019c42a8-7c36-7c5c-ac10-f7c4a51f52cd')
;

-- Feb 9, 2026, 10:53:52 AM BRT
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (nextidfunc(26,'N'),'C_DocType Payments','S','C_DocType.DocBaseType IN (''APP'')  AND C_DocType.AD_Client_ID=@#AD_Client_ID@',0,0,'Y',TO_TIMESTAMP('2026-02-09 10:53:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-02-09 10:53:52','YYYY-MM-DD HH24:MI:SS'),100,'D','019c42ae-1b41-7225-a925-b498b628ab86')
;

-- Feb 9, 2026, 10:54:58 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,AD_Val_Rule_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (nextidfunc(3,'N'),0,'From Document Type',200246,toRecordId('AD_Val_Rule','019c42ae-1b41-7225-a925-b498b628ab86'),'From_DocType_ID',22,'N','N','Y','N','N',0,'N',30,170,0,0,'Y',TO_TIMESTAMP('2026-02-09 10:54:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-02-09 10:54:58','YYYY-MM-DD HH24:MI:SS'),100,toRecordId('AD_Element','019c42a8-4928-7216-b726-b2352ce1d1cd'),'Y','N','D','N','N','N','Y','019c42af-1c74-76d5-ba06-4ff66f53c244','Y',0,'N','N','N','N')
;

-- Feb 9, 2026, 10:55:24 AM BRT
UPDATE AD_Column SET FKConstraintName='FromDocType_CBankTransfer', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-02-09 10:55:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_UU='019c42af-1c74-76d5-ba06-4ff66f53c244'
;

-- Feb 9, 2026, 10:55:24 AM BRT
ALTER TABLE C_BankTransfer ADD From_DocType_ID NUMBER(10) NOT NULL
;

-- Feb 9, 2026, 10:55:24 AM BRT
ALTER TABLE C_BankTransfer ADD CONSTRAINT FromDocType_CBankTransfer FOREIGN KEY (From_DocType_ID) REFERENCES c_doctype(c_doctype_id) DEFERRABLE INITIALLY DEFERRED
;

-- Feb 9, 2026, 10:56:21 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,AD_Val_Rule_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (nextidfunc(3,'N'),0,'To Document Type',200246,200038,'To_DocType_ID',22,'N','N','Y','N','N',0,'N',30,170,0,0,'Y',TO_TIMESTAMP('2026-02-09 10:56:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-02-09 10:56:21','YYYY-MM-DD HH24:MI:SS'),100,toRecordId('AD_Element','019c42a8-7c36-7c5c-ac10-f7c4a51f52cd'),'Y','N','D','N','N','N','Y','019c42b0-61a6-7bdd-bca1-c11370894204','Y',0,'N','N','N','N')
;

-- Feb 9, 2026, 10:56:43 AM BRT
UPDATE AD_Column SET FKConstraintName='ToDocType_CBankTransfer', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-02-09 10:56:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_UU='019c42b0-61a6-7bdd-bca1-c11370894204'
;

-- Feb 9, 2026, 10:56:43 AM BRT
ALTER TABLE C_BankTransfer ADD To_DocType_ID NUMBER(10) NOT NULL
;

-- Feb 9, 2026, 10:56:43 AM BRT
ALTER TABLE C_BankTransfer ADD CONSTRAINT ToDocType_CBankTransfer FOREIGN KEY (To_DocType_ID) REFERENCES c_doctype(c_doctype_id) DEFERRABLE INITIALLY DEFERRED
;

-- Feb 9, 2026, 10:58:24 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (nextidfunc(4,'N'),'From Document Type',200255,toRecordId('AD_Column','019c42af-1c74-76d5-ba06-4ff66f53c244'),'Y',22,270,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-02-09 10:58:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-02-09 10:58:24','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019c42b2-4106-72fe-a6ad-5f25c00da636','Y',270,2)
;

-- Feb 9, 2026, 10:58:24 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (nextidfunc(4,'N'),'To Document Type',200255,toRecordId('AD_Column','019c42b0-61a6-7bdd-bca1-c11370894204'),'Y',22,280,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-02-09 10:58:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-02-09 10:58:24','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019c42b2-41d4-7c59-b266-472990769e5d','Y',280,2)
;

-- Feb 9, 2026, 10:59:01 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=140, AD_FieldGroup_ID=200024, XPosition=1,Updated=TO_TIMESTAMP('2026-02-09 10:59:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_UU='019c42b2-4106-72fe-a6ad-5f25c00da636'
;

-- Feb 9, 2026, 10:59:01 AM BRT
UPDATE AD_Field SET SeqNo=150,Updated=TO_TIMESTAMP('2026-02-09 10:59:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205698
;

-- Feb 9, 2026, 10:59:01 AM BRT
UPDATE AD_Field SET SeqNo=160,Updated=TO_TIMESTAMP('2026-02-09 10:59:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205699
;

-- Feb 9, 2026, 10:59:01 AM BRT
UPDATE AD_Field SET SeqNo=170,Updated=TO_TIMESTAMP('2026-02-09 10:59:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205705
;

-- Feb 9, 2026, 10:59:01 AM BRT
UPDATE AD_Field SET SeqNo=180,Updated=TO_TIMESTAMP('2026-02-09 10:59:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205700
;

-- Feb 9, 2026, 10:59:01 AM BRT
UPDATE AD_Field SET SeqNo=190,Updated=TO_TIMESTAMP('2026-02-09 10:59:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205701
;

-- Feb 9, 2026, 10:59:01 AM BRT
UPDATE AD_Field SET SeqNo=200,Updated=TO_TIMESTAMP('2026-02-09 10:59:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206946
;

-- Feb 9, 2026, 10:59:01 AM BRT
UPDATE AD_Field SET SeqNo=210,Updated=TO_TIMESTAMP('2026-02-09 10:59:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206948
;

-- Feb 9, 2026, 10:59:01 AM BRT
UPDATE AD_Field SET SeqNo=220,Updated=TO_TIMESTAMP('2026-02-09 10:59:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205703
;

-- Feb 9, 2026, 10:59:01 AM BRT
UPDATE AD_Field SET SeqNo=230,Updated=TO_TIMESTAMP('2026-02-09 10:59:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205702
;

-- Feb 9, 2026, 10:59:01 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=240, XPosition=1,Updated=TO_TIMESTAMP('2026-02-09 10:59:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205811
;

-- Feb 9, 2026, 10:59:01 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=250, AD_FieldGroup_ID=200025, XPosition=1,Updated=TO_TIMESTAMP('2026-02-09 10:59:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_UU='019c42b2-41d4-7c59-b266-472990769e5d'
;

-- Feb 9, 2026, 10:59:01 AM BRT
UPDATE AD_Field SET SeqNo=260,Updated=TO_TIMESTAMP('2026-02-09 10:59:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205686
;

-- Feb 9, 2026, 10:59:01 AM BRT
UPDATE AD_Field SET SeqNo=270,Updated=TO_TIMESTAMP('2026-02-09 10:59:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205685
;

-- Feb 9, 2026, 10:59:01 AM BRT
UPDATE AD_Field SET SeqNo=280,Updated=TO_TIMESTAMP('2026-02-09 10:59:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205690
;

-- Feb 9, 2026, 2:03:39 PM BRT
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2026-02-09 14:03:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_UU='019c42af-1c74-76d5-ba06-4ff66f53c244'
;

-- Feb 9, 2026, 2:03:44 PM BRT
ALTER TABLE C_BankTransfer MODIFY From_DocType_ID NUMBER(10) DEFAULT NULL 
;

-- Feb 9, 2026, 2:03:44 PM BRT
ALTER TABLE C_BankTransfer MODIFY From_DocType_ID NULL
;

-- Feb 9, 2026, 2:04:15 PM BRT
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2026-02-09 14:04:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_UU='019c42b0-61a6-7bdd-bca1-c11370894204'
;

-- Feb 9, 2026, 2:04:20 PM BRT
ALTER TABLE C_BankTransfer MODIFY To_DocType_ID NUMBER(10) DEFAULT NULL 
;

-- Feb 9, 2026, 2:04:20 PM BRT
ALTER TABLE C_BankTransfer MODIFY To_DocType_ID NULL
;

-- Feb 9, 2026, 2:05:21 PM BRT
UPDATE AD_Field SET SeqNo=140, MandatoryLogic='1=1',Updated=TO_TIMESTAMP('2026-02-09 14:05:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_UU='019c42b2-4106-72fe-a6ad-5f25c00da636'
;

-- Feb 9, 2026, 2:05:21 PM BRT
UPDATE AD_Field SET SeqNo=250, MandatoryLogic='1=1',Updated=TO_TIMESTAMP('2026-02-09 14:05:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_UU='019c42b2-41d4-7c59-b266-472990769e5d'
;

