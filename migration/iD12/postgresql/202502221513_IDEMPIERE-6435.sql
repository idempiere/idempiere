-- IDEMPIERE-6435 Add Hide on Zero to Document Status (Activities)
SELECT register_migration_script('202502221513_IDEMPIERE-6435.sql') FROM dual;

-- Feb 22, 2025, 3:13:05 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203986,0,0,'Y',TO_TIMESTAMP('2025-02-22 15:11:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-02-22 15:11:53','YYYY-MM-DD HH24:MI:SS'),100,'IsHideWhenZero','Hide when Zero','Hide when the Value is Zero',NULL,'Hide when Zero','D','56378fad-1609-44fc-bc52-c006721856c3')
;

-- Feb 22, 2025, 3:13:19 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217043,0,'Hide when Zero','Hide when the Value is Zero',200216,'IsHideWhenZero','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2025-02-22 15:13:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-02-22 15:13:18','YYYY-MM-DD HH24:MI:SS'),100,203986,'Y','N','D','N','N','N','Y','de14ac95-0990-4d66-8bef-e5b33134e158','Y',0,'N','N','N','N')
;

-- Feb 22, 2025, 3:13:21 PM CET
ALTER TABLE PA_DocumentStatus ADD COLUMN IsHideWhenZero CHAR(1) DEFAULT 'N' CHECK (IsHideWhenZero IN ('Y','N')) NOT NULL
;

-- Feb 22, 2025, 3:19:46 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217044,0,'Category',200216,'Category',40,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2025-02-22 15:19:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-02-22 15:19:46','YYYY-MM-DD HH24:MI:SS'),100,52017,'Y','N','D','N','N','N','Y','cbe124d5-1d2f-48d9-a2ba-8030e0fded1b','Y',0,'N','N','N','N')
;

-- Feb 22, 2025, 3:19:48 PM CET
ALTER TABLE PA_DocumentStatus ADD COLUMN Category VARCHAR(40) DEFAULT NULL 
;

-- Feb 22, 2025, 3:21:47 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217045,0,'Comment/Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.',200216,'Help',4000,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_TIMESTAMP('2025-02-22 15:21:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-02-22 15:21:46','YYYY-MM-DD HH24:MI:SS'),100,326,'Y','N','D','N','N','N','Y','540f48bd-b92a-4e45-a794-cbb9c70f2395','Y',0,'N','N','N','N')
;

-- Feb 22, 2025, 3:21:49 PM CET
ALTER TABLE PA_DocumentStatus ADD COLUMN Help VARCHAR(4000) DEFAULT NULL 
;

-- Feb 22, 2025, 3:23:52 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217046,0,'Comment/Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.',200217,'Help',4000,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_TIMESTAMP('2025-02-22 15:23:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-02-22 15:23:51','YYYY-MM-DD HH24:MI:SS'),100,326,'Y','N','D','N','N','N','Y','0e9330d0-b2bd-4732-aadb-3050d40efa52','Y',0,'N','N','N','N')
;

-- Feb 22, 2025, 3:23:53 PM CET
ALTER TABLE PA_DocumentStatus_Trl ADD COLUMN Help VARCHAR(4000) DEFAULT NULL 
;

