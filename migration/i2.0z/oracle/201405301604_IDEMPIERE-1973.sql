SET SQLBLANKLINES ON
SET DEFINE OFF

-- May 30, 2014 10:02:41 PM ICT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (0,'N',0,211273,'N','N','N',0,'N',1,'N','N','N','Y','bf98ee02-ec0f-4279-8577-11b8d267c7a7','Y','IsMandatory','Data entry is required in this column','N','The field must have a value for the record to be saved to the database.','Mandatory','Y',TO_DATE('2014-05-30 22:02:40','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2014-05-30 22:02:40','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N','N',392,20,897)
;

-- May 30, 2014 10:02:47 PM ICT
ALTER TABLE AD_InfoColumn ADD IsMandatory CHAR(1) DEFAULT 'N' CHECK (IsMandatory IN ('Y','N'))
;

-- May 30, 2014 10:02:56 PM ICT
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_DATE('2014-05-30 22:02:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211273
;

-- May 30, 2014 10:05:01 PM ICT
INSERT INTO AD_Field (SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,Created) VALUES (0,'N',844,0,'N','N',250,'Y',203049,'N','The field must have a value for the record to be saved to the database.','Data entry is required in this column','Mandatory','0a2c4d46-748b-4451-988b-d9f6931ed62d','Y','N',100,0,100,TO_DATE('2014-05-30 22:05:00','YYYY-MM-DD HH24:MI:SS'),'Y','Y',160,1,'N',0,1,1,'N','N',211273,'D',TO_DATE('2014-05-30 22:05:00','YYYY-MM-DD HH24:MI:SS'))
;

-- May 30, 2014 10:06:40 PM ICT
UPDATE AD_Field SET SeqNo=150, IsDisplayed='Y', XPosition=2, ColumnSpan=2,Updated=TO_DATE('2014-05-30 22:06:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203049
;

-- May 30, 2014 10:06:40 PM ICT
UPDATE AD_Field SET SeqNo=160, IsDisplayed='Y', XPosition=4,Updated=TO_DATE('2014-05-30 22:06:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201719
;

-- May 30, 2014 10:06:40 PM ICT
UPDATE AD_Field SET SeqNo=170, IsDisplayed='Y', XPosition=7, ColumnSpan=2,Updated=TO_DATE('2014-05-30 22:06:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201720
;

-- May 30, 2014 10:06:40 PM ICT
UPDATE AD_Field SET SeqNo=180,Updated=TO_DATE('2014-05-30 22:06:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201625
;

-- May 30, 2014 10:06:40 PM ICT
UPDATE AD_Field SET SeqNo=190,Updated=TO_DATE('2014-05-30 22:06:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203048
;

-- May 30, 2014 10:06:40 PM ICT
UPDATE AD_Field SET SeqNo=200,Updated=TO_DATE('2014-05-30 22:06:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201635
;

-- May 30, 2014 10:06:40 PM ICT
UPDATE AD_Field SET SeqNo=210,Updated=TO_DATE('2014-05-30 22:06:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201636
;

-- May 30, 2014 10:06:40 PM ICT
UPDATE AD_Field SET SeqNo=220,Updated=TO_DATE('2014-05-30 22:06:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13603
;

-- May 30, 2014 10:06:40 PM ICT
UPDATE AD_Field SET SeqNo=230,Updated=TO_DATE('2014-05-30 22:06:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201622
;

-- May 30, 2014 10:06:40 PM ICT
UPDATE AD_Field SET SeqNo=240,Updated=TO_DATE('2014-05-30 22:06:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201623
;

-- May 30, 2014 10:06:40 PM ICT
UPDATE AD_Field SET SeqNo=250,Updated=TO_DATE('2014-05-30 22:06:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13597
;

UPDATE ad_infocolumn SET ismandatory = 'N'
;

ALTER TABLE ad_infocolumn MODIFY (ismandatory CHAR(1) NOT NULL)
;
-- Jun 11, 2014 8:59:36 AM ICT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Field SET DisplayLogic='@IsQueryCriteria@=Y',Updated=TO_DATE('2014-06-11 08:59:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203049
;
SELECT register_migration_script('201405301604_IDEMPIERE-1973.sql') FROM dual
;
