SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-5232
-- Mar 15, 2022, 2:30:49 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214712,0,'Chart',107,'AD_Chart_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_DATE('2022-03-15 14:30:49','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2022-03-15 14:30:49','YYYY-MM-DD HH24:MI:SS'),0,54268,'Y','N','D','N','N','N','Y','1f3620c0-0def-4180-a577-fc1e682ff8e6','Y',0,'N','N','N','N')
;

-- Mar 15, 2022, 2:30:50 PM CET
UPDATE AD_Column SET FKConstraintName='ADChart_ADField', FKConstraintType='N',Updated=TO_DATE('2022-03-15 14:30:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=214712
;

-- Mar 15, 2022, 2:30:50 PM CET
ALTER TABLE AD_Field ADD AD_Chart_ID NUMBER(10) DEFAULT NULL 
;

-- Mar 15, 2022, 2:30:50 PM CET
ALTER TABLE AD_Field ADD CONSTRAINT ADChart_ADField FOREIGN KEY (AD_Chart_ID) REFERENCES ad_chart(ad_chart_id) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 15, 2022, 2:31:08 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214713,0,'Chart',464,'AD_Chart_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_DATE('2022-03-15 14:31:08','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2022-03-15 14:31:08','YYYY-MM-DD HH24:MI:SS'),0,54268,'Y','N','D','N','N','N','Y','bc6b9241-f8bf-49fb-8198-fcd53f80b047','Y',0,'N','N','N','N')
;

-- Mar 15, 2022, 2:31:09 PM CET
UPDATE AD_Column SET FKConstraintName='ADChart_ADUserDefField', FKConstraintType='N',Updated=TO_DATE('2022-03-15 14:31:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=214713
;

-- Mar 15, 2022, 2:31:09 PM CET
ALTER TABLE AD_UserDef_Field ADD AD_Chart_ID NUMBER(10) DEFAULT NULL 
;

-- Mar 15, 2022, 2:31:09 PM CET
ALTER TABLE AD_UserDef_Field ADD CONSTRAINT ADChart_ADUserDefField FOREIGN KEY (AD_Chart_ID) REFERENCES ad_chart(ad_chart_id) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 15, 2022, 2:31:24 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206914,'Chart',107,214712,'Y',22,510,'N','N','N','N',0,0,'Y',TO_DATE('2022-03-15 14:31:24','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2022-03-15 14:31:24','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','df23d2db-b8ab-4e63-af6f-f5283b907f72','Y',500,2)
;

-- Mar 15, 2022, 2:31:34 PM CET
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=53370', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-03-15 14:31:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206914
;

-- Mar 15, 2022, 2:32:10 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=450, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2022-03-15 14:32:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206914
;

-- Mar 15, 2022, 2:32:10 PM CET
UPDATE AD_Field SET SeqNo=460, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-03-15 14:32:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=53280
;

-- Mar 15, 2022, 2:32:10 PM CET
UPDATE AD_Field SET SeqNo=470, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-03-15 14:32:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=203500
;

-- Mar 15, 2022, 2:32:10 PM CET
UPDATE AD_Field SET SeqNo=480, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-03-15 14:32:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200836
;

-- Mar 15, 2022, 2:32:10 PM CET
UPDATE AD_Field SET SeqNo=490, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-03-15 14:32:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200835
;

-- Mar 15, 2022, 2:32:10 PM CET
UPDATE AD_Field SET SeqNo=500, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-03-15 14:32:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=136
;

-- Mar 15, 2022, 2:32:10 PM CET
UPDATE AD_Field SET SeqNo=510, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-03-15 14:32:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=139
;

-- Mar 15, 2022, 2:32:22 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206915,'Chart',395,214713,'Y',22,390,'N','N','N','N',0,0,'Y',TO_DATE('2022-03-15 14:32:22','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2022-03-15 14:32:22','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','b1b92474-66d4-40b3-9623-31c776bc0c3f','Y',360,2)
;

-- Mar 15, 2022, 2:32:34 PM CET
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=53370', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-03-15 14:32:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206915
;

-- Mar 15, 2022, 2:32:49 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=340, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2022-03-15 14:32:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206915
;

-- Mar 15, 2022, 2:32:49 PM CET
UPDATE AD_Field SET SeqNo=350, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-03-15 14:32:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200852
;

-- Mar 15, 2022, 2:32:49 PM CET
UPDATE AD_Field SET SeqNo=360, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-03-15 14:32:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=203499
;

-- Mar 15, 2022, 2:32:49 PM CET
UPDATE AD_Field SET SeqNo=370, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-03-15 14:32:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200854
;

-- Mar 15, 2022, 2:32:49 PM CET
UPDATE AD_Field SET SeqNo=380, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-03-15 14:32:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=5051
;

-- Mar 15, 2022, 2:32:49 PM CET
UPDATE AD_Field SET SeqNo=390, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-03-15 14:32:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=5057
;

-- Mar 15, 2022, 2:33:06 PM CET
UPDATE AD_ViewColumn SET ColumnSQL='COALESCE(f.ad_chart_id, c.ad_chart_id)',Updated=TO_DATE('2022-03-15 14:33:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_ViewColumn_ID=200277
;

-- Mar 15, 2022, 2:33:11 PM CET
CREATE OR REPLACE VIEW AD_Field_v(AD_Window_ID, AD_Tab_ID, AD_Field_ID, AD_Table_ID, AD_Column_ID, Name, Description, Help, IsDisplayed, DisplayLogic, DisplayLength, SeqNo, SortNo, IsSameLine, IsHeading, IsFieldOnly, IsReadOnly, isencryptedfield, ObscureType, ColumnName, ColumnSQL, FieldLength, VFormat, DefaultValue, IsKey, IsParent, IsMandatory, IsIdentifier, IsTranslated, AD_Reference_Value_ID, Callout, AD_Reference_ID, AD_Val_Rule_ID, AD_Process_ID, IsAlwaysUpdateable, ReadOnlyLogic, MandatoryLogic, IsUpdateable, isencryptedcolumn, IsSelectionColumn, TableName, ValueMin, ValueMax, fieldgroup, validationcode, Included_Tab_ID, FieldGroupType, IsCollapsedByDefault, InfoFactoryClass, IsAutocomplete, IsAllowCopy, IsDisplayedGrid, SeqNoGrid, SeqNoSelection, XPosition, ColumnSpan, NumLines, IsToolbarButton, FormatPattern, IsAdvancedField, IsDefaultFocus, AD_Chart_ID, AD_LabelStyle_ID, AD_FieldStyle_ID, PA_DashboardContent_ID, Placeholder, IsHtml, IsQuickForm, AD_Val_Rule_Lookup_ID, validationcodelookup) AS SELECT t.ad_window_id AS AD_Window_ID, f.ad_tab_id AS AD_Tab_ID, f.ad_field_id AS AD_Field_ID, tbl.ad_table_id AS AD_Table_ID, f.ad_column_id AS AD_Column_ID, f.name AS Name, f.description AS Description, f.help AS Help, f.isdisplayed AS IsDisplayed, f.displaylogic AS DisplayLogic, f.displaylength AS DisplayLength, f.seqno AS SeqNo, f.sortno AS SortNo, f.issameline AS IsSameLine, f.isheading AS IsHeading, f.isfieldonly AS IsFieldOnly, f.isreadonly AS IsReadOnly, f.isencrypted AS isencryptedfield, f.obscuretype AS ObscureType, c.columnname AS ColumnName, COALESCE(f.columnsql, c.columnsql) AS ColumnSQL, c.fieldlength AS FieldLength, COALESCE(f.vformat, c.vformat) AS VFormat, COALESCE(f.defaultvalue, c.defaultvalue) AS DefaultValue, c.iskey AS IsKey, c.isparent AS IsParent, COALESCE(f.ismandatory, c.ismandatory) AS IsMandatory, c.isidentifier AS IsIdentifier, c.istranslated AS IsTranslated, 
COALESCE(f.ad_reference_value_id, c.ad_reference_value_id) AS AD_Reference_Value_ID, c.callout AS Callout, COALESCE(f.ad_reference_id, c.ad_reference_id) AS AD_Reference_ID, COALESCE(f.ad_val_rule_id, c.ad_val_rule_id) AS AD_Val_Rule_ID, c.ad_process_id AS AD_Process_ID, COALESCE(f.isalwaysupdateable, c.isalwaysupdateable) AS IsAlwaysUpdateable, COALESCE(f.readonlylogic, c.readonlylogic) AS ReadOnlyLogic, COALESCE(f.mandatorylogic, c.mandatorylogic) AS MandatoryLogic, COALESCE(f.isupdateable, c.isupdateable) AS IsUpdateable, c.isencrypted AS isencryptedcolumn, COALESCE(f.isselectioncolumn, c.isselectioncolumn) AS IsSelectionColumn, tbl.tablename AS TableName, c.valuemin AS ValueMin, c.valuemax AS ValueMax, fg.name AS fieldgroup, vr.code AS validationcode, f.included_tab_id AS Included_Tab_ID, fg.fieldgrouptype AS FieldGroupType, fg.iscollapsedbydefault AS IsCollapsedByDefault, COALESCE(f.infofactoryclass, c.infofactoryclass) AS InfoFactoryClass, c.isautocomplete AS IsAutocomplete, COALESCE(f.isallowcopy, c.isallowcopy) AS IsAllowCopy, f.isdisplayedgrid AS IsDisplayedGrid, f.seqnogrid AS SeqNoGrid, c.seqnoselection AS SeqNoSelection, f.xposition AS XPosition, f.columnspan AS ColumnSpan, f.numlines AS NumLines, COALESCE(f.istoolbarbutton, c.istoolbarbutton) AS IsToolbarButton, c.formatpattern AS FormatPattern, f.isadvancedfield AS IsAdvancedField, f.isdefaultfocus AS IsDefaultFocus, COALESCE(f.ad_chart_id, c.ad_chart_id) AS AD_Chart_ID, f.ad_labelstyle_id AS AD_LabelStyle_ID, f.ad_fieldstyle_id AS AD_FieldStyle_ID, c.pa_dashboardcontent_id AS PA_DashboardContent_ID, COALESCE(f.placeholder, c.placeholder) AS Placeholder, c.ishtml AS IsHtml, f.isquickform AS IsQuickForm, COALESCE(f.ad_val_rule_lookup_id, c.ad_val_rule_lookup_id) AS AD_Val_Rule_Lookup_ID, vrf.code AS validationcodelookup FROM ad_field f
JOIN ad_tab t ON f.ad_tab_id = t.ad_tab_id
LEFT JOIN ad_fieldgroup fg ON f.ad_fieldgroup_id = fg.ad_fieldgroup_id
LEFT JOIN ad_column c ON f.ad_column_id = c.ad_column_id
JOIN ad_table tbl ON c.ad_table_id = tbl.ad_table_id
LEFT JOIN ad_val_rule vr ON vr.ad_val_rule_id = COALESCE(f.ad_val_rule_id, c.ad_val_rule_id)
LEFT JOIN ad_val_rule vrf ON vrf.ad_val_rule_id = COALESCE(f.ad_val_rule_lookup_id, c.ad_val_rule_lookup_id) WHERE f.isactive = 'Y' AND c.isactive = 'Y'
;

-- Mar 15, 2022, 2:33:19 PM CET
UPDATE AD_ViewColumn SET ColumnSQL='COALESCE(f.ad_chart_id, c.ad_chart_id)',Updated=TO_DATE('2022-03-15 14:33:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_ViewColumn_ID=200348
;

-- Mar 15, 2022, 2:33:24 PM CET
CREATE OR REPLACE VIEW AD_Field_vt(AD_Language, AD_Window_ID, AD_Tab_ID, AD_Field_ID, AD_Table_ID, AD_Column_ID, Name, Description, Help, IsDisplayed, DisplayLogic, DisplayLength, SeqNo, SortNo, IsSameLine, IsHeading, IsFieldOnly, IsReadOnly, isencryptedfield, ObscureType, ColumnName, ColumnSQL, FieldLength, VFormat, DefaultValue, IsKey, IsParent, IsMandatory, IsIdentifier, IsTranslated, AD_Reference_Value_ID, Callout, AD_Reference_ID, AD_Val_Rule_ID, AD_Process_ID, IsAlwaysUpdateable, ReadOnlyLogic, MandatoryLogic, IsUpdateable, isencryptedcolumn, IsSelectionColumn, TableName, ValueMin, ValueMax, fieldgroup, validationcode, Included_Tab_ID, FieldGroupType, IsCollapsedByDefault, InfoFactoryClass, IsAutocomplete, IsAllowCopy, IsDisplayedGrid, SeqNoGrid, SeqNoSelection, XPosition, ColumnSpan, NumLines, IsToolbarButton, FormatPattern, IsAdvancedField, IsDefaultFocus, AD_Chart_ID, AD_LabelStyle_ID, AD_FieldStyle_ID, PA_DashboardContent_ID, Placeholder, IsHtml, IsQuickForm, AD_Val_Rule_Lookup_ID, validationcodelookup) AS SELECT trl.ad_language AS AD_Language, t.ad_window_id AS AD_Window_ID, f.ad_tab_id AS AD_Tab_ID, f.ad_field_id AS AD_Field_ID, tbl.ad_table_id AS AD_Table_ID, f.ad_column_id AS AD_Column_ID, trl.name AS Name, trl.description AS Description, trl.help AS Help, f.isdisplayed AS IsDisplayed, f.displaylogic AS DisplayLogic, f.displaylength AS DisplayLength, f.seqno AS SeqNo, f.sortno AS SortNo, f.issameline AS IsSameLine, f.isheading AS IsHeading, f.isfieldonly AS IsFieldOnly, f.isreadonly AS IsReadOnly, f.isencrypted AS isencryptedfield, f.obscuretype AS ObscureType, c.columnname AS ColumnName, COALESCE(f.columnsql, c.columnsql) AS ColumnSQL, c.fieldlength AS FieldLength, COALESCE(f.vformat, c.vformat) AS VFormat, COALESCE(f.defaultvalue, c.defaultvalue) AS DefaultValue, c.iskey AS IsKey, c.isparent AS IsParent, COALESCE(f.ismandatory, c.ismandatory) AS IsMandatory, c.isidentifier AS IsIdentifier, c.istranslated AS IsTranslated, 
COALESCE(f.ad_reference_value_id, c.ad_reference_value_id) AS AD_Reference_Value_ID, c.callout AS Callout, COALESCE(f.ad_reference_id, c.ad_reference_id) AS AD_Reference_ID, COALESCE(f.ad_val_rule_id, c.ad_val_rule_id) AS AD_Val_Rule_ID, c.ad_process_id AS AD_Process_ID, COALESCE(f.isalwaysupdateable, c.isalwaysupdateable) AS IsAlwaysUpdateable, COALESCE(f.readonlylogic, c.readonlylogic) AS ReadOnlyLogic, COALESCE(f.mandatorylogic, c.mandatorylogic) AS MandatoryLogic, COALESCE(f.isupdateable, c.isupdateable) AS IsUpdateable, c.isencrypted AS isencryptedcolumn, COALESCE(f.isselectioncolumn, c.isselectioncolumn) AS IsSelectionColumn, tbl.tablename AS TableName, c.valuemin AS ValueMin, c.valuemax AS ValueMax, fgt.name AS fieldgroup, vr.code AS validationcode, f.included_tab_id AS Included_Tab_ID, fg.fieldgrouptype AS FieldGroupType, fg.iscollapsedbydefault AS IsCollapsedByDefault, COALESCE(f.infofactoryclass, c.infofactoryclass) AS InfoFactoryClass, c.isautocomplete AS IsAutocomplete, COALESCE(f.isallowcopy, c.isallowcopy) AS IsAllowCopy, f.isdisplayedgrid AS IsDisplayedGrid, f.seqnogrid AS SeqNoGrid, c.seqnoselection AS SeqNoSelection, f.xposition AS XPosition, f.columnspan AS ColumnSpan, f.numlines AS NumLines, COALESCE(f.istoolbarbutton, c.istoolbarbutton) AS IsToolbarButton, c.formatpattern AS FormatPattern, f.isadvancedfield AS IsAdvancedField, f.isdefaultfocus AS IsDefaultFocus, COALESCE(f.ad_chart_id, c.ad_chart_id) AS AD_Chart_ID, f.ad_labelstyle_id AS AD_LabelStyle_ID, f.ad_fieldstyle_id AS AD_FieldStyle_ID, c.pa_dashboardcontent_id AS PA_DashboardContent_ID, COALESCE(trl.placeholder, ct.placeholder) AS Placeholder, c.ishtml AS IsHtml, f.isquickform AS IsQuickForm, COALESCE(f.ad_val_rule_lookup_id, c.ad_val_rule_lookup_id) AS AD_Val_Rule_Lookup_ID, vrf.code AS validationcodelookup FROM ad_field f
JOIN ad_field_trl trl ON f.ad_field_id = trl.ad_field_id
JOIN ad_tab t ON f.ad_tab_id = t.ad_tab_id
LEFT JOIN ad_fieldgroup fg ON f.ad_fieldgroup_id = fg.ad_fieldgroup_id
LEFT JOIN ad_fieldgroup_trl fgt ON f.ad_fieldgroup_id = fgt.ad_fieldgroup_id AND trl.ad_language = fgt.ad_language
LEFT JOIN ad_column c ON f.ad_column_id = c.ad_column_id
LEFT JOIN ad_column_trl ct ON f.ad_column_id = ct.ad_column_id AND trl.ad_language = ct.ad_language
JOIN ad_table tbl ON c.ad_table_id = tbl.ad_table_id
LEFT JOIN ad_val_rule vr ON vr.ad_val_rule_id = COALESCE(f.ad_val_rule_id, c.ad_val_rule_id)
LEFT JOIN ad_val_rule vrf ON vrf.ad_val_rule_id = COALESCE(f.ad_val_rule_lookup_id, c.ad_val_rule_lookup_id) WHERE f.isactive = 'Y' AND c.isactive = 'Y'
;

-- Mar 16, 2022, 7:09:20 AM CET
UPDATE AD_Table SET AccessLevel='6',Updated=TO_TIMESTAMP('2022-03-16 07:09:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Table_ID=53284
;

-- Mar 16, 2022, 7:09:23 AM CET
UPDATE AD_Table SET AccessLevel='6',Updated=TO_TIMESTAMP('2022-03-16 07:09:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Table_ID=200122
;

-- Mar 16, 2022, 7:09:28 AM CET
UPDATE AD_Table SET AccessLevel='6',Updated=TO_TIMESTAMP('2022-03-16 07:09:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Table_ID=53282
;

-- Mar 22, 2022, 4:27:04 PM CET
UPDATE AD_Tab SET IsAdvancedTab='Y',Updated=TO_TIMESTAMP('2022-03-22 16:27:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Tab_ID=53340
;

SELECT register_migration_script('202203151430_IDEMPIERE-5232.sql') FROM dual
;
