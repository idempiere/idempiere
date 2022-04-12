-- IDEMPIERE-5093 Scheduler cron pattern scheduling is always using server time zone
SELECT register_migration_script('202204111508_IDEMPIERE-5093.sql') FROM dual;

-- Apr 11, 2022, 3:09:15 PM MYT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203573,0,0,'Y',TO_TIMESTAMP('2022-04-11 15:09:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-11 15:09:13','YYYY-MM-DD HH24:MI:SS'),100,'T_Timestamp','Timestamp','Timestamp with time zone','Timestamp','D','0e993a88-2c26-4946-9ca8-2eb4263d4323')
;

-- Apr 11, 2022, 3:16:46 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214755,0,'Timestamp','Timestamp with time zone',135,'T_Timestamp',10,'N','N','N','N','N',0,'N',200133,0,0,'Y',TO_TIMESTAMP('2022-04-11 15:16:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-11 15:16:45','YYYY-MM-DD HH24:MI:SS'),100,203573,'Y','N','D','N','N','N','Y','ec1dd52b-d346-4ca3-ac50-6f87008ee99a','Y',0,'N','N','N','N')
;

-- Apr 11, 2022, 3:16:52 PM MYT
ALTER TABLE Test ADD COLUMN T_Timestamp TIMESTAMP WITH TIME ZONE DEFAULT NULL 
;

-- Apr 11, 2022, 3:17:54 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206945,'Timestamp','Timestamp with time zone',152,214755,'Y',0,270,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-11 15:17:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-11 15:17:54','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e95039ef-5430-473b-8f92-3caf99d6d914','Y',280,1,2,1,'N','N','N','N')
;

-- Apr 11, 2022, 3:18:15 PM MYT
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=206945
;

-- Apr 11, 2022, 3:18:15 PM MYT
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=3209
;

-- Apr 11, 2022, 3:18:15 PM MYT
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=3902
;

-- Apr 11, 2022, 3:18:15 PM MYT
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=3210
;

-- Apr 11, 2022, 3:18:15 PM MYT
UPDATE AD_Field SET SeqNo=190,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=4251
;

-- Apr 11, 2022, 3:18:15 PM MYT
UPDATE AD_Field SET SeqNo=200,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=3057
;

-- Apr 11, 2022, 3:18:15 PM MYT
UPDATE AD_Field SET SeqNo=210,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=3056
;

-- Apr 11, 2022, 3:18:15 PM MYT
UPDATE AD_Field SET SeqNo=220,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=205590
;

-- Apr 11, 2022, 3:18:15 PM MYT
UPDATE AD_Field SET SeqNo=230,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=8351
;

-- Apr 11, 2022, 3:18:15 PM MYT
UPDATE AD_Field SET SeqNo=240,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=8352
;

-- Apr 11, 2022, 3:18:15 PM MYT
UPDATE AD_Field SET SeqNo=250,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=3060
;

-- Apr 11, 2022, 3:18:15 PM MYT
UPDATE AD_Field SET SeqNo=260,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=3061
;

-- Apr 11, 2022, 3:18:15 PM MYT
UPDATE AD_Field SET SeqNo=270,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=206818
;

-- Apr 11, 2022, 3:18:28 PM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=2024
;

-- Apr 11, 2022, 3:18:28 PM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=415
;

-- Apr 11, 2022, 3:18:28 PM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=416
;

-- Apr 11, 2022, 3:18:28 PM MYT
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=417
;

-- Apr 11, 2022, 3:18:28 PM MYT
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=418
;

-- Apr 11, 2022, 3:18:28 PM MYT
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=419
;

-- Apr 11, 2022, 3:18:28 PM MYT
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=420
;

-- Apr 11, 2022, 3:18:28 PM MYT
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=421
;

-- Apr 11, 2022, 3:18:28 PM MYT
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=422
;

-- Apr 11, 2022, 3:18:28 PM MYT
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=423
;

-- Apr 11, 2022, 3:18:28 PM MYT
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=424
;

-- Apr 11, 2022, 3:18:28 PM MYT
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=3059
;

-- Apr 11, 2022, 3:18:28 PM MYT
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=3062
;

-- Apr 11, 2022, 3:18:28 PM MYT
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=425
;

-- Apr 11, 2022, 3:18:28 PM MYT
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=426
;

-- Apr 11, 2022, 3:18:28 PM MYT
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=206945
;

-- Apr 11, 2022, 3:18:28 PM MYT
UPDATE AD_Field SET SeqNoGrid=140,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=3057
;

-- Apr 11, 2022, 3:18:28 PM MYT
UPDATE AD_Field SET SeqNoGrid=150,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=3056
;

-- Apr 11, 2022, 3:18:28 PM MYT
UPDATE AD_Field SET SeqNoGrid=160,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=3902
;

-- Apr 11, 2022, 3:18:28 PM MYT
UPDATE AD_Field SET SeqNoGrid=170,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=4251
;

-- Apr 11, 2022, 3:18:28 PM MYT
UPDATE AD_Field SET SeqNoGrid=180,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=3209
;

-- Apr 11, 2022, 3:18:28 PM MYT
UPDATE AD_Field SET SeqNoGrid=190,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=3210
;

-- Apr 11, 2022, 3:18:28 PM MYT
UPDATE AD_Field SET SeqNoGrid=200,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=8351
;

-- Apr 11, 2022, 3:18:28 PM MYT
UPDATE AD_Field SET SeqNoGrid=210,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=8352
;

-- Apr 11, 2022, 3:18:28 PM MYT
UPDATE AD_Field SET SeqNoGrid=220,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=3060
;

-- Apr 11, 2022, 3:18:28 PM MYT
UPDATE AD_Field SET SeqNoGrid=230,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=3061
;

-- Apr 11, 2022, 3:18:28 PM MYT
UPDATE AD_Field SET SeqNoGrid=240,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=205590
;

-- Apr 11, 2022, 3:18:28 PM MYT
UPDATE AD_Field SET SeqNoGrid=250,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=206818
;

