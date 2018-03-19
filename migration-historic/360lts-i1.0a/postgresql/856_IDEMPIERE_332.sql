-- Jul 12, 2012 9:29:41 AM CEST
-- IDEMPIERE-332 Document sequence organization level and restart monthly
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,200060,0,'StartNewMonth',TO_TIMESTAMP('2012-07-12 09:29:39','YYYY-MM-DD HH24:MI:SS'),0,'D','Y','Restart sequence every month','Restart sequence every month',TO_TIMESTAMP('2012-07-12 09:29:39','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Jul 12, 2012 9:29:41 AM CEST
-- IDEMPIERE-332 Document sequence organization level and restart monthly
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Description,Help,Name,PO_Description,PO_Help,PO_Name,PO_PrintName,PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.Description,t.Help,t.Name,t.PO_Description,t.PO_Help,t.PO_Name,t.PO_PrintName,t.PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200060 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Jul 12, 2012 9:30:32 AM CEST
-- IDEMPIERE-332 Document sequence organization level and restart monthly
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,Description,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,200061,0,'IsOrgLevelSequence',TO_TIMESTAMP('2012-07-12 09:30:32','YYYY-MM-DD HH24:MI:SS'),0,'This sequence can be defined for each organization','D','Y','Organization level','Organization level',TO_TIMESTAMP('2012-07-12 09:30:32','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Jul 12, 2012 9:30:32 AM CEST
-- IDEMPIERE-332 Document sequence organization level and restart monthly
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Description,Help,Name,PO_Description,PO_Help,PO_Name,PO_PrintName,PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.Description,t.Help,t.Name,t.PO_Description,t.PO_Help,t.PO_Name,t.PO_PrintName,t.PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200061 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Jul 12, 2012 9:32:18 AM CEST
-- IDEMPIERE-332 Document sequence organization level and restart monthly
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,EntityType,FieldLength,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsSyncDatabase,IsTranslated,IsUpdateable,Name,SeqNo,Updated,UpdatedBy,Version) VALUES (0,200212,200060,0,20,115,'StartNewMonth',TO_TIMESTAMP('2012-07-12 09:32:18','YYYY-MM-DD HH24:MI:SS'),0,'N','D',1,'Y','Y','Y','N','N','N','N','N','Y','N','N','N','N','Y','Restart sequence every month',0,TO_TIMESTAMP('2012-07-12 09:32:18','YYYY-MM-DD HH24:MI:SS'),0,0)
;

-- Jul 12, 2012 9:32:19 AM CEST
-- IDEMPIERE-332 Document sequence organization level and restart monthly
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200212 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 12, 2012 9:32:48 AM CEST
-- IDEMPIERE-332 Document sequence organization level and restart monthly
ALTER TABLE AD_Sequence ADD COLUMN StartNewMonth CHAR(1) DEFAULT 'N' CHECK (StartNewMonth IN ('Y','N')) NOT NULL
;

-- Jul 12, 2012 9:33:30 AM CEST
-- IDEMPIERE-332 Document sequence organization level and restart monthly
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsSyncDatabase,IsTranslated,IsUpdateable,Name,SeqNo,Updated,UpdatedBy,Version) VALUES (0,200213,200061,0,20,115,'IsOrgLevelSequence',TO_TIMESTAMP('2012-07-12 09:33:29','YYYY-MM-DD HH24:MI:SS'),0,'N','This sequence can be defined for each organization','D',1,'Y','Y','Y','N','N','N','N','N','Y','N','N','N','N','Y','Organization level',0,TO_TIMESTAMP('2012-07-12 09:33:29','YYYY-MM-DD HH24:MI:SS'),0,0)
;

-- Jul 12, 2012 9:33:30 AM CEST
-- IDEMPIERE-332 Document sequence organization level and restart monthly
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200213 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 12, 2012 9:33:31 AM CEST
-- IDEMPIERE-332 Document sequence organization level and restart monthly
ALTER TABLE AD_Sequence ADD COLUMN IsOrgLevelSequence CHAR(1) DEFAULT 'N' CHECK (IsOrgLevelSequence IN ('Y','N')) NOT NULL
;

-- Jul 12, 2012 9:34:03 AM CEST
-- IDEMPIERE-332 Document sequence organization level and restart monthly
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsSyncDatabase,IsTranslated,IsUpdateable,MandatoryLogic,Name,SeqNo,Updated,UpdatedBy,Version) VALUES (0,200214,1591,0,10,115,'OrgColumn',TO_TIMESTAMP('2012-07-12 09:34:03','YYYY-MM-DD HH24:MI:SS'),0,'Fully qualified Organization column (AD_Org_ID)','D',60,'The Organization Column indicates the organization to be used in calculating this measurement.','Y','Y','Y','N','N','N','N','N','N','N','N','N','N','Y','@IsUseOrgLevelSequence@=Y','Org Column',0,TO_TIMESTAMP('2012-07-12 09:34:03','YYYY-MM-DD HH24:MI:SS'),0,0)
;

