-- Jul 25, 2013 5:46:56 PM SGT
-- IDEMPIERE-1149 Implement SetFocus on field
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('IsDefaultFocus',202572,'Default Focus','Default Focus','1051f0e7-7bfa-4cab-828f-93fa8ac1c153',TO_TIMESTAMP('2013-07-25 17:46:54','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-07-25 17:46:54','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D')
;

-- Jul 25, 2013 5:46:56 PM SGT
-- IDEMPIERE-1149 Implement SetFocus on field
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202572 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Jul 25, 2013 5:47:21 PM SGT
-- IDEMPIERE-1149 Implement SetFocus on field
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,DefaultValue,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,107,210664,'Y','N','N',0,'N',1,'N',20,'N','N','Y','eae0eb7c-9356-4be1-afb3-73662e709474','Y','IsDefaultFocus','N','Default Focus','Y',TO_TIMESTAMP('2013-07-25 17:47:20','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-25 17:47:20','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202572,'N')
;

-- Jul 25, 2013 5:47:21 PM SGT
-- IDEMPIERE-1149 Implement SetFocus on field
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210664 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 25, 2013 5:47:28 PM SGT
-- IDEMPIERE-1149 Implement SetFocus on field
ALTER TABLE AD_Field ADD COLUMN IsDefaultFocus CHAR(1) DEFAULT 'N' CHECK (IsDefaultFocus IN ('Y','N')) NOT NULL
;

-- Jul 25, 2013 5:48:40 PM SGT
-- IDEMPIERE-1149 Implement SetFocus on field
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,XPosition,AD_Client_ID,ColumnSpan) VALUES ('N',107,1,'N','N',210664,400,'Y',202341,'N','D','Default Focus','1cb6cbd3-9e4f-4586-a00d-b4415fbfb024','Y','N',100,0,TO_TIMESTAMP('2013-07-25 17:48:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-25 17:48:39','YYYY-MM-DD HH24:MI:SS'),'Y',2,0,2)
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

-- Jul 25, 2013 5:49:43 PM SGT
-- IDEMPIERE-1149 Implement SetFocus on field
UPDATE AD_Field SET SeqNoGrid=380,IsDisplayedGrid='Y' WHERE AD_Field_ID=200835
;

-- Jul 25, 2013 5:49:43 PM SGT
-- IDEMPIERE-1149 Implement SetFocus on field
UPDATE AD_Field SET SeqNoGrid=390,IsDisplayedGrid='Y' WHERE AD_Field_ID=200836
;

DROP VIEW ad_field_v;

CREATE OR REPLACE VIEW ad_field_v AS 
 SELECT t.ad_window_id, f.ad_tab_id, f.ad_field_id, tbl.ad_table_id, f.ad_column_id, 
 f.name, f.description, f.help, f.isdisplayed, f.displaylogic, f.displaylength, f.seqno, 
 f.sortno, f.issameline, f.isheading, f.isfieldonly, f.isreadonly, f.isencrypted AS isencryptedfield, 
 f.obscuretype, c.columnname, c.columnsql, c.fieldlength, c.vformat, 
 COALESCE(f.defaultvalue, c.defaultvalue) AS defaultvalue, c.iskey, c.isparent, 
 COALESCE(f.ismandatory, c.ismandatory) AS ismandatory, c.isidentifier, c.istranslated, 
 COALESCE(f.ad_reference_value_id, c.ad_reference_value_id) AS ad_reference_value_id, c.callout, 
 COALESCE(f.ad_reference_id, c.ad_reference_id) AS ad_reference_id, 
 COALESCE(f.ad_val_rule_id, c.ad_val_rule_id) AS ad_val_rule_id, c.ad_process_id, 
 COALESCE(f.Isalwaysupdateable , C.Isalwaysupdateable) As Isalwaysupdateable, 
 COALESCE(f.Readonlylogic,  c.Readonlylogic ) As Readonlylogic, 
 COALESCE(f.Mandatorylogic , C.Mandatorylogic) As Mandatorylogic, 
 COALESCE(f.isupdateable, c.isupdateable) AS isupdateable, 
 c.isencrypted AS isencryptedcolumn, c.isselectioncolumn, tbl.tablename, c.valuemin, c.valuemax, 
 fg.name AS fieldgroup, vr.code AS validationcode, f.included_tab_id, fg.fieldgrouptype, fg.iscollapsedbydefault, 
 COALESCE(f.infofactoryclass, c.infofactoryclass) AS infofactoryclass, c.isautocomplete,
 COALESCE(f.IsAllowCopy, c.IsAllowCopy) AS IsAllowCopy,
	f.isdisplayedgrid, 
	f.seqnogrid,
	c.seqnoselection, f.xposition, f.columnspan, f.numlines, 
 COALESCE(f.istoolbarbutton , c.istoolbarbutton ) As istoolbarbutton,
 c.FormatPattern, f.IsDefaultFocus 
   FROM ad_field f
   JOIN ad_tab t ON f.ad_tab_id = t.ad_tab_id
   LEFT JOIN ad_fieldgroup fg ON f.ad_fieldgroup_id = fg.ad_fieldgroup_id
   LEFT JOIN ad_column c ON f.ad_column_id = c.ad_column_id
   JOIN ad_table tbl ON c.ad_table_id = tbl.ad_table_id
   LEFT JOIN ad_val_rule vr ON vr.ad_val_rule_id = COALESCE(f.ad_val_rule_id, c.ad_val_rule_id)
  WHERE f.isactive = 'Y'::bpchar AND c.isactive = 'Y'::bpchar;

DROP VIEW ad_field_vt;

CREATE OR REPLACE VIEW ad_field_vt AS 
 SELECT trl.ad_language, t.ad_window_id, f.ad_tab_id, f.ad_field_id, tbl.ad_table_id, f.ad_column_id, trl.name, trl.description, 
 trl.help, f.isdisplayed, f.displaylogic, f.displaylength, f.seqno, f.sortno, f.issameline, f.isheading, f.isfieldonly, f.isreadonly, 
 f.isencrypted AS isencryptedfield, f.obscuretype, c.columnname, c.columnsql, c.fieldlength, c.vformat, COALESCE(f.defaultvalue, c.defaultvalue) AS defaultvalue, 
 c.iskey, c.isparent, COALESCE(f.ismandatory, c.ismandatory) AS ismandatory, c.isidentifier, c.istranslated, 
 COALESCE(f.ad_reference_value_id, c.ad_reference_value_id) AS ad_reference_value_id, c.callout, COALESCE(f.ad_reference_id, c.ad_reference_id) AS ad_reference_id, 
 COALESCE(f.ad_val_rule_id,c.ad_val_rule_id) AS ad_val_rule_id, c.ad_process_id,  
 COALESCE(f.Isalwaysupdateable,C.Isalwaysupdateable) As Isalwaysupdateable,
 COALESCE(f.Readonlylogic,c.Readonlylogic) As Readonlylogic, 
 COALESCE(f.Mandatorylogic , C.Mandatorylogic) As Mandatorylogic, 
 COALESCE(f.isupdateable, c.isupdateable) AS isupdateable,  
 c.isencrypted AS isencryptedcolumn, c.isselectioncolumn, tbl.tablename, c.valuemin, c.valuemax, fgt.name AS fieldgroup, vr.code AS validationcode, 
 f.included_tab_id, fg.fieldgrouptype, fg.iscollapsedbydefault, COALESCE(f.infofactoryclass, c.infofactoryclass) AS infofactoryclass, c.isautocomplete,
 COALESCE(f.IsAllowCopy, c.IsAllowCopy) AS IsAllowCopy,
	f.isdisplayedgrid, 
	f.seqnogrid,
	c.seqnoselection, f.xposition, f.columnspan, f.numlines, 
 COALESCE(f.istoolbarbutton , c.istoolbarbutton ) As istoolbarbutton,
 c.FormatPattern, f.IsDefaultFocus 
   FROM ad_field f
   JOIN ad_field_trl trl ON f.ad_field_id = trl.ad_field_id
   JOIN ad_tab t ON f.ad_tab_id = t.ad_tab_id
   LEFT JOIN ad_fieldgroup fg ON f.ad_fieldgroup_id = fg.ad_fieldgroup_id
   LEFT JOIN ad_fieldgroup_trl fgt ON f.ad_fieldgroup_id = fgt.ad_fieldgroup_id AND trl.ad_language::text = fgt.ad_language::text
   LEFT JOIN ad_column c ON f.ad_column_id = c.ad_column_id
   JOIN ad_table tbl ON c.ad_table_id = tbl.ad_table_id
   LEFT JOIN ad_val_rule vr ON vr.ad_val_rule_id = COALESCE(f.ad_val_rule_id, c.ad_val_rule_id)
  WHERE f.isactive = 'Y'::bpchar AND c.isactive = 'Y'::bpchar;
  
SELECT register_migration_script('201307291518_IDEMPIERE-1149.sql') FROM dual
;
