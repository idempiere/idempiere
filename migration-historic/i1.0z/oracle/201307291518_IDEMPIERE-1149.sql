-- Jul 25, 2013 5:46:56 PM SGT
-- IDEMPIERE-1149 Implement SetFocus on field
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('IsDefaultFocus',202572,'Default Focus','Default Focus','1051f0e7-7bfa-4cab-828f-93fa8ac1c153',TO_DATE('2013-07-25 17:46:54','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-07-25 17:46:54','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D')
;

-- Jul 25, 2013 5:46:56 PM SGT
-- IDEMPIERE-1149 Implement SetFocus on field
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202572 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Jul 25, 2013 5:47:21 PM SGT
-- IDEMPIERE-1149 Implement SetFocus on field
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,DefaultValue,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,107,210664,'Y','N','N',0,'N',1,'N',20,'N','N','Y','eae0eb7c-9356-4be1-afb3-73662e709474','Y','IsDefaultFocus','N','Default Focus','Y',TO_DATE('2013-07-25 17:47:20','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-07-25 17:47:20','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202572,'N')
;

-- Jul 25, 2013 5:47:21 PM SGT
-- IDEMPIERE-1149 Implement SetFocus on field
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210664 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 25, 2013 5:47:28 PM SGT
-- IDEMPIERE-1149 Implement SetFocus on field
ALTER TABLE AD_Field ADD IsDefaultFocus CHAR(1) DEFAULT 'N' CHECK (IsDefaultFocus IN ('Y','N')) NOT NULL
;

-- Jul 25, 2013 5:48:40 PM SGT
-- IDEMPIERE-1149 Implement SetFocus on field
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,XPosition,AD_Client_ID,ColumnSpan) VALUES ('N',107,1,'N','N',210664,400,'Y',202341,'N','D','Default Focus','1cb6cbd3-9e4f-4586-a00d-b4415fbfb024','Y','N',100,0,TO_DATE('2013-07-25 17:48:39','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-07-25 17:48:39','YYYY-MM-DD HH24:MI:SS'),'Y',2,0,2)
;

-- Jul 25, 2013 5:48:40 PM SGT
-- IDEMPIERE-1149 Implement SetFocus on field
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202341 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 25, 2013 5:49:26 PM SGT
-- IDEMPIERE-1149 Implement SetFocus on field
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=6432
;

-- Jul 25, 2013 5:49:26 PM SGT
-- IDEMPIERE-1149 Implement SetFocus on field
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200275
;

-- Jul 25, 2013 5:49:26 PM SGT
-- IDEMPIERE-1149 Implement SetFocus on field
UPDATE AD_Field SET SeqNo=240,IsDisplayed='Y' WHERE AD_Field_ID=202341
;

-- Jul 25, 2013 5:49:26 PM SGT
-- IDEMPIERE-1149 Implement SetFocus on field
UPDATE AD_Field SET SeqNo=250,IsDisplayed='Y' WHERE AD_Field_ID=200350
;

-- Jul 25, 2013 5:49:26 PM SGT
-- IDEMPIERE-1149 Implement SetFocus on field
UPDATE AD_Field SET SeqNo=260,IsDisplayed='Y' WHERE AD_Field_ID=200348
;

-- Jul 25, 2013 5:49:26 PM SGT
-- IDEMPIERE-1149 Implement SetFocus on field
UPDATE AD_Field SET SeqNo=270,IsDisplayed='Y' WHERE AD_Field_ID=200349
;

-- Jul 25, 2013 5:49:26 PM SGT
-- IDEMPIERE-1149 Implement SetFocus on field
UPDATE AD_Field SET SeqNo=280,IsDisplayed='Y' WHERE AD_Field_ID=13425
;

-- Jul 25, 2013 5:49:26 PM SGT
-- IDEMPIERE-1149 Implement SetFocus on field
UPDATE AD_Field SET SeqNo=290,IsDisplayed='Y' WHERE AD_Field_ID=200837
;

-- Jul 25, 2013 5:49:26 PM SGT
-- IDEMPIERE-1149 Implement SetFocus on field
UPDATE AD_Field SET SeqNo=300,IsDisplayed='Y' WHERE AD_Field_ID=54402
;

-- Jul 25, 2013 5:49:26 PM SGT
-- IDEMPIERE-1149 Implement SetFocus on field
UPDATE AD_Field SET SeqNo=310,IsDisplayed='Y' WHERE AD_Field_ID=54401
;

-- Jul 25, 2013 5:49:26 PM SGT
-- IDEMPIERE-1149 Implement SetFocus on field
UPDATE AD_Field SET SeqNo=320,IsDisplayed='Y' WHERE AD_Field_ID=200838
;

-- Jul 25, 2013 5:49:26 PM SGT
-- IDEMPIERE-1149 Implement SetFocus on field
UPDATE AD_Field SET SeqNo=330,IsDisplayed='Y' WHERE AD_Field_ID=200834
;

-- Jul 25, 2013 5:49:26 PM SGT
-- IDEMPIERE-1149 Implement SetFocus on field
UPDATE AD_Field SET SeqNo=340,IsDisplayed='Y' WHERE AD_Field_ID=13424
;

-- Jul 25, 2013 5:49:26 PM SGT
-- IDEMPIERE-1149 Implement SetFocus on field
UPDATE AD_Field SET SeqNo=350,IsDisplayed='Y' WHERE AD_Field_ID=62468
;

-- Jul 25, 2013 5:49:26 PM SGT
-- IDEMPIERE-1149 Implement SetFocus on field
UPDATE AD_Field SET SeqNo=360,IsDisplayed='Y' WHERE AD_Field_ID=53280
;

-- Jul 25, 2013 5:49:26 PM SGT
-- IDEMPIERE-1149 Implement SetFocus on field
UPDATE AD_Field SET SeqNo=370,IsDisplayed='Y' WHERE AD_Field_ID=200836
;

-- Jul 25, 2013 5:49:26 PM SGT
-- IDEMPIERE-1149 Implement SetFocus on field
UPDATE AD_Field SET SeqNo=380,IsDisplayed='Y' WHERE AD_Field_ID=200835
;

-- Jul 25, 2013 5:49:26 PM SGT
-- IDEMPIERE-1149 Implement SetFocus on field
UPDATE AD_Field SET SeqNo=390,IsDisplayed='Y' WHERE AD_Field_ID=136
;

-- Jul 25, 2013 5:49:26 PM SGT
-- IDEMPIERE-1149 Implement SetFocus on field
UPDATE AD_Field SET SeqNo=400,IsDisplayed='Y' WHERE AD_Field_ID=139
;

-- Jul 25, 2013 5:49:42 PM SGT
-- IDEMPIERE-1149 Implement SetFocus on field
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200275
;

-- Jul 25, 2013 5:49:42 PM SGT
-- IDEMPIERE-1149 Implement SetFocus on field
UPDATE AD_Field SET SeqNoGrid=240,IsDisplayedGrid='Y' WHERE AD_Field_ID=202341
;

-- Jul 25, 2013 5:49:42 PM SGT
-- IDEMPIERE-1149 Implement SetFocus on field
UPDATE AD_Field SET SeqNoGrid=250,IsDisplayedGrid='Y' WHERE AD_Field_ID=13425
;

-- Jul 25, 2013 5:49:42 PM SGT
-- IDEMPIERE-1149 Implement SetFocus on field
UPDATE AD_Field SET SeqNoGrid=260,IsDisplayedGrid='Y' WHERE AD_Field_ID=54401
;

-- Jul 25, 2013 5:49:42 PM SGT
-- IDEMPIERE-1149 Implement SetFocus on field
UPDATE AD_Field SET SeqNoGrid=270,IsDisplayedGrid='Y' WHERE AD_Field_ID=54402
;

-- Jul 25, 2013 5:49:42 PM SGT
-- IDEMPIERE-1149 Implement SetFocus on field
UPDATE AD_Field SET SeqNoGrid=280,IsDisplayedGrid='Y' WHERE AD_Field_ID=13424
;

-- Jul 25, 2013 5:49:42 PM SGT
-- IDEMPIERE-1149 Implement SetFocus on field
UPDATE AD_Field SET SeqNoGrid=290,IsDisplayedGrid='Y' WHERE AD_Field_ID=62468
;

-- Jul 25, 2013 5:49:42 PM SGT
-- IDEMPIERE-1149 Implement SetFocus on field
UPDATE AD_Field SET SeqNoGrid=300,IsDisplayedGrid='Y' WHERE AD_Field_ID=200771
;

-- Jul 25, 2013 5:49:42 PM SGT
-- IDEMPIERE-1149 Implement SetFocus on field
UPDATE AD_Field SET SeqNoGrid=310,IsDisplayedGrid='Y' WHERE AD_Field_ID=53280
;

-- Jul 25, 2013 5:49:42 PM SGT
-- IDEMPIERE-1149 Implement SetFocus on field
UPDATE AD_Field SET SeqNoGrid=320,IsDisplayedGrid='Y' WHERE AD_Field_ID=200837
;

-- Jul 25, 2013 5:49:42 PM SGT
-- IDEMPIERE-1149 Implement SetFocus on field
UPDATE AD_Field SET SeqNoGrid=330,IsDisplayedGrid='Y' WHERE AD_Field_ID=200350
;

-- Jul 25, 2013 5:49:42 PM SGT
-- IDEMPIERE-1149 Implement SetFocus on field
UPDATE AD_Field SET SeqNoGrid=340,IsDisplayedGrid='Y' WHERE AD_Field_ID=200348
;

-- Jul 25, 2013 5:49:42 PM SGT
-- IDEMPIERE-1149 Implement SetFocus on field
UPDATE AD_Field SET SeqNoGrid=350,IsDisplayedGrid='Y' WHERE AD_Field_ID=200838
;

-- Jul 25, 2013 5:49:42 PM SGT
-- IDEMPIERE-1149 Implement SetFocus on field
UPDATE AD_Field SET SeqNoGrid=360,IsDisplayedGrid='Y' WHERE AD_Field_ID=200834
;

-- Jul 25, 2013 5:49:42 PM SGT
-- IDEMPIERE-1149 Implement SetFocus on field
UPDATE AD_Field SET SeqNoGrid=370,IsDisplayedGrid='Y' WHERE AD_Field_ID=200349
;

-- Jul 25, 2013 5:49:42 PM SGT
-- IDEMPIERE-1149 Implement SetFocus on field
UPDATE AD_Field SET SeqNoGrid=380,IsDisplayedGrid='Y' WHERE AD_Field_ID=200835
;

-- Jul 25, 2013 5:49:43 PM SGT
-- IDEMPIERE-1149 Implement SetFocus on field
UPDATE AD_Field SET SeqNoGrid=390,IsDisplayedGrid='Y' WHERE AD_Field_ID=200836
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
    COALESCE(f.AD_Val_Rule_ID, c.AD_Val_Rule_ID) AS AD_Val_Rule_ID, c.AD_Process_ID, 
 COALESCE(f.Isalwaysupdateable , C.Isalwaysupdateable) As Isalwaysupdateable,
 COALESCE(f.Readonlylogic,  c.Readonlylogic ) As Readonlylogic,
 COALESCE(f.Mandatorylogic , C.Mandatorylogic) As Mandatorylogic, 
 COALESCE(f.isupdateable, c.isupdateable) AS isupdateable, c.IsEncrypted AS IsEncryptedColumn, 
    c.IsSelectionColumn,
 tbl.TableName, c.ValueMin, c.ValueMax,
 fg.NAME AS FieldGroup, vr.Code AS ValidationCode,
 f.Included_Tab_ID, fg.FieldGroupType, fg.IsCollapsedByDefault,
 COALESCE(f.InfoFactoryClass, c.InfoFactoryClass) as InfoFactoryClass,
 c.IsAutocomplete, COALESCE(f.IsAllowCopy, c.IsAllowCopy) AS IsAllowCopy,
	f.isdisplayedgrid, 
	f.seqnogrid,
	c.seqnoselection, f.xposition, f.columnspan, f.numlines, 
 COALESCE(f.istoolbarbutton , c.istoolbarbutton ) As istoolbarbutton,
 c.FormatPattern, f.IsDefaultFocus 
FROM AD_FIELD f 
  INNER JOIN AD_TAB t ON (f.AD_Tab_ID = t.AD_Tab_ID)
  LEFT OUTER JOIN AD_FIELDGROUP fg ON (f.AD_FieldGroup_ID = fg.AD_FieldGroup_ID) 
  LEFT OUTER JOIN AD_COLUMN c ON (f.AD_Column_ID = c.AD_Column_ID)
 INNER JOIN AD_TABLE tbl ON (c.AD_Table_ID = tbl.AD_Table_ID)
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
      COALESCE(f.AD_Val_Rule_ID, c.AD_Val_Rule_ID) as AD_Val_Rule_ID, c.AD_Process_ID, 
   COALESCE(f.Isalwaysupdateable , C.Isalwaysupdateable) As Isalwaysupdateable,
   COALESCE(f.Readonlylogic,  c.Readonlylogic ) As Readonlylogic,
   COALESCE(f.Mandatorylogic , C.Mandatorylogic) As Mandatorylogic,  
   COALESCE(f.isupdateable, c.isupdateable) AS isupdateable, c.IsEncrypted AS IsEncryptedColumn, c.IsSelectionColumn,
   tbl.TableName, c.ValueMin, c.ValueMax, 
   fgt.NAME AS FieldGroup, vr.Code AS ValidationCode,
   f.Included_Tab_ID, fg.FieldGroupType, fg.IsCollapsedByDefault,
   COALESCE(f.InfoFactoryClass, c.InfoFactoryClass) as InfoFactoryClass,
   c.IsAutocomplete, COALESCE(f.IsAllowCopy, c.IsAllowCopy) AS IsAllowCopy,
	f.isdisplayedgrid, 
	f.seqnogrid,
	c.seqnoselection, f.xposition, f.columnspan, f.numlines, 
  COALESCE(f.istoolbarbutton , c.istoolbarbutton ) As istoolbarbutton,
  c.FormatPattern, f.IsDefaultFocus 
  FROM AD_FIELD f 
   INNER JOIN AD_FIELD_TRL trl ON (f.AD_Field_ID = trl.AD_Field_ID)
    INNER JOIN AD_TAB t ON (f.AD_Tab_ID = t.AD_Tab_ID)
    LEFT OUTER JOIN AD_FIELDGROUP fg ON (f.AD_FieldGroup_ID = fg.AD_FieldGroup_ID) 
    LEFT OUTER JOIN AD_FIELDGROUP_TRL fgt ON 
   (f.AD_FieldGroup_ID = fgt.AD_FieldGroup_ID AND trl.AD_LANGUAGE=fgt.AD_LANGUAGE)
    LEFT OUTER JOIN AD_COLUMN c ON (f.AD_Column_ID = c.AD_Column_ID)
   INNER JOIN AD_TABLE tbl ON (c.AD_Table_ID = tbl.AD_Table_ID)
   LEFT OUTER JOIN AD_VAL_RULE vr ON (vr.AD_Val_Rule_ID=COALESCE(f.AD_Val_Rule_ID, c.AD_Val_Rule_ID))
  WHERE f.IsActive = 'Y' 
  AND c.IsActive = 'Y';

SELECT register_migration_script('201307291518_IDEMPIERE-1149.sql') FROM dual
;