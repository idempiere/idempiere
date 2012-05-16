-- May 10, 2012 4:43:49 PM COT
-- IDEMPIERE-249 implement encrypt en ad_processparameter same as in ad_field
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,Description,Name,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,ColumnName,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200141,285,'D',0,'N','N','N','Display encryption (in Window/Tab/Field) - all characters are displayed as ''*'' - in the database it is stored in clear text. You will not be able to report on these columns.<br>
Data storage encryption (in Table/Column) - data is stored encrypted in the database (dangerous!) and you will not be able to report on those columns. Independent from Display encryption.','N','Display or Storage is encrypted','Encrypted',1,'N',20,'N',374,'IsEncrypted','N','Y','N',100,TO_DATE('2012-05-10 16:43:48','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-05-10 16:43:48','YYYY-MM-DD HH24:MI:SS'),100)
;

-- May 10, 2012 4:43:49 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200141 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- May 15, 2012 9:11:40 PM COT
UPDATE AD_Column SET DefaultValue='N', IsMandatory='Y',Updated=TO_DATE('2012-05-15 21:11:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200141
;

-- May 15, 2012 9:11:53 PM COT
ALTER TABLE AD_Process_Para ADD IsEncrypted CHAR(1) DEFAULT 'N' CHECK (IsEncrypted IN ('Y','N')) NOT NULL
;

-- May 10, 2012 4:44:29 PM COT
INSERT INTO AD_Field (IsEncrypted,Description,DisplayLength,Name,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,Help,EntityType,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N','Display or Storage is encrypted',1,'Encrypted','Y','N','N',200141,'N','Y',246,200097,'N','Display encryption (in Window/Tab/Field) - all characters are displayed as ''*'' - in the database it is stored in clear text. You will not be able to report on these columns.<br>
Data storage encryption (in Table/Column) - data is stored encrypted in the database (dangerous!) and you will not be able to report on those columns. Independent from Display encryption.','D',100,0,'Y',TO_DATE('2012-05-10 16:44:28','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-05-10 16:44:28','YYYY-MM-DD HH24:MI:SS'))
;

-- May 10, 2012 4:44:29 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Name,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Name,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200097 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- May 10, 2012 4:47:07 PM COT
UPDATE AD_Process_Para SET IsEncrypted='Y',Updated=TO_DATE('2012-05-10 16:47:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=516
;

-- May 10, 2012 4:47:10 PM COT
UPDATE AD_Process_Para SET IsEncrypted='Y',Updated=TO_DATE('2012-05-10 16:47:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=517
;

