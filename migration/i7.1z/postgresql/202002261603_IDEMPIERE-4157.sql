-- IDEMPIERE-4157 Quick Form enhancement
-- Oct 31, 2017 5:12:27 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203142,0,0,'Y',TO_TIMESTAMP('2017-10-31 17:12:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-10-31 17:12:26','YYYY-MM-DD HH24:MI:SS'),100,'IsQuickForm','Quick Form','Quick Form','D','3367c970-b5a2-47c8-86ad-efc08fd0a9f6')
;

-- Oct 31, 2017 5:13:45 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (213257,0,'Quick Form',107,'IsQuickForm','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2017-10-31 17:13:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-10-31 17:13:44','YYYY-MM-DD HH24:MI:SS'),100,203142,'Y','N','D','N','N','N','Y','882bd1cb-1777-4824-9ace-f434d00e1722','Y',0,'N','N')
;

-- Oct 31, 2017 5:13:51 PM IST
ALTER TABLE AD_Field ADD COLUMN IsQuickForm CHAR(1) DEFAULT 'N' CHECK (IsQuickForm IN ('Y','N')) NOT NULL
;

-- Oct 31, 2017 5:26:16 PM IST
UPDATE AD_Element SET Description='Display in Quick Form', Help='The field will be displayed in Quick Form for easy entry.',Updated=TO_TIMESTAMP('2017-10-31 17:26:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203142
;

-- Oct 31, 2017 5:26:16 PM IST
UPDATE AD_Column SET ColumnName='IsQuickForm', Name='Quick Form', Description='Display in Quick Form', Help='The field will be displayed in Quick Form for easy entry.' WHERE AD_Element_ID=203142
;

-- Oct 31, 2017 5:28:18 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205244,'Quick Form','Display in Quick Form','The field will be displayed in Quick Form for easy entry.',107,213257,'Y',0,440,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-10-31 17:28:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-10-31 17:28:17','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ada991db-87ad-45a3-8fd7-b8fefd16e50a','Y',420,1,1,1,'N','N','N')
;

-- Oct 31, 2017 5:29:05 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-10-31 17:29:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205244
;

-- Oct 31, 2017 5:29:05 PM IST
UPDATE AD_Field SET SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-10-31 17:29:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=133
;

-- Oct 31, 2017 5:29:05 PM IST
UPDATE AD_Field SET SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-10-31 17:29:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=137
;

-- Oct 31, 2017 5:29:06 PM IST
UPDATE AD_Field SET SeqNo=190, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-10-31 17:29:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200274
;

-- Oct 31, 2017 5:29:06 PM IST
UPDATE AD_Field SET SeqNo=200, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-10-31 17:29:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=138
;

-- Oct 31, 2017 5:29:06 PM IST
UPDATE AD_Field SET SeqNo=210, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-10-31 17:29:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202362
;

-- Oct 31, 2017 5:29:06 PM IST
UPDATE AD_Field SET SeqNo=220, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-10-31 17:29:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=142
;

-- Oct 31, 2017 5:29:06 PM IST
UPDATE AD_Field SET SeqNo=230, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-10-31 17:29:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8343
;

-- Oct 31, 2017 5:29:06 PM IST
UPDATE AD_Field SET SeqNo=240, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-10-31 17:29:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=140
;

-- Oct 31, 2017 5:29:06 PM IST
UPDATE AD_Field SET SeqNo=250, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-10-31 17:29:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202341
;

-- Oct 31, 2017 5:29:06 PM IST
UPDATE AD_Field SET SeqNo=260, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-10-31 17:29:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=141
;

-- Oct 31, 2017 5:29:06 PM IST
UPDATE AD_Field SET SeqNo=270, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-10-31 17:29:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200350
;

-- Oct 31, 2017 5:29:06 PM IST
UPDATE AD_Field SET SeqNo=280, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-10-31 17:29:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200348
;

-- Oct 31, 2017 5:29:06 PM IST
UPDATE AD_Field SET SeqNo=290, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-10-31 17:29:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200349
;

-- Oct 31, 2017 5:29:06 PM IST
UPDATE AD_Field SET SeqNo=300, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-10-31 17:29:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204213
;

-- Oct 31, 2017 5:29:06 PM IST
UPDATE AD_Field SET SeqNo=310, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-10-31 17:29:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204214
;

-- Oct 31, 2017 5:29:06 PM IST
UPDATE AD_Field SET SeqNo=320, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-10-31 17:29:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13425
;

-- Oct 31, 2017 5:29:06 PM IST
UPDATE AD_Field SET SeqNo=330, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-10-31 17:29:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200837
;

-- Oct 31, 2017 5:29:06 PM IST
UPDATE AD_Field SET SeqNo=340, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-10-31 17:29:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=54402
;

-- Oct 31, 2017 5:29:06 PM IST
UPDATE AD_Field SET SeqNo=350, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-10-31 17:29:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=54401
;

-- Oct 31, 2017 5:29:06 PM IST
UPDATE AD_Field SET SeqNo=360, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-10-31 17:29:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200838
;

-- Oct 31, 2017 5:29:06 PM IST
UPDATE AD_Field SET SeqNo=370, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-10-31 17:29:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200834
;

-- Oct 31, 2017 5:29:06 PM IST
UPDATE AD_Field SET SeqNo=380, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-10-31 17:29:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13424
;

-- Oct 31, 2017 5:29:06 PM IST
UPDATE AD_Field SET SeqNo=390, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-10-31 17:29:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=62468
;

-- Oct 31, 2017 5:29:06 PM IST
UPDATE AD_Field SET SeqNo=400, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-10-31 17:29:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53280
;

-- Oct 31, 2017 5:29:06 PM IST
UPDATE AD_Field SET SeqNo=410, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-10-31 17:29:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200836
;

-- Oct 31, 2017 5:29:06 PM IST
UPDATE AD_Field SET SeqNo=420, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-10-31 17:29:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203500
;

-- Oct 31, 2017 5:29:06 PM IST
UPDATE AD_Field SET SeqNo=430, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-10-31 17:29:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200835
;

-- Oct 31, 2017 5:29:06 PM IST
UPDATE AD_Field SET SeqNo=440, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-10-31 17:29:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=136
;

-- Oct 31, 2017 5:29:06 PM IST
UPDATE AD_Field SET SeqNo=450, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-10-31 17:29:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=139
;

INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,AD_ToolBarButton_ID,Name,Updated,UpdatedBy,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers,AD_ToolBarButton_UU,"action",SeqNo,IsAdvancedButton,IsAddSeparator,EntityType,IsShowMore) VALUES (0,0,TO_TIMESTAMP('2017-11-01 09:47:25','YYYY-MM-DD HH24:MI:SS'),100,'QuickForm','Y',200094,'Window -QuickForm',TO_TIMESTAMP('2017-11-01 09:47:25','YYYY-MM-DD HH24:MI:SS'),100,'N',0,0,'73c01d0e-ff1b-4bbb-b3c7-e6c650adbed8','W',280,'N','Y','D','Y')
;