-- Jul 12, 2012 9:34:03 AM CEST
-- IDEMPIERE-332 Document sequence organization level and restart monthly
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200214 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 12, 2012 9:34:04 AM CEST
-- IDEMPIERE-332 Document sequence organization level and restart monthly
ALTER TABLE AD_Sequence ADD COLUMN OrgColumn VARCHAR(60) DEFAULT NULL 
;

-- Jul 12, 2012 9:35:04 AM CEST
-- IDEMPIERE-332 Document sequence organization level and restart monthly
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,SortNo,Updated,UpdatedBy) VALUES (0,200213,200162,0,146,TO_TIMESTAMP('2012-07-12 09:35:03','YYYY-MM-DD HH24:MI:SS'),0,'This sequence can be defined for each organization',0,'D','Y','Y','Y','N','N','N','N','N','Organization level',170,0,TO_TIMESTAMP('2012-07-12 09:35:03','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Jul 12, 2012 9:35:04 AM CEST
-- IDEMPIERE-332 Document sequence organization level and restart monthly
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200162 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 12, 2012 9:35:24 AM CEST
-- IDEMPIERE-332 Document sequence organization level and restart monthly
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,DisplayLogic,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,SortNo,Updated,UpdatedBy) VALUES (0,200214,200163,0,146,TO_TIMESTAMP('2012-07-12 09:35:23','YYYY-MM-DD HH24:MI:SS'),0,'Fully qualified Organization column (AD_Org_ID)',0,'@IsOrgLevelSequence@=Y','D','The Organization Column indicates the organization to be used in calculating this measurement.','Y','Y','Y','N','N','N','N','Y','Org Column',180,0,TO_TIMESTAMP('2012-07-12 09:35:23','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Jul 12, 2012 9:35:24 AM CEST
-- IDEMPIERE-332 Document sequence organization level and restart monthly
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200163 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 12, 2012 9:35:39 AM CEST
-- IDEMPIERE-332 Document sequence organization level and restart monthly
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,DisplayLength,DisplayLogic,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,SortNo,Updated,UpdatedBy) VALUES (0,200212,200164,0,146,TO_TIMESTAMP('2012-07-12 09:35:39','YYYY-MM-DD HH24:MI:SS'),0,0,'@StartNewYear@=Y','D','Y','Y','Y','N','N','N','N','N','Restart sequence every month',190,0,TO_TIMESTAMP('2012-07-12 09:35:39','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Jul 12, 2012 9:35:39 AM CEST
-- IDEMPIERE-332 Document sequence organization level and restart monthly
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200164 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 12, 2012 9:36:20 AM CEST
-- IDEMPIERE-332 Document sequence organization level and restart monthly
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=54391
;

-- Jul 12, 2012 9:36:20 AM CEST
-- IDEMPIERE-332 Document sequence organization level and restart monthly
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=332
;

-- Jul 12, 2012 9:36:20 AM CEST
-- IDEMPIERE-332 Document sequence organization level and restart monthly
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=333
;

-- Jul 12, 2012 9:36:20 AM CEST
-- IDEMPIERE-332 Document sequence organization level and restart monthly
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=200162
;

-- Jul 12, 2012 9:36:20 AM CEST
-- IDEMPIERE-332 Document sequence organization level and restart monthly
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=200163
;

-- Jul 12, 2012 9:36:20 AM CEST
-- IDEMPIERE-332 Document sequence organization level and restart monthly
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=335
;

-- Jul 12, 2012 9:36:20 AM CEST
-- IDEMPIERE-332 Document sequence organization level and restart monthly
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=54357
;

-- Jul 12, 2012 9:36:20 AM CEST
-- IDEMPIERE-332 Document sequence organization level and restart monthly
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y' WHERE AD_Field_ID=200164
;

-- Jul 12, 2012 9:36:20 AM CEST
-- IDEMPIERE-332 Document sequence organization level and restart monthly
UPDATE AD_Field SET SeqNo=190,IsDisplayed='Y' WHERE AD_Field_ID=1555
;

-- Jul 12, 2012 9:36:20 AM CEST
-- IDEMPIERE-332 Document sequence organization level and restart monthly
UPDATE AD_Field SET SeqNo=200,IsDisplayed='Y' WHERE AD_Field_ID=334
;

-- Jul 12, 2012 9:38:29 AM CEST
-- IDEMPIERE-332 Document sequence organization level and restart monthly
UPDATE AD_Field SET DisplayLogic='@IsAutoSequence@=Y & @IsTableID@=N', IsSameLine='N',Updated=TO_TIMESTAMP('2012-07-12 09:38:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=1555
;

-- Jul 12, 2012 9:38:51 AM CEST
-- IDEMPIERE-332 Document sequence organization level and restart monthly
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2012-07-12 09:38:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=54357
;

-- Jul 12, 2012 9:41:56 AM CEST
-- IDEMPIERE-332 Document sequence organization level and restart monthly
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,Description,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,200062,0,'CalendarYearMonth',TO_TIMESTAMP('2012-07-12 09:41:55','YYYY-MM-DD HH24:MI:SS'),0,'YYYYMM','D','Y','YearMonth','YearMonth',TO_TIMESTAMP('2012-07-12 09:41:55','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Jul 12, 2012 9:41:56 AM CEST
-- IDEMPIERE-332 Document sequence organization level and restart monthly
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Description,Help,Name,PO_Description,PO_Help,PO_Name,PO_PrintName,PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.Description,t.Help,t.Name,t.PO_Description,t.PO_Help,t.PO_Name,t.PO_PrintName,t.PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200062 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 1, 2012 8:32:42 AM COT
-- IDEMPIERE-332 Document sequence organization level and restart monthly
UPDATE AD_Column SET Help=NULL, FieldLength=6, AD_Element_ID=200062, IsUpdateable='N', ColumnName='CalendarYearMonth', Description='YYYYMM', Name='YearMonth',Updated=TO_TIMESTAMP('2012-08-01 08:32:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=262
;

-- Aug 1, 2012 8:32:42 AM COT
-- IDEMPIERE-332 Document sequence organization level and restart monthly
UPDATE AD_Column_Trl SET IsTranslated='N' WHERE AD_Column_ID=262
;

-- Aug 1, 2012 8:32:42 AM COT
UPDATE AD_Field SET Name='YearMonth', Description='YYYYMM', Help=NULL WHERE AD_Column_ID=262 AND IsCentrallyMaintained='Y'
;

ALTER TABLE ad_sequence_no ALTER COLUMN calendaryear TYPE varchar(6)
;

ALTER TABLE ad_sequence_no RENAME calendaryear TO calendaryearmonth
;

ALTER TABLE ad_sequence_no DROP CONSTRAINT ad_sequence_no_pkey CASCADE
;

ALTER TABLE ad_sequence_no ADD CONSTRAINT ad_sequence_no_pkey PRIMARY KEY (ad_sequence_id, calendaryearmonth, ad_org_id)
;

-- Jul 12, 2012 9:44:43 AM CEST
-- IDEMPIERE-332 Document sequence organization level and restart monthly
UPDATE AD_Tab SET DisplayLogic='@StartNewYear@=''Y'' | @IsOrgLevelSequence@=Y',Updated=TO_TIMESTAMP('2012-07-12 09:44:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Tab_ID=200001
;

-- Jul 12, 2012 9:46:03 AM CEST
-- IDEMPIERE-332 Document sequence organization level and restart monthly
UPDATE AD_Column SET ReadOnlyLogic='@StartNewYear@=N & @IsOrgLevelSequence@=N',Updated=TO_TIMESTAMP('2012-07-12 09:46:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=2746
;

DROP FUNCTION nextidbyyear(numeric, numeric, character varying);

-- Sep 7, 2012 11:04:53 AM COT
-- IDEMPIERE-332 Document sequence organization level and restart monthly
UPDATE AD_Process_Para SET IsActive='N',Updated=TO_TIMESTAMP('2012-09-07 11:04:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=53129
;

-- Sep 7, 2012 11:04:57 AM COT
-- IDEMPIERE-332 Document sequence organization level and restart monthly
UPDATE AD_Process SET IsActive='N',Updated=TO_TIMESTAMP('2012-09-07 11:04:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=53068
;

-- Sep 7, 2012 11:04:57 AM COT
-- IDEMPIERE-332 Document sequence organization level and restart monthly
UPDATE AD_Menu SET Name='Update Sequence No', Description=NULL, IsActive='N',Updated=TO_TIMESTAMP('2012-09-07 11:04:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=53087
;

-- Sep 7, 2012 11:04:57 AM COT
-- IDEMPIERE-332 Document sequence organization level and restart monthly
UPDATE AD_Menu_Trl SET IsTranslated='N' WHERE AD_Menu_ID=53087
;

-- Sep 7, 2012 2:30:26 PM COT
-- IDEMPIERE-332 Document sequence organization level and restart monthly
UPDATE AD_Field SET DisplayLogic='@IsTableID@=N',Updated=TO_TIMESTAMP('2012-09-07 14:30:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200162
;

-- Sep 7, 2012 2:32:51 PM COT
-- IDEMPIERE-332 Document sequence organization level and restart monthly
UPDATE AD_Sequence SET StartNewMonth='Y', IsOrgLevelSequence='Y', OrgColumn='AD_Org_ID', StartNewYear='Y', Prefix='@AD_Org_ID<AD_Org.Value>@-', DateColumn='DateOrdered', Suffix='-@DateAcct<yyyyMM>@', DecimalPattern='0000000',Updated=TO_TIMESTAMP('2012-09-07 14:32:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Sequence_ID=383
;

UPDATE AD_System
SET LastMigrationScriptApplied='856_IDEMPIERE_332.sql'
WHERE LastMigrationScriptApplied<'856_IDEMPIERE_332.sql'
OR LastMigrationScriptApplied IS NULL;
