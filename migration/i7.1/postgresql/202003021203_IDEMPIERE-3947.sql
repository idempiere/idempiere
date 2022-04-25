-- IDEMPIERE-3947 Fixed Asset bugs and enhancements
-- Feb 11, 2020, 11:36:17 AM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214180,0,'ISO Currency Code','Three letter ISO 4217 Code of the Currency','For details - http://www.unece.org/trade/rec/rec09en.htm',53277,'ISO_Code',3,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2020-02-11 11:36:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-02-11 11:36:15','YYYY-MM-DD HH24:MI:SS'),100,328,'Y','N','D','N','N','N','Y','d3b4c038-fcfd-4276-bee8-b879cc870806','Y',0,'N','N','N')
;

-- Feb 11, 2020, 11:36:26 AM SGT
ALTER TABLE I_FixedAsset ADD COLUMN ISO_Code VARCHAR(3) DEFAULT NULL 
;

-- Feb 11, 2020, 11:37:03 AM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214181,0,'Currency','The Currency for this record','Indicates the Currency to be used when processing or reporting on this record',53277,'C_Currency_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2020-02-11 11:37:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-02-11 11:37:02','YYYY-MM-DD HH24:MI:SS'),100,193,'Y','N','D','N','N','N','Y','e7596989-7e4c-43f8-9e55-f20866d5c12d','Y',0,'N','N','N','N')
;

-- Feb 11, 2020, 11:40:00 AM SGT
UPDATE AD_Column SET FKConstraintName='CCurrency_IFixedAsset', FKConstraintType='N',Updated=TO_TIMESTAMP('2020-02-11 11:40:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214181
;

-- Feb 11, 2020, 11:40:00 AM SGT
ALTER TABLE I_FixedAsset ADD COLUMN C_Currency_ID NUMERIC(10) DEFAULT NULL 
;

-- Feb 11, 2020, 11:40:00 AM SGT
ALTER TABLE I_FixedAsset ADD CONSTRAINT CCurrency_IFixedAsset FOREIGN KEY (C_Currency_ID) REFERENCES c_currency(c_currency_id) DEFERRABLE INITIALLY DEFERRED
;

-- Feb 11, 2020, 11:40:46 AM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214182,0,'Entered Amount',53277,'AssetAmtEntered','0',10,'N','N','N','N','N',0,'N',12,0,0,'Y',TO_TIMESTAMP('2020-02-11 11:40:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-02-11 11:40:45','YYYY-MM-DD HH24:MI:SS'),100,54207,'Y','N','D','N','N','N','Y','bc12181f-f685-46fe-9c76-b2468ad29e9b','Y',0,'N','N','N')
;

-- Feb 11, 2020, 11:40:51 AM SGT
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2020-02-11 11:40:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214182
;

-- Feb 11, 2020, 11:40:57 AM SGT
ALTER TABLE I_FixedAsset ADD COLUMN AssetAmtEntered NUMERIC DEFAULT '0' NOT NULL
;

-- Feb 11, 2020, 11:41:51 AM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214183,0,'Source Amount',53277,'AssetSourceAmt','0',22,'N','N','Y','N','N',0,'N',12,0,0,'Y',TO_TIMESTAMP('2020-02-11 11:41:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-02-11 11:41:50','YYYY-MM-DD HH24:MI:SS'),100,54202,'Y','N','D','N','N','N','Y','43286a53-e708-431f-978e-1b7a25ec3841','Y',0,'N','N','N')
;

-- Feb 11, 2020, 11:42:15 AM SGT
ALTER TABLE I_FixedAsset ADD COLUMN AssetSourceAmt NUMERIC DEFAULT '0' NOT NULL
;

-- Feb 11, 2020, 11:42:52 AM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214184,0,'Account Schema Name','Name of the Accounting Schema',53277,'AcctSchemaName',120,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2020-02-11 11:42:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-02-11 11:42:51','YYYY-MM-DD HH24:MI:SS'),100,2084,'Y','Y','D','N','N','N','Y','63f665c5-5085-4c7e-9f2c-b5ae163de16e','Y',10,'N','N','N')
;

-- Feb 11, 2020, 11:42:58 AM SGT
ALTER TABLE I_FixedAsset ADD COLUMN AcctSchemaName VARCHAR(120) DEFAULT NULL 
;

-- Feb 11, 2020, 11:43:45 AM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214185,0,'Accounting Schema','Rules for accounting','An Accounting Schema defines the rules used in accounting such as costing method, currency and calendar',53277,'C_AcctSchema_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2020-02-11 11:43:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-02-11 11:43:45','YYYY-MM-DD HH24:MI:SS'),100,181,'N','N','D','N','N','N','Y','bf429587-d193-4190-a32d-8503ce63c2d3','Y',0,'N','N','C','N')
;

