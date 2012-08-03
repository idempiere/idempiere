-- Jul 30, 2012 5:47:12 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,Description,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('IsShowInDashboard',1000000,'U','Show in Dashboard','Show the dashlet in the dashboard','Show in Dashboard','7d368f1f-8e8c-41d6-b427-abd9b4853d8f',0,TO_TIMESTAMP('2012-07-30 17:47:12','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-07-30 17:47:12','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Jul 30, 2012 5:47:12 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=1000000 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Jul 30, 2012 5:47:33 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,50010,1000000,'U','Y','N','N',0,'N',1,'N',20,'N','N',1000000,'N','Y','d8dc950e-ddf5-4846-9cba-d7924dd08ece','N','Y','N','IsShowInDashboard','Show the dashlet in the dashboard','''Y''','Show in Dashboard','Y',100,TO_TIMESTAMP('2012-07-30 17:47:33','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-07-30 17:47:33','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Jul 30, 2012 5:47:33 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=1000000 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 30, 2012 5:47:39 PM SGT
-- Move the Menu to be a Portlet
ALTER TABLE PA_DashboardContent ADD COLUMN IsShowInDashboard CHAR(1) DEFAULT 'Y' CHECK (IsShowInDashboard IN ('Y','N')) NOT NULL
;

-- Jul 30, 2012 5:48:10 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',50010,36,'N','N',60964,'Y',1000000,'N','D','PA_DashboardContent_UU','Y','N','fa330423-848e-4f6e-b94b-ca502f03c228',100,0,TO_TIMESTAMP('2012-07-30 17:48:10','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-07-30 17:48:10','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jul 30, 2012 5:48:10 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=1000000 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 30, 2012 5:48:10 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',50010,1,'N','N',1000000,'Y',1000001,'N','U','Show the dashlet in the dashboard','Show in Dashboard','Y','N','ced4be5c-cd78-44d4-8f84-561ceec749ce',100,0,TO_TIMESTAMP('2012-07-30 17:48:10','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-07-30 17:48:10','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jul 30, 2012 5:48:10 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=1000001 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 30, 2012 5:48:21 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=1000000
;

-- Jul 30, 2012 5:48:21 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=56504
;

-- Jul 30, 2012 5:48:21 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=1000001
;

-- Aug 2, 2012 10:50:25 AM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,50010,1000001,'U','N','N','N',0,'N',10,'N',19,'N','N',117,'N','Y','b65e85c5-494a-450d-a495-d81612e63cd6','N','Y','N','AD_Process_ID','Process or Report','The Process field identifies a unique Process or Report in the system.','Process','Y',100,TO_TIMESTAMP('2012-08-02 10:50:25','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-02 10:50:25','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 2, 2012 10:50:25 AM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=1000001 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 2, 2012 10:50:42 AM SGT
-- Move the Menu to be a Portlet
ALTER TABLE PA_DashboardContent ADD COLUMN AD_Process_ID NUMERIC(10) DEFAULT NULL 
;

-- Aug 2, 2012 10:51:45 AM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,Description,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('IsEmbedReportContent',1000001,'U','Embed Report Content','Embed report content into dashboard','Embed Report Content','9b2c09ce-ffbd-49db-bdcf-922fa14c89d7',0,TO_TIMESTAMP('2012-08-02 10:51:45','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-08-02 10:51:45','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Aug 2, 2012 10:51:46 AM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=1000001 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 2, 2012 10:52:37 AM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,50010,1000002,'U','Y','N','N',0,'N',1,'N',20,'N','N',1000001,'N','Y','00f77d84-8488-45ae-b2c4-5560df00a01f','N','Y','N','IsEmbedReportContent','Embed report content into dashboard','N','Embed Report Content','Y',100,TO_TIMESTAMP('2012-08-02 10:52:37','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-02 10:52:37','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 2, 2012 10:52:37 AM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=1000002 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 2, 2012 10:52:41 AM SGT
-- Move the Menu to be a Portlet
ALTER TABLE PA_DashboardContent ADD COLUMN IsEmbedReportContent CHAR(1) DEFAULT 'N' CHECK (IsEmbedReportContent IN ('Y','N')) NOT NULL
;

-- Aug 2, 2012 10:53:50 AM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Help,EntityType,Name,Description,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('ProcessParameters',1000002,'A list of name value pair process parameter separated by comma','U','Process Parameters','Comma separated process parameter list','Process Parameters','ce4fe485-2380-42b6-9e42-62a6ddaadb92',0,TO_TIMESTAMP('2012-08-02 10:53:50','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-08-02 10:53:50','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Aug 2, 2012 10:53:50 AM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=1000002 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 2, 2012 10:54:33 AM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,50010,1000003,'U','N','N','N',0,'N',2000,'N',10,'N','N',1000002,'N','Y','07242c07-416a-4dec-8f0c-dab19d271d6d','N','Y','N','ProcessParameters','Comma separated process parameter list','A list of name value pair process parameter separated by comma','Process Parameters','Y',100,TO_TIMESTAMP('2012-08-02 10:54:33','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-02 10:54:33','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 2, 2012 10:54:33 AM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=1000003 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 2, 2012 10:54:37 AM SGT
-- Move the Menu to be a Portlet
ALTER TABLE PA_DashboardContent ADD COLUMN ProcessParameters VARCHAR(2000) DEFAULT NULL 
;

-- Aug 2, 2012 10:55:12 AM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',50010,1,'N','N',1000002,'Y',1000002,'N','U','Embed report content into dashboard','Embed Report Content','Y','N','c89622f5-06a4-4b36-8f4c-81b8f0487b21',100,0,TO_TIMESTAMP('2012-08-02 10:55:12','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-08-02 10:55:12','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Aug 2, 2012 10:55:12 AM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=1000002 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 2, 2012 10:55:12 AM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',50010,10,'N','N',1000001,'Y',1000003,'N','The Process field identifies a unique Process or Report in the system.','U','Process or Report','Process','Y','N','58a3f72c-fff4-4209-8625-9b63d3e5f9be',100,0,TO_TIMESTAMP('2012-08-02 10:55:12','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-08-02 10:55:12','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Aug 2, 2012 10:55:12 AM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=1000003 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 2, 2012 10:55:12 AM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',50010,2000,'N','N',1000003,'Y',1000004,'N','A list of name value pair process parameter separated by comma','U','Comma separated process parameter list','Process Parameters','Y','N','7baae861-ad87-44ec-b2d0-5c0c7e9b0f87',100,0,TO_TIMESTAMP('2012-08-02 10:55:12','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-08-02 10:55:12','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Aug 2, 2012 10:55:12 AM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=1000004 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 2, 2012 10:55:35 AM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=1000003
;

-- Aug 2, 2012 10:55:35 AM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=1000002
;

-- Aug 2, 2012 10:55:35 AM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=1000004
;

-- Aug 2, 2012 10:56:20 AM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET IsSameLine='Y', DefaultValue='@AD_Process_ID@!0',Updated=TO_TIMESTAMP('2012-08-02 10:56:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1000002
;

-- Aug 2, 2012 10:56:57 AM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET DefaultValue='@AD_Process_ID@!0&@IsEmbedReportContent@=''Y''',Updated=TO_TIMESTAMP('2012-08-02 10:56:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1000004
;

-- Aug 2, 2012 4:58:46 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,Description,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('HeaderColor',1000003,'U','Header Color','Header color of calendar dashlet','Header Color','5eb8a795-bb75-4ab6-8e60-4b780e80b7bd',0,TO_TIMESTAMP('2012-08-02 16:58:45','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-08-02 16:58:45','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Aug 2, 2012 4:58:46 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=1000003 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 2, 2012 4:59:03 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,529,1000004,'U','N','N','N',0,'N',7,'N',10,'N','N',1000003,'N','Y','2da3cc0f-9db0-404f-ad1a-c306d6f65a9c','N','Y','N','HeaderColor','Header color of calendar dashlet','Header Color','Y',100,TO_TIMESTAMP('2012-08-02 16:59:03','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-02 16:59:03','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 2, 2012 4:59:03 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=1000004 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 2, 2012 4:59:14 PM SGT
-- Move the Menu to be a Portlet
ALTER TABLE R_RequestType ADD COLUMN HeaderColor VARCHAR(7) DEFAULT NULL 
;

-- Aug 2, 2012 4:59:45 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,Description,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('ContentColor',1000004,'U','Content Color','Content color of calendar dashlet','Content Color','b94231dd-8bda-46e3-8e5d-2b6753150549',0,TO_TIMESTAMP('2012-08-02 16:59:45','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-08-02 16:59:45','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Aug 2, 2012 4:59:45 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=1000004 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 2, 2012 5:00:05 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,529,1000005,'U','N','N','N',0,'N',7,'N',10,'N','N',1000004,'N','Y','63b8d845-33b8-4632-bbd8-b6caeee09c66','N','Y','N','ContentColor','Content color of calendar dashlet','Content Color','Y',100,TO_TIMESTAMP('2012-08-02 17:00:05','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-02 17:00:05','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 2, 2012 5:00:05 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=1000005 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 2, 2012 5:00:09 PM SGT
-- Move the Menu to be a Portlet
ALTER TABLE R_RequestType ADD COLUMN ContentColor VARCHAR(7) DEFAULT NULL 
;

-- Aug 2, 2012 5:00:26 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',437,7,'N','N',1000005,'Y',1000005,'N','U','Content color of calendar dashlet','Content Color','Y','N','fcf10a9f-a004-43d4-84a3-13c93590918e',100,0,TO_TIMESTAMP('2012-08-02 17:00:26','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-08-02 17:00:26','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Aug 2, 2012 5:00:26 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=1000005 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 2, 2012 5:00:26 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',437,7,'N','N',1000004,'Y',1000006,'N','U','Header color of calendar dashlet','Header Color','Y','N','fd8cca24-1b80-4cfe-84fa-7826757b60f4',100,0,TO_TIMESTAMP('2012-08-02 17:00:26','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-08-02 17:00:26','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Aug 2, 2012 5:00:26 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=1000006 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 2, 2012 5:00:26 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',437,1,'N','N',15805,'Y',1000007,'N','For cross document search, the document can be indexed for faster search (Container, Document Type, Request Type)','D','Index the document for the internal search engine','Indexed','Y','N','6b54a3cb-2e86-407c-88d4-3f64ceea240b',100,0,TO_TIMESTAMP('2012-08-02 17:00:26','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-08-02 17:00:26','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Aug 2, 2012 5:00:26 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=1000007 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 2, 2012 5:00:26 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',437,36,'N','N',61027,'Y',1000008,'N','D','R_RequestType_UU','Y','N','f75af72f-116c-4780-b38b-323cf5dd9428',100,0,TO_TIMESTAMP('2012-08-02 17:00:26','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-08-02 17:00:26','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Aug 2, 2012 5:00:26 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=1000008 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 2, 2012 5:00:38 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=1000007
;

-- Aug 2, 2012 5:00:38 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=1000008
;

-- Aug 2, 2012 5:00:38 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=1000006
;

-- Aug 2, 2012 5:00:38 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y' WHERE AD_Field_ID=1000005
;

-- Aug 2, 2012 5:00:49 PM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2012-08-02 17:00:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1000005
;

-- Aug 3, 2012 10:41:17 AM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,50010,1000006,'U','Y','N','N',0,'N',1,'N',20,'N','N',53336,'N','Y','944e6718-0fe6-4d11-a874-d84987523f63','N','Y','N','IsCollapsedByDefault','Flag to set the initial state of collapsible field group.','N','Collapsed By Default','Y',100,TO_TIMESTAMP('2012-08-03 10:41:17','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-03 10:41:17','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 3, 2012 10:41:17 AM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=1000006 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 3, 2012 10:41:25 AM SGT
-- Move the Menu to be a Portlet
ALTER TABLE PA_DashboardContent ADD COLUMN IsCollapsedByDefault CHAR(1) DEFAULT 'N' CHECK (IsCollapsedByDefault IN ('Y','N')) NOT NULL
;

-- Aug 3, 2012 10:42:03 AM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',50010,1,'N','N',1000006,'Y',1000009,'N','U','Flag to set the initial state of collapsible field group.','Collapsed By Default','Y','N','1953b83a-94b5-4fd7-98b8-d8b4d7b9e718',100,0,TO_TIMESTAMP('2012-08-03 10:42:02','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-08-03 10:42:02','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Aug 3, 2012 10:42:03 AM SGT
-- Move the Menu to be a Portlet
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=1000009 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 3, 2012 10:42:17 AM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=1000009
;

-- Aug 3, 2012 10:42:17 AM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=1000001
;

-- Aug 3, 2012 10:42:17 AM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=1000003
;

-- Aug 3, 2012 10:42:17 AM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=1000002
;

-- Aug 3, 2012 10:42:17 AM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y' WHERE AD_Field_ID=1000004
;

-- Aug 3, 2012 10:42:41 AM SGT
-- Move the Menu to be a Portlet
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2012-08-03 10:42:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1000009
;

-- Aug 3, 2012 2:49:53 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO PA_DashboardContent (Line,PA_DashboardContent_ID,ZulFilePath,ColumnNo,IsCollapsible,GoalDisplay,Description,Name,AD_Org_ID,Created,CreatedBy,Updated,AD_Client_ID,UpdatedBy,IsActive,PA_DashboardContent_UU,IsShowInDashboard,IsEmbedReportContent,IsCollapsedByDefault) VALUES (0,1000006,'/zul/menuTree.zul',0,'Y','T','Menu','Menu',0,TO_TIMESTAMP('2012-08-03 14:49:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2012-08-03 14:49:53','YYYY-MM-DD HH24:MI:SS'),0,100,'Y','a0c98b7a-56d5-44d5-850b-d969a5abb65f','N','N','N')
;

-- Aug 3, 2012 2:49:53 PM SGT
-- Move the Menu to be a Portlet
INSERT INTO PA_DashboardContent_Trl (AD_Language,PA_DashboardContent_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.PA_DashboardContent_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, PA_DashboardContent t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.PA_DashboardContent_ID=1000006 AND NOT EXISTS (SELECT * FROM PA_DashboardContent_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.PA_DashboardContent_ID=t.PA_DashboardContent_ID)
;