CREATE OR REPLACE VIEW ad_field_v AS
 SELECT t.ad_window_id, f.ad_tab_id, f.ad_field_id, tbl.ad_table_id, f.ad_column_id, f.name, f.description, f.help, f.isdisplayed, f.displaylogic, f.displaylength, f.seqno, f.sortno, f.issameline,
f.isheading, f.isfieldonly, f.isreadonly, f.isencrypted AS isencryptedfield, f.obscuretype, c.columnname, c.columnsql, c.fieldlength, COALESCE(f.VFormat, c.VFormat) AS VFormat, COALESCE(f.defaultvalue, c.defaultvalue) AS defaultvalue,
c.iskey, c.isparent, COALESCE(f.ismandatory, c.ismandatory) AS ismandatory, c.isidentifier, c.istranslated, COALESCE(f.ad_reference_value_id, c.ad_reference_value_id) AS ad_reference_value_id,
c.callout, COALESCE(f.ad_reference_id, c.ad_reference_id) AS ad_reference_id, COALESCE(f.ad_val_rule_id, c.ad_val_rule_id) AS ad_val_rule_id, c.ad_process_id, COALESCE(f.isalwaysupdateable, c.isalwaysupdateable) AS isalwaysupdateable,
COALESCE(f.readonlylogic, c.readonlylogic) AS readonlylogic, COALESCE(f.mandatorylogic, c.mandatorylogic) AS mandatorylogic, COALESCE(f.isupdateable, c.isupdateable) AS isupdateable,
c.isencrypted AS isencryptedcolumn, c.isselectioncolumn, tbl.tablename, c.valuemin, c.valuemax, fg.name AS fieldgroup, vr.code AS validationcode, f.included_tab_id, fg.fieldgrouptype,
fg.iscollapsedbydefault, COALESCE(f.infofactoryclass, c.infofactoryclass) AS infofactoryclass, c.isautocomplete, COALESCE(f.isallowcopy, c.isallowcopy) AS isallowcopy, f.isdisplayedgrid,
f.seqnogrid, c.seqnoselection, f.xposition, f.columnspan, f.numlines, COALESCE(f.istoolbarbutton, c.istoolbarbutton) AS istoolbarbutton, c.formatpattern, f.isadvancedfield, f.isdefaultfocus,
c.ad_chart_id, f.ad_labelstyle_id, f.ad_fieldstyle_id, c.pa_dashboardcontent_id, COALESCE(f.placeholder, c.placeholder) AS placeholder, c.ishtml, f.isquickform
   FROM ad_field f
   JOIN ad_tab t ON f.ad_tab_id = t.ad_tab_id
   LEFT JOIN ad_fieldgroup fg ON f.ad_fieldgroup_id = fg.ad_fieldgroup_id
   LEFT JOIN ad_column c ON f.ad_column_id = c.ad_column_id
   JOIN ad_table tbl ON c.ad_table_id = tbl.ad_table_id
   LEFT JOIN ad_val_rule vr ON vr.ad_val_rule_id = COALESCE(f.ad_val_rule_id, c.ad_val_rule_id)
  WHERE f.isactive = 'Y' AND c.isactive = 'Y'