-- Feb 11, 2020, 11:43:51 AM SGT
UPDATE AD_Column SET FKConstraintName='CAcctSchema_IFixedAsset', FKConstraintType='C',Updated=TO_TIMESTAMP('2020-02-11 11:43:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214185
;

-- Feb 11, 2020, 11:43:51 AM SGT
ALTER TABLE I_FixedAsset ADD COLUMN C_AcctSchema_ID NUMERIC(10) DEFAULT NULL 
;

-- Feb 11, 2020, 11:43:51 AM SGT
ALTER TABLE I_FixedAsset ADD CONSTRAINT CAcctSchema_IFixedAsset FOREIGN KEY (C_AcctSchema_ID) REFERENCES c_acctschema(c_acctschema_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Feb 11, 2020, 11:44:43 AM SGT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206390,'ISO Currency Code','Three letter ISO 4217 Code of the Currency','For details - http://www.unece.org/trade/rec/rec09en.htm',53334,214180,'Y',3,310,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-02-11 11:44:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-02-11 11:44:42','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7236b757-b73a-450a-9c85-98a8ab08389d','Y',310,2)
;

-- Feb 11, 2020, 11:44:44 AM SGT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206391,'Currency','The Currency for this record','Indicates the Currency to be used when processing or reporting on this record',53334,214181,'Y',22,320,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-02-11 11:44:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-02-11 11:44:43','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','11bdfc71-4d1f-4d31-9b3a-b88d75406bd8','Y',320,2)
;

-- Feb 11, 2020, 11:44:45 AM SGT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206392,'Entered Amount',53334,214182,'Y',10,330,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-02-11 11:44:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-02-11 11:44:45','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','bfe5930e-9348-4b2a-9087-a4d0461d3fc2','Y',330,2)
;

-- Feb 11, 2020, 11:44:46 AM SGT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206393,'Source Amount',53334,214183,'Y',22,340,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-02-11 11:44:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-02-11 11:44:45','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e2b58b61-b516-4f16-b282-f861cc3248bb','Y',340,2)
;

-- Feb 11, 2020, 11:44:47 AM SGT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206394,'Account Schema Name','Name of the Accounting Schema',53334,214184,'Y',120,350,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-02-11 11:44:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-02-11 11:44:47','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','3e4eaad8-098f-418d-a9be-3deb18a4e00b','Y',350,5)
;

-- Feb 11, 2020, 11:44:48 AM SGT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206395,'Accounting Schema','Rules for accounting','An Accounting Schema defines the rules used in accounting such as costing method, currency and calendar',53334,214185,'Y',22,360,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-02-11 11:44:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-02-11 11:44:47','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','0adfa648-05b8-415f-a655-3ca44584dfc9','Y',360,2)
;

-- Feb 11, 2020, 11:46:29 AM SGT
UPDATE AD_Field SET SeqNo=320, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-02-11 11:46:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206391
;

-- Feb 11, 2020, 11:46:29 AM SGT
UPDATE AD_Field SET SeqNo=340, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-02-11 11:46:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206393
;

-- Feb 11, 2020, 11:46:30 AM SGT
UPDATE AD_Field SET SeqNo=350, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-02-11 11:46:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206394
;

-- Feb 11, 2020, 11:46:30 AM SGT
UPDATE AD_Field SET SeqNo=360, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-02-11 11:46:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206395
;

-- Feb 11, 2020, 11:47:44 AM SGT
UPDATE AD_Field SET SeqNo=290,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=206390
;

-- Feb 11, 2020, 11:47:44 AM SGT
UPDATE AD_Field SET SeqNo=300,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=206391
;

-- Feb 11, 2020, 11:47:44 AM SGT
UPDATE AD_Field SET SeqNo=310,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=206392
;

-- Feb 11, 2020, 11:47:44 AM SGT
UPDATE AD_Field SET SeqNo=320,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=206393
;

-- Feb 11, 2020, 11:47:44 AM SGT
UPDATE AD_Field SET SeqNo=330,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=206394
;

-- Feb 11, 2020, 11:47:44 AM SGT
UPDATE AD_Field SET SeqNo=340,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=206395
;

-- Feb 11, 2020, 11:47:45 AM SGT
UPDATE AD_Field SET SeqNo=350,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59489
;

-- Feb 11, 2020, 11:47:45 AM SGT
UPDATE AD_Field SET SeqNo=360,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59499
;

-- Feb 11, 2020, 11:47:58 AM SGT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59485
;

-- Feb 11, 2020, 11:47:58 AM SGT
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59498
;

-- Feb 11, 2020, 11:47:59 AM SGT
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59474
;

-- Feb 11, 2020, 11:47:59 AM SGT
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59494
;

-- Feb 11, 2020, 11:47:59 AM SGT
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59497
;

-- Feb 11, 2020, 11:47:59 AM SGT
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59493
;

-- Feb 11, 2020, 11:47:59 AM SGT
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59470
;

-- Feb 11, 2020, 11:47:59 AM SGT
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59478
;

-- Feb 11, 2020, 11:47:59 AM SGT
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59479
;

-- Feb 11, 2020, 11:47:59 AM SGT
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59481
;

-- Feb 11, 2020, 11:48:00 AM SGT
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59482
;

-- Feb 11, 2020, 11:48:00 AM SGT
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59501
;

-- Feb 11, 2020, 11:48:00 AM SGT
UPDATE AD_Field SET SeqNoGrid=140,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59502
;

-- Feb 11, 2020, 11:48:00 AM SGT
UPDATE AD_Field SET SeqNoGrid=150,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59488
;

-- Feb 11, 2020, 11:48:00 AM SGT
UPDATE AD_Field SET SeqNoGrid=160,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59507
;

-- Feb 11, 2020, 11:48:00 AM SGT
UPDATE AD_Field SET SeqNoGrid=170,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59506
;

-- Feb 11, 2020, 11:48:00 AM SGT
UPDATE AD_Field SET SeqNoGrid=180,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59495
;

-- Feb 11, 2020, 11:48:00 AM SGT
UPDATE AD_Field SET SeqNoGrid=190,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59496
;

-- Feb 11, 2020, 11:48:00 AM SGT
UPDATE AD_Field SET SeqNoGrid=200,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59503
;

-- Feb 11, 2020, 11:48:00 AM SGT
UPDATE AD_Field SET SeqNoGrid=210,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59476
;

-- Feb 11, 2020, 11:48:01 AM SGT
UPDATE AD_Field SET SeqNoGrid=220,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=200161
;

-- Feb 11, 2020, 11:48:01 AM SGT
UPDATE AD_Field SET SeqNoGrid=230,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59508
;

-- Feb 11, 2020, 11:48:01 AM SGT
UPDATE AD_Field SET SeqNoGrid=240,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59509
;

-- Feb 11, 2020, 11:48:01 AM SGT
UPDATE AD_Field SET SeqNoGrid=250,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59486
;

-- Feb 11, 2020, 11:48:01 AM SGT
UPDATE AD_Field SET SeqNoGrid=260,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59471
;

-- Feb 11, 2020, 11:48:01 AM SGT
UPDATE AD_Field SET SeqNoGrid=270,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59472
;

-- Feb 11, 2020, 11:48:01 AM SGT
UPDATE AD_Field SET SeqNoGrid=280,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=206390
;

-- Feb 11, 2020, 11:48:01 AM SGT
UPDATE AD_Field SET SeqNoGrid=290,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=206391
;

-- Feb 11, 2020, 11:48:02 AM SGT
UPDATE AD_Field SET SeqNoGrid=300,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=206392
;

-- Feb 11, 2020, 11:48:02 AM SGT
UPDATE AD_Field SET SeqNoGrid=310,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=206393
;

-- Feb 11, 2020, 11:48:02 AM SGT
UPDATE AD_Field SET SeqNoGrid=320,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=206394
;

-- Feb 11, 2020, 11:48:02 AM SGT
UPDATE AD_Field SET SeqNoGrid=330,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=206395
;

-- Feb 11, 2020, 11:48:02 AM SGT
UPDATE AD_Field SET SeqNoGrid=340,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59489
;

-- Feb 11, 2020, 11:48:02 AM SGT
UPDATE AD_Field SET SeqNoGrid=350,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59499
;

-- Feb 11, 2020, 12:00:51 PM SGT
UPDATE AD_Field SET SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-02-11 12:00:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59494
;

-- Feb 11, 2020, 12:00:51 PM SGT
UPDATE AD_Field SET SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-02-11 12:00:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59479
;

-- Feb 11, 2020, 12:00:52 PM SGT
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-02-11 12:00:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59482
;

-- Feb 11, 2020, 12:00:52 PM SGT
UPDATE AD_Field SET SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-02-11 12:00:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59502
;

-- Feb 11, 2020, 12:00:52 PM SGT
UPDATE AD_Field SET SeqNo=200, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-02-11 12:00:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59496
;

-- Feb 27, 2020, 2:40:01 PM SGT
UPDATE AD_Field SET SeqNo=290, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-02-27 14:40:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206391
;

-- Feb 27, 2020, 2:40:01 PM SGT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=300, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-02-27 14:40:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206390
;

-- Feb 27, 2020, 2:40:02 PM SGT
UPDATE AD_Field SET SeqNo=330, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-02-27 14:40:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206395
;

-- Feb 27, 2020, 2:40:02 PM SGT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=340, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-02-27 14:40:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206394
;

-- Feb 27, 2020, 2:40:43 PM SGT
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, SeqNoGrid=280, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-02-27 14:40:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206391
;

-- Feb 27, 2020, 2:40:48 PM SGT
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, SeqNoGrid=290, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-02-27 14:40:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206390
;

-- Feb 27, 2020, 2:40:59 PM SGT
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, SeqNoGrid=320, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-02-27 14:40:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206395
;

-- Feb 27, 2020, 2:41:05 PM SGT
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, SeqNoGrid=330, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-02-27 14:41:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206394
;

-- Feb 27, 2020, 2:48:27 PM SGT
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, MandatoryLogic='@C_Currency_ID@=0 & @ISO_Code@=''''', IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-02-27 14:48:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206391
;

-- Feb 27, 2020, 2:54:44 PM SGT
UPDATE AD_Field SET IsMandatory='Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-02-27 14:54:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59508
;

-- Feb 27, 2020, 2:55:03 PM SGT
UPDATE AD_Field SET IsMandatory='Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-02-27 14:55:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59471
;

-- Feb 27, 2020, 3:09:22 PM SGT
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59477
;

-- Feb 27, 2020, 3:09:22 PM SGT
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59478
;

-- Feb 27, 2020, 3:09:23 PM SGT
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59479
;

-- Feb 27, 2020, 3:09:23 PM SGT
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59481
;

-- Feb 27, 2020, 3:09:23 PM SGT
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59482
;

-- Feb 27, 2020, 3:09:23 PM SGT
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59501
;

-- Feb 27, 2020, 3:09:23 PM SGT
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59502
;

-- Feb 27, 2020, 3:09:23 PM SGT
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59488
;

-- Feb 27, 2020, 3:09:23 PM SGT
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59507
;

-- Feb 27, 2020, 3:09:24 PM SGT
UPDATE AD_Field SET SeqNo=190,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59506
;

-- Feb 27, 2020, 3:09:24 PM SGT
UPDATE AD_Field SET SeqNo=200,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59495
;

-- Feb 27, 2020, 3:09:24 PM SGT
UPDATE AD_Field SET SeqNo=210,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59496
;

-- Feb 27, 2020, 3:09:24 PM SGT
UPDATE AD_Field SET SeqNo=220,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59503
;

-- Feb 27, 2020, 3:09:24 PM SGT
UPDATE AD_Field SET SeqNo=230,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59476
;

-- Feb 27, 2020, 3:09:24 PM SGT
UPDATE AD_Field SET SeqNo=240,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=200161
;

-- Feb 27, 2020, 3:09:24 PM SGT
UPDATE AD_Field SET SeqNo=250,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59508
;

-- Feb 27, 2020, 3:09:25 PM SGT
UPDATE AD_Field SET SeqNo=260,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59509
;

-- Feb 27, 2020, 3:09:25 PM SGT
UPDATE AD_Field SET SeqNo=270,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59486
;

-- Feb 27, 2020, 3:09:25 PM SGT
UPDATE AD_Field SET SeqNo=280,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59471
;

-- Feb 27, 2020, 3:09:25 PM SGT
UPDATE AD_Field SET SeqNo=290,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59472
;

-- Feb 27, 2020, 3:09:25 PM SGT
UPDATE AD_Field SET SeqNo=300,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=206391
;

-- Feb 27, 2020, 3:09:25 PM SGT
UPDATE AD_Field SET SeqNo=310,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=206390
;

-- Feb 27, 2020, 3:09:26 PM SGT
UPDATE AD_Field SET SeqNo=320,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=206392
;

-- Feb 27, 2020, 3:09:26 PM SGT
UPDATE AD_Field SET SeqNo=330,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=206393
;

-- Feb 27, 2020, 3:09:26 PM SGT
UPDATE AD_Field SET SeqNo=340,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=206395
;

-- Feb 27, 2020, 3:09:26 PM SGT
UPDATE AD_Field SET SeqNo=350,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=206394
;

-- Feb 27, 2020, 3:09:26 PM SGT
UPDATE AD_Field SET SeqNo=360,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59489
;

-- Feb 27, 2020, 3:09:26 PM SGT
UPDATE AD_Field SET SeqNo=370,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59499
;

-- Feb 27, 2020, 3:09:39 PM SGT
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59477
;

-- Feb 27, 2020, 3:09:39 PM SGT
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59478
;

-- Feb 27, 2020, 3:09:39 PM SGT
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59479
;

-- Feb 27, 2020, 3:09:39 PM SGT
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59481
;

-- Feb 27, 2020, 3:09:40 PM SGT
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59482
;

-- Feb 27, 2020, 3:09:40 PM SGT
UPDATE AD_Field SET SeqNoGrid=140,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59501
;

-- Feb 27, 2020, 3:09:40 PM SGT
UPDATE AD_Field SET SeqNoGrid=150,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59502
;

-- Feb 27, 2020, 3:09:40 PM SGT
UPDATE AD_Field SET SeqNoGrid=160,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59488
;

-- Feb 27, 2020, 3:09:40 PM SGT
UPDATE AD_Field SET SeqNoGrid=170,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59507
;

-- Feb 27, 2020, 3:09:40 PM SGT
UPDATE AD_Field SET SeqNoGrid=180,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59506
;

-- Feb 27, 2020, 3:09:41 PM SGT
UPDATE AD_Field SET SeqNoGrid=190,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59495
;

-- Feb 27, 2020, 3:09:41 PM SGT
UPDATE AD_Field SET SeqNoGrid=200,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59496
;

-- Feb 27, 2020, 3:09:41 PM SGT
UPDATE AD_Field SET SeqNoGrid=210,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59503
;

-- Feb 27, 2020, 3:09:41 PM SGT
UPDATE AD_Field SET SeqNoGrid=220,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59476
;

-- Feb 27, 2020, 3:09:41 PM SGT
UPDATE AD_Field SET SeqNoGrid=230,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=200161
;

-- Feb 27, 2020, 3:09:41 PM SGT
UPDATE AD_Field SET SeqNoGrid=240,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59508
;

-- Feb 27, 2020, 3:09:41 PM SGT
UPDATE AD_Field SET SeqNoGrid=250,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59509
;

-- Feb 27, 2020, 3:09:42 PM SGT
UPDATE AD_Field SET SeqNoGrid=260,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59486
;

-- Feb 27, 2020, 3:09:42 PM SGT
UPDATE AD_Field SET SeqNoGrid=270,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59471
;

-- Feb 27, 2020, 3:09:42 PM SGT
UPDATE AD_Field SET SeqNoGrid=280,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59472
;

-- Feb 27, 2020, 3:09:42 PM SGT
UPDATE AD_Field SET SeqNoGrid=290,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=206391
;

-- Feb 27, 2020, 3:09:42 PM SGT
UPDATE AD_Field SET SeqNoGrid=300,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=206390
;

-- Feb 27, 2020, 3:09:42 PM SGT
UPDATE AD_Field SET SeqNoGrid=310,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=206392
;

-- Feb 27, 2020, 3:09:42 PM SGT
UPDATE AD_Field SET SeqNoGrid=320,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=206393
;

-- Feb 27, 2020, 3:09:42 PM SGT
UPDATE AD_Field SET SeqNoGrid=330,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=206395
;

-- Feb 27, 2020, 3:09:43 PM SGT
UPDATE AD_Field SET SeqNoGrid=340,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=206394
;

-- Feb 27, 2020, 3:09:43 PM SGT
UPDATE AD_Field SET SeqNoGrid=350,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59489
;

-- Feb 27, 2020, 3:09:43 PM SGT
UPDATE AD_Field SET SeqNoGrid=360,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=59499
;

-- Feb 27, 2020, 3:10:13 PM SGT
UPDATE AD_Field SET SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-02-27 15:10:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59477
;

-- Feb 27, 2020, 3:15:38 PM SGT
UPDATE AD_Field SET IsMandatory='Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-02-27 15:15:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59477
;

-- Feb 17, 2020, 5:43:36 PM SGT
UPDATE AD_Field SET IsMandatory='Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-02-17 17:43:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59493
;

-- Feb 17, 2020, 5:51:40 PM SGT
UPDATE AD_Column SET IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2020-02-17 17:51:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=59521
;

-- Feb 17, 2020, 5:55:28 PM SGT
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ReadOnlyLogic='@Processed@=''Y''', IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-02-17 17:55:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59489
;

-- Feb 17, 2020, 6:15:27 PM SGT
UPDATE AD_Column SET IsUpdateable='Y',Updated=TO_TIMESTAMP('2020-02-17 18:15:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214185
;

SELECT register_migration_script('202003021203_IDEMPIERE-3947.sql') FROM dual
;