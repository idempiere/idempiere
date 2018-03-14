-- Aug 30, 2012 3:45:37 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('IsLocked',200111,'U','Locked','Locked','0988d4d3-c46e-4d51-8474-38d81b16ad57',0,TO_TIMESTAMP('2012-08-30 15:45:36','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-08-30 15:45:36','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Aug 30, 2012 3:45:38 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200111 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 30, 2012 3:46:11 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,DefaultValue,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,114,200404,'D','Y','N','N',0,'N',1,'N',20,'N','N',200111,'N','Y','fb4326ef-4bb7-405e-8e76-5d0a178c6f70','N','Y','N','IsLocked','''N''','Locked','Y',100,TO_TIMESTAMP('2012-08-30 15:46:11','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-30 15:46:11','YYYY-MM-DD HH24:MI:SS'),100,0,0)
;

-- Aug 30, 2012 3:46:12 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200404 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 30, 2012 3:46:16 PM SGT
-- IDEMPIERE-373 Implement User Locking
ALTER TABLE AD_User ADD COLUMN IsLocked CHAR(1) DEFAULT 'N' CHECK (IsLocked IN ('Y','N')) NOT NULL
;

-- Aug 30, 2012 3:46:30 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Element SET EntityType='D',Updated=TO_TIMESTAMP('2012-08-30 15:46:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200111
;

-- Aug 30, 2012 3:47:03 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('DateAccountLocked',200112,'D','Date Account Locked','Date Account Locked','1214f78d-8511-40ff-90d1-0ea2f2e8ba18',0,TO_TIMESTAMP('2012-08-30 15:47:02','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-08-30 15:47:02','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Aug 30, 2012 3:47:03 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200112 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 30, 2012 3:47:42 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,114,200405,'U','N','N','N',0,'N',7,'N',16,'N','N',200112,'N','Y','c7f6d455-4956-4a11-a528-ee007dd3c49d','N','Y','N','DateAccountLocked','Date Account Locked','Y',100,TO_TIMESTAMP('2012-08-30 15:47:42','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-30 15:47:42','YYYY-MM-DD HH24:MI:SS'),100,0,0)
;

-- Aug 30, 2012 3:47:43 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200405 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 30, 2012 3:47:50 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2012-08-30 15:47:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200405
;

-- Aug 30, 2012 3:47:53 PM SGT
-- IDEMPIERE-373 Implement User Locking
ALTER TABLE AD_User ADD COLUMN DateAccountLocked TIMESTAMP DEFAULT NULL 
;

-- Aug 30, 2012 3:48:22 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('FailedLoginCount',200113,'D','Failed Login Count','Failed Login Count','a9cb3baf-263d-48c4-86b5-36f629403eb3',0,TO_TIMESTAMP('2012-08-30 15:48:21','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-08-30 15:48:21','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Aug 30, 2012 3:48:22 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200113 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 30, 2012 3:48:52 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,DefaultValue,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,114,200406,'D','Y','N','N',0,'N',14,'N',11,'N','N',200113,'N','Y','8d212739-78bc-4c64-ba6e-8365008e2d4c','N','Y','N','FailedLoginCount','0','Failed Login Count','Y',100,TO_TIMESTAMP('2012-08-30 15:48:51','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-30 15:48:51','YYYY-MM-DD HH24:MI:SS'),100,0,0)
;

-- Aug 30, 2012 3:48:52 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200406 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 30, 2012 3:48:56 PM SGT
-- IDEMPIERE-373 Implement User Locking
ALTER TABLE AD_User ADD COLUMN FailedLoginCount NUMERIC(10) DEFAULT '0' NOT NULL
;

-- Aug 30, 2012 3:49:19 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('DatePasswordChanged',200114,'U','Date Password Changed','Date Password Changed','0f29bfb6-4517-4490-848c-be9db13468f9',0,TO_TIMESTAMP('2012-08-30 15:49:19','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-08-30 15:49:19','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Aug 30, 2012 3:49:19 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200114 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 30, 2012 3:49:33 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,114,200407,'U','N','N','N',0,'N',7,'N',16,'N','N',200114,'N','Y','1c04e2e3-8910-490d-a459-5cb1a3ec5a1d','N','Y','N','DatePasswordChanged','Date Password Changed','Y',100,TO_TIMESTAMP('2012-08-30 15:49:32','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-30 15:49:32','YYYY-MM-DD HH24:MI:SS'),100,0,0)
;

-- Aug 30, 2012 3:49:33 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200407 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 30, 2012 3:49:37 PM SGT
-- IDEMPIERE-373 Implement User Locking
ALTER TABLE AD_User ADD COLUMN DatePasswordChanged TIMESTAMP DEFAULT NULL 
;

-- Aug 30, 2012 3:50:00 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('DateLastLogin',200115,'U','Date Last Login','Date Last Login','584365fe-c1d2-4378-9650-b56b1462b59e',0,TO_TIMESTAMP('2012-08-30 15:49:59','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-08-30 15:49:59','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Aug 30, 2012 3:50:00 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200115 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 30, 2012 3:50:12 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,114,200408,'U','N','N','N',0,'N',7,'N',16,'N','N',200115,'N','Y','6885fa87-4608-418c-a5d7-d94875c7ac91','N','Y','N','DateLastLogin','Date Last Login','Y',100,TO_TIMESTAMP('2012-08-30 15:50:11','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-30 15:50:11','YYYY-MM-DD HH24:MI:SS'),100,0,0)
;

-- Aug 30, 2012 3:50:12 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200408 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 30, 2012 3:50:19 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2012-08-30 15:50:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200408
;

-- Aug 30, 2012 3:50:21 PM SGT
-- IDEMPIERE-373 Implement User Locking
ALTER TABLE AD_User ADD COLUMN DateLastLogin TIMESTAMP DEFAULT NULL 
;

-- Aug 30, 2012 3:51:46 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('IsNoPasswordReset',200116,'D','No Password Reset','No Password Reset','b265e8c9-04e2-442a-acbb-f98edaf292b9',0,TO_TIMESTAMP('2012-08-30 15:51:45','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-08-30 15:51:45','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Aug 30, 2012 3:51:46 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200116 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 30, 2012 3:52:10 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,DefaultValue,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,114,200409,'D','Y','N','N',0,'N',1,'N',20,'N','N',200116,'N','Y','c5b7f0e4-8e88-4614-a39e-783c2d74d4fc','N','Y','N','IsNoPasswordReset','''N''','No Password Reset','Y',100,TO_TIMESTAMP('2012-08-30 15:52:10','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-30 15:52:10','YYYY-MM-DD HH24:MI:SS'),100,0,0)
;

-- Aug 30, 2012 3:52:10 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200409 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 30, 2012 3:52:12 PM SGT
-- IDEMPIERE-373 Implement User Locking
ALTER TABLE AD_User ADD COLUMN IsNoPasswordReset CHAR(1) DEFAULT 'N' CHECK (IsNoPasswordReset IN ('Y','N')) NOT NULL
;

-- Aug 30, 2012 3:52:32 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',118,36,'N','N',60528,'Y',200399,'N','D','AD_User_UU','Y','N','a332188e-d618-4c95-a703-6e2a169ca9ac',100,0,TO_TIMESTAMP('2012-08-30 15:52:31','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-08-30 15:52:31','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Aug 30, 2012 3:52:33 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200399 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 30, 2012 3:52:34 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',118,7,'N','N',200405,'Y',200400,'N','D','Date Account Locked','Y','N','dc64d823-725e-44f9-865e-7009e9eea0bb',100,0,TO_TIMESTAMP('2012-08-30 15:52:33','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-08-30 15:52:33','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Aug 30, 2012 3:52:34 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200400 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 30, 2012 3:52:34 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',118,7,'N','N',200408,'Y',200401,'N','D','Date Last Login','Y','N','49dbb591-067c-4136-ad03-434309b8545f',100,0,TO_TIMESTAMP('2012-08-30 15:52:34','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-08-30 15:52:34','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Aug 30, 2012 3:52:34 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200401 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 30, 2012 3:52:35 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',118,7,'N','N',200407,'Y',200402,'N','U','Date Password Changed','Y','N','ff1d49b7-2ce7-490f-ae95-e1ec42b6cb4b',100,0,TO_TIMESTAMP('2012-08-30 15:52:34','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-08-30 15:52:34','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Aug 30, 2012 3:52:35 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200402 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 30, 2012 3:52:36 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',118,14,'N','N',200406,'Y',200403,'N','D','Failed Login Count','Y','N','153b851b-eb43-4245-8572-e7d4ed591424',100,0,TO_TIMESTAMP('2012-08-30 15:52:35','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-08-30 15:52:35','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Aug 30, 2012 3:52:36 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200403 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 30, 2012 3:52:36 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',118,1,'N','N',56294,'Y',200404,'N','EE02','Defined if any User Contact will be used for Calculate Payroll','Is In Payroll','Y','N','88e0446c-706d-4770-b27b-2c10622d40ba',100,0,TO_TIMESTAMP('2012-08-30 15:52:36','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-08-30 15:52:36','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Aug 30, 2012 3:52:36 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200404 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 30, 2012 3:52:37 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',118,1,'N','N',200404,'Y',200405,'N','D','Locked','Y','N','b5b96ad1-f11d-483b-8dbf-4def8027da50',100,0,TO_TIMESTAMP('2012-08-30 15:52:36','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-08-30 15:52:36','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Aug 30, 2012 3:52:37 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200405 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 30, 2012 3:52:38 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',118,1,'N','N',200409,'Y',200406,'N','D','No Password Reset','Y','N','9ca76696-1087-4b68-96a3-feb02cf251d5',100,0,TO_TIMESTAMP('2012-08-30 15:52:37','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-08-30 15:52:37','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Aug 30, 2012 3:52:38 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200406 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 30, 2012 3:52:39 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',118,16,'N','N',61756,'Y',200407,'N','D','Random data added to improve password hash effectiveness','Salt','Y','N','90d88711-04b2-48d4-b6f6-f93fbe73549a',100,0,TO_TIMESTAMP('2012-08-30 15:52:38','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-08-30 15:52:38','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Aug 30, 2012 3:52:39 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200407 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 30, 2012 3:53:51 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200399
;

-- Aug 30, 2012 3:53:51 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200404
;

-- Aug 30, 2012 3:53:51 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200407
;

-- Aug 30, 2012 3:53:51 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Field SET SeqNo=330,IsDisplayed='Y' WHERE AD_Field_ID=200405
;

-- Aug 30, 2012 3:53:51 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Field SET SeqNo=340,IsDisplayed='Y' WHERE AD_Field_ID=200400
;

-- Aug 30, 2012 3:53:51 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Field SET SeqNo=350,IsDisplayed='Y' WHERE AD_Field_ID=200403
;

-- Aug 30, 2012 3:53:51 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Field SET SeqNo=360,IsDisplayed='Y' WHERE AD_Field_ID=200401
;

-- Aug 30, 2012 3:53:51 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Field SET SeqNo=370,IsDisplayed='Y' WHERE AD_Field_ID=200402
;

-- Aug 30, 2012 3:53:51 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Field SET SeqNo=380,IsDisplayed='Y' WHERE AD_Field_ID=200406
;

-- Aug 30, 2012 3:54:19 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200399
;

-- Aug 30, 2012 3:54:19 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200404
;

-- Aug 30, 2012 3:54:19 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200407
;

-- Aug 30, 2012 3:54:19 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Field SET SeqNoGrid=330,IsDisplayedGrid='Y' WHERE AD_Field_ID=200405
;

-- Aug 30, 2012 3:54:19 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Field SET SeqNoGrid=340,IsDisplayedGrid='Y' WHERE AD_Field_ID=200400
;

-- Aug 30, 2012 3:54:19 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Field SET SeqNoGrid=350,IsDisplayedGrid='Y' WHERE AD_Field_ID=200403
;

-- Aug 30, 2012 3:54:19 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Field SET SeqNoGrid=360,IsDisplayedGrid='Y' WHERE AD_Field_ID=200401
;

-- Aug 30, 2012 3:54:19 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Field SET SeqNoGrid=370,IsDisplayedGrid='Y' WHERE AD_Field_ID=200402
;

-- Aug 30, 2012 3:54:19 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Field SET SeqNoGrid=380,IsDisplayedGrid='Y' WHERE AD_Field_ID=200406
;

-- Aug 30, 2012 3:54:40 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Field SET EntityType='D',Updated=TO_TIMESTAMP('2012-08-30 15:54:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200402
;

-- Aug 30, 2012 3:55:00 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2012-08-30 15:55:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200407
;

-- Aug 30, 2012 3:55:10 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Element SET EntityType='D',Updated=TO_TIMESTAMP('2012-08-30 15:55:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200114
;

-- Aug 30, 2012 3:55:33 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2012-08-30 15:55:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200400
;

-- Aug 30, 2012 3:55:42 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2012-08-30 15:55:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200401
;

-- Aug 30, 2012 3:55:49 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2012-08-30 15:55:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200406
;

-- Aug 30, 2012 3:56:11 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_FieldGroup (FieldGroupType,EntityType,IsCollapsedByDefault,Name,AD_FieldGroup_ID,AD_FieldGroup_UU,AD_Client_ID,Created,CreatedBy,Updated,AD_Org_ID,UpdatedBy,IsActive) VALUES ('C','D','N','User Locking',200003,'b6c15362-01ee-4ed5-8fd2-003f437cb7c1',0,TO_TIMESTAMP('2012-08-30 15:56:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2012-08-30 15:56:11','YYYY-MM-DD HH24:MI:SS'),0,100,'Y')
;

-- Aug 30, 2012 3:56:11 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_FieldGroup_Trl (AD_Language,AD_FieldGroup_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_FieldGroup_Trl_UU ) SELECT l.AD_Language,t.AD_FieldGroup_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_FieldGroup t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_FieldGroup_ID=200003 AND NOT EXISTS (SELECT * FROM AD_FieldGroup_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_FieldGroup_ID=t.AD_FieldGroup_ID)
;

-- Aug 30, 2012 3:56:20 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Field SET AD_FieldGroup_ID=200003,Updated=TO_TIMESTAMP('2012-08-30 15:56:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200405
;

-- Aug 30, 2012 3:56:27 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Field SET AD_FieldGroup_ID=200003,Updated=TO_TIMESTAMP('2012-08-30 15:56:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200400
;

-- Aug 30, 2012 3:56:32 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Field SET AD_FieldGroup_ID=200003,Updated=TO_TIMESTAMP('2012-08-30 15:56:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200403
;

-- Aug 30, 2012 3:56:38 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Field SET AD_FieldGroup_ID=200003,Updated=TO_TIMESTAMP('2012-08-30 15:56:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200401
;

-- Aug 30, 2012 3:56:44 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Field SET AD_FieldGroup_ID=200003,Updated=TO_TIMESTAMP('2012-08-30 15:56:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200402
;

-- Aug 30, 2012 3:56:52 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Field SET AD_FieldGroup_ID=200003,Updated=TO_TIMESTAMP('2012-08-30 15:56:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200406
;

-- Aug 30, 2012 3:58:46 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_SysConfig (AD_SysConfig_ID,EntityType,ConfigurationLevel,Value,Description,AD_SysConfig_UU,Created,Updated,AD_Client_ID,AD_Org_ID,CreatedBy,IsActive,UpdatedBy,Name) VALUES (200015,'D','S','0','Maximum account locking in minutes','d42a65e6-5b90-429f-b8cd-1fb004a890f2',TO_TIMESTAMP('2012-08-30 15:58:45','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-08-30 15:58:45','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Y',100,'USER_LOCKING_MAX_ACCOUNT_LOCK_MINUTES')
;

-- Aug 30, 2012 3:59:27 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_SysConfig (AD_SysConfig_ID,EntityType,ConfigurationLevel,Value,Description,AD_SysConfig_UU,Created,Updated,AD_Client_ID,AD_Org_ID,CreatedBy,IsActive,UpdatedBy,Name) VALUES (200016,'D','S','0','Maximum number of login attempts','bbde394f-2529-49ba-b69f-1625627f0027',TO_TIMESTAMP('2012-08-30 15:59:26','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-08-30 15:59:26','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Y',100,'USER_LOCKING_MAX_LOGIN_ATTEMPT')
;

-- Aug 30, 2012 4:00:52 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_SysConfig (AD_SysConfig_ID,EntityType,ConfigurationLevel,Value,Description,AD_SysConfig_UU,Created,Updated,AD_Client_ID,AD_Org_ID,CreatedBy,IsActive,UpdatedBy,Name) VALUES (200017,'D','S','0','Maximum password age in days','320e810f-b63d-4109-9321-917ff9572efb',TO_TIMESTAMP('2012-08-30 16:00:51','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-08-30 16:00:51','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Y',100,'USER_LOCKING_MAX_PASSWORD_AGE_DAY')
;

-- Aug 30, 2012 4:31:32 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Field SET SeqNo=370,IsDisplayed='Y' WHERE AD_Field_ID=200406
;

-- Aug 30, 2012 4:31:32 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Field SET SeqNo=380,IsDisplayed='Y' WHERE AD_Field_ID=200402
;

-- Aug 30, 2012 4:31:40 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Field SET SeqNoGrid=370,IsDisplayedGrid='Y' WHERE AD_Field_ID=200406
;

-- Aug 30, 2012 4:31:40 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Field SET SeqNoGrid=380,IsDisplayedGrid='Y' WHERE AD_Field_ID=200402
;

-- Aug 30, 2012 4:31:53 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2012-08-30 16:31:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200405
;

-- Aug 30, 2012 4:31:56 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2012-08-30 16:31:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200400
;

-- Aug 30, 2012 4:32:00 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2012-08-30 16:32:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200403
;

-- Aug 30, 2012 4:32:05 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2012-08-30 16:32:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200401
;

-- Aug 30, 2012 4:32:09 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Field SET IsSameLine='N',Updated=TO_TIMESTAMP('2012-08-30 16:32:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200406
;

-- Aug 30, 2012 4:32:14 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Field SET IsSameLine='Y', IsReadOnly='Y',Updated=TO_TIMESTAMP('2012-08-30 16:32:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200402
;

-- Aug 30, 2012 6:22:03 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_SysConfig (AD_SysConfig_ID,EntityType,ConfigurationLevel,Value,Description,AD_SysConfig_UU,Created,Updated,AD_Client_ID,AD_Org_ID,CreatedBy,IsActive,UpdatedBy,Name) VALUES (200018,'U','S','0','Maximum inactive period in days','04227b57-47e8-4b0c-a401-2cf6b280443d',TO_TIMESTAMP('2012-08-30 18:22:01','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-08-30 18:22:01','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Y',100,'USER_LOCKING_MAX_INACTIVE_PERIOD_DAY')
;

-- Aug 30, 2012 6:22:23 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_SysConfig SET EntityType='D',Updated=TO_TIMESTAMP('2012-08-30 18:22:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_SysConfig_ID=200018
;

-- Sep 3, 2012 6:50:03 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Process (Help,AD_Process_ID,IsDirectPrint,IsReport,AD_Process_UU,AccessLevel,IsBetaFunctionality,IsServerProcess,Statistic_Seconds,Statistic_Count,ShowHelp,EntityType,Classname,Description,Name,Value,AD_Org_ID,AD_Client_ID,Updated,UpdatedBy,Created,IsActive,CreatedBy) VALUES (NULL,200008,'N','N','4527cc85-0076-4ebf-9907-33efc94f25a3','7','N','N',0,0,'Y','U','org.adempiere.process.ResetLockedAccount','Reset Locked Account for User','Reset Locked Account','AD_User_LockedAccount',0,0,TO_TIMESTAMP('2012-09-03 18:50:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2012-09-03 18:50:01','YYYY-MM-DD HH24:MI:SS'),'Y',100)
;

-- Sep 3, 2012 6:50:03 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Process_Trl (AD_Language,AD_Process_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Process_Trl_UU ) SELECT l.AD_Language,t.AD_Process_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Process t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_ID=200008 AND NOT EXISTS (SELECT * FROM AD_Process_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_ID=t.AD_Process_ID)
;

-- Sep 3, 2012 6:50:09 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Process SET EntityType='D',Updated=TO_TIMESTAMP('2012-09-03 18:50:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200008
;

-- Sep 3, 2012 6:50:46 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Process_Para (IsRange,AD_Element_ID,AD_Process_Para_ID,AD_Process_Para_UU,Help,AD_Process_ID,AD_Reference_ID,IsMandatory,EntityType,Name,ColumnName,Description,FieldLength,IsCentrallyMaintained,SeqNo,IsActive,UpdatedBy,Updated,CreatedBy,Created,AD_Org_ID,AD_Client_ID,IsEncrypted) VALUES ('N',102,200029,'7fec47ef-1b60-4537-a356-c036c7474e77','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200008,19,'Y','D','Client','AD_Client_ID','Client/Tenant for this installation.',0,'Y',10,'Y',100,TO_TIMESTAMP('2012-09-03 18:50:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2012-09-03 18:50:46','YYYY-MM-DD HH24:MI:SS'),0,0,'N')
;

-- Sep 3, 2012 6:50:47 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Process_Para_Trl (AD_Language,AD_Process_Para_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Process_Para_Trl_UU ) SELECT l.AD_Language,t.AD_Process_Para_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Process_Para t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_Para_ID=200029 AND NOT EXISTS (SELECT * FROM AD_Process_Para_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_Para_ID=t.AD_Process_Para_ID)
;

-- Sep 3, 2012 6:51:14 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Process_Para (IsRange,AD_Element_ID,AD_Process_Para_ID,AD_Process_Para_UU,Help,AD_Process_ID,AD_Reference_ID,IsMandatory,EntityType,Name,ColumnName,Description,FieldLength,IsCentrallyMaintained,SeqNo,IsActive,UpdatedBy,Updated,CreatedBy,Created,AD_Org_ID,AD_Client_ID,IsEncrypted) VALUES ('N',138,200030,'646405c2-cba9-452b-b62f-265d209d1dff','The User identifies a unique user in the system. This could be an internal user or a business partner contact',200008,19,'N','U','User/Contact','AD_User_ID','User within the system - Internal or Business Partner Contact',0,'Y',20,'Y',100,TO_TIMESTAMP('2012-09-03 18:51:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2012-09-03 18:51:13','YYYY-MM-DD HH24:MI:SS'),0,0,'N')
;

-- Sep 3, 2012 6:51:14 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Process_Para_Trl (AD_Language,AD_Process_Para_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Process_Para_Trl_UU ) SELECT l.AD_Language,t.AD_Process_Para_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Process_Para t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_Para_ID=200030 AND NOT EXISTS (SELECT * FROM AD_Process_Para_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_Para_ID=t.AD_Process_Para_ID)
;

-- Sep 3, 2012 6:52:17 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Menu (AD_Menu_ID,IsSummary,IsSOTrx,IsReadOnly,AD_Process_ID,EntityType,IsCentrallyMaintained,Name,Description,"action",AD_Menu_UU,IsActive,AD_Client_ID,CreatedBy,Updated,AD_Org_ID,Created,UpdatedBy) VALUES (200012,'N','N','N',200008,'D','Y','Reset Locked Account','Reset Locked Account for User','P','5c6927d6-fb4d-4762-b023-af032f963d74','Y',0,100,TO_TIMESTAMP('2012-09-03 18:52:16','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2012-09-03 18:52:16','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 3, 2012 6:52:17 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Menu_Trl (AD_Language,AD_Menu_ID, Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Menu_Trl_UU ) SELECT l.AD_Language,t.AD_Menu_ID, t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Menu t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Menu_ID=200012 AND NOT EXISTS (SELECT * FROM AD_Menu_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Menu_ID=t.AD_Menu_ID)
;

-- Sep 3, 2012 6:52:17 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', CURRENT_TIMESTAMP, 100, CURRENT_TIMESTAMP, 100,t.AD_Tree_ID, 200012, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200012)
;

-- Sep 3, 2012 6:52:33 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=0, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=200002
;

-- Sep 3, 2012 6:52:33 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=1, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=147
;

-- Sep 3, 2012 6:52:33 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=2, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=53246
;

-- Sep 3, 2012 6:52:33 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=3, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=487
;

-- Sep 3, 2012 6:52:33 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=4, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=200012
;

-- Sep 3, 2012 6:52:33 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=5, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=150
;

-- Sep 3, 2012 6:52:33 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=6, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=495
;

-- Sep 3, 2012 6:52:33 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=7, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=50007
;

-- Sep 3, 2012 6:52:33 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=8, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=362
;

-- Sep 3, 2012 6:52:33 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=9, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=200001
;

-- Sep 3, 2012 6:52:33 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=10, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=475
;

-- Sep 3, 2012 6:52:33 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=11, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=366
;

-- Sep 3, 2012 6:52:33 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=12, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=483
;

-- Sep 3, 2012 6:52:33 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=13, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=368
;

-- Sep 3, 2012 6:52:33 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=14, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=508
;

-- Sep 3, 2012 6:52:33 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=15, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=53348
;

-- Sep 3, 2012 6:53:50 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','Old Password',200027,'D','c9b0a4a7-642f-4256-a77e-e0e41b112b37','Old Password','Y',TO_TIMESTAMP('2012-09-03 18:53:50','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_TIMESTAMP('2012-09-03 18:53:50','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 3, 2012 6:53:51 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200027 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Sep 3, 2012 6:54:02 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','New Password',200028,'D','66f34194-4995-488f-8abc-78d382617a76','New Password','Y',TO_TIMESTAMP('2012-09-03 18:54:01','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_TIMESTAMP('2012-09-03 18:54:01','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 3, 2012 6:54:02 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200028 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Sep 3, 2012 6:54:13 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','New Password Confirm',200029,'D','b78295fc-eeec-4db7-ac8d-260f14e56de8','New Password Confirm','Y',TO_TIMESTAMP('2012-09-03 18:54:13','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_TIMESTAMP('2012-09-03 18:54:13','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 3, 2012 6:54:14 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200029 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Sep 3, 2012 6:55:00 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','New Password Confirm is Mandatory',200030,'D','b649b8ea-97f5-408a-81bd-12eb0e8ae388','NewPasswordConfirmMandatory','Y',TO_TIMESTAMP('2012-09-03 18:54:59','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_TIMESTAMP('2012-09-03 18:54:59','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 3, 2012 6:55:00 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200030 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Sep 3, 2012 6:56:29 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','Password does not match the confirm password',200031,'D','10fdcb04-bc7c-4c30-b149-570231862faf','PasswordNotMatch','Y',TO_TIMESTAMP('2012-09-03 18:56:28','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_TIMESTAMP('2012-09-03 18:56:28','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 3, 2012 6:56:29 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200031 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Sep 3, 2012 6:57:52 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Message SET MsgText='Confirm New Password',Updated=TO_TIMESTAMP('2012-09-03 18:57:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200029
;

-- Sep 3, 2012 6:57:52 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Message_Trl SET IsTranslated='N' WHERE AD_Message_ID=200029
;

-- Sep 3, 2012 6:58:08 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Message SET MsgText='Confirm New Password is Mandatory',Updated=TO_TIMESTAMP('2012-09-03 18:58:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200030
;

-- Sep 3, 2012 6:58:08 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Message_Trl SET IsTranslated='N' WHERE AD_Message_ID=200030
;

-- Sep 3, 2012 6:58:20 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Message SET MsgText='Password does not match the Confirm Password',Updated=TO_TIMESTAMP('2012-09-03 18:58:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200031
;

-- Sep 3, 2012 6:58:20 PM SGT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Message_Trl SET IsTranslated='N' WHERE AD_Message_ID=200031
;

UPDATE AD_System
  SET LastMigrationScriptApplied='898_IDEMPIERE-373_User_Locking.sql'
WHERE LastMigrationScriptApplied<'898_IDEMPIERE-373_User_Locking.sql'
   OR LastMigrationScriptApplied IS NULL
;