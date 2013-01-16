-- Jan 15, 2013 9:15:26 PM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
UPDATE AD_Element SET Name='Activity Key', Description='Text key of the Activity', PrintName='Activity Key',Updated=TO_TIMESTAMP('2013-01-15 21:15:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53222
;

-- Jan 15, 2013 9:15:26 PM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=53222
;

-- Jan 15, 2013 9:15:26 PM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
UPDATE AD_Column SET ColumnName='ActivityValue', Name='Activity Key', Description='Text key of the Activity', Help=NULL WHERE AD_Element_ID=53222
;

-- Jan 15, 2013 9:15:26 PM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
UPDATE AD_Process_Para SET ColumnName='ActivityValue', Name='Activity Key', Description='Text key of the Activity', Help=NULL, AD_Element_ID=53222 WHERE UPPER(ColumnName)='ACTIVITYVALUE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Jan 15, 2013 9:15:26 PM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
UPDATE AD_Process_Para SET ColumnName='ActivityValue', Name='Activity Key', Description='Text key of the Activity', Help=NULL WHERE AD_Element_ID=53222 AND IsCentrallyMaintained='Y'
;

-- Jan 15, 2013 9:15:26 PM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
UPDATE AD_InfoColumn SET ColumnName='ActivityValue', Name='Activity Key', Description='Text key of the Activity', Help=NULL WHERE AD_Element_ID=53222 AND IsCentrallyMaintained='Y'
;

-- Jan 15, 2013 9:15:26 PM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
UPDATE AD_Field SET Name='Activity Key', Description='Text key of the Activity', Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=53222) AND IsCentrallyMaintained='Y'
;

-- Jan 15, 2013 9:15:27 PM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
UPDATE AD_PrintFormatItem SET PrintName='Activity Key', Name='Activity Key' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=53222)
;

-- Jan 15, 2013 9:15:50 PM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
UPDATE AD_Element SET Name='Campaign Key', Description='Text key of the Campaign', PrintName='Campaign Key',Updated=TO_TIMESTAMP('2013-01-15 21:15:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=54241
;

-- Jan 15, 2013 9:15:50 PM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=54241
;

-- Jan 15, 2013 9:15:50 PM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
UPDATE AD_Column SET ColumnName='CampaignValue', Name='Campaign Key', Description='Text key of the Campaign', Help=NULL WHERE AD_Element_ID=54241
;

-- Jan 15, 2013 9:15:50 PM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
UPDATE AD_Process_Para SET ColumnName='CampaignValue', Name='Campaign Key', Description='Text key of the Campaign', Help=NULL, AD_Element_ID=54241 WHERE UPPER(ColumnName)='CAMPAIGNVALUE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Jan 15, 2013 9:15:50 PM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
UPDATE AD_Process_Para SET ColumnName='CampaignValue', Name='Campaign Key', Description='Text key of the Campaign', Help=NULL WHERE AD_Element_ID=54241 AND IsCentrallyMaintained='Y'
;

-- Jan 15, 2013 9:15:50 PM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
UPDATE AD_InfoColumn SET ColumnName='CampaignValue', Name='Campaign Key', Description='Text key of the Campaign', Help=NULL WHERE AD_Element_ID=54241 AND IsCentrallyMaintained='Y'
;

-- Jan 15, 2013 9:15:50 PM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
UPDATE AD_Field SET Name='Campaign Key', Description='Text key of the Campaign', Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=54241) AND IsCentrallyMaintained='Y'
;

-- Jan 15, 2013 9:15:50 PM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
UPDATE AD_PrintFormatItem SET PrintName='Campaign Key', Name='Campaign Key' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=54241)
;

