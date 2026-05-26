-- IDEMPIERE-7018
-- https://idempiere.atlassian.net/browse/IDEMPIERE-7018
SELECT register_migration_script('202605261044_IDEMPIERE-7018.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- May 26, 2026, 10:44:02 AM BRT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (204101,0,0,'Y',TO_TIMESTAMP('2026-05-26 10:44:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-05-26 10:44:01','YYYY-MM-DD HH24:MI:SS'),100,'To_User1_ID','To User Element List 1','To User Element List 1','D','019e6487-30e7-7fcb-b546-6132b57c8e10')
;

-- May 26, 2026, 10:44:11 AM BRT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (204102,0,0,'Y',TO_TIMESTAMP('2026-05-26 10:44:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-05-26 10:44:11','YYYY-MM-DD HH24:MI:SS'),100,'To_User2_ID','To User Element List 2','To User Element List 2','D','019e6487-577b-7dbd-9d3e-4ef0bbd71517')
;

-- May 26, 2026, 10:44:26 AM BRT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (204103,0,0,'Y',TO_TIMESTAMP('2026-05-26 10:44:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-05-26 10:44:26','YYYY-MM-DD HH24:MI:SS'),100,'From_User2_ID','From User Element List 2','From User Element List 2','D','019e6487-90e4-741b-85cd-260af6386e1b')
;

-- May 26, 2026, 10:44:36 AM BRT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (204104,0,0,'Y',TO_TIMESTAMP('2026-05-26 10:44:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-05-26 10:44:36','YYYY-MM-DD HH24:MI:SS'),100,'From_User1_ID','From User Element List 1','From User Element List 1','D','019e6487-b86b-757c-bebd-d9915d5c29b5')
;

-- May 26, 2026, 10:46:31 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217577,0,'To User Element List 1',200246,'To_User1_ID',22,'N','N','N','N','N',0,'N',30,134,0,0,'Y',TO_TIMESTAMP('2026-05-26 10:46:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-05-26 10:46:30','YYYY-MM-DD HH24:MI:SS'),100,204101,'Y','N','D','N','N','N','Y','019e6489-77f8-779b-8f44-45c83eaf7707','Y',0,'N','N','N','N')
;

-- May 26, 2026, 10:46:45 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217578,0,'To User Element List 2',200246,'To_User2_ID',22,'N','N','N','N','N',0,'N',30,137,0,0,'Y',TO_TIMESTAMP('2026-05-26 10:46:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-05-26 10:46:45','YYYY-MM-DD HH24:MI:SS'),100,204102,'Y','N','D','N','N','N','Y','019e6489-b0b1-7d79-8b8f-af773c1bc778','Y',0,'N','N','N','N')
;

-- May 26, 2026, 10:47:04 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217579,0,'From User Element List 2',200246,'From_User2_ID',22,'N','N','N','N','N',0,'N',30,137,0,0,'Y',TO_TIMESTAMP('2026-05-26 10:47:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-05-26 10:47:03','YYYY-MM-DD HH24:MI:SS'),100,204103,'Y','N','D','N','N','N','Y','019e6489-f84c-7939-a2fd-a45b100872d6','Y',0,'N','N','N','N')
;

-- May 26, 2026, 10:47:41 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217580,0,'From User Element List 1',200246,'From_User1_ID',22,'N','N','N','N','N',0,'N',30,134,0,0,'Y',TO_TIMESTAMP('2026-05-26 10:47:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-05-26 10:47:40','YYYY-MM-DD HH24:MI:SS'),100,204104,'Y','N','D','N','N','N','Y','019e648a-88e1-7958-a9e4-9fb4ebe8fb39','Y',0,'N','N','N','N')
;

-- May 26, 2026, 10:48:14 AM BRT
UPDATE AD_Column SET FKConstraintName='FromUser1_CBankTransfer', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-05-26 10:48:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217580
;

-- May 26, 2026, 10:48:14 AM BRT
ALTER TABLE C_BankTransfer ADD From_User1_ID NUMBER(10) DEFAULT NULL 
;

