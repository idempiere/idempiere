-- Apr 12, 2012 11:08:21 AM CEST
-- IDEMPIERE-129 Expand menu automatically
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,Description,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,200023,0,'IsMenuAutoExpand',TO_TIMESTAMP('2012-04-12 11:08:19','YYYY-MM-DD HH24:MI:SS'),100,'If ticked, the menu is automatically expanded','D','Y','Auto expand menu','Auto expand menu',TO_TIMESTAMP('2012-04-12 11:08:19','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Apr 12, 2012 11:08:21 AM CEST
-- IDEMPIERE-129 Expand menu automatically
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Description,Help,Name,PO_Description,PO_Help,PO_Name,PO_PrintName,PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.Description,t.Help,t.Name,t.PO_Description,t.PO_Help,t.PO_Name,t.PO_PrintName,t.PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200023 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Apr 12, 2012 11:09:31 AM CEST
-- IDEMPIERE-129 Expand menu automatically
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsSyncDatabase,IsTranslated,IsUpdateable,Name,SeqNo,Updated,UpdatedBy,Version) VALUES (0,200112,200023,0,20,156,'IsMenuAutoExpand',TO_TIMESTAMP('2012-04-12 11:09:31','YYYY-MM-DD HH24:MI:SS'),100,'N','If ticked, the menu is automatically expanded','D',1,'Y','Y','Y','N','N','N','N','N','Y','N','N','N','N','Y','Auto expand menu',0,TO_TIMESTAMP('2012-04-12 11:09:31','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Apr 12, 2012 11:09:31 AM CEST
-- IDEMPIERE-129 Expand menu automatically
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200112 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Apr 12, 2012 11:09:41 AM CEST
-- IDEMPIERE-129 Expand menu automatically
ALTER TABLE AD_Role ADD COLUMN IsMenuAutoExpand CHAR(1) DEFAULT 'N' CHECK (IsMenuAutoExpand IN ('Y','N')) NOT NULL
;

-- Apr 12, 2012 11:10:42 AM CEST
-- IDEMPIERE-129 Expand menu automatically
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,SortNo,Updated,UpdatedBy) VALUES (0,200112,200071,0,119,TO_TIMESTAMP('2012-04-12 11:10:41','YYYY-MM-DD HH24:MI:SS'),100,'If ticked, the menu is automatically expanded',0,'D','Y','Y','Y','N','N','N','N','N','Auto expand menu',430,0,TO_TIMESTAMP('2012-04-12 11:10:41','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Apr 12, 2012 11:10:42 AM CEST
-- IDEMPIERE-129 Expand menu automatically
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200071 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Apr 12, 2012 11:11:23 AM CEST
-- IDEMPIERE-129 Expand menu automatically
UPDATE AD_Field SET SeqNo=300,IsDisplayed='Y' WHERE AD_Field_ID=200071
;

-- Apr 12, 2012 11:11:23 AM CEST
-- IDEMPIERE-129 Expand menu automatically
UPDATE AD_Field SET SeqNo=310,IsDisplayed='Y' WHERE AD_Field_ID=50168
;

-- Apr 12, 2012 11:11:23 AM CEST
-- IDEMPIERE-129 Expand menu automatically
UPDATE AD_Field SET SeqNo=320,IsDisplayed='Y' WHERE AD_Field_ID=50169
;

-- Apr 12, 2012 11:11:23 AM CEST
-- IDEMPIERE-129 Expand menu automatically
UPDATE AD_Field SET SeqNo=330,IsDisplayed='Y' WHERE AD_Field_ID=50170
;

-- Apr 12, 2012 11:11:23 AM CEST
-- IDEMPIERE-129 Expand menu automatically
UPDATE AD_Field SET SeqNo=340,IsDisplayed='Y' WHERE AD_Field_ID=50171
;

-- Apr 12, 2012 11:11:23 AM CEST
-- IDEMPIERE-129 Expand menu automatically
UPDATE AD_Field SET SeqNo=350,IsDisplayed='Y' WHERE AD_Field_ID=50172
;

-- Apr 12, 2012 11:11:23 AM CEST
-- IDEMPIERE-129 Expand menu automatically
UPDATE AD_Field SET SeqNo=360,IsDisplayed='Y' WHERE AD_Field_ID=50173
;

-- Apr 12, 2012 11:11:23 AM CEST
-- IDEMPIERE-129 Expand menu automatically
UPDATE AD_Field SET SeqNo=370,IsDisplayed='Y' WHERE AD_Field_ID=50174
;

-- Apr 12, 2012 11:11:23 AM CEST
-- IDEMPIERE-129 Expand menu automatically
UPDATE AD_Field SET SeqNo=380,IsDisplayed='Y' WHERE AD_Field_ID=50175
;

-- Apr 12, 2012 11:11:23 AM CEST
-- IDEMPIERE-129 Expand menu automatically
UPDATE AD_Field SET SeqNo=390,IsDisplayed='Y' WHERE AD_Field_ID=50176
;

-- Apr 12, 2012 11:11:23 AM CEST
-- IDEMPIERE-129 Expand menu automatically
UPDATE AD_Field SET SeqNo=400,IsDisplayed='Y' WHERE AD_Field_ID=50177
;

-- Apr 12, 2012 11:11:23 AM CEST
-- IDEMPIERE-129 Expand menu automatically
UPDATE AD_Field SET SeqNo=410,IsDisplayed='Y' WHERE AD_Field_ID=50178
;

-- Apr 12, 2012 11:11:23 AM CEST
-- IDEMPIERE-129 Expand menu automatically
UPDATE AD_Field SET SeqNo=420,IsDisplayed='Y' WHERE AD_Field_ID=55432
;

-- Apr 12, 2012 11:11:23 AM CEST
-- IDEMPIERE-129 Expand menu automatically
UPDATE AD_Field SET SeqNo=430,IsDisplayed='Y' WHERE AD_Field_ID=55433
;

-- Apr 12, 2012 11:12:28 AM CEST
-- IDEMPIERE-129 Expand menu automatically
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsSyncDatabase,IsTranslated,IsUpdateable,Name,SeqNo,Updated,UpdatedBy,Version) VALUES (0,200113,200023,0,20,114,'IsMenuAutoExpand',TO_TIMESTAMP('2012-04-12 11:12:27','YYYY-MM-DD HH24:MI:SS'),100,'N','If ticked, the menu is automatically expanded','D',1,'Y','Y','Y','N','N','N','N','N','Y','N','N','N','N','Y','Auto expand menu',0,TO_TIMESTAMP('2012-04-12 11:12:27','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Apr 12, 2012 11:12:28 AM CEST
-- IDEMPIERE-129 Expand menu automatically
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200113 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Apr 12, 2012 11:12:29 AM CEST
-- IDEMPIERE-129 Expand menu automatically
ALTER TABLE AD_User ADD COLUMN IsMenuAutoExpand CHAR(1) DEFAULT 'N' CHECK (IsMenuAutoExpand IN ('Y','N')) NOT NULL
;

-- Apr 12, 2012 11:13:08 AM CEST
-- IDEMPIERE-129 Expand menu automatically
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,SortNo,Updated,UpdatedBy) VALUES (0,200113,200072,0,118,TO_TIMESTAMP('2012-04-12 11:13:07','YYYY-MM-DD HH24:MI:SS'),100,'If ticked, the menu is automatically expanded',0,'D','Y','Y','Y','N','N','N','N','N','Auto expand menu',310,0,TO_TIMESTAMP('2012-04-12 11:13:07','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Apr 12, 2012 11:13:08 AM CEST
-- IDEMPIERE-129 Expand menu automatically
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200072 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Apr 12, 2012 11:13:25 AM CEST
-- IDEMPIERE-129 Expand menu automatically
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=52010
;

-- Apr 12, 2012 11:13:25 AM CEST
-- IDEMPIERE-129 Expand menu automatically
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=6515
;

-- Apr 12, 2012 11:13:25 AM CEST
-- IDEMPIERE-129 Expand menu automatically
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=6517
;

-- Apr 12, 2012 11:13:25 AM CEST
-- IDEMPIERE-129 Expand menu automatically
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=6514
;

-- Apr 12, 2012 11:13:25 AM CEST
-- IDEMPIERE-129 Expand menu automatically
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=6518
;

-- Apr 12, 2012 11:13:25 AM CEST
-- IDEMPIERE-129 Expand menu automatically
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y' WHERE AD_Field_ID=11679
;

-- Apr 12, 2012 11:13:25 AM CEST
-- IDEMPIERE-129 Expand menu automatically
UPDATE AD_Field SET SeqNo=190,IsDisplayed='Y' WHERE AD_Field_ID=12324
;

-- Apr 12, 2012 11:13:25 AM CEST
-- IDEMPIERE-129 Expand menu automatically
UPDATE AD_Field SET SeqNo=200,IsDisplayed='Y' WHERE AD_Field_ID=12323
;

-- Apr 12, 2012 11:13:25 AM CEST
-- IDEMPIERE-129 Expand menu automatically
UPDATE AD_Field SET SeqNo=210,IsDisplayed='Y' WHERE AD_Field_ID=5883
;

-- Apr 12, 2012 11:13:25 AM CEST
-- IDEMPIERE-129 Expand menu automatically
UPDATE AD_Field SET SeqNo=220,IsDisplayed='Y' WHERE AD_Field_ID=5884
;

-- Apr 12, 2012 11:13:25 AM CEST
-- IDEMPIERE-129 Expand menu automatically
UPDATE AD_Field SET SeqNo=230,IsDisplayed='Y' WHERE AD_Field_ID=4261
;

-- Apr 12, 2012 11:13:25 AM CEST
-- IDEMPIERE-129 Expand menu automatically
UPDATE AD_Field SET SeqNo=240,IsDisplayed='Y' WHERE AD_Field_ID=10491
;

-- Apr 12, 2012 11:13:25 AM CEST
-- IDEMPIERE-129 Expand menu automatically
UPDATE AD_Field SET SeqNo=250,IsDisplayed='Y' WHERE AD_Field_ID=6511
;

-- Apr 12, 2012 11:13:25 AM CEST
-- IDEMPIERE-129 Expand menu automatically
UPDATE AD_Field SET SeqNo=260,IsDisplayed='Y' WHERE AD_Field_ID=12640
;

-- Apr 12, 2012 11:13:25 AM CEST
-- IDEMPIERE-129 Expand menu automatically
UPDATE AD_Field SET SeqNo=270,IsDisplayed='Y' WHERE AD_Field_ID=200072
;

-- Apr 12, 2012 11:13:25 AM CEST
-- IDEMPIERE-129 Expand menu automatically
UPDATE AD_Field SET SeqNo=280,IsDisplayed='Y' WHERE AD_Field_ID=6513
;

-- Apr 12, 2012 11:13:25 AM CEST
-- IDEMPIERE-129 Expand menu automatically
UPDATE AD_Field SET SeqNo=290,IsDisplayed='Y' WHERE AD_Field_ID=11525
;

-- Apr 12, 2012 11:13:25 AM CEST
-- IDEMPIERE-129 Expand menu automatically
UPDATE AD_Field SET SeqNo=300,IsDisplayed='Y' WHERE AD_Field_ID=6520
;

-- Apr 12, 2012 11:13:25 AM CEST
-- IDEMPIERE-129 Expand menu automatically
UPDATE AD_Field SET SeqNo=310,IsDisplayed='Y' WHERE AD_Field_ID=8342
;

-- Apr 12, 2012 11:13:25 AM CEST
-- IDEMPIERE-129 Expand menu automatically
UPDATE AD_Field SET SeqNo=320,IsDisplayed='Y' WHERE AD_Field_ID=6519
;

-- Apr 12, 2012 11:13:47 AM CEST
-- IDEMPIERE-129 Expand menu automatically
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,SortNo,Updated,UpdatedBy) VALUES (0,200113,200073,0,53282,TO_TIMESTAMP('2012-04-12 11:13:46','YYYY-MM-DD HH24:MI:SS'),100,'If ticked, the menu is automatically expanded',0,'D','Y','Y','Y','N','N','N','N','N','Auto expand menu',310,0,TO_TIMESTAMP('2012-04-12 11:13:46','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Apr 12, 2012 11:13:47 AM CEST
-- IDEMPIERE-129 Expand menu automatically
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200073 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Apr 12, 2012 11:13:58 AM CEST
-- IDEMPIERE-129 Expand menu automatically
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=57995
;

-- Apr 12, 2012 11:13:58 AM CEST
-- IDEMPIERE-129 Expand menu automatically
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=57997
;

-- Apr 12, 2012 11:13:58 AM CEST
-- IDEMPIERE-129 Expand menu automatically
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=57998
;

-- Apr 12, 2012 11:13:58 AM CEST
-- IDEMPIERE-129 Expand menu automatically
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=57999
;

-- Apr 12, 2012 11:13:58 AM CEST
-- IDEMPIERE-129 Expand menu automatically
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=58000
;

-- Apr 12, 2012 11:13:58 AM CEST
-- IDEMPIERE-129 Expand menu automatically
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y' WHERE AD_Field_ID=58001
;

-- Apr 12, 2012 11:13:58 AM CEST
-- IDEMPIERE-129 Expand menu automatically
UPDATE AD_Field SET SeqNo=190,IsDisplayed='Y' WHERE AD_Field_ID=58002
;

-- Apr 12, 2012 11:13:58 AM CEST
-- IDEMPIERE-129 Expand menu automatically
UPDATE AD_Field SET SeqNo=200,IsDisplayed='Y' WHERE AD_Field_ID=58003
;

-- Apr 12, 2012 11:13:58 AM CEST
-- IDEMPIERE-129 Expand menu automatically
UPDATE AD_Field SET SeqNo=210,IsDisplayed='Y' WHERE AD_Field_ID=58004
;

-- Apr 12, 2012 11:13:58 AM CEST
-- IDEMPIERE-129 Expand menu automatically
UPDATE AD_Field SET SeqNo=220,IsDisplayed='Y' WHERE AD_Field_ID=58005
;

-- Apr 12, 2012 11:13:58 AM CEST
-- IDEMPIERE-129 Expand menu automatically
UPDATE AD_Field SET SeqNo=230,IsDisplayed='Y' WHERE AD_Field_ID=58006
;

-- Apr 12, 2012 11:13:58 AM CEST
-- IDEMPIERE-129 Expand menu automatically
UPDATE AD_Field SET SeqNo=240,IsDisplayed='Y' WHERE AD_Field_ID=58007
;

-- Apr 12, 2012 11:13:58 AM CEST
-- IDEMPIERE-129 Expand menu automatically
UPDATE AD_Field SET SeqNo=250,IsDisplayed='Y' WHERE AD_Field_ID=58008
;

-- Apr 12, 2012 11:13:58 AM CEST
-- IDEMPIERE-129 Expand menu automatically
UPDATE AD_Field SET SeqNo=260,IsDisplayed='Y' WHERE AD_Field_ID=58009
;

-- Apr 12, 2012 11:13:58 AM CEST
-- IDEMPIERE-129 Expand menu automatically
UPDATE AD_Field SET SeqNo=270,IsDisplayed='Y' WHERE AD_Field_ID=200073
;

-- Apr 12, 2012 11:13:58 AM CEST
-- IDEMPIERE-129 Expand menu automatically
UPDATE AD_Field SET SeqNo=280,IsDisplayed='Y' WHERE AD_Field_ID=58010
;

-- Apr 12, 2012 11:13:58 AM CEST
-- IDEMPIERE-129 Expand menu automatically
UPDATE AD_Field SET SeqNo=290,IsDisplayed='Y' WHERE AD_Field_ID=58011
;

-- Apr 12, 2012 11:13:58 AM CEST
-- IDEMPIERE-129 Expand menu automatically
UPDATE AD_Field SET SeqNo=300,IsDisplayed='Y' WHERE AD_Field_ID=58012
;

-- Apr 12, 2012 11:13:58 AM CEST
-- IDEMPIERE-129 Expand menu automatically
UPDATE AD_Field SET SeqNo=310,IsDisplayed='Y' WHERE AD_Field_ID=58013
;

-- Apr 12, 2012 11:13:58 AM CEST
-- IDEMPIERE-129 Expand menu automatically
UPDATE AD_Field SET SeqNo=320,IsDisplayed='Y' WHERE AD_Field_ID=58014
;

UPDATE AD_System
  SET LastMigrationScriptApplied='835_IDEMPIERE-195_MenuAutoExpand.sql'
WHERE LastMigrationScriptApplied<'835_IDEMPIERE-195_MenuAutoExpand.sql'
   OR LastMigrationScriptApplied IS NULL
;