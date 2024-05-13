-- IDEMPIERE-5943 Implement table partitioning support
SELECT register_migration_script('202312201102_IDEMPIERE-5943.sql') FROM dual;

-- Dec 20, 2023, 11:02:30 AM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216305,0,'Column','Column in the table','Link to the database column of the table',200411,100,'AD_Column_ID',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2023-12-20 11:02:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-20 11:02:29','YYYY-MM-DD HH24:MI:SS'),100,104,'N','N','D','N','N','N','N','384ead93-7ceb-4a86-80ea-f584db5b78e3','N',0,'N','N','N','N','N')
;

-- Dec 20, 2023, 11:02:35 AM MYT
UPDATE AD_Column SET FKConstraintName='ADColumn_ADTablePartition', FKConstraintType='N',Updated=TO_TIMESTAMP('2023-12-20 11:02:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216305
;

-- Dec 20, 2023, 11:02:35 AM MYT
ALTER TABLE AD_TablePartition ADD COLUMN AD_Column_ID NUMERIC(10) NOT NULL
;

-- Dec 20, 2023, 11:02:35 AM MYT
ALTER TABLE AD_TablePartition ADD CONSTRAINT ADColumn_ADTablePartition FOREIGN KEY (AD_Column_ID) REFERENCES ad_column(ad_column_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 20, 2023, 11:04:55 AM MYT
UPDATE AD_Field SET SeqNo=70, SeqNoGrid=50,Updated=TO_TIMESTAMP('2023-12-20 11:04:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208091
;

-- Dec 20, 2023, 11:05:01 AM MYT
UPDATE AD_Field SET SeqNo=60, SeqNoGrid=40,Updated=TO_TIMESTAMP('2023-12-20 11:05:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208090
;

-- Dec 20, 2023, 11:05:13 AM MYT
UPDATE AD_Field SET SeqNo=50, SeqNoGrid=30,Updated=TO_TIMESTAMP('2023-12-20 11:05:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208087
;

-- Dec 20, 2023, 11:05:55 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208095,'Column','Column in the table','Link to the database column of the table',200381,216305,'Y',0,40,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-12-20 11:05:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-20 11:05:55','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','57c973c1-cf9b-44cb-a150-61c706a1479d','Y',20,4,2,1,'N','N','N','N')
;

