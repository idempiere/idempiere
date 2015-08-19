-- Nov 6, 2014 3:13:05 PM ICT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator

-- Nov 6, 2014 3:13:13 PM ICT
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES (0,'N',0,211799,'N','N','N',0,'N',1,'N','N','N','Y','4ef802de-84a4-4ebc-a364-8ba9a27a39b5','Y','IsKey','This column is the key in this table','The key column must also be display sequence 0 in the field definition and may be hidden.','Key column','N',TO_TIMESTAMP('2014-11-06 15:13:12','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-11-06 15:13:12','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',389,20,897,0,0,'D')
;

-- Nov 6, 2014 3:13:25 PM ICT
ALTER TABLE AD_InfoColumn ADD COLUMN IsKey CHAR(1) DEFAULT NULL CHECK (IsKey IN ('Y','N'))
;

-- Nov 6, 2014 3:14:19 PM ICT
INSERT INTO AD_Field (SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,AD_Org_ID,Created) VALUES (0,'N',844,0,'N','N',260,'Y',203471,'N','The key column must also be display sequence 0 in the field definition and may be hidden.','D','This column is the key in this table','Key column','dd0b953a-d575-4eac-b435-87db841346c6','Y','N',100,100,TO_TIMESTAMP('2014-11-06 15:14:18','YYYY-MM-DD HH24:MI:SS'),'Y','Y',170,1,'N',0,1,1,'N','N',211799,0,TO_TIMESTAMP('2014-11-06 15:14:18','YYYY-MM-DD HH24:MI:SS'))
;

-- Nov 6, 2014 3:17:53 PM ICT
UPDATE AD_Field SET Help='In case data of info window come from a view, define a column contain unique value as key to keep selected record', Description='Define this column has unique value, play as key of table', Name='Is View Key',Updated=TO_TIMESTAMP('2014-11-06 15:17:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203471
;

-- Nov 6, 2014 3:18:15 PM ICT
UPDATE AD_Field SET SeqNo=170, IsDisplayed='Y', XPosition=6,Updated=TO_TIMESTAMP('2014-11-06 15:18:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203471
;

-- Nov 6, 2014 3:18:15 PM ICT
UPDATE AD_Field SET SeqNo=180,Updated=TO_TIMESTAMP('2014-11-06 15:18:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201720
;

-- Nov 6, 2014 3:18:15 PM ICT
UPDATE AD_Field SET SeqNo=190,Updated=TO_TIMESTAMP('2014-11-06 15:18:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201625
;

-- Nov 6, 2014 3:18:15 PM ICT
UPDATE AD_Field SET SeqNo=200,Updated=TO_TIMESTAMP('2014-11-06 15:18:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203048
;

-- Nov 6, 2014 3:18:15 PM ICT
UPDATE AD_Field SET SeqNo=210,Updated=TO_TIMESTAMP('2014-11-06 15:18:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201635
;

-- Nov 6, 2014 3:18:15 PM ICT
UPDATE AD_Field SET SeqNo=220,Updated=TO_TIMESTAMP('2014-11-06 15:18:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201636
;

-- Nov 6, 2014 3:18:15 PM ICT
UPDATE AD_Field SET SeqNo=230,Updated=TO_TIMESTAMP('2014-11-06 15:18:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13603
;

-- Nov 6, 2014 3:18:15 PM ICT
UPDATE AD_Field SET SeqNo=240,Updated=TO_TIMESTAMP('2014-11-06 15:18:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201622
;

-- Nov 6, 2014 3:18:15 PM ICT
UPDATE AD_Field SET SeqNo=250,Updated=TO_TIMESTAMP('2014-11-06 15:18:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201623
;

-- Nov 6, 2014 3:18:15 PM ICT
UPDATE AD_Field SET SeqNo=260,Updated=TO_TIMESTAMP('2014-11-06 15:18:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13597
;
SELECT register_migration_script('201411061604_IDEMPIERE-2230.sql') FROM dual
;