-- May 26, 2026, 10:48:14 AM BRT
ALTER TABLE C_BankTransfer ADD CONSTRAINT FromUser1_CBankTransfer FOREIGN KEY (From_User1_ID) REFERENCES c_elementvalue(c_elementvalue_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 26, 2026, 12:20:03 PM BRT
UPDATE AD_Column SET FKConstraintName='ToUser1_CBankTransfer', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-05-26 12:20:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217577
;

-- May 26, 2026, 12:20:03 PM BRT
ALTER TABLE C_BankTransfer ADD To_User1_ID NUMBER(10) DEFAULT NULL 
;

-- May 26, 2026, 12:20:03 PM BRT
ALTER TABLE C_BankTransfer ADD CONSTRAINT ToUser1_CBankTransfer FOREIGN KEY (To_User1_ID) REFERENCES c_elementvalue(c_elementvalue_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 26, 2026, 12:20:03 PM BRT
UPDATE AD_Column SET FKConstraintName='ToUser2_CBankTransfer', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-05-26 12:20:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217578
;

-- May 26, 2026, 12:20:03 PM BRT
ALTER TABLE C_BankTransfer ADD To_User2_ID NUMBER(10) DEFAULT NULL 
;

-- May 26, 2026, 12:20:03 PM BRT
ALTER TABLE C_BankTransfer ADD CONSTRAINT ToUser2_CBankTransfer FOREIGN KEY (To_User2_ID) REFERENCES c_elementvalue(c_elementvalue_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 26, 2026, 12:20:03 PM BRT
UPDATE AD_Column SET FKConstraintName='FromUser2_CBankTransfer', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-05-26 12:20:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217579
;

-- May 26, 2026, 12:20:03 PM BRT
ALTER TABLE C_BankTransfer ADD From_User2_ID NUMBER(10) DEFAULT NULL 
;

-- May 26, 2026, 12:20:03 PM BRT
ALTER TABLE C_BankTransfer ADD CONSTRAINT FromUser2_CBankTransfer FOREIGN KEY (From_User2_ID) REFERENCES c_elementvalue(c_elementvalue_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 26, 2026, 12:20:03 PM BRT
ALTER TABLE C_BankTransfer MODIFY From_User1_ID NUMBER(10) DEFAULT NULL 
;

-- May 26, 2026, 10:48:54 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209183,'To User Element List 1',200255,217577,'Y',22,270,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-05-26 10:48:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-05-26 10:48:53','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019e648b-a644-77ae-83be-27b59c43f055','Y',270,2)
;

-- May 26, 2026, 10:48:54 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209184,'To User Element List 2',200255,217578,'Y',22,280,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-05-26 10:48:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-05-26 10:48:54','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019e648b-a7c9-7078-b793-8c0a351c7bf1','Y',280,2)
;

-- May 26, 2026, 10:48:54 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209185,'From User Element List 2',200255,217579,'Y',22,290,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-05-26 10:48:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-05-26 10:48:54','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019e648b-a91b-7848-956d-ae5b571737f4','Y',290,2)
;

-- May 26, 2026, 10:48:55 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209186,'From User Element List 1',200255,217580,'Y',22,300,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-05-26 10:48:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-05-26 10:48:54','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019e648b-aa69-7c57-9b54-a476774caf2c','Y',300,2)
;

-- May 26, 2026, 10:49:24 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=80, XPosition=4,Updated=TO_TIMESTAMP('2026-05-26 10:49:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209186
;

-- May 26, 2026, 10:49:24 AM BRT
UPDATE AD_Field SET SeqNo=90,Updated=TO_TIMESTAMP('2026-05-26 10:49:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205694
;

-- May 26, 2026, 10:49:24 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=100, XPosition=4,Updated=TO_TIMESTAMP('2026-05-26 10:49:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209185
;

-- May 26, 2026, 10:49:24 AM BRT
UPDATE AD_Field SET SeqNo=110,Updated=TO_TIMESTAMP('2026-05-26 10:49:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205817
;

-- May 26, 2026, 10:49:24 AM BRT
UPDATE AD_Field SET SeqNo=120,Updated=TO_TIMESTAMP('2026-05-26 10:49:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205695
;

-- May 26, 2026, 10:49:25 AM BRT
UPDATE AD_Field SET SeqNo=130,Updated=TO_TIMESTAMP('2026-05-26 10:49:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205696
;

-- May 26, 2026, 10:49:25 AM BRT
UPDATE AD_Field SET SeqNo=140,Updated=TO_TIMESTAMP('2026-05-26 10:49:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205697
;

-- May 26, 2026, 10:49:25 AM BRT
UPDATE AD_Field SET SeqNo=150,Updated=TO_TIMESTAMP('2026-05-26 10:49:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205810
;

-- May 26, 2026, 10:49:25 AM BRT
UPDATE AD_Field SET SeqNo=160,Updated=TO_TIMESTAMP('2026-05-26 10:49:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205698
;

-- May 26, 2026, 10:49:25 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=170, XPosition=4,Updated=TO_TIMESTAMP('2026-05-26 10:49:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209183
;

-- May 26, 2026, 10:49:25 AM BRT
UPDATE AD_Field SET SeqNo=180,Updated=TO_TIMESTAMP('2026-05-26 10:49:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205699
;

-- May 26, 2026, 10:49:25 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=190, XPosition=4,Updated=TO_TIMESTAMP('2026-05-26 10:49:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209184
;

-- May 26, 2026, 10:49:25 AM BRT
UPDATE AD_Field SET SeqNo=200,Updated=TO_TIMESTAMP('2026-05-26 10:49:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205705
;

-- May 26, 2026, 10:49:25 AM BRT
UPDATE AD_Field SET SeqNo=210,Updated=TO_TIMESTAMP('2026-05-26 10:49:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205700
;

-- May 26, 2026, 10:49:25 AM BRT
UPDATE AD_Field SET SeqNo=220,Updated=TO_TIMESTAMP('2026-05-26 10:49:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205701
;

-- May 26, 2026, 10:49:25 AM BRT
UPDATE AD_Field SET SeqNo=230,Updated=TO_TIMESTAMP('2026-05-26 10:49:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206946
;

-- May 26, 2026, 10:49:25 AM BRT
UPDATE AD_Field SET SeqNo=240,Updated=TO_TIMESTAMP('2026-05-26 10:49:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206948
;

-- May 26, 2026, 10:49:25 AM BRT
UPDATE AD_Field SET SeqNo=250,Updated=TO_TIMESTAMP('2026-05-26 10:49:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205703
;

-- May 26, 2026, 10:49:25 AM BRT
UPDATE AD_Field SET SeqNo=260,Updated=TO_TIMESTAMP('2026-05-26 10:49:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205702
;

-- May 26, 2026, 10:49:25 AM BRT
UPDATE AD_Field SET SeqNo=270,Updated=TO_TIMESTAMP('2026-05-26 10:49:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205811
;

-- May 26, 2026, 10:49:25 AM BRT
UPDATE AD_Field SET SeqNo=280,Updated=TO_TIMESTAMP('2026-05-26 10:49:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205686
;

-- May 26, 2026, 10:49:25 AM BRT
UPDATE AD_Field SET SeqNo=290,Updated=TO_TIMESTAMP('2026-05-26 10:49:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205685
;

-- May 26, 2026, 10:49:25 AM BRT
UPDATE AD_Field SET SeqNo=300,Updated=TO_TIMESTAMP('2026-05-26 10:49:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205690
;