-- Feb 22, 2025, 3:24:02 PM CET
UPDATE AD_Column SET IsTranslated='Y',Updated=TO_TIMESTAMP('2025-02-22 15:24:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217045
;

-- Feb 22, 2025, 3:24:13 PM CET
UPDATE AD_Column SET AD_Reference_ID=10, FKConstraintType=NULL,Updated=TO_TIMESTAMP('2025-02-22 15:24:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217045
;

-- Feb 22, 2025, 3:24:26 PM CET
UPDATE AD_Column SET AD_Reference_ID=10, FKConstraintType=NULL,Updated=TO_TIMESTAMP('2025-02-22 15:24:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217046
;

-- Feb 22, 2025, 3:29:13 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203987,0,0,'Y',TO_TIMESTAMP('2025-02-22 15:29:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-02-22 15:29:13','YYYY-MM-DD HH24:MI:SS'),100,'Name_PrintColorZero_ID','Print Color for Name when Zero','Print Color for Name when Zero','D','4b8209a8-7e98-435c-b9b6-03f7879f83bc')
;

-- Feb 22, 2025, 3:29:30 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217047,0,'Print Color for Name when Zero',200216,'Name_PrintColorZero_ID',10,'N','N','N','N','N',0,'N',18,266,0,0,'Y',TO_TIMESTAMP('2025-02-22 15:29:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-02-22 15:29:30','YYYY-MM-DD HH24:MI:SS'),100,203987,'Y','Y','D','N','N','N','Y','1d40f9e0-7b9b-4d8e-8fd9-56385cb0bc88','Y',10,'N','N','N','N')
;

-- Feb 22, 2025, 3:30:25 PM CET
UPDATE AD_Column SET FKConstraintName='NamePrintColorZero_PADocumentStatus', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-02-22 15:30:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217047
;

-- Feb 22, 2025, 3:30:25 PM CET
ALTER TABLE PA_DocumentStatus ADD COLUMN Name_PrintColorZero_ID NUMERIC(10) DEFAULT NULL 
;

-- Feb 22, 2025, 3:30:25 PM CET
ALTER TABLE PA_DocumentStatus ADD CONSTRAINT NamePrintColorZero_PADocumentStatus FOREIGN KEY (Name_PrintColorZero_ID) REFERENCES ad_printcolor(ad_printcolor_id) DEFERRABLE INITIALLY DEFERRED
;

-- Feb 22, 2025, 3:30:54 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208705,'Comment/Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.',200222,217045,'Y',4000,190,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-02-22 15:30:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-02-22 15:30:53','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','fa399299-c61e-4830-820e-6015f39f33a4','Y',190,5)
;

-- Feb 22, 2025, 3:30:54 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208706,'Hide when Zero','Hide when the Value is Zero',200222,217043,'Y',1,200,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-02-22 15:30:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-02-22 15:30:54','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b4dbf3d2-bd77-4e52-96ea-669123b3cf72','Y',200,2,2)
;

-- Feb 22, 2025, 3:30:54 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208707,'Category',200222,217044,'Y',40,210,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-02-22 15:30:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-02-22 15:30:54','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6ab2b018-7273-49e9-8c2e-c8a2eda31228','Y',210,2)
;

-- Feb 22, 2025, 3:30:55 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208708,'Print Color for Name when Zero',200222,217047,'Y',10,220,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-02-22 15:30:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-02-22 15:30:54','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','40bad390-418c-4587-8076-3b5738c3d2df','Y',220,2)
;

-- Feb 22, 2025, 3:32:20 PM CET
UPDATE AD_Field SET SeqNo=70,Updated=TO_TIMESTAMP('2025-02-22 15:32:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204406
;

-- Feb 22, 2025, 3:32:20 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=80, XPosition=4,Updated=TO_TIMESTAMP('2025-02-22 15:32:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208707
;

-- Feb 22, 2025, 3:32:20 PM CET
UPDATE AD_Field SET SeqNo=90,Updated=TO_TIMESTAMP('2025-02-22 15:32:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204407
;

-- Feb 22, 2025, 3:32:20 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=100, XPosition=5,Updated=TO_TIMESTAMP('2025-02-22 15:32:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208706
;

-- Feb 22, 2025, 3:32:20 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=120, XPosition=4,Updated=TO_TIMESTAMP('2025-02-22 15:32:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204411
;

-- Feb 22, 2025, 3:32:20 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=130, XPosition=1,Updated=TO_TIMESTAMP('2025-02-22 15:32:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204408
;

-- Feb 22, 2025, 3:32:20 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=140, XPosition=4,Updated=TO_TIMESTAMP('2025-02-22 15:32:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208708
;

-- Feb 22, 2025, 3:32:20 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=150, XPosition=1,Updated=TO_TIMESTAMP('2025-02-22 15:32:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204410
;

-- Feb 22, 2025, 3:32:20 PM CET
UPDATE AD_Field SET SeqNo=160,Updated=TO_TIMESTAMP('2025-02-22 15:32:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204412
;

-- Feb 22, 2025, 3:32:20 PM CET
UPDATE AD_Field SET SeqNo=170,Updated=TO_TIMESTAMP('2025-02-22 15:32:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204413
;

-- Feb 22, 2025, 3:32:20 PM CET
UPDATE AD_Field SET SeqNo=180,Updated=TO_TIMESTAMP('2025-02-22 15:32:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204414
;

-- Feb 22, 2025, 3:32:20 PM CET
UPDATE AD_Field SET SeqNo=190,Updated=TO_TIMESTAMP('2025-02-22 15:32:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204415
;

-- Feb 22, 2025, 3:32:20 PM CET
UPDATE AD_Field SET SeqNo=200, NumLines=3,Updated=TO_TIMESTAMP('2025-02-22 15:32:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208705
;

-- Feb 22, 2025, 3:32:20 PM CET
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2025-02-22 15:32:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204404
;

-- Feb 22, 2025, 3:32:20 PM CET
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2025-02-22 15:32:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204405
;

-- Feb 22, 2025, 3:32:28 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208709,'Comment/Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.',200223,217046,'Y',4000,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-02-22 15:32:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-02-22 15:32:28','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','adba1215-4ceb-467b-aa11-f00ac8f9e210','Y',100,5)
;

-- Feb 22, 2025, 3:32:41 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=70, XPosition=1, NumLines=3,Updated=TO_TIMESTAMP('2025-02-22 15:32:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208709
;

-- Feb 22, 2025, 3:32:41 PM CET
UPDATE AD_Field SET SeqNo=80,Updated=TO_TIMESTAMP('2025-02-22 15:32:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204423
;

-- Feb 22, 2025, 3:32:41 PM CET
UPDATE AD_Field SET SeqNo=90,Updated=TO_TIMESTAMP('2025-02-22 15:32:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204424
;

-- Feb 23, 2025, 1:10:51 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=70, XPosition=4,Updated=TO_TIMESTAMP('2025-02-23 13:10:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208707
;

-- Feb 23, 2025, 1:10:51 PM CET
UPDATE AD_Field SET SeqNo=80,Updated=TO_TIMESTAMP('2025-02-23 13:10:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204406
;

-- Feb 23, 2025, 1:45:39 PM CET
UPDATE AD_Field SET SeqNo=100, ColumnSpan=1,Updated=TO_TIMESTAMP('2025-02-23 13:45:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208706
;

-- Feb 23, 2025, 1:45:39 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=140, XPosition=4,Updated=TO_TIMESTAMP('2025-02-23 13:45:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204410
;

-- Feb 23, 2025, 1:45:39 PM CET
UPDATE AD_Field SET IsDisplayed='Y', DisplayLogic='@IsHideWhenZero@=N', SeqNo=150, XPosition=1,Updated=TO_TIMESTAMP('2025-02-23 13:45:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208708
;

