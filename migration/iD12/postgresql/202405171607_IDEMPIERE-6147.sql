-- IDEMPIERE-6147
SELECT register_migration_script('202405171607_IDEMPIERE-6147.sql') FROM dual;

-- May 17, 2024, 4:07:02 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216599,0,'HTML','Text has HTML tags',107,'IsHtml','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2024-05-17 16:07:01','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-05-17 16:07:01','YYYY-MM-DD HH24:MI:SS'),10,1510,'Y','N','D','N','N','N','Y','b07dadf1-0115-4e67-b818-3122717c3330','Y','N','N','N','N','N')
;

-- May 17, 2024, 4:07:30 PM CEST
ALTER TABLE AD_Field ADD COLUMN IsHtml CHAR(1) DEFAULT NULL 
;

-- May 17, 2024, 4:08:03 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (216600,0,'HTML','Text has HTML tags',464,'IsHtml',NULL,1,'N','N','N','N','N',0,'N',17,319,0,0,'Y',TO_TIMESTAMP('2024-05-17 16:08:02','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-05-17 16:08:02','YYYY-MM-DD HH24:MI:SS'),10,1510,'Y','N','D','N','N','N','Y','aaae1b3d-d37f-4423-bffe-1facadb9a5ea','Y',0,'N','N','N','N')
;

UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2024-05-17 16:24:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=216599
;

-- May 17, 2024, 4:08:03 PM CEST
ALTER TABLE AD_UserDef_Field ADD COLUMN IsHtml CHAR(1) DEFAULT NULL 
;

