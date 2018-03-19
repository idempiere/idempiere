-- IDEMPIERE-388 Enable port and TLS configuration for email
-- Oct 3, 2012 10:55:41 AM COT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,Description,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('SMTPPort',200170,'D','SMTP Port','SMTP Port Number','SMTP Port','20c841ef-0f1c-4482-87a7-0e882ae1e0de',0,TO_TIMESTAMP('2012-10-03 10:55:39','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-10-03 10:55:39','YYYY-MM-DD HH24:MI:SS'),0,0,0,'Y')
;

-- Oct 3, 2012 10:55:41 AM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200170 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Oct 3, 2012 10:58:59 AM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,112,200580,'D','N','N','N',0,'N',10,'N',11,'N','N',200170,'N','Y','e463ed28-f6d5-4150-b7bd-49cdc6e7e03b','N','Y','N','SMTPPort','SMTP Port Number','SMTP Port','Y',0,TO_TIMESTAMP('2012-10-03 10:58:58','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-03 10:58:58','YYYY-MM-DD HH24:MI:SS'),0,0,0)
;

-- Oct 3, 2012 10:58:59 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200580 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 3, 2012 11:00:50 AM COT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,Description,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('IsSecureSMTP',200171,'D','SMTP SSL/TLS','Use SSL/TLS for SMTP','SMTP SSL/TLS','08c7ca81-950d-4f5f-b0fd-99da440cd1e2',0,TO_TIMESTAMP('2012-10-03 11:00:49','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-10-03 11:00:49','YYYY-MM-DD HH24:MI:SS'),0,0,0,'Y')
;

-- Oct 3, 2012 11:00:50 AM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200171 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Oct 3, 2012 11:02:40 AM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,112,200581,'D','N','N','N',0,'N',1,'N',20,'N','N',200171,'N','Y','1bf7924e-8543-481d-972d-32ac400ce786','N','Y','N','IsSecureSMTP','Use SSL/TLS for SMTP','N','SMTP SSL/TLS','Y',0,TO_TIMESTAMP('2012-10-03 11:02:39','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-03 11:02:39','YYYY-MM-DD HH24:MI:SS'),0,0,0)
;

-- Oct 3, 2012 11:02:40 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200581 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 3, 2012 11:24:52 AM COT
INSERT INTO AD_Field (SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,AD_FieldGroup_ID,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES (0,'N',145,0,'N','N',200580,113,'Y',200594,'N',119,'D','SMTP Port Number','SMTP Port','Y','N','e54979c8-39fc-4ac5-8fd0-5232834a070c',0,0,TO_TIMESTAMP('2012-10-03 11:24:52','YYYY-MM-DD HH24:MI:SS'),0,0,TO_TIMESTAMP('2012-10-03 11:24:52','YYYY-MM-DD HH24:MI:SS'),'Y','Y',113,1,1,1)
;

-- Oct 3, 2012 11:24:52 AM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200594 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 3, 2012 11:27:59 AM COT
INSERT INTO AD_Field (SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,AD_FieldGroup_ID,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES (0,'N',145,0,'Y','N',200581,115,'Y',200595,'N',119,'D','Use SSL/TLS for SMTP','SMTP SSL/TLS','Y','N','dbef5a74-3dfa-4246-8b76-04b924ec869c',0,0,TO_TIMESTAMP('2012-10-03 11:27:58','YYYY-MM-DD HH24:MI:SS'),0,0,TO_TIMESTAMP('2012-10-03 11:27:58','YYYY-MM-DD HH24:MI:SS'),'Y','Y',115,5,2,1)
;

-- Oct 3, 2012 11:27:59 AM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200595 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 8, 2012 10:15:49 PM COT
-- IDEMPIERE-388 Enable port and TLS configuration for email
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2012-10-08 22:15:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200581
;

-- Oct 8, 2012 10:15:51 PM COT
-- IDEMPIERE-388 Enable port and TLS configuration for email
ALTER TABLE AD_Client ADD COLUMN IsSecureSMTP CHAR(1) DEFAULT 'N' CHECK (IsSecureSMTP IN ('Y','N')) NOT NULL
;

-- Oct 8, 2012 10:16:24 PM COT
-- IDEMPIERE-388 Enable port and TLS configuration for email
ALTER TABLE AD_Client ADD COLUMN SMTPPort NUMERIC(10) DEFAULT NULL 
;

SELECT register_migration_script('927_IDEMPIERE-388.sql') FROM dual
;
