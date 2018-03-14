-- Jan 16, 2013 4:21:16 AM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
UPDATE AD_Element SET Name='Activity Key', Description='Text key for Activity', PrintName='Activity Key',Updated=TO_TIMESTAMP('2013-01-16 04:21:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53222
;

-- Jan 16, 2013 4:21:16 AM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=53222
;

-- Jan 16, 2013 4:21:16 AM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
UPDATE AD_Column SET ColumnName='ActivityValue', Name='Activity Key', Description='Text key for Activity', Help=NULL WHERE AD_Element_ID=53222
;

-- Jan 16, 2013 4:21:16 AM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
UPDATE AD_Process_Para SET ColumnName='ActivityValue', Name='Activity Key', Description='Text key for Activity', Help=NULL, AD_Element_ID=53222 WHERE UPPER(ColumnName)='ACTIVITYVALUE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Jan 16, 2013 4:21:16 AM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
UPDATE AD_Process_Para SET ColumnName='ActivityValue', Name='Activity Key', Description='Text key for Activity', Help=NULL WHERE AD_Element_ID=53222 AND IsCentrallyMaintained='Y'
;

-- Jan 16, 2013 4:21:16 AM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
UPDATE AD_InfoColumn SET ColumnName='ActivityValue', Name='Activity Key', Description='Text key for Activity', Help=NULL WHERE AD_Element_ID=53222 AND IsCentrallyMaintained='Y'
;

-- Jan 16, 2013 4:21:16 AM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
UPDATE AD_Field SET Name='Activity Key', Description='Text key for Activity', Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=53222) AND IsCentrallyMaintained='Y'
;

-- Jan 16, 2013 4:21:16 AM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
UPDATE AD_PrintFormatItem SET PrintName='Activity Key', Name='Activity Key' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=53222)
;

-- Jan 16, 2013 4:23:38 AM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
UPDATE AD_Element SET Name='Campaign Key', Description='Text key of the Campaign', PrintName='Campaign Key',Updated=TO_TIMESTAMP('2013-01-16 04:23:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=54241
;

-- Jan 16, 2013 4:23:38 AM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=54241
;

-- Jan 16, 2013 4:23:38 AM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
UPDATE AD_Column SET ColumnName='CampaignValue', Name='Campaign Key', Description='Text key of the Campaign', Help=NULL WHERE AD_Element_ID=54241
;

-- Jan 16, 2013 4:23:38 AM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
UPDATE AD_Process_Para SET ColumnName='CampaignValue', Name='Campaign Key', Description='Text key of the Campaign', Help=NULL, AD_Element_ID=54241 WHERE UPPER(ColumnName)='CAMPAIGNVALUE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Jan 16, 2013 4:23:38 AM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
UPDATE AD_Process_Para SET ColumnName='CampaignValue', Name='Campaign Key', Description='Text key of the Campaign', Help=NULL WHERE AD_Element_ID=54241 AND IsCentrallyMaintained='Y'
;

-- Jan 16, 2013 4:23:38 AM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
UPDATE AD_InfoColumn SET ColumnName='CampaignValue', Name='Campaign Key', Description='Text key of the Campaign', Help=NULL WHERE AD_Element_ID=54241 AND IsCentrallyMaintained='Y'
;

-- Jan 16, 2013 4:23:38 AM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
UPDATE AD_Field SET Name='Campaign Key', Description='Text key of the Campaign', Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=54241) AND IsCentrallyMaintained='Y'
;

-- Jan 16, 2013 4:23:39 AM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
UPDATE AD_PrintFormatItem SET PrintName='Campaign Key', Name='Campaign Key' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=54241)
;

-- Jan 16, 2013 4:24:13 AM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,Description,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('SalesRegionValue',202193,'D','Sales Region Key','Text key of the Sales Region','Sales Region Key','5e4ae95e-a657-415b-8950-d0607b734495',0,TO_TIMESTAMP('2013-01-16 04:24:13','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-01-16 04:24:13','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Jan 16, 2013 4:24:13 AM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202193 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Jan 16, 2013 4:27:32 AM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
INSERT INTO AD_Column (IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES ('N','N',1,599,208378,'D','N','N','N',0,'N',40,'N',10,'N',53222,'N','Y','b422b2fa-1e2c-44ff-869e-d9dc1868e5a4','Y','ActivityValue','Text key for Activity','Activity Key','Y',TO_TIMESTAMP('2013-01-16 04:27:31','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-01-16 04:27:31','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 16, 2013 4:27:32 AM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208378 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 16, 2013 4:27:34 AM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
ALTER TABLE I_GLJournal ADD COLUMN ActivityValue VARCHAR(40) DEFAULT NULL 
;

-- Jan 16, 2013 4:28:25 AM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
INSERT INTO AD_Column (IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES ('N','N',1,599,208379,'D','N','N','N',0,'N',40,'N',10,'N',54241,'N','Y','1e417c58-e70d-43a9-b791-6b885f4696b4','Y','CampaignValue','Text key of the Campaign','Campaign Key','Y',TO_TIMESTAMP('2013-01-16 04:28:24','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-01-16 04:28:24','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 16, 2013 4:28:25 AM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208379 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 16, 2013 4:28:31 AM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
ALTER TABLE I_GLJournal ADD COLUMN CampaignValue VARCHAR(40) DEFAULT NULL 
;

-- Jan 16, 2013 4:29:17 AM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
INSERT INTO AD_Column (IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES ('N','N',1,599,208380,'D','N','N','N',0,'N',40,'N',10,'N',202193,'N','Y','59321609-8c57-4b5f-91e4-94604eac91af','Y','SalesRegionValue','Text key of the Sales Region','Sales Region Key','Y',TO_TIMESTAMP('2013-01-16 04:29:16','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-01-16 04:29:16','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 16, 2013 4:29:17 AM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208380 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 16, 2013 4:29:21 AM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
ALTER TABLE I_GLJournal ADD COLUMN SalesRegionValue VARCHAR(40) DEFAULT NULL 
;

-- Jan 16, 2013 4:31:41 AM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
INSERT INTO AD_Field (ColumnSpan,NumLines,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry) VALUES (2,1,'N',508,20,'N','N',208378,515,'Y',201651,'N','D','Text key for Activity','Activity Key','Y','N','a394d053-f0c2-436b-aed5-e84967c4be81',100,0,TO_TIMESTAMP('2013-01-16 04:31:40','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-01-16 04:31:40','YYYY-MM-DD HH24:MI:SS'),'Y','Y',515,1,'N')
;

-- Jan 16, 2013 4:31:41 AM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201651 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 16, 2013 4:32:35 AM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
INSERT INTO AD_Field (ColumnSpan,NumLines,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry) VALUES (2,1,'N',508,20,'N','N',208379,505,'Y',201652,'N','D','Text key of the Campaign','Campaign Key','Y','N','9fd17334-4a7b-4585-a96a-000bc99d54ec',100,0,TO_TIMESTAMP('2013-01-16 04:32:35','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-01-16 04:32:35','YYYY-MM-DD HH24:MI:SS'),'Y','Y',505,1,'N')
;

-- Jan 16, 2013 4:32:35 AM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201652 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 16, 2013 4:33:32 AM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
INSERT INTO AD_Field (ColumnSpan,NumLines,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry) VALUES (2,1,'N',508,20,'N','N',208380,525,'Y',201653,'N','D','Text key of the Sales Region','Sales Region Key','Y','N','245b156e-5dc9-41f9-8f41-f49d8607ae52',100,0,TO_TIMESTAMP('2013-01-16 04:33:32','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-01-16 04:33:32','YYYY-MM-DD HH24:MI:SS'),'Y','Y',525,1,'N')
;

-- Jan 16, 2013 4:33:32 AM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201653 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 16, 2013 4:34:19 AM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2013-01-16 04:34:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7114
;

-- Jan 16, 2013 4:34:35 AM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2013-01-16 04:34:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7157
;

SELECT register_migration_script('201301160230_IDEMPIERE-539.sql') FROM dual
;