;

CREATE OR REPLACE VIEW ad_field_vt AS
 SELECT trl.ad_language, t.ad_window_id, f.ad_tab_id, f.ad_field_id, tbl.ad_table_id, f.ad_column_id, trl.name, trl.description, trl.help, f.isdisplayed, f.displaylogic, f.displaylength, f.seqno,
 f.sortno, f.issameline, f.isheading, f.isfieldonly, f.isreadonly, f.isencrypted AS isencryptedfield, f.obscuretype, c.columnname, c.columnsql, c.fieldlength, COALESCE(f.VFormat, c.VFormat) AS VFormat, COALESCE(f.defaultvalue, c.defaultvalue) AS defaultvalue,
 c.iskey, c.isparent, COALESCE(f.ismandatory, c.ismandatory) AS ismandatory, c.isidentifier, c.istranslated, COALESCE(f.ad_reference_value_id, c.ad_reference_value_id) AS ad_reference_value_id,
 c.callout, COALESCE(f.ad_reference_id, c.ad_reference_id) AS ad_reference_id, COALESCE(f.ad_val_rule_id, c.ad_val_rule_id) AS ad_val_rule_id, c.ad_process_id, COALESCE(f.isalwaysupdateable,
 c.isalwaysupdateable) AS isalwaysupdateable, COALESCE(f.readonlylogic, c.readonlylogic) AS readonlylogic, COALESCE(f.mandatorylogic, c.mandatorylogic) AS mandatorylogic, COALESCE(f.isupdateable, c.isupdateable) AS isupdateable,
 c.isencrypted AS isencryptedcolumn, c.isselectioncolumn, tbl.tablename, c.valuemin, c.valuemax, fgt.name AS fieldgroup, vr.code AS validationcode, f.included_tab_id, fg.fieldgrouptype,
 fg.iscollapsedbydefault, COALESCE(f.infofactoryclass, c.infofactoryclass) AS infofactoryclass, c.isautocomplete, COALESCE(f.isallowcopy, c.isallowcopy) AS isallowcopy, f.isdisplayedgrid,
 f.seqnogrid, c.seqnoselection, f.xposition, f.columnspan, f.numlines, COALESCE(f.istoolbarbutton, c.istoolbarbutton) AS istoolbarbutton, c.formatpattern, f.isadvancedfield, f.isdefaultfocus, c.ad_chart_id, f.ad_labelstyle_id, f.ad_fieldstyle_id, c.pa_dashboardcontent_id, COALESCE(trl.placeholder, ct.placeholder) AS placeholder, c.ishtml, f.isquickform
   FROM ad_field f
   JOIN ad_field_trl trl ON f.ad_field_id = trl.ad_field_id
   JOIN ad_tab t ON f.ad_tab_id = t.ad_tab_id
   LEFT JOIN ad_fieldgroup fg ON f.ad_fieldgroup_id = fg.ad_fieldgroup_id
   LEFT JOIN ad_fieldgroup_trl fgt ON f.ad_fieldgroup_id = fgt.ad_fieldgroup_id AND trl.ad_language::text = fgt.ad_language::text
   LEFT JOIN ad_column c ON f.ad_column_id = c.ad_column_id
   LEFT JOIN ad_column_trl ct ON f.ad_column_id = ct.ad_column_id AND trl.ad_language::text = ct.ad_language::text
   JOIN ad_table tbl ON c.ad_table_id = tbl.ad_table_id
   LEFT JOIN ad_val_rule vr ON vr.ad_val_rule_id = COALESCE(f.ad_val_rule_id, c.ad_val_rule_id)
  WHERE f.isactive = 'Y' AND c.isactive = 'Y'
