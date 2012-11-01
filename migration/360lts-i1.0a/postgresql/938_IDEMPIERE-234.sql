-- Oct 19, 2012 2:04:03 PM MYT
-- IDEMPIERE-234 Configure Toolbar
INSERT INTO AD_Element (ColumnName,AD_Client_ID,Created,Updated,EntityType,PrintName,AD_Element_UU,AD_Element_ID,Help,Name,Description,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('IsToolbarButton',0,TO_TIMESTAMP('2012-10-19 14:04:01','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-10-19 14:04:01','YYYY-MM-DD HH24:MI:SS'),'D','Toolbar Button','3c610247-e801-43ff-a7f7-9540f04150fa',200187,'There IsToolbarButton check box indicates if this column button is part of the toolbar''s process button popup list or render as field.','Toolbar Button','Add the column button to the toolbar',0,100,100,'Y')
;

-- Oct 19, 2012 2:04:03 PM MYT
-- IDEMPIERE-234 Configure Toolbar
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, PO_Description,PO_Help,PrintName,PO_Name,PO_PrintName,Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.PO_Description,t.PO_Help,t.PrintName,t.PO_Name,t.PO_PrintName,t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200187 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Oct 19, 2012 2:06:09 PM MYT
-- IDEMPIERE-234 Configure Toolbar
INSERT INTO AD_Column (Version,AD_Table_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,CreatedBy,Updated,AD_Org_ID,IsActive,IsAutocomplete,IsAllowLogging,Created,IsUpdateable,AD_Column_UU,IsAlwaysUpdateable,Help,IsAllowCopy,UpdatedBy,DefaultValue,IsEncrypted,ColumnName,Description,Name,AD_Client_ID,AD_Column_ID,SeqNoSelection) VALUES (1,101,'D','Y','N','N',0,'N',1,'N',20,'N','N',200187,100,TO_TIMESTAMP('2012-10-19 14:06:08','YYYY-MM-DD HH24:MI:SS'),0,'Y','N','Y',TO_TIMESTAMP('2012-10-19 14:06:08','YYYY-MM-DD HH24:MI:SS'),'Y','0a289e70-0e89-449c-b748-f337a6bff84e','N','There IsToolbarButton check box indicates if this column button is part of the toolbar''s process button popup list or render as field.','Y',100,'Y','N','IsToolbarButton','Add the column button to the toolbar','Toolbar Button',0,200703,0)
;

-- Oct 19, 2012 2:06:09 PM MYT
-- IDEMPIERE-234 Configure Toolbar
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200703 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 19, 2012 2:09:23 PM MYT
-- IDEMPIERE-234 Configure Toolbar
INSERT INTO AD_Field (SortNo,IsEncrypted,AD_Tab_ID,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,Help,CreatedBy,Updated,EntityType,IsDisplayed,IsFieldOnly,IsDisplayedGrid,SeqNoGrid,AD_Field_UU,DisplayLength,DisplayLogic,Description,Name,IsActive,XPosition,ColumnSpan,NumLines) VALUES (0,'N',101,'N','N',200703,420,'Y',200648,'N',100,0,TO_TIMESTAMP('2012-10-19 14:09:21','YYYY-MM-DD HH24:MI:SS'),0,'There IsToolbarButton check box indicates if this column button is part of the toolbar''s process button popup list or render as field.',100,TO_TIMESTAMP('2012-10-19 14:09:21','YYYY-MM-DD HH24:MI:SS'),'D','Y','N','Y',400,'452b8d03-a4f0-4597-a30c-24e525f90590',0,'@AD_Reference_ID@=28','Add the column button to the toolbar','Toolbar Button','Y',2,1,1)
;

-- Oct 19, 2012 2:09:23 PM MYT
-- IDEMPIERE-234 Configure Toolbar
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200648 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 19, 2012 2:09:37 PM MYT
-- IDEMPIERE-234 Configure Toolbar
ALTER TABLE AD_Column ADD COLUMN IsToolbarButton CHAR(1) DEFAULT 'Y' CHECK (IsToolbarButton IN ('Y','N')) NOT NULL
;

UPDATE AD_Column SET IsToolbarButton='N' WHERE AD_Reference_ID != 28;

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
 c.isalwaysupdateable, c.readonlylogic, c.mandatorylogic, c.isupdateable, 
 c.isencrypted AS isencryptedcolumn, c.isselectioncolumn, tbl.tablename, c.valuemin, c.valuemax, 
 fg.name AS fieldgroup, vr.code AS validationcode, f.included_tab_id, fg.fieldgrouptype, fg.iscollapsedbydefault, 
 COALESCE(f.infofactoryclass, c.infofactoryclass) AS infofactoryclass, c.isautocomplete,
 COALESCE(f.IsAllowCopy, c.IsAllowCopy) AS IsAllowCopy,
	f.isdisplayedgrid, 
	f.seqnogrid,
	c.seqnoselection, f.xposition, f.columnspan, f.numlines, c.isToolbarButton
   FROM ad_field f
   JOIN ad_tab t ON f.ad_tab_id = t.ad_tab_id
   LEFT JOIN ad_fieldgroup fg ON f.ad_fieldgroup_id = fg.ad_fieldgroup_id
   LEFT JOIN ad_column c ON f.ad_column_id = c.ad_column_id
   JOIN ad_table tbl ON c.ad_table_id = tbl.ad_table_id
   JOIN ad_reference r ON c.ad_reference_id = r.ad_reference_id
   LEFT JOIN ad_val_rule vr ON vr.ad_val_rule_id = COALESCE(f.ad_val_rule_id, c.ad_val_rule_id)
  WHERE f.isactive = 'Y'::bpchar AND c.isactive = 'Y'::bpchar;

CREATE OR REPLACE VIEW ad_field_vt AS 
 SELECT trl.ad_language, t.ad_window_id, f.ad_tab_id, f.ad_field_id, tbl.ad_table_id, f.ad_column_id, trl.name, trl.description, 
 trl.help, f.isdisplayed, f.displaylogic, f.displaylength, f.seqno, f.sortno, f.issameline, f.isheading, f.isfieldonly, f.isreadonly, 
 f.isencrypted AS isencryptedfield, f.obscuretype, c.columnname, c.columnsql, c.fieldlength, c.vformat, COALESCE(f.defaultvalue, c.defaultvalue) AS defaultvalue, 
 c.iskey, c.isparent, COALESCE(f.ismandatory, c.ismandatory) AS ismandatory, c.isidentifier, c.istranslated, 
 COALESCE(f.ad_reference_value_id, c.ad_reference_value_id) AS ad_reference_value_id, c.callout, COALESCE(f.ad_reference_id, c.ad_reference_id) AS ad_reference_id, 
 COALESCE(f.ad_val_rule_id, c.ad_val_rule_id) AS ad_val_rule_id, c.ad_process_id, c.isalwaysupdateable, c.readonlylogic, c.mandatorylogic, c.isupdateable, 
 c.isencrypted AS isencryptedcolumn, c.isselectioncolumn, tbl.tablename, c.valuemin, c.valuemax, fgt.name AS fieldgroup, vr.code AS validationcode, 
 f.included_tab_id, fg.fieldgrouptype, fg.iscollapsedbydefault, COALESCE(f.infofactoryclass, c.infofactoryclass) AS infofactoryclass, c.isautocomplete,
 COALESCE(f.IsAllowCopy, c.IsAllowCopy) AS IsAllowCopy,
	f.isdisplayedgrid, 
	f.seqnogrid,
	c.seqnoselection, f.xposition, f.columnspan, f.numlines, c.isToolbarButton
   FROM ad_field f
   JOIN ad_field_trl trl ON f.ad_field_id = trl.ad_field_id
   JOIN ad_tab t ON f.ad_tab_id = t.ad_tab_id
   LEFT JOIN ad_fieldgroup fg ON f.ad_fieldgroup_id = fg.ad_fieldgroup_id
   LEFT JOIN ad_fieldgroup_trl fgt ON f.ad_fieldgroup_id = fgt.ad_fieldgroup_id AND trl.ad_language::text = fgt.ad_language::text
   LEFT JOIN ad_column c ON f.ad_column_id = c.ad_column_id
   JOIN ad_table tbl ON c.ad_table_id = tbl.ad_table_id
   JOIN ad_reference r ON c.ad_reference_id = r.ad_reference_id
   LEFT JOIN ad_val_rule vr ON vr.ad_val_rule_id = COALESCE(f.ad_val_rule_id, c.ad_val_rule_id)
  WHERE f.isactive = 'Y'::bpchar AND c.isactive = 'Y'::bpchar;

-- Oct 19, 2012 8:15:51 PM MYT
-- IDEMPIERE-234 Configure Toolbar
UPDATE AD_Field SET SeqNo=200,IsDisplayed='Y' WHERE AD_Field_ID=200648
;

-- Oct 19, 2012 8:15:51 PM MYT
-- IDEMPIERE-234 Configure Toolbar
UPDATE AD_Field SET SeqNo=210,IsDisplayed='Y' WHERE AD_Field_ID=54403
;

-- Oct 19, 2012 8:15:51 PM MYT
-- IDEMPIERE-234 Configure Toolbar
UPDATE AD_Field SET SeqNo=220,IsDisplayed='Y' WHERE AD_Field_ID=2574
;

-- Oct 19, 2012 8:15:51 PM MYT
-- IDEMPIERE-234 Configure Toolbar
UPDATE AD_Field SET SeqNo=230,IsDisplayed='Y' WHERE AD_Field_ID=2573
;

-- Oct 19, 2012 8:15:51 PM MYT
-- IDEMPIERE-234 Configure Toolbar
UPDATE AD_Field SET SeqNo=240,IsDisplayed='Y' WHERE AD_Field_ID=160
;

-- Oct 19, 2012 8:15:51 PM MYT
-- IDEMPIERE-234 Configure Toolbar
UPDATE AD_Field SET SeqNo=250,IsDisplayed='Y' WHERE AD_Field_ID=161
;

-- Oct 19, 2012 8:15:51 PM MYT
-- IDEMPIERE-234 Configure Toolbar
UPDATE AD_Field SET SeqNo=260,IsDisplayed='Y' WHERE AD_Field_ID=162
;

-- Oct 19, 2012 8:15:51 PM MYT
-- IDEMPIERE-234 Configure Toolbar
UPDATE AD_Field SET SeqNo=270,IsDisplayed='Y' WHERE AD_Field_ID=166
;

-- Oct 19, 2012 8:15:51 PM MYT
-- IDEMPIERE-234 Configure Toolbar
UPDATE AD_Field SET SeqNo=280,IsDisplayed='Y' WHERE AD_Field_ID=2370
;

-- Oct 19, 2012 8:15:51 PM MYT
-- IDEMPIERE-234 Configure Toolbar
UPDATE AD_Field SET SeqNo=290,IsDisplayed='Y' WHERE AD_Field_ID=169
;

-- Oct 19, 2012 8:15:51 PM MYT
-- IDEMPIERE-234 Configure Toolbar
UPDATE AD_Field SET SeqNo=300,IsDisplayed='Y' WHERE AD_Field_ID=10128
;

-- Oct 19, 2012 8:15:51 PM MYT
-- IDEMPIERE-234 Configure Toolbar
UPDATE AD_Field SET SeqNo=310,IsDisplayed='Y' WHERE AD_Field_ID=4941
;

-- Oct 19, 2012 8:15:51 PM MYT
-- IDEMPIERE-234 Configure Toolbar
UPDATE AD_Field SET SeqNo=320,IsDisplayed='Y' WHERE AD_Field_ID=50188
;

-- Oct 19, 2012 8:15:51 PM MYT
-- IDEMPIERE-234 Configure Toolbar
UPDATE AD_Field SET SeqNo=330,IsDisplayed='Y' WHERE AD_Field_ID=168
;

-- Oct 19, 2012 8:15:51 PM MYT
-- IDEMPIERE-234 Configure Toolbar
UPDATE AD_Field SET SeqNo=340,IsDisplayed='Y' WHERE AD_Field_ID=159
;

-- Oct 19, 2012 8:15:51 PM MYT
-- IDEMPIERE-234 Configure Toolbar
UPDATE AD_Field SET SeqNo=350,IsDisplayed='Y' WHERE AD_Field_ID=825
;

-- Oct 19, 2012 8:15:51 PM MYT
-- IDEMPIERE-234 Configure Toolbar
UPDATE AD_Field SET SeqNo=360,IsDisplayed='Y' WHERE AD_Field_ID=4940
;

-- Oct 19, 2012 8:15:51 PM MYT
-- IDEMPIERE-234 Configure Toolbar
UPDATE AD_Field SET SeqNo=370,IsDisplayed='Y' WHERE AD_Field_ID=200288
;

-- Oct 19, 2012 8:15:51 PM MYT
-- IDEMPIERE-234 Configure Toolbar
UPDATE AD_Field SET SeqNo=380,IsDisplayed='Y' WHERE AD_Field_ID=167
;

-- Oct 19, 2012 8:15:51 PM MYT
-- IDEMPIERE-234 Configure Toolbar
UPDATE AD_Field SET SeqNo=390,IsDisplayed='Y' WHERE AD_Field_ID=5121
;

-- Oct 19, 2012 8:15:51 PM MYT
-- IDEMPIERE-234 Configure Toolbar
UPDATE AD_Field SET SeqNo=400,IsDisplayed='Y' WHERE AD_Field_ID=56317
;

-- Oct 19, 2012 8:15:51 PM MYT
-- IDEMPIERE-234 Configure Toolbar
UPDATE AD_Field SET SeqNo=410,IsDisplayed='Y' WHERE AD_Field_ID=62467
;

-- Oct 19, 2012 8:15:51 PM MYT
-- IDEMPIERE-234 Configure Toolbar
UPDATE AD_Field SET SeqNo=420,IsDisplayed='Y' WHERE AD_Field_ID=5122
;

-- Oct 19, 2012 8:18:29 PM MYT
-- IDEMPIERE-234 Configure Toolbar
UPDATE AD_Field SET XPosition=1,Updated=TO_TIMESTAMP('2012-10-19 20:18:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=54403
;

-- Oct 19, 2012 8:24:01 PM MYT
-- IDEMPIERE-234 Configure Toolbar
UPDATE AD_Field SET SeqNo=190,IsDisplayed='Y' WHERE AD_Field_ID=200648
;

-- Oct 19, 2012 8:24:01 PM MYT
-- IDEMPIERE-234 Configure Toolbar
UPDATE AD_Field SET SeqNo=200,IsDisplayed='Y' WHERE AD_Field_ID=171
;

-- Oct 19, 2012 8:25:00 PM MYT
-- IDEMPIERE-234 Configure Toolbar
UPDATE AD_Field SET SeqNoGrid=170,IsDisplayedGrid='Y' WHERE AD_Field_ID=56374
;

-- Oct 19, 2012 8:25:00 PM MYT
-- IDEMPIERE-234 Configure Toolbar
UPDATE AD_Field SET SeqNoGrid=180,IsDisplayedGrid='Y' WHERE AD_Field_ID=2526
;

-- Oct 19, 2012 8:25:00 PM MYT
-- IDEMPIERE-234 Configure Toolbar
UPDATE AD_Field SET SeqNoGrid=190,IsDisplayedGrid='Y' WHERE AD_Field_ID=200648
;

-- Oct 19, 2012 8:25:00 PM MYT
-- IDEMPIERE-234 Configure Toolbar
UPDATE AD_Field SET SeqNoGrid=200,IsDisplayedGrid='Y' WHERE AD_Field_ID=171
;

-- Oct 19, 2012 8:25:00 PM MYT
-- IDEMPIERE-234 Configure Toolbar
UPDATE AD_Field SET SeqNoGrid=210,IsDisplayedGrid='Y' WHERE AD_Field_ID=54403
;

-- Oct 19, 2012 8:25:00 PM MYT
-- IDEMPIERE-234 Configure Toolbar
UPDATE AD_Field SET SeqNoGrid=220,IsDisplayedGrid='Y' WHERE AD_Field_ID=2574
;

-- Oct 19, 2012 8:25:00 PM MYT
-- IDEMPIERE-234 Configure Toolbar
UPDATE AD_Field SET SeqNoGrid=230,IsDisplayedGrid='Y' WHERE AD_Field_ID=2573
;

-- Oct 19, 2012 8:25:00 PM MYT
-- IDEMPIERE-234 Configure Toolbar
UPDATE AD_Field SET SeqNoGrid=240,IsDisplayedGrid='Y' WHERE AD_Field_ID=160
;

-- Oct 19, 2012 8:25:00 PM MYT
-- IDEMPIERE-234 Configure Toolbar
UPDATE AD_Field SET SeqNoGrid=250,IsDisplayedGrid='Y' WHERE AD_Field_ID=161
;

-- Oct 19, 2012 8:25:00 PM MYT
-- IDEMPIERE-234 Configure Toolbar
UPDATE AD_Field SET SeqNoGrid=260,IsDisplayedGrid='Y' WHERE AD_Field_ID=162
;

-- Oct 19, 2012 8:25:00 PM MYT
-- IDEMPIERE-234 Configure Toolbar
UPDATE AD_Field SET SeqNoGrid=270,IsDisplayedGrid='Y' WHERE AD_Field_ID=166
;

-- Oct 19, 2012 8:25:00 PM MYT
-- IDEMPIERE-234 Configure Toolbar
UPDATE AD_Field SET SeqNoGrid=280,IsDisplayedGrid='Y' WHERE AD_Field_ID=2370
;

-- Oct 19, 2012 8:25:00 PM MYT
-- IDEMPIERE-234 Configure Toolbar
UPDATE AD_Field SET SeqNoGrid=290,IsDisplayedGrid='Y' WHERE AD_Field_ID=169
;

-- Oct 19, 2012 8:25:00 PM MYT
-- IDEMPIERE-234 Configure Toolbar
UPDATE AD_Field SET SeqNoGrid=300,IsDisplayedGrid='Y' WHERE AD_Field_ID=10128
;

-- Oct 19, 2012 8:25:00 PM MYT
-- IDEMPIERE-234 Configure Toolbar
UPDATE AD_Field SET SeqNoGrid=310,IsDisplayedGrid='Y' WHERE AD_Field_ID=4941
;

-- Oct 19, 2012 8:25:00 PM MYT
-- IDEMPIERE-234 Configure Toolbar
UPDATE AD_Field SET SeqNoGrid=320,IsDisplayedGrid='Y' WHERE AD_Field_ID=50188
;

-- Oct 19, 2012 8:25:00 PM MYT
-- IDEMPIERE-234 Configure Toolbar
UPDATE AD_Field SET SeqNoGrid=330,IsDisplayedGrid='Y' WHERE AD_Field_ID=168
;

-- Oct 19, 2012 8:25:00 PM MYT
-- IDEMPIERE-234 Configure Toolbar
UPDATE AD_Field SET SeqNoGrid=340,IsDisplayedGrid='Y' WHERE AD_Field_ID=159
;

-- Oct 19, 2012 8:25:00 PM MYT
-- IDEMPIERE-234 Configure Toolbar
UPDATE AD_Field SET SeqNoGrid=350,IsDisplayedGrid='Y' WHERE AD_Field_ID=825
;

-- Oct 19, 2012 8:25:00 PM MYT
-- IDEMPIERE-234 Configure Toolbar
UPDATE AD_Field SET SeqNoGrid=360,IsDisplayedGrid='Y' WHERE AD_Field_ID=4940
;

-- Oct 19, 2012 8:25:00 PM MYT
-- IDEMPIERE-234 Configure Toolbar
UPDATE AD_Field SET SeqNoGrid=370,IsDisplayedGrid='Y' WHERE AD_Field_ID=167
;

-- Oct 19, 2012 8:25:00 PM MYT
-- IDEMPIERE-234 Configure Toolbar
UPDATE AD_Field SET SeqNoGrid=380,IsDisplayedGrid='Y' WHERE AD_Field_ID=5121
;

-- Oct 19, 2012 8:25:00 PM MYT
-- IDEMPIERE-234 Configure Toolbar
UPDATE AD_Field SET SeqNoGrid=390,IsDisplayedGrid='Y' WHERE AD_Field_ID=56317
;

-- Oct 19, 2012 8:25:00 PM MYT
-- IDEMPIERE-234 Configure Toolbar
UPDATE AD_Field SET SeqNoGrid=400,IsDisplayedGrid='Y' WHERE AD_Field_ID=62467
;

-- Oct 19, 2012 8:25:00 PM MYT
-- IDEMPIERE-234 Configure Toolbar
UPDATE AD_Field SET SeqNoGrid=410,IsDisplayedGrid='Y' WHERE AD_Field_ID=5122
;

-- Oct 19, 2012 8:25:00 PM MYT
-- IDEMPIERE-234 Configure Toolbar
UPDATE AD_Field SET SeqNoGrid=420,IsDisplayedGrid='Y' WHERE AD_Field_ID=200288
;

SELECT register_migration_script('938_IDEMPIERE-234.sql') FROM dual
;

