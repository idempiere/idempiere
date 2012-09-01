-- Aug 23, 2012 11:30:43 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,107,200351,'U','N','N','N',0,'N',10,'N',11,'N','N',1810,'N','Y','3bfff65c-fb60-43e8-b00c-5c1fbf6185e3','N','Y','N','XPosition','Absolute X (horizontal) position in 1/72 of an inch','1','Absolute X (horizontal) position in 1/72 of an inch','X Position','Y',100,TO_DATE('2012-08-23 11:30:42','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-08-23 11:30:42','YYYY-MM-DD HH24:MI:SS'),100,0,0)
;

-- Aug 23, 2012 11:30:43 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200351 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;


-- Aug 23, 2012 11:33:34 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Column SET EntityType='D',Updated=TO_DATE('2012-08-23 11:33:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200351
;


-- Aug 23, 2012 11:37:33 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,Description,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('ColumnSpan',200098,'D','Column Span','Number of column for a box of field','Column Span','51989873-702b-453d-8b4a-de2cc6c64f9b',0,TO_DATE('2012-08-23 11:37:32','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-08-23 11:37:32','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Aug 23, 2012 11:37:33 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200098 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;



-- Aug 23, 2012 11:39:15 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Help,EntityType,Name,Description,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('NumLines',200099,'Number of rows for a field','D','Number of Lines','Number of lines for a field','Number of Lines','0431edfc-f488-43c9-9c35-64b8058c8256',0,TO_DATE('2012-08-23 11:39:13','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-08-23 11:39:13','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Aug 23, 2012 11:39:15 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200099 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;





-- Aug 23, 2012 11:41:08 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,107,200352,'D','N','N','N',0,'N',10,'N',11,'N','N',54137,'N','Y','13585828-61e9-4a35-beec-ea8e1e58e60c','N','Y','N','SpanX','Number of columns spanned','1','Column span','Y',100,TO_DATE('2012-08-23 11:41:08','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-08-23 11:41:08','YYYY-MM-DD HH24:MI:SS'),100,0,0)
;

-- Aug 23, 2012 11:41:08 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200352 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;


-- Aug 23, 2012 11:41:41 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Column SET AD_Element_ID=200098, ColumnName='ColumnSpan', Description='Number of column for a box of field', Help=NULL, Name='Column Span',Updated=TO_DATE('2012-08-23 11:41:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200352
;

-- Aug 23, 2012 11:41:41 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Field SET Name='Column Span', Description='Number of column for a box of field', Help=NULL WHERE AD_Column_ID=200352 AND IsCentrallyMaintained='Y'
;

-- Aug 23, 2012 11:43:00 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,107,200354,'D','N','N','N',0,'N',10,'N',11,'N','N',200099,'N','Y','6f9339fa-3339-4199-957e-9358bc90d4af','N','Y','N','NumLines','Number of lines for a field','1','Number of Lines','Number of Lines','Y',100,TO_DATE('2012-08-23 11:42:59','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-08-23 11:42:59','YYYY-MM-DD HH24:MI:SS'),100,0,0)
;

-- Aug 23, 2012 11:43:00 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200354 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;



-- Aug 23, 2012 11:43:54 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
ALTER TABLE AD_Field ADD XPosition NUMBER(10) DEFAULT 1
;

-- Aug 23, 2012 11:46:09 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
ALTER TABLE AD_Field ADD NumLines NUMBER(10) DEFAULT 1
;


-- Aug 23, 2012 11:46:54 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
ALTER TABLE AD_Field ADD ColumnSpan NUMBER(10) DEFAULT 1
;

CREATE OR REPLACE VIEW AD_FIELD_V AS 
  SELECT t.AD_Window_ID, f.AD_Tab_ID, f.AD_Field_ID, tbl.AD_Table_ID, f.AD_Column_ID, 
 f.NAME, f.Description, f.Help, f.IsDisplayed, f.DisplayLogic, f.DisplayLength, 
 f.SeqNo, f.SortNo, f.IsSameLine, f.IsHeading, f.IsFieldOnly, f.IsReadOnly, 
 f.IsEncrypted AS IsEncryptedField, f.ObscureType,
 c.ColumnName, c.ColumnSQL, c.FieldLength, c.VFormat,
 COALESCE(f.DefaultValue, c.DefaultValue) AS DefaultValue,
 c.IsKey, c.IsParent, 
 COALESCE(f.IsMandatory, c.IsMandatory) AS IsMandatory, 
    c.IsIdentifier, c.IsTranslated, COALESCE(f.AD_Reference_Value_ID, c.AD_Reference_Value_ID) AS AD_Reference_Value_ID, 
 c.Callout, COALESCE(f.AD_Reference_ID, c.AD_Reference_ID) AS AD_Reference_ID, 
    COALESCE(f.AD_Val_Rule_ID, c.AD_Val_Rule_ID) AS AD_Val_Rule_ID, c.AD_Process_ID, c.IsAlwaysUpdateable,
 c.ReadOnlyLogic, c.MandatoryLogic, c.IsUpdateable, c.IsEncrypted AS IsEncryptedColumn, 
    c.IsSelectionColumn,
 tbl.TableName, c.ValueMin, c.ValueMax,
 fg.NAME AS FieldGroup, vr.Code AS ValidationCode,
 f.Included_Tab_ID, fg.FieldGroupType, fg.IsCollapsedByDefault,
 COALESCE(f.InfoFactoryClass, c.InfoFactoryClass) as InfoFactoryClass,
 c.IsAutocomplete, COALESCE(f.IsAllowCopy, c.IsAllowCopy) AS IsAllowCopy,
	f.isdisplayedgrid, 
	f.seqnogrid,
	c.seqnoselection, f.xposition, f.columnspan, f.numlines
FROM AD_FIELD f 
  INNER JOIN AD_TAB t ON (f.AD_Tab_ID = t.AD_Tab_ID)
  LEFT OUTER JOIN AD_FIELDGROUP fg ON (f.AD_FieldGroup_ID = fg.AD_FieldGroup_ID) 
  LEFT OUTER JOIN AD_COLUMN c ON (f.AD_Column_ID = c.AD_Column_ID)
 INNER JOIN AD_TABLE tbl ON (c.AD_Table_ID = tbl.AD_Table_ID)
 INNER JOIN AD_REFERENCE r ON (c.AD_Reference_ID = r.AD_Reference_ID)
 LEFT OUTER JOIN AD_VAL_RULE vr ON (vr.AD_Val_Rule_ID = COALESCE(f.AD_Val_Rule_ID, c.AD_Val_Rule_ID))
WHERE f.IsActive = 'Y' 
  AND c.IsActive = 'Y';

CREATE OR REPLACE VIEW AD_FIELD_VT AS 
    SELECT trl.AD_LANGUAGE, t.AD_Window_ID, f.AD_Tab_ID, f.AD_Field_ID, tbl.AD_Table_ID, f.AD_Column_ID, 
   trl.NAME, trl.Description, trl.Help, f.IsDisplayed, f.DisplayLogic, f.DisplayLength, 
   f.SeqNo, f.SortNo, f.IsSameLine, f.IsHeading, f.IsFieldOnly, f.IsReadOnly, 
   f.IsEncrypted AS IsEncryptedField, f.ObscureType,
   c.ColumnName, c.ColumnSQL, c.FieldLength, c.VFormat,
   COALESCE(f.DefaultValue, c.DefaultValue) AS DefaultValue,
   c.IsKey, c.IsParent, 
   COALESCE(f.IsMandatory, c.IsMandatory) AS IsMandatory, 
      c.IsIdentifier, c.IsTranslated, COALESCE(f.AD_Reference_Value_ID, c.AD_Reference_Value_ID) AS AD_Reference_Value_ID, 
   c.Callout, COALESCE(f.AD_Reference_ID, c.AD_Reference_ID) AS AD_Reference_ID, 
      COALESCE(f.AD_Val_Rule_ID, c.AD_Val_Rule_ID) as AD_Val_Rule_ID, c.AD_Process_ID, c.IsAlwaysUpdateable,
   c.ReadOnlyLogic, c.MandatoryLogic, c.IsUpdateable, c.IsEncrypted AS IsEncryptedColumn, c.IsSelectionColumn,
   tbl.TableName, c.ValueMin, c.ValueMax, 
   fgt.NAME AS FieldGroup, vr.Code AS ValidationCode,
   f.Included_Tab_ID, fg.FieldGroupType, fg.IsCollapsedByDefault,
   COALESCE(f.InfoFactoryClass, c.InfoFactoryClass) as InfoFactoryClass,
   c.IsAutocomplete, COALESCE(f.IsAllowCopy, c.IsAllowCopy) AS IsAllowCopy,
	f.isdisplayedgrid, 
	f.seqnogrid,
	c.seqnoselection, f.xposition, f.columnspan, f.numlines
  FROM AD_FIELD f 
   INNER JOIN AD_FIELD_TRL trl ON (f.AD_Field_ID = trl.AD_Field_ID)
    INNER JOIN AD_TAB t ON (f.AD_Tab_ID = t.AD_Tab_ID)
    LEFT OUTER JOIN AD_FIELDGROUP fg ON (f.AD_FieldGroup_ID = fg.AD_FieldGroup_ID) 
    LEFT OUTER JOIN AD_FIELDGROUP_TRL fgt ON 
   (f.AD_FieldGroup_ID = fgt.AD_FieldGroup_ID AND trl.AD_LANGUAGE=fgt.AD_LANGUAGE)
    LEFT OUTER JOIN AD_COLUMN c ON (f.AD_Column_ID = c.AD_Column_ID)
   INNER JOIN AD_TABLE tbl ON (c.AD_Table_ID = tbl.AD_Table_ID)
   INNER JOIN AD_REFERENCE r ON (c.AD_Reference_ID = r.AD_Reference_ID)
   LEFT OUTER JOIN AD_VAL_RULE vr ON (vr.AD_Val_Rule_ID=COALESCE(f.AD_Val_Rule_ID, c.AD_Val_Rule_ID))
  WHERE f.IsActive = 'Y' 
  AND c.IsActive = 'Y';

-- Aug 23, 2012 11:49:35 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',107,10,'N','N',200352,'Y',200348,'N','D','Number of column for a box of field','Column Span','Y','N','b5de9fd6-5c23-41da-ad6b-25b0ef06ca77',100,0,TO_DATE('2012-08-23 11:49:34','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-08-23 11:49:34','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Aug 23, 2012 11:49:35 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200348 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 23, 2012 11:49:35 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',107,10,'N','N',200354,'Y',200349,'N','Number of lines for a field','D','Number of lines for a field','Number of Lines','Y','N','f29bc74a-88d5-487a-ae62-c38f235bebe0',100,0,TO_DATE('2012-08-23 11:49:35','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-08-23 11:49:35','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Aug 23, 2012 11:49:35 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200349 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;


-- Aug 23, 2012 11:49:36 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',107,10,'N','N',200351,'Y',200350,'N','Absolute X (horizontal) position in 1/72 of an inch','D','Absolute X (horizontal) position in 1/72 of an inch','X Position','Y','N','85043584-8b26-4a6e-8107-22fe1244cc41',100,0,TO_DATE('2012-08-23 11:49:35','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-08-23 11:49:35','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Aug 23, 2012 11:49:36 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200350 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 23, 2012 11:51:32 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
INSERT INTO AD_FieldGroup (EntityType,IsCollapsedByDefault,Name,AD_FieldGroup_ID,AD_FieldGroup_UU,AD_Client_ID,Created,CreatedBy,Updated,AD_Org_ID,UpdatedBy,IsActive) VALUES ('D','N','Swing Position',200000,'56cfcf5b-ab15-42b9-89eb-6fba4038b2a8',0,TO_DATE('2012-08-23 11:51:31','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-08-23 11:51:31','YYYY-MM-DD HH24:MI:SS'),0,100,'Y')
;

-- Aug 23, 2012 11:51:32 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
INSERT INTO AD_FieldGroup_Trl (AD_Language,AD_FieldGroup_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_FieldGroup_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_FieldGroup t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_FieldGroup_ID=200000 AND NOT EXISTS (SELECT * FROM AD_FieldGroup_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_FieldGroup_ID=t.AD_FieldGroup_ID)
;


-- Aug 23, 2012 11:51:53 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
INSERT INTO AD_FieldGroup (EntityType,IsCollapsedByDefault,Name,AD_FieldGroup_ID,AD_FieldGroup_UU,AD_Client_ID,Created,CreatedBy,Updated,AD_Org_ID,UpdatedBy,IsActive) VALUES ('D','N','Web Position',200001,'16383246-000c-4479-bd25-e728e440d64e',0,TO_DATE('2012-08-23 11:51:53','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-08-23 11:51:53','YYYY-MM-DD HH24:MI:SS'),0,100,'Y')
;

-- Aug 23, 2012 11:51:53 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
INSERT INTO AD_FieldGroup_Trl (AD_Language,AD_FieldGroup_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_FieldGroup_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_FieldGroup t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_FieldGroup_ID=200001 AND NOT EXISTS (SELECT * FROM AD_FieldGroup_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_FieldGroup_ID=t.AD_FieldGroup_ID)
;

-- Aug 23, 2012 11:53:14 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Field SET AD_FieldGroup_ID=200001,Updated=TO_DATE('2012-08-23 11:53:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200350
;

-- Aug 23, 2012 11:53:23 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Field SET AD_FieldGroup_ID=200001,Updated=TO_DATE('2012-08-23 11:53:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200349
;

-- Aug 23, 2012 11:53:33 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Field SET AD_FieldGroup_ID=200001,Updated=TO_DATE('2012-08-23 11:53:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200348
;

-- Aug 23, 2012 11:54:13 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Field SET AD_FieldGroup_ID=200000,Updated=TO_DATE('2012-08-23 11:54:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=136
;

-- Aug 23, 2012 11:54:28 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Field SET AD_FieldGroup_ID=200000,Updated=TO_DATE('2012-08-23 11:54:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=139
;

-- Aug 23, 2012 11:54:50 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=142
;

-- Aug 23, 2012 11:54:50 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y' WHERE AD_Field_ID=137
;

-- Aug 23, 2012 11:54:50 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Field SET SeqNo=190,IsDisplayed='Y' WHERE AD_Field_ID=200274
;

-- Aug 23, 2012 11:54:50 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Field SET SeqNo=200,IsDisplayed='Y' WHERE AD_Field_ID=136
;

-- Aug 23, 2012 11:54:50 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Field SET SeqNo=330,IsDisplayed='Y' WHERE AD_Field_ID=200348
;

-- Aug 23, 2012 11:54:50 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Field SET SeqNo=340,IsDisplayed='Y' WHERE AD_Field_ID=200349
;

-- Aug 23, 2012 11:54:50 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Field SET SeqNo=350,IsDisplayed='Y' WHERE AD_Field_ID=200350
;

-- Aug 23, 2012 11:58:37 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Field SET SeqNo=330,IsDisplayed='Y' WHERE AD_Field_ID=200350
;

-- Aug 23, 2012 11:58:37 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Field SET SeqNo=340,IsDisplayed='Y' WHERE AD_Field_ID=200348
;

-- Aug 23, 2012 11:58:37 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Field SET SeqNo=350,IsDisplayed='Y' WHERE AD_Field_ID=200349
;

-- Aug 23, 2012 12:07:26 PM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_DATE('2012-08-23 12:07:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200348
;

-- Aug 23, 2012 12:08:15 PM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Field SET SeqNo=200,IsDisplayed='Y' WHERE AD_Field_ID=138
;

-- Aug 23, 2012 12:08:15 PM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Field SET SeqNo=210,IsDisplayed='Y' WHERE AD_Field_ID=8343
;

-- Aug 23, 2012 12:08:15 PM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Field SET SeqNo=220,IsDisplayed='Y' WHERE AD_Field_ID=140
;

-- Aug 23, 2012 12:08:15 PM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Field SET SeqNo=230,IsDisplayed='Y' WHERE AD_Field_ID=141
;

-- Aug 23, 2012 12:08:15 PM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Field SET SeqNo=240,IsDisplayed='Y' WHERE AD_Field_ID=13425
;

-- Aug 23, 2012 12:08:15 PM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Field SET SeqNo=250,IsDisplayed='Y' WHERE AD_Field_ID=54401
;

-- Aug 23, 2012 12:08:15 PM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Field SET SeqNo=260,IsDisplayed='Y' WHERE AD_Field_ID=54402
;

-- Aug 23, 2012 12:08:15 PM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Field SET SeqNo=270,IsDisplayed='Y' WHERE AD_Field_ID=13424
;

-- Aug 23, 2012 12:08:15 PM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Field SET SeqNo=280,IsDisplayed='Y' WHERE AD_Field_ID=62468
;

-- Aug 23, 2012 12:08:16 PM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Field SET SeqNo=290,IsDisplayed='Y' WHERE AD_Field_ID=53280
;

-- Aug 23, 2012 12:08:16 PM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Field SET SeqNo=300,IsDisplayed='Y' WHERE AD_Field_ID=200275
;

-- Aug 23, 2012 12:08:16 PM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Field SET SeqNo=310,IsDisplayed='Y' WHERE AD_Field_ID=136
;

-- Aug 23, 2012 12:08:16 PM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Field SET SeqNo=320,IsDisplayed='Y' WHERE AD_Field_ID=139
;


UPDATE AD_Field SET XPosition=3
WHERE IsSameLine='Y'
AND IsActive='Y';

UPDATE AD_Field SET XPosition=1
WHERE IsSameline='N'
AND IsActive='Y';

UPDATE AD_Field SET ColumnSpan=1
WHERE DisplayLength<30
AND IsActive='Y';


UPDATE AD_Field SET ColumnSpan=3
WHERE DisplayLength>=30
AND IsActive='Y';

UPDATE AD_Field SET NumLines=3
WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Reference_ID=14)
AND IsActive='Y';

UPDATE AD_Field SET NumLines=5
WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Reference_ID=36)
AND IsActive='Y';

UPDATE AD_Field SET NumLines=8
WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Reference_ID=34)
AND IsActive='Y';



UPDATE AD_Field SET ColumnSpan=2
WHERE AD_Field_ID IN(
SELECT AD_Field_ID
FROM AD_Field
WHERE XPosition=1
AND ColumnSpan=1
AND IsActive='Y');


UPDATE AD_Field SET XPosition=4,ColumnSpan=2
WHERE AD_Field_ID IN(
SELECT AD_Field_ID
FROM AD_Field
WHERE XPosition=3
AND ColumnSpan=1
AND IsActive='Y');


UPDATE AD_Field SET XPosition=XPosition+1
WHERE AD_Field_ID IN(
SELECT fi.AD_Field_ID
FROM AD_Field fi
INNER JOIN AD_Column c ON (fi.AD_Column_ID=C.AD_Column_ID)
WHERE c.AD_Reference_ID in (20,28)
AND fi.IsActive='Y');

UPDATE AD_Field SET ColumnSpan=5
WHERE AD_Field_ID IN(
SELECT AD_Field_ID
FROM AD_Field
WHERE XPosition=1
AND ColumnSpan=3
AND IsActive='Y'); 


UPDATE AD_Field SET XPosition=XPosition+1
WHERE IsFieldOnly='Y';

UPDATE AD_System
  SET LastMigrationScriptApplied='892_IDEMPIERE_368.sql'
WHERE LastMigrationScriptApplied<'892_IDEMPIERE_368.sql'
   OR LastMigrationScriptApplied IS NULL
;
