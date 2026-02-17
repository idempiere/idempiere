-- IDEMPIERE-6848
SELECT register_migration_script('202602171336_IDEMPIERE-6848.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Feb 17, 2026, 1:36:50 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217380,0,'Process','Process or Report','The Process field identifies a unique Process or Report in the system.',107,'AD_Process_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2026-02-17 13:36:49','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-02-17 13:36:49','YYYY-MM-DD HH24:MI:SS'),10,117,'Y','N','D','N','N','N','Y','019c6b9a-7390-7328-bd35-2b8a99547ab5','Y',0,'N','N','N','N','N')
;

-- Feb 17, 2026, 1:37:24 PM CET
UPDATE AD_Column SET FKConstraintName='ADProcess_ADField', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-02-17 13:37:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=217380
;

-- Feb 17, 2026, 1:37:24 PM CET
ALTER TABLE AD_Field ADD AD_Process_ID NUMBER(10) DEFAULT NULL 
;

-- Feb 17, 2026, 1:37:24 PM CET
ALTER TABLE AD_Field ADD CONSTRAINT ADProcess_ADField FOREIGN KEY (AD_Process_ID) REFERENCES ad_process(ad_process_id) DEFERRABLE INITIALLY DEFERRED
;

-- Feb 17, 2026, 1:37:35 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209005,'Process','Process or Report','The Process field identifies a unique Process or Report in the system.',107,217380,'Y',22,540,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-02-17 13:37:35','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-02-17 13:37:35','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','019c6b9b-2421-78f2-8e47-3dd1f8e5bb4c','Y',520,2)
;

-- Feb 17, 2026, 1:37:55 PM CET
UPDATE AD_Field SET IsDisplayed='Y', DisplayLogic='@AD_Reference_ID@=28', SeqNo=480, XPosition=1,Updated=TO_TIMESTAMP('2026-02-17 13:37:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=209005
;

-- Feb 17, 2026, 1:37:55 PM CET
UPDATE AD_Field SET SeqNo=490,Updated=TO_TIMESTAMP('2026-02-17 13:37:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=53280
;

-- Feb 17, 2026, 1:37:55 PM CET
UPDATE AD_Field SET SeqNo=500,Updated=TO_TIMESTAMP('2026-02-17 13:37:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=203500
;

-- Feb 17, 2026, 1:37:55 PM CET
UPDATE AD_Field SET SeqNo=510,Updated=TO_TIMESTAMP('2026-02-17 13:37:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=200836
;

-- Feb 17, 2026, 1:37:55 PM CET
UPDATE AD_Field SET SeqNo=520,Updated=TO_TIMESTAMP('2026-02-17 13:37:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=200835
;

-- Feb 17, 2026, 1:37:55 PM CET
UPDATE AD_Field SET SeqNo=530,Updated=TO_TIMESTAMP('2026-02-17 13:37:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=136
;

-- Feb 17, 2026, 1:37:55 PM CET
UPDATE AD_Field SET SeqNo=540,Updated=TO_TIMESTAMP('2026-02-17 13:37:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=139
;

-- Feb 17, 2026, 1:38:16 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217381,0,'Process','Process or Report','The Process field identifies a unique Process or Report in the system.',464,'AD_Process_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2026-02-17 13:38:16','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-02-17 13:38:16','YYYY-MM-DD HH24:MI:SS'),10,117,'Y','N','D','N','N','N','Y','019c6b9b-c499-74b0-962b-621049b5d3ed','Y',0,'N','N','N','N','N')
;

-- Feb 17, 2026, 1:38:17 PM CET
UPDATE AD_Column SET FKConstraintName='ADProcess_ADUserDefField', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-02-17 13:38:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=217381
;

-- Feb 17, 2026, 1:38:17 PM CET
ALTER TABLE AD_UserDef_Field ADD AD_Process_ID NUMBER(10) DEFAULT NULL 
;

-- Feb 17, 2026, 1:38:17 PM CET
ALTER TABLE AD_UserDef_Field ADD CONSTRAINT ADProcess_ADUserDefField FOREIGN KEY (AD_Process_ID) REFERENCES ad_process(ad_process_id) DEFERRABLE INITIALLY DEFERRED
;

-- Feb 17, 2026, 1:38:37 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209006,'Process','Process or Report','The Process field identifies a unique Process or Report in the system.',395,217381,'Y',22,420,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-02-17 13:38:37','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-02-17 13:38:37','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','019c6b9c-1734-745c-bbe9-1e7a006e58ed','Y',380,2)
;

-- Feb 17, 2026, 1:38:50 PM CET
UPDATE AD_Field SET IsDisplayed='Y', DisplayLogic='@AD_Reference_ID@=28', SeqNo=370, XPosition=1,Updated=TO_TIMESTAMP('2026-02-17 13:38:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=209006
;

-- Feb 17, 2026, 1:38:50 PM CET
UPDATE AD_Field SET SeqNo=380,Updated=TO_TIMESTAMP('2026-02-17 13:38:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=200852
;

-- Feb 17, 2026, 1:38:50 PM CET
UPDATE AD_Field SET SeqNo=390,Updated=TO_TIMESTAMP('2026-02-17 13:38:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=203499
;

-- Feb 17, 2026, 1:38:50 PM CET
UPDATE AD_Field SET SeqNo=400,Updated=TO_TIMESTAMP('2026-02-17 13:38:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=200854
;

-- Feb 17, 2026, 1:38:50 PM CET
UPDATE AD_Field SET SeqNo=410,Updated=TO_TIMESTAMP('2026-02-17 13:38:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=5051
;

-- Feb 17, 2026, 1:38:50 PM CET
UPDATE AD_Field SET SeqNo=420,Updated=TO_TIMESTAMP('2026-02-17 13:38:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=5057
;

-- Feb 17, 2026, 1:39:29 PM CET
UPDATE AD_ViewColumn SET ColumnSQL='COALESCE(f.ad_process_id, c.AD_Process_ID)',Updated=TO_TIMESTAMP('2026-02-17 13:39:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_ViewColumn_ID=200249
;

-- Feb 17, 2026, 1:39:35 PM CET
CREATE OR REPLACE VIEW AD_Field_v(AD_Window_ID, AD_Tab_ID, AD_Field_ID, AD_Table_ID, AD_Column_ID, Name, Description, Help, IsDisplayed, DisplayLogic, DisplayLength, SeqNo, SortNo, IsSameLine, IsHeading, IsFieldOnly, IsReadOnly, isencryptedfield, ObscureType, ColumnName, ColumnSQL, FieldLength, VFormat, DefaultValue, IsKey, IsParent, IsMandatory, IsIdentifier, IsTranslated, AD_Reference_Value_ID, Callout, AD_Reference_ID, AD_Val_Rule_ID, AD_Process_ID, IsAlwaysUpdateable, ReadOnlyLogic, MandatoryLogic, IsUpdateable, isencryptedcolumn, IsSelectionColumn, TableName, ValueMin, ValueMax, fieldgroup, validationcode, Included_Tab_ID, FieldGroupType, IsCollapsedByDefault, InfoFactoryClass, IsAutocomplete, IsAllowCopy, IsDisplayedGrid, SeqNoGrid, SeqNoSelection, XPosition, ColumnSpan, NumLines, IsToolbarButton, FormatPattern, IsAdvancedField, IsDefaultFocus, AD_Chart_ID, AD_LabelStyle_ID, AD_FieldStyle_ID, PA_DashboardContent_ID, Placeholder, IsHtml, IsQuickForm, AD_Val_Rule_Lookup_ID, validationcodelookup, alwaysupdatablelogic, AD_InfoWindow_ID, entitytype) AS SELECT t.ad_window_id AS AD_Window_ID, f.ad_tab_id AS AD_Tab_ID, f.ad_field_id AS AD_Field_ID, tbl.ad_table_id AS AD_Table_ID, f.ad_column_id AS AD_Column_ID, f.name AS Name, f.description AS Description, f.help AS Help, f.isdisplayed AS IsDisplayed, f.displaylogic AS DisplayLogic, f.displaylength AS DisplayLength, f.seqno AS SeqNo, f.sortno AS SortNo, f.issameline AS IsSameLine, f.isheading AS IsHeading, f.isfieldonly AS IsFieldOnly, f.isreadonly AS IsReadOnly, f.isencrypted AS isencryptedfield, f.obscuretype AS ObscureType, c.columnname AS ColumnName, COALESCE(f.columnsql, c.columnsql) AS ColumnSQL, c.fieldlength AS FieldLength, COALESCE(f.vformat, c.vformat) AS VFormat, COALESCE(f.defaultvalue, c.defaultvalue) AS DefaultValue, c.iskey AS IsKey, c.isparent AS IsParent, COALESCE(f.ismandatory, c.ismandatory) AS IsMandatory, c.isidentifier AS IsIdentifier, c.istranslated AS IsTranslated, COALESCE(f.ad_reference_value_id, c.ad_reference_value_id) AS AD_Reference_Value_ID, c.callout AS Callout, COALESCE(f.ad_reference_id, c.ad_reference_id) AS AD_Reference_ID, COALESCE(f.ad_val_rule_id, c.ad_val_rule_id) AS AD_Val_Rule_ID, COALESCE(f.ad_process_id, c.AD_Process_ID) AS AD_Process_ID, COALESCE(f.isalwaysupdateable, c.isalwaysupdateable) AS IsAlwaysUpdateable, COALESCE(f.readonlylogic, c.readonlylogic) AS ReadOnlyLogic, COALESCE(f.mandatorylogic, c.mandatorylogic) AS MandatoryLogic, COALESCE(f.isupdateable, c.isupdateable) AS IsUpdateable, c.isencrypted AS isencryptedcolumn, COALESCE(f.isselectioncolumn, c.isselectioncolumn) AS IsSelectionColumn, tbl.tablename AS TableName, c.valuemin AS ValueMin, c.valuemax AS ValueMax, fg.name AS fieldgroup, vr.code AS validationcode, f.included_tab_id AS Included_Tab_ID, fg.fieldgrouptype AS FieldGroupType, fg.iscollapsedbydefault AS IsCollapsedByDefault, COALESCE(f.infofactoryclass, c.infofactoryclass) AS InfoFactoryClass, c.isautocomplete AS IsAutocomplete, COALESCE(f.isallowcopy, c.isallowcopy) AS IsAllowCopy, f.isdisplayedgrid AS IsDisplayedGrid, f.seqnogrid AS SeqNoGrid, c.seqnoselection AS SeqNoSelection, f.xposition AS XPosition, f.columnspan AS ColumnSpan, f.numlines AS NumLines, COALESCE(f.istoolbarbutton, c.istoolbarbutton) AS IsToolbarButton, c.formatpattern AS FormatPattern, f.isadvancedfield AS IsAdvancedField, f.isdefaultfocus AS IsDefaultFocus, COALESCE(f.ad_chart_id, c.ad_chart_id) AS AD_Chart_ID, f.ad_labelstyle_id AS AD_LabelStyle_ID, f.ad_fieldstyle_id AS AD_FieldStyle_ID, c.pa_dashboardcontent_id AS PA_DashboardContent_ID, COALESCE(f.placeholder, c.placeholder) AS Placeholder, COALESCE(f.ishtml, c.ishtml) AS IsHtml, f.isquickform AS IsQuickForm, COALESCE(f.ad_val_rule_lookup_id, c.ad_val_rule_lookup_id) AS AD_Val_Rule_Lookup_ID, vrf.code AS validationcodelookup, COALESCE(f.alwaysupdatablelogic, c.alwaysupdatablelogic) AS alwaysupdatablelogic, c.ad_infowindow_id AS AD_InfoWindow_ID, f.entitytype AS entitytype FROM ad_field f
JOIN ad_tab t ON f.ad_tab_id = t.ad_tab_id
LEFT JOIN ad_fieldgroup fg ON f.ad_fieldgroup_id = fg.ad_fieldgroup_id
LEFT JOIN ad_column c ON f.ad_column_id = c.ad_column_id
JOIN ad_table tbl ON c.ad_table_id = tbl.ad_table_id
LEFT JOIN ad_val_rule vr ON vr.ad_val_rule_id = COALESCE(f.ad_val_rule_id, c.ad_val_rule_id)
LEFT JOIN ad_val_rule vrf ON vrf.ad_val_rule_id = COALESCE(f.ad_val_rule_lookup_id, c.ad_val_rule_lookup_id) WHERE f.isactive = 'Y' AND c.isactive = 'Y'
;

-- Feb 17, 2026, 1:39:46 PM CET
UPDATE AD_ViewColumn SET ColumnSQL='COALESCE(f.ad_process_id, c.AD_Process_ID)',Updated=TO_TIMESTAMP('2026-02-17 13:39:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_ViewColumn_ID=200320
;

-- Feb 17, 2026, 1:39:51 PM CET
CREATE OR REPLACE VIEW AD_Field_vt(AD_Language, AD_Window_ID, AD_Tab_ID, AD_Field_ID, AD_Table_ID, AD_Column_ID, Name, Description, Help, IsDisplayed, DisplayLogic, DisplayLength, SeqNo, SortNo, IsSameLine, IsHeading, IsFieldOnly, IsReadOnly, isencryptedfield, ObscureType, ColumnName, ColumnSQL, FieldLength, VFormat, DefaultValue, IsKey, IsParent, IsMandatory, IsIdentifier, IsTranslated, AD_Reference_Value_ID, Callout, AD_Reference_ID, AD_Val_Rule_ID, AD_Process_ID, IsAlwaysUpdateable, ReadOnlyLogic, MandatoryLogic, IsUpdateable, isencryptedcolumn, IsSelectionColumn, TableName, ValueMin, ValueMax, fieldgroup, validationcode, Included_Tab_ID, FieldGroupType, IsCollapsedByDefault, InfoFactoryClass, IsAutocomplete, IsAllowCopy, IsDisplayedGrid, SeqNoGrid, SeqNoSelection, XPosition, ColumnSpan, NumLines, IsToolbarButton, FormatPattern, IsAdvancedField, IsDefaultFocus, AD_Chart_ID, AD_LabelStyle_ID, AD_FieldStyle_ID, PA_DashboardContent_ID, Placeholder, IsHtml, IsQuickForm, AD_Val_Rule_Lookup_ID, validationcodelookup, alwaysupdatablelogic, AD_InfoWindow_ID, entitytype) AS SELECT trl.ad_language AS AD_Language, t.ad_window_id AS AD_Window_ID, f.ad_tab_id AS AD_Tab_ID, f.ad_field_id AS AD_Field_ID, tbl.ad_table_id AS AD_Table_ID, f.ad_column_id AS AD_Column_ID, trl.name AS Name, trl.description AS Description, trl.help AS Help, f.isdisplayed AS IsDisplayed, f.displaylogic AS DisplayLogic, f.displaylength AS DisplayLength, f.seqno AS SeqNo, f.sortno AS SortNo, f.issameline AS IsSameLine, f.isheading AS IsHeading, f.isfieldonly AS IsFieldOnly, f.isreadonly AS IsReadOnly, f.isencrypted AS isencryptedfield, f.obscuretype AS ObscureType, c.columnname AS ColumnName, COALESCE(f.columnsql, c.columnsql) AS ColumnSQL, c.fieldlength AS FieldLength, COALESCE(f.vformat, c.vformat) AS VFormat, COALESCE(f.defaultvalue, c.defaultvalue) AS DefaultValue, c.iskey AS IsKey, c.isparent AS IsParent, COALESCE(f.ismandatory, c.ismandatory) AS IsMandatory, c.isidentifier AS IsIdentifier, c.istranslated AS IsTranslated, COALESCE(f.ad_reference_value_id, c.ad_reference_value_id) AS AD_Reference_Value_ID, c.callout AS Callout, COALESCE(f.ad_reference_id, c.ad_reference_id) AS AD_Reference_ID, COALESCE(f.ad_val_rule_id, c.ad_val_rule_id) AS AD_Val_Rule_ID, COALESCE(f.ad_process_id, c.AD_Process_ID) AS AD_Process_ID, COALESCE(f.isalwaysupdateable, c.isalwaysupdateable) AS IsAlwaysUpdateable, COALESCE(f.readonlylogic, c.readonlylogic) AS ReadOnlyLogic, COALESCE(f.mandatorylogic, c.mandatorylogic) AS MandatoryLogic, COALESCE(f.isupdateable, c.isupdateable) AS IsUpdateable, c.isencrypted AS isencryptedcolumn, COALESCE(f.isselectioncolumn, c.isselectioncolumn) AS IsSelectionColumn, tbl.tablename AS TableName, c.valuemin AS ValueMin, c.valuemax AS ValueMax, fgt.name AS fieldgroup, vr.code AS validationcode, f.included_tab_id AS Included_Tab_ID, fg.fieldgrouptype AS FieldGroupType, fg.iscollapsedbydefault AS IsCollapsedByDefault, COALESCE(f.infofactoryclass, c.infofactoryclass) AS InfoFactoryClass, c.isautocomplete AS IsAutocomplete, COALESCE(f.isallowcopy, c.isallowcopy) AS IsAllowCopy, f.isdisplayedgrid AS IsDisplayedGrid, f.seqnogrid AS SeqNoGrid, c.seqnoselection AS SeqNoSelection, f.xposition AS XPosition, f.columnspan AS ColumnSpan, f.numlines AS NumLines, COALESCE(f.istoolbarbutton, c.istoolbarbutton) AS IsToolbarButton, c.formatpattern AS FormatPattern, f.isadvancedfield AS IsAdvancedField, f.isdefaultfocus AS IsDefaultFocus, COALESCE(f.ad_chart_id, c.ad_chart_id) AS AD_Chart_ID, f.ad_labelstyle_id AS AD_LabelStyle_ID, f.ad_fieldstyle_id AS AD_FieldStyle_ID, c.pa_dashboardcontent_id AS PA_DashboardContent_ID, COALESCE(trl.placeholder, ct.placeholder) AS Placeholder, COALESCE(f.ishtml, c.ishtml) AS IsHtml, f.isquickform AS IsQuickForm, COALESCE(f.ad_val_rule_lookup_id, c.ad_val_rule_lookup_id) AS AD_Val_Rule_Lookup_ID, vrf.code AS validationcodelookup, COALESCE(f.alwaysupdatablelogic, c.alwaysupdatablelogic) AS alwaysupdatablelogic, c.ad_infowindow_id AS AD_InfoWindow_ID, f.entitytype AS entitytype FROM ad_field f
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

