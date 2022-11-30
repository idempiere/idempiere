-- IDEMPIERE-5505
SELECT register_migration_script('202211301123_IDEMPIERE-5505.sql') FROM dual;

-- Nov 30, 2022, 11:23:47 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215691,0,'Search Key','Search key for the record in the format required - must be unique','A search key allows you a fast method of finding a particular record.
If you leave the search key empty, the system automatically creates a numeric number.  The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).',218,'Value',40,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2022-11-30 11:23:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-11-30 11:23:46','YYYY-MM-DD HH24:MI:SS'),100,620,'Y','N','D','N','N','N','Y','2b2fcbf5-873f-410e-b648-723c7096715a','Y',0,'N','N','N')
;

-- Nov 30, 2022, 11:24:00 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215692,0,'Print Text','The label text to be printed on a document or correspondence.','The Label to be printed indicates the name that will be printed on a document or correspondence. The max length is 2000 characters.',218,'PrintName',60,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2022-11-30 11:24:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-11-30 11:24:00','YYYY-MM-DD HH24:MI:SS'),100,958,'Y','N','D','N','N','N','Y','3bd98094-fdd7-41a8-bb6e-ae799a3b0183','Y',0,'N','N','N')
;

-- Nov 30, 2022, 11:24:05 AM CET
ALTER TABLE GL_Category ADD COLUMN Value VARCHAR(40) DEFAULT NULL 
;

-- Nov 30, 2022, 11:24:05 AM CET
ALTER TABLE GL_Category ADD COLUMN PrintName VARCHAR(60) DEFAULT NULL 
;

-- Nov 30, 2022, 11:24:12 AM CET
UPDATE AD_Column SET IsTranslated='Y',Updated=TO_TIMESTAMP('2022-11-30 11:24:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215692
;

-- Nov 30, 2022, 11:24:32 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215693,0,'Print Text','The label text to be printed on a document or correspondence.','The Label to be printed indicates the name that will be printed on a document or correspondence. The max length is 2000 characters.',200111,'PrintName',60,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2022-11-30 11:24:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-11-30 11:24:31','YYYY-MM-DD HH24:MI:SS'),100,958,'Y','N','D','N','N','N','Y','48025922-02ce-44e3-bee6-c85df92bb043','Y',0,'N','N','N')
;

-- Nov 30, 2022, 11:24:36 AM CET
ALTER TABLE GL_Category_Trl ADD COLUMN PrintName VARCHAR(60) DEFAULT NULL 
;

-- Nov 30, 2022, 11:24:44 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207452,'Search Key','Search key for the record in the format required - must be unique','A search key allows you a fast method of finding a particular record.
If you leave the search key empty, the system automatically creates a numeric number.  The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).',158,215691,'Y',40,100,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-11-30 11:24:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-11-30 11:24:44','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8f22ff1f-d45f-4758-94c9-7bff1a0a8f99','Y',100,2)
;

-- Nov 30, 2022, 11:24:44 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207453,'Print Text','The label text to be printed on a document or correspondence.','The Label to be printed indicates the name that will be printed on a document or correspondence. The max length is 2000 characters.',158,215692,'Y',60,110,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-11-30 11:24:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-11-30 11:24:44','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8c75288e-4e19-4856-9ff5-9ef02912cddc','Y',110,5)
;

-- Nov 30, 2022, 11:24:54 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207454,'Print Text','The label text to be printed on a document or correspondence.','The Label to be printed indicates the name that will be printed on a document or correspondence. The max length is 2000 characters.',200121,215693,'Y',60,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-11-30 11:24:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-11-30 11:24:54','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','1c05ecb5-fe6d-41ae-8d5e-f9fb95e31e3e','Y',10,5)
;

-- Nov 30, 2022, 11:25:11 AM CET
UPDATE AD_Field SET SeqNo=10,Updated=TO_TIMESTAMP('2022-11-30 11:25:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=674
;

-- Nov 30, 2022, 11:25:11 AM CET
UPDATE AD_Field SET SeqNo=20,Updated=TO_TIMESTAMP('2022-11-30 11:25:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2030
;

-- Nov 30, 2022, 11:25:11 AM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=30, XPosition=1,Updated=TO_TIMESTAMP('2022-11-30 11:25:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207452
;

-- Nov 30, 2022, 11:25:11 AM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=50, XPosition=1,Updated=TO_TIMESTAMP('2022-11-30 11:25:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207453
;

-- Nov 30, 2022, 11:25:11 AM CET
UPDATE AD_Field SET SeqNo=60,Updated=TO_TIMESTAMP('2022-11-30 11:25:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=677
;

-- Nov 30, 2022, 11:25:11 AM CET
UPDATE AD_Field SET SeqNo=70,Updated=TO_TIMESTAMP('2022-11-30 11:25:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=675
;

-- Nov 30, 2022, 11:25:11 AM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=80, XPosition=5,Updated=TO_TIMESTAMP('2022-11-30 11:25:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5140
;

-- Nov 30, 2022, 11:25:11 AM CET
UPDATE AD_Field SET SeqNo=90,Updated=TO_TIMESTAMP('2022-11-30 11:25:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3664
;

-- Nov 30, 2022, 11:25:11 AM CET
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2022-11-30 11:25:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=673
;

-- Nov 30, 2022, 11:25:11 AM CET
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2022-11-30 11:25:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204839
;