;


-- Nov 8, 2017 10:56:03 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213259,0,'Quick Form','Display in Quick Form','The field will be displayed in Quick Form for easy encoding.',200008,'IsQuickForm','N',1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2017-11-08 10:56:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-11-08 10:56:02','YYYY-MM-DD HH24:MI:SS'),100,203142,'Y','N','D','N','N','N','Y','c52262c8-322a-4607-a50d-745a7f063706','Y',0,'N','N','N')
;

-- Nov 8, 2017 10:56:08 AM IST
ALTER TABLE AD_Tab_Customization ADD COLUMN IsQuickForm CHAR(1) DEFAULT 'N' CHECK (IsQuickForm IN ('Y','N'))
;

-- Nov 9, 2017 10:55:12 AM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Quick Form',0,0,'Y',TO_TIMESTAMP('2017-11-09 10:55:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-11-09 10:55:11','YYYY-MM-DD HH24:MI:SS'),100,200440,'QuickForm','D','0fadb3eb-413b-41c2-b41c-d0ae3a1d5c27')
;


-- Nov 21, 2017 11:39:03 AM IST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200112,0,0,TO_TIMESTAMP('2017-11-21 11:39:02','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2017-11-21 11:39:02','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','QUICKFORM_PAGE_SIZE','25','Default paging size for Quick Form in zk webui','D','C','2ae2e737-285e-4cda-82a6-bbe7efce2cb8')
;

-- Quick Form enhancement
-- Nov 22, 2017 12:48:12 PM IST
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,AD_ToolBarButton_ID,Name,Updated,UpdatedBy,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers,AD_ToolBarButton_UU,"action",SeqNo,IsAdvancedButton,IsAddSeparator,EntityType,IsShowMore) VALUES (0,0,TO_TIMESTAMP('2017-11-22 12:48:11','YYYY-MM-DD HH24:MI:SS'),100,'QuickForm','Y',200095,'Detail - QuickForm',TO_TIMESTAMP('2017-11-22 12:48:11','YYYY-MM-DD HH24:MI:SS'),100,'N',0,0,'93a9a483-ea2f-49b7-8737-a4113b2aa8de','D',50,'N','N','D','N')
;

-- Quick Form read only
-- Feb 18, 2020, 6:13:37 PM IST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ReadOnlyLogic='@AD_Column_ID.AD_Reference_ID@=200122 | @AD_Column_ID.AD_Reference_ID@=200127 | @AD_Column_ID.AD_Reference_ID@=200128 | @AD_Column_ID.AD_Reference_ID@=200161 | @AD_Column_ID.AD_Reference_ID@=200162 | @AD_Column_ID.AD_Reference_ID@=200163', IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-02-18 18:13:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205244
;

-- Feb 26, 2020, 7:06:38 PM CET
UPDATE AD_ToolBarButton SET SeqNo=300,Updated=TO_TIMESTAMP('2020-02-26 19:06:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ToolBarButton_ID=200081
;

-- Feb 26, 2020, 7:06:51 PM CET
UPDATE AD_ToolBarButton SET SeqNo=290,Updated=TO_TIMESTAMP('2020-02-26 19:06:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ToolBarButton_ID=200067
;

SELECT register_migration_script('202002261603_IDEMPIERE-4157.sql') FROM dual
;