-- Jan 15, 2013 9:16:29 PM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,Description,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('SalesRegionValue',1000000,'D','Sales Region Key','Text key of the Sales Region','Sales Region Key','4a650dff-ca51-4138-8d88-15ff37c9a6b9',0,TO_TIMESTAMP('2013-01-15 21:16:29','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-01-15 21:16:29','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Jan 15, 2013 9:16:29 PM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=1000000 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Jan 15, 2013 9:18:02 PM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
INSERT INTO AD_Column (IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES ('N','N',1,599,1000000,'D','N','N','N',0,'N',40,'N',10,'N',53222,'N','Y','ea5cae38-e5ca-41ed-84cf-b705047423b2','Y','ActivityValue','Text key of the Activity','Activity Key','Y',TO_TIMESTAMP('2013-01-15 21:18:02','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-01-15 21:18:02','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 15, 2013 9:18:02 PM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=1000000 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 15, 2013 9:18:56 PM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
INSERT INTO AD_Column (IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES ('N','N',1,599,1000001,'D','N','N','N',0,'N',40,'N',10,'N',54241,'N','Y','7b723ab4-6cbc-49aa-882a-4b96f1b293f7','Y','CampaignValue','Text key of the Campaign','Campaign Key','Y',TO_TIMESTAMP('2013-01-15 21:18:56','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-01-15 21:18:56','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 15, 2013 9:18:57 PM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=1000001 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 15, 2013 9:19:29 PM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
INSERT INTO AD_Column (IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES ('N','N',1,599,1000002,'U','N','N','N',0,'N',40,'N',10,'N',1000000,'N','Y','602a3901-4ead-4d0e-bd75-f9e78f37e107','Y','SalesRegionValue','Text key of the Sales Region','Sales Region Key','Y',TO_TIMESTAMP('2013-01-15 21:19:29','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-01-15 21:19:29','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 15, 2013 9:19:29 PM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=1000002 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 15, 2013 9:19:39 PM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2013-01-15 21:19:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=1000002
;

-- Jan 15, 2013 9:19:51 PM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
ALTER TABLE I_GLJournal ADD COLUMN ActivityValue VARCHAR(40) DEFAULT NULL 
;

-- Jan 15, 2013 9:19:59 PM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
ALTER TABLE I_GLJournal ADD COLUMN CampaignValue VARCHAR(40) DEFAULT NULL 
;

-- Jan 15, 2013 9:20:04 PM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
ALTER TABLE I_GLJournal ADD COLUMN SalesRegionValue VARCHAR(40) DEFAULT NULL 
;

-- Jan 15, 2013 9:21:43 PM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
INSERT INTO AD_Field (ColumnSpan,NumLines,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry) VALUES (2,1,'N',508,20,'N','N',1000000,505,'Y',1000000,'N','D','Text key of the Activity','Activity Key','Y','N','f8fc818a-793a-4237-9e21-50b0fde8477d',100,0,TO_TIMESTAMP('2013-01-15 21:21:42','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-01-15 21:21:42','YYYY-MM-DD HH24:MI:SS'),'Y','Y',505,1,'N')
;

-- Jan 15, 2013 9:21:43 PM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=1000000 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 15, 2013 9:22:35 PM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
INSERT INTO AD_Field (ColumnSpan,NumLines,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry) VALUES (2,1,'N',508,20,'N','N',1000001,515,'Y',1000001,'N','D','Text key of the Campaign','Campaign Key','Y','N','3dd3f08e-fb5c-4f83-92fe-1588db8def3b',100,0,TO_TIMESTAMP('2013-01-15 21:22:35','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-01-15 21:22:35','YYYY-MM-DD HH24:MI:SS'),'Y','Y',515,1,'N')
;

-- Jan 15, 2013 9:22:35 PM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=1000001 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 15, 2013 9:23:41 PM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
INSERT INTO AD_Field (ColumnSpan,NumLines,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry) VALUES (2,1,'N',508,20,'N','N',1000002,525,'Y',1000002,'N','D','Text key of the Sales Region','Sales Region Key','Y','N','973293e0-b18b-4d33-9092-40da4b686bc4',100,0,TO_TIMESTAMP('2013-01-15 21:23:40','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-01-15 21:23:40','YYYY-MM-DD HH24:MI:SS'),'Y','Y',525,1,'N')
;

-- Jan 15, 2013 9:23:41 PM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=1000002 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 15, 2013 9:24:36 PM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2013-01-15 21:24:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7114
;

-- Jan 15, 2013 9:24:51 PM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2013-01-15 21:24:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7157
;

-- Jan 15, 2013 9:30:08 PM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
UPDATE AD_Field SET SeqNo=515, SeqNoGrid=515,Updated=TO_TIMESTAMP('2013-01-15 21:30:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1000000
;

-- Jan 15, 2013 9:30:15 PM CET
-- IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
UPDATE AD_Field SET SeqNo=505, SeqNoGrid=505,Updated=TO_TIMESTAMP('2013-01-15 21:30:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1000001
;

SELECT register_migration_script('201301160230_IDEMPIERE-539.sql') FROM dual
;