-- May 17, 2024, 4:08:14 PM CEST
UPDATE AD_Column SET AD_Reference_ID=17, AD_Reference_Value_ID=319, FKConstraintType=NULL,Updated=TO_TIMESTAMP('2024-05-17 16:08:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=216599
;

-- May 17, 2024, 4:09:04 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208485,'HTML','Text has HTML tags',107,216599,'Y',1,520,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-05-17 16:09:04','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-05-17 16:09:04','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','fe1062c9-6d1a-4535-a6e8-8f1e51dfcc6a','Y',510,2)
;

-- May 17, 2024, 4:10:13 PM CEST
UPDATE AD_Field SET SeqNo=410,Updated=TO_TIMESTAMP('2024-05-17 16:10:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207128
;

-- May 17, 2024, 4:10:13 PM CEST
UPDATE AD_Field SET SeqNo=420,Updated=TO_TIMESTAMP('2024-05-17 16:10:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=13424
;

-- May 17, 2024, 4:10:13 PM CEST
UPDATE AD_Field SET SeqNo=430,Updated=TO_TIMESTAMP('2024-05-17 16:10:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=62468
;

-- May 17, 2024, 4:10:13 PM CEST
UPDATE AD_Field SET SeqNo=440,Updated=TO_TIMESTAMP('2024-05-17 16:10:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=206080
;

-- May 17, 2024, 4:10:13 PM CEST
UPDATE AD_Field SET SeqNo=450,Updated=TO_TIMESTAMP('2024-05-17 16:10:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=206665
;

-- May 17, 2024, 4:10:13 PM CEST
UPDATE AD_Field SET SeqNo=460,Updated=TO_TIMESTAMP('2024-05-17 16:10:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=206914
;

-- May 17, 2024, 4:10:13 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=470, XPosition=4,Updated=TO_TIMESTAMP('2024-05-17 16:10:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=208485
;

-- May 17, 2024, 4:10:13 PM CEST
UPDATE AD_Field SET SeqNo=480,Updated=TO_TIMESTAMP('2024-05-17 16:10:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=53280
;

-- May 17, 2024, 4:10:13 PM CEST
UPDATE AD_Field SET SeqNo=490,Updated=TO_TIMESTAMP('2024-05-17 16:10:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=203500
;

-- May 17, 2024, 4:10:13 PM CEST
UPDATE AD_Field SET SeqNo=500,Updated=TO_TIMESTAMP('2024-05-17 16:10:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=200836
;

-- May 17, 2024, 4:10:13 PM CEST
UPDATE AD_Field SET SeqNo=510,Updated=TO_TIMESTAMP('2024-05-17 16:10:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=200835
;

-- May 17, 2024, 4:10:13 PM CEST
UPDATE AD_Field SET SeqNo=520,Updated=TO_TIMESTAMP('2024-05-17 16:10:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=136
;

-- May 17, 2024, 4:10:13 PM CEST
UPDATE AD_Field SET SeqNo=530,Updated=TO_TIMESTAMP('2024-05-17 16:10:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=139
;

-- May 17, 2024, 4:10:35 PM CEST
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=34|@AD_Reference_ID@=10|@AD_Reference_ID@=14|@AD_Reference_ID@=36',Updated=TO_TIMESTAMP('2024-05-17 16:10:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=208485
;

-- May 17, 2024, 4:10:48 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208486,'HTML','Text has HTML tags',395,216600,'Y',1,400,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-05-17 16:10:48','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-05-17 16:10:48','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','6ed0d80f-7280-467d-b14a-30f29e845202','Y',370,2)
;

-- May 17, 2024, 4:10:56 PM CEST
UPDATE AD_Field SET SeqNo=320,Updated=TO_TIMESTAMP('2024-05-17 16:10:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207129
;

-- May 17, 2024, 4:10:56 PM CEST
UPDATE AD_Field SET SeqNo=330,Updated=TO_TIMESTAMP('2024-05-17 16:10:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=200851
;

-- May 17, 2024, 4:10:56 PM CEST
UPDATE AD_Field SET SeqNo=340,Updated=TO_TIMESTAMP('2024-05-17 16:10:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=206408
;

-- May 17, 2024, 4:10:57 PM CEST
UPDATE AD_Field SET SeqNo=350,Updated=TO_TIMESTAMP('2024-05-17 16:10:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=206915
;

-- May 17, 2024, 4:10:57 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=360, XPosition=4,Updated=TO_TIMESTAMP('2024-05-17 16:10:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=208486
;

-- May 17, 2024, 4:10:57 PM CEST
UPDATE AD_Field SET SeqNo=370,Updated=TO_TIMESTAMP('2024-05-17 16:10:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=200852
;

-- May 17, 2024, 4:10:57 PM CEST
UPDATE AD_Field SET SeqNo=380,Updated=TO_TIMESTAMP('2024-05-17 16:10:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=203499
;

-- May 17, 2024, 4:10:57 PM CEST
UPDATE AD_Field SET SeqNo=390,Updated=TO_TIMESTAMP('2024-05-17 16:10:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=200854
;

-- May 17, 2024, 4:10:57 PM CEST
UPDATE AD_Field SET SeqNo=400,Updated=TO_TIMESTAMP('2024-05-17 16:10:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=5051
;

-- May 17, 2024, 4:10:57 PM CEST
UPDATE AD_Field SET SeqNo=410,Updated=TO_TIMESTAMP('2024-05-17 16:10:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=5057
;

-- May 17, 2024, 4:11:10 PM CEST
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=34|@AD_Reference_ID@=10|@AD_Reference_ID@=14|@AD_Reference_ID@=36',Updated=TO_TIMESTAMP('2024-05-17 16:11:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=208486
;

-- May 17, 2024, 4:40:01 PM CEST
UPDATE AD_ViewColumn SET ColumnSQL='COALESCE(f.ishtml, c.ishtml)',Updated=TO_TIMESTAMP('2024-05-17 16:40:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_ViewColumn_ID=200353
;

-- May 17, 2024, 4:40:05 PM CEST
CREATE OR REPLACE VIEW AD_Field_vt(AD_Language, AD_Window_ID, AD_Tab_ID, AD_Field_ID, AD_Table_ID, AD_Column_ID, Name, Description, Help, IsDisplayed, DisplayLogic, DisplayLength, SeqNo, SortNo, IsSameLine, IsHeading, IsFieldOnly, IsReadOnly, isencryptedfield, ObscureType, ColumnName, ColumnSQL, FieldLength, VFormat, DefaultValue, IsKey, IsParent, IsMandatory, IsIdentifier, IsTranslated, AD_Reference_Value_ID, Callout, AD_Reference_ID, AD_Val_Rule_ID, AD_Process_ID, IsAlwaysUpdateable, ReadOnlyLogic, MandatoryLogic, IsUpdateable, isencryptedcolumn, IsSelectionColumn, TableName, ValueMin, ValueMax, fieldgroup, validationcode, Included_Tab_ID, FieldGroupType, IsCollapsedByDefault, InfoFactoryClass, IsAutocomplete, IsAllowCopy, IsDisplayedGrid, SeqNoGrid, SeqNoSelection, XPosition, ColumnSpan, NumLines, IsToolbarButton, FormatPattern, IsAdvancedField, IsDefaultFocus, AD_Chart_ID, AD_LabelStyle_ID, AD_FieldStyle_ID, PA_DashboardContent_ID, Placeholder, IsHtml, IsQuickForm, AD_Val_Rule_Lookup_ID, validationcodelookup, alwaysupdatablelogic, AD_InfoWindow_ID, entitytype) AS SELECT trl.ad_language AS AD_Language, t.ad_window_id AS AD_Window_ID, f.ad_tab_id AS AD_Tab_ID, f.ad_field_id AS AD_Field_ID, tbl.ad_table_id AS AD_Table_ID, f.ad_column_id AS AD_Column_ID, trl.name AS Name, trl.description AS Description, trl.help AS Help, f.isdisplayed AS IsDisplayed, f.displaylogic AS DisplayLogic, f.displaylength AS DisplayLength, f.seqno AS SeqNo, f.sortno AS SortNo, f.issameline AS IsSameLine, f.isheading AS IsHeading, f.isfieldonly AS IsFieldOnly, f.isreadonly AS IsReadOnly, f.isencrypted AS isencryptedfield, f.obscuretype AS ObscureType, c.columnname AS ColumnName, COALESCE(f.columnsql, c.columnsql) AS ColumnSQL, c.fieldlength AS FieldLength, COALESCE(f.vformat, c.vformat) AS VFormat, COALESCE(f.defaultvalue, c.defaultvalue) AS DefaultValue, c.iskey AS IsKey, c.isparent AS IsParent, COALESCE(f.ismandatory, c.ismandatory) AS IsMandatory, c.isidentifier AS IsIdentifier, c.istranslated AS IsTranslated, COALESCE(f.ad_reference_value_id, c.ad_reference_value_id) AS AD_Reference_Value_ID, c.callout AS Callout, COALESCE(f.ad_reference_id, c.ad_reference_id) AS AD_Reference_ID, COALESCE(f.ad_val_rule_id, c.ad_val_rule_id) AS AD_Val_Rule_ID, c.ad_process_id AS AD_Process_ID, COALESCE(f.isalwaysupdateable, c.isalwaysupdateable) AS IsAlwaysUpdateable, COALESCE(f.readonlylogic, c.readonlylogic) AS ReadOnlyLogic, COALESCE(f.mandatorylogic, c.mandatorylogic) AS MandatoryLogic, COALESCE(f.isupdateable, c.isupdateable) AS IsUpdateable, c.isencrypted AS isencryptedcolumn, COALESCE(f.isselectioncolumn, c.isselectioncolumn) AS IsSelectionColumn, tbl.tablename AS TableName, c.valuemin AS ValueMin, c.valuemax AS ValueMax, fgt.name AS fieldgroup, vr.code AS validationcode, f.included_tab_id AS Included_Tab_ID, fg.fieldgrouptype AS FieldGroupType, fg.iscollapsedbydefault AS IsCollapsedByDefault, COALESCE(f.infofactoryclass, c.infofactoryclass) AS InfoFactoryClass, c.isautocomplete AS IsAutocomplete, COALESCE(f.isallowcopy, c.isallowcopy) AS IsAllowCopy, f.isdisplayedgrid AS IsDisplayedGrid, f.seqnogrid AS SeqNoGrid, c.seqnoselection AS SeqNoSelection, f.xposition AS XPosition, f.columnspan AS ColumnSpan, f.numlines AS NumLines, COALESCE(f.istoolbarbutton, c.istoolbarbutton) AS IsToolbarButton, c.formatpattern AS FormatPattern, f.isadvancedfield AS IsAdvancedField, f.isdefaultfocus AS IsDefaultFocus, COALESCE(f.ad_chart_id, c.ad_chart_id) AS AD_Chart_ID, f.ad_labelstyle_id AS AD_LabelStyle_ID, f.ad_fieldstyle_id AS AD_FieldStyle_ID, c.pa_dashboardcontent_id AS PA_DashboardContent_ID, COALESCE(trl.placeholder, ct.placeholder) AS Placeholder, COALESCE(f.ishtml, c.ishtml) AS IsHtml, f.isquickform AS IsQuickForm, COALESCE(f.ad_val_rule_lookup_id, c.ad_val_rule_lookup_id) AS AD_Val_Rule_Lookup_ID, vrf.code AS validationcodelookup, COALESCE(f.alwaysupdatablelogic, c.alwaysupdatablelogic) AS alwaysupdatablelogic, c.ad_infowindow_id AS AD_InfoWindow_ID, f.entitytype AS entitytype FROM ad_field f JOIN ad_field_trl trl ON f.ad_field_id = trl.ad_field_id JOIN ad_tab t ON f.ad_tab_id = t.ad_tab_id LEFT JOIN ad_fieldgroup fg ON f.ad_fieldgroup_id = fg.ad_fieldgroup_id LEFT JOIN ad_fieldgroup_trl fgt ON f.ad_fieldgroup_id = fgt.ad_fieldgroup_id AND trl.ad_language = fgt.ad_language LEFT JOIN ad_column c ON f.ad_column_id = c.ad_column_id LEFT JOIN ad_column_trl ct ON f.ad_column_id = ct.ad_column_id AND trl.ad_language = ct.ad_language JOIN ad_table tbl ON c.ad_table_id = tbl.ad_table_id LEFT JOIN ad_val_rule vr ON vr.ad_val_rule_id = COALESCE(f.ad_val_rule_id, c.ad_val_rule_id) LEFT JOIN ad_val_rule vrf ON vrf.ad_val_rule_id = COALESCE(f.ad_val_rule_lookup_id, c.ad_val_rule_lookup_id) WHERE f.isactive = 'Y' AND c.isactive = 'Y'
;

-- May 17, 2024, 4:40:25 PM CEST
UPDATE AD_ViewColumn SET ColumnSQL='COALESCE(f.ishtml, c.ishtml)',Updated=TO_TIMESTAMP('2024-05-17 16:40:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_ViewColumn_ID=200282
;

-- May 17, 2024, 4:40:31 PM CEST
CREATE OR REPLACE VIEW AD_Field_v(AD_Window_ID, AD_Tab_ID, AD_Field_ID, AD_Table_ID, AD_Column_ID, Name, Description, Help, IsDisplayed, DisplayLogic, DisplayLength, SeqNo, SortNo, IsSameLine, IsHeading, IsFieldOnly, IsReadOnly, isencryptedfield, ObscureType, ColumnName, ColumnSQL, FieldLength, VFormat, DefaultValue, IsKey, IsParent, IsMandatory, IsIdentifier, IsTranslated, AD_Reference_Value_ID, Callout, AD_Reference_ID, AD_Val_Rule_ID, AD_Process_ID, IsAlwaysUpdateable, ReadOnlyLogic, MandatoryLogic, IsUpdateable, isencryptedcolumn, IsSelectionColumn, TableName, ValueMin, ValueMax, fieldgroup, validationcode, Included_Tab_ID, FieldGroupType, IsCollapsedByDefault, InfoFactoryClass, IsAutocomplete, IsAllowCopy, IsDisplayedGrid, SeqNoGrid, SeqNoSelection, XPosition, ColumnSpan, NumLines, IsToolbarButton, FormatPattern, IsAdvancedField, IsDefaultFocus, AD_Chart_ID, AD_LabelStyle_ID, AD_FieldStyle_ID, PA_DashboardContent_ID, Placeholder, IsHtml, IsQuickForm, AD_Val_Rule_Lookup_ID, validationcodelookup, alwaysupdatablelogic, AD_InfoWindow_ID, entitytype) AS SELECT t.ad_window_id AS AD_Window_ID, f.ad_tab_id AS AD_Tab_ID, f.ad_field_id AS AD_Field_ID, tbl.ad_table_id AS AD_Table_ID, f.ad_column_id AS AD_Column_ID, f.name AS Name, f.description AS Description, f.help AS Help, f.isdisplayed AS IsDisplayed, f.displaylogic AS DisplayLogic, f.displaylength AS DisplayLength, f.seqno AS SeqNo, f.sortno AS SortNo, f.issameline AS IsSameLine, f.isheading AS IsHeading, f.isfieldonly AS IsFieldOnly, f.isreadonly AS IsReadOnly, f.isencrypted AS isencryptedfield, f.obscuretype AS ObscureType, c.columnname AS ColumnName, COALESCE(f.columnsql, c.columnsql) AS ColumnSQL, c.fieldlength AS FieldLength, COALESCE(f.vformat, c.vformat) AS VFormat, COALESCE(f.defaultvalue, c.defaultvalue) AS DefaultValue, c.iskey AS IsKey, c.isparent AS IsParent, COALESCE(f.ismandatory, c.ismandatory) AS IsMandatory, c.isidentifier AS IsIdentifier, c.istranslated AS IsTranslated, COALESCE(f.ad_reference_value_id, c.ad_reference_value_id) AS AD_Reference_Value_ID, c.callout AS Callout, COALESCE(f.ad_reference_id, c.ad_reference_id) AS AD_Reference_ID, COALESCE(f.ad_val_rule_id, c.ad_val_rule_id) AS AD_Val_Rule_ID, c.ad_process_id AS AD_Process_ID, COALESCE(f.isalwaysupdateable, c.isalwaysupdateable) AS IsAlwaysUpdateable, COALESCE(f.readonlylogic, c.readonlylogic) AS ReadOnlyLogic, COALESCE(f.mandatorylogic, c.mandatorylogic) AS MandatoryLogic, COALESCE(f.isupdateable, c.isupdateable) AS IsUpdateable, c.isencrypted AS isencryptedcolumn, COALESCE(f.isselectioncolumn, c.isselectioncolumn) AS IsSelectionColumn, tbl.tablename AS TableName, c.valuemin AS ValueMin, c.valuemax AS ValueMax, fg.name AS fieldgroup, vr.code AS validationcode, f.included_tab_id AS Included_Tab_ID, fg.fieldgrouptype AS FieldGroupType, fg.iscollapsedbydefault AS IsCollapsedByDefault, COALESCE(f.infofactoryclass, c.infofactoryclass) AS InfoFactoryClass, c.isautocomplete AS IsAutocomplete, COALESCE(f.isallowcopy, c.isallowcopy) AS IsAllowCopy, f.isdisplayedgrid AS IsDisplayedGrid, f.seqnogrid AS SeqNoGrid, c.seqnoselection AS SeqNoSelection, f.xposition AS XPosition, f.columnspan AS ColumnSpan, f.numlines AS NumLines, COALESCE(f.istoolbarbutton, c.istoolbarbutton) AS IsToolbarButton, c.formatpattern AS FormatPattern, f.isadvancedfield AS IsAdvancedField, f.isdefaultfocus AS IsDefaultFocus, COALESCE(f.ad_chart_id, c.ad_chart_id) AS AD_Chart_ID, f.ad_labelstyle_id AS AD_LabelStyle_ID, f.ad_fieldstyle_id AS AD_FieldStyle_ID, c.pa_dashboardcontent_id AS PA_DashboardContent_ID, COALESCE(f.placeholder, c.placeholder) AS Placeholder, COALESCE(f.ishtml, c.ishtml) AS IsHtml, f.isquickform AS IsQuickForm, COALESCE(f.ad_val_rule_lookup_id, c.ad_val_rule_lookup_id) AS AD_Val_Rule_Lookup_ID, vrf.code AS validationcodelookup, COALESCE(f.alwaysupdatablelogic, c.alwaysupdatablelogic) AS alwaysupdatablelogic, c.ad_infowindow_id AS AD_InfoWindow_ID, f.entitytype AS entitytype FROM ad_field f JOIN ad_tab t ON f.ad_tab_id = t.ad_tab_id LEFT JOIN ad_fieldgroup fg ON f.ad_fieldgroup_id = fg.ad_fieldgroup_id LEFT JOIN ad_column c ON f.ad_column_id = c.ad_column_id JOIN ad_table tbl ON c.ad_table_id = tbl.ad_table_id LEFT JOIN ad_val_rule vr ON vr.ad_val_rule_id = COALESCE(f.ad_val_rule_id, c.ad_val_rule_id) LEFT JOIN ad_val_rule vrf ON vrf.ad_val_rule_id = COALESCE(f.ad_val_rule_lookup_id, c.ad_val_rule_lookup_id) WHERE f.isactive = 'Y' AND c.isactive = 'Y'
;

