-- IDEMPIERE-5396 Replace CreateFrom form with Info Window Process
SELECT register_migration_script('202209021444_IDEMPIERE-5396.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Sep 2, 2022, 2:44:49 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215126,0,'Info Window','Info and search/select Window','The Info window is used to search and select records as well as display information relevant to the selection.',101,'AD_InfoWindow_ID',10,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2022-09-02 14:44:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-02 14:44:47','YYYY-MM-DD HH24:MI:SS'),100,3068,'Y','N','D','N','N','N','Y','a9fef67a-55cf-4a57-ab3a-95457cc3c294','Y',0,'N','N','C','N')
;

-- Sep 2, 2022, 2:45:04 PM SGT
UPDATE AD_Column SET FKConstraintName='ADInfoWindow_ADColumn', FKConstraintType='C',Updated=TO_TIMESTAMP('2022-09-02 14:45:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215126
;

-- Sep 2, 2022, 2:45:04 PM SGT
ALTER TABLE AD_Column ADD AD_InfoWindow_ID NUMBER(10) DEFAULT NULL 
;

-- Sep 2, 2022, 2:45:04 PM SGT
ALTER TABLE AD_Column ADD CONSTRAINT ADInfoWindow_ADColumn FOREIGN KEY (AD_InfoWindow_ID) REFERENCES ad_infowindow(ad_infowindow_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Sep 2, 2022, 2:45:43 PM SGT
UPDATE AD_Column SET FKConstraintType='S',Updated=TO_TIMESTAMP('2022-09-02 14:45:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215126
;

-- Sep 2, 2022, 2:45:54 PM SGT
ALTER TABLE AD_Column MODIFY AD_InfoWindow_ID NUMBER(10) DEFAULT NULL 
;

-- Sep 2, 2022, 2:45:54 PM SGT
ALTER TABLE AD_Column DROP CONSTRAINT adinfowindow_adcolumn
;

-- Sep 2, 2022, 2:45:54 PM SGT
ALTER TABLE AD_Column ADD CONSTRAINT ADInfoWindow_ADColumn FOREIGN KEY (AD_InfoWindow_ID) REFERENCES ad_infowindow(ad_infowindow_id) ON DELETE SET NULL DEFERRABLE INITIALLY DEFERRED
;

-- Sep 2, 2022, 2:47:26 PM SGT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207143,'Info Window','Info and search/select Window','The Info window is used to search and select records as well as display information relevant to the selection.',101,215126,'Y',10,500,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-09-02 14:47:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-02 14:47:25','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','95af860d-1e82-40f6-86b4-520922a86814','Y',470,2)
;

-- Sep 2, 2022, 2:51:22 PM SGT
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=28', SeqNo=225, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, SeqNoGrid=175, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-02 14:51:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207143
;

-- Sep 2, 2022, 3:59:35 PM SGT
UPDATE AD_Column SET ReadOnlyLogic='@AD_InfoWindow_ID@!0',Updated=TO_TIMESTAMP('2022-09-02 15:59:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=3369
;

-- Sep 2, 2022, 3:59:55 PM SGT
UPDATE AD_Column SET Callout='org.compiere.model.Callout_AD_Column.process',Updated=TO_TIMESTAMP('2022-09-02 15:59:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=3369
;

-- Sep 2, 2022, 4:00:53 PM SGT
UPDATE AD_Column SET Callout='org.compiere.model.Callout_AD_Column.infoWindow', ReadOnlyLogic='@AD_Process_ID@!0',Updated=TO_TIMESTAMP('2022-09-02 16:00:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215126
;

-- Sep 2, 2022, 4:19:00 PM SGT
UPDATE AD_Column SET AD_InfoWindow_ID=200022,Updated=TO_TIMESTAMP('2022-09-02 16:19:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215125
;

-- Sep 2, 2022, 4:45:05 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217521,'bed9be3a-11bc-4712-9b76-7f6e8ec06abc',TO_TIMESTAMP('2022-09-02 16:45:03','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-02 16:45:03','YYYY-MM-DD HH24:MI:SS'),100,200008,'AD_InfoWindow_ID','t.ad_infowindow_id',710)
;

-- Sep 2, 2022, 4:47:12 PM SGT
UPDATE AD_ViewColumn SET ColumnSQL='c.ad_infowindow_id',Updated=TO_TIMESTAMP('2022-09-02 16:47:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewColumn_ID=217521
;

-- Sep 2, 2022, 4:47:40 PM SGT
CREATE OR REPLACE VIEW AD_Field_v(AD_Window_ID, AD_Tab_ID, AD_Field_ID, AD_Table_ID, AD_Column_ID, Name, Description, Help, IsDisplayed, DisplayLogic, DisplayLength, SeqNo, SortNo, IsSameLine, IsHeading, IsFieldOnly, IsReadOnly, isencryptedfield, ObscureType, ColumnName, ColumnSQL, FieldLength, VFormat, DefaultValue, IsKey, IsParent, IsMandatory, IsIdentifier, IsTranslated, AD_Reference_Value_ID, Callout, AD_Reference_ID, AD_Val_Rule_ID, AD_Process_ID, IsAlwaysUpdateable, ReadOnlyLogic, MandatoryLogic, IsUpdateable, isencryptedcolumn, IsSelectionColumn, TableName, ValueMin, ValueMax, fieldgroup, validationcode, Included_Tab_ID, FieldGroupType, IsCollapsedByDefault, InfoFactoryClass, IsAutocomplete, IsAllowCopy, IsDisplayedGrid, SeqNoGrid, SeqNoSelection, XPosition, ColumnSpan, NumLines, IsToolbarButton, FormatPattern, IsAdvancedField, IsDefaultFocus, AD_Chart_ID, AD_LabelStyle_ID, AD_FieldStyle_ID, PA_DashboardContent_ID, Placeholder, IsHtml, IsQuickForm, AD_Val_Rule_Lookup_ID, validationcodelookup, AD_InfoWindow_ID) AS 
SELECT t.ad_window_id AS AD_Window_ID, f.ad_tab_id AS AD_Tab_ID, f.ad_field_id AS AD_Field_ID, tbl.ad_table_id AS AD_Table_ID, f.ad_column_id AS AD_Column_ID, f.name AS Name, f.description AS Description, f.help AS Help, f.isdisplayed AS IsDisplayed, f.displaylogic AS DisplayLogic, f.displaylength AS DisplayLength, f.seqno AS SeqNo, f.sortno AS SortNo, f.issameline AS IsSameLine, f.isheading AS IsHeading, f.isfieldonly AS IsFieldOnly, f.isreadonly AS IsReadOnly, f.isencrypted AS isencryptedfield, f.obscuretype AS ObscureType, c.columnname AS ColumnName, COALESCE(f.columnsql, c.columnsql) AS ColumnSQL, c.fieldlength AS FieldLength, COALESCE(f.vformat, c.vformat) AS VFormat, COALESCE(f.defaultvalue, c.defaultvalue) AS DefaultValue, c.iskey AS IsKey, c.isparent AS IsParent, COALESCE(f.ismandatory, c.ismandatory) AS IsMandatory, c.isidentifier AS IsIdentifier, c.istranslated AS IsTranslated, COALESCE(f.ad_reference_value_id, c.ad_reference_value_id) AS AD_Reference_Value_ID, c.callout AS Callout, 
COALESCE(f.ad_reference_id, c.ad_reference_id) AS AD_Reference_ID, COALESCE(f.ad_val_rule_id, c.ad_val_rule_id) AS AD_Val_Rule_ID, c.ad_process_id AS AD_Process_ID, COALESCE(f.isalwaysupdateable, c.isalwaysupdateable) AS IsAlwaysUpdateable, COALESCE(f.readonlylogic, c.readonlylogic) AS ReadOnlyLogic, COALESCE(f.mandatorylogic, c.mandatorylogic) AS MandatoryLogic, COALESCE(f.isupdateable, c.isupdateable) AS IsUpdateable, c.isencrypted AS isencryptedcolumn, COALESCE(f.isselectioncolumn, c.isselectioncolumn) AS IsSelectionColumn, tbl.tablename AS TableName, c.valuemin AS ValueMin, c.valuemax AS ValueMax, fg.name AS fieldgroup, vr.code AS validationcode, f.included_tab_id AS Included_Tab_ID, fg.fieldgrouptype AS FieldGroupType, fg.iscollapsedbydefault AS IsCollapsedByDefault, COALESCE(f.infofactoryclass, c.infofactoryclass) AS InfoFactoryClass, c.isautocomplete AS IsAutocomplete, COALESCE(f.isallowcopy, c.isallowcopy) AS IsAllowCopy, f.isdisplayedgrid AS IsDisplayedGrid, f.seqnogrid AS SeqNoGrid, 
c.seqnoselection AS SeqNoSelection, f.xposition AS XPosition, f.columnspan AS ColumnSpan, f.numlines AS NumLines, COALESCE(f.istoolbarbutton, c.istoolbarbutton) AS IsToolbarButton, c.formatpattern AS FormatPattern, f.isadvancedfield AS IsAdvancedField, f.isdefaultfocus AS IsDefaultFocus, c.ad_chart_id AS AD_Chart_ID, f.ad_labelstyle_id AS AD_LabelStyle_ID, f.ad_fieldstyle_id AS AD_FieldStyle_ID, c.pa_dashboardcontent_id AS PA_DashboardContent_ID, COALESCE(f.placeholder, c.placeholder) AS Placeholder, c.ishtml AS IsHtml, f.isquickform AS IsQuickForm, COALESCE(f.ad_val_rule_lookup_id, c.ad_val_rule_lookup_id) AS AD_Val_Rule_Lookup_ID, vrf.code AS validationcodelookup, c.ad_infowindow_id AS AD_InfoWindow_ID 
FROM ad_field f
JOIN ad_tab t ON f.ad_tab_id = t.ad_tab_id
LEFT JOIN ad_fieldgroup fg ON f.ad_fieldgroup_id = fg.ad_fieldgroup_id
LEFT JOIN ad_column c ON f.ad_column_id = c.ad_column_id
JOIN ad_table tbl ON c.ad_table_id = tbl.ad_table_id
LEFT JOIN ad_val_rule vr ON vr.ad_val_rule_id = COALESCE(f.ad_val_rule_id, c.ad_val_rule_id)
LEFT JOIN ad_val_rule vrf ON vrf.ad_val_rule_id = COALESCE(f.ad_val_rule_lookup_id, c.ad_val_rule_lookup_id) WHERE f.isactive = 'Y' AND c.isactive = 'Y'
;

-- Sep 2, 2022, 5:15:36 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217522,'d7b9bf59-e48c-42dc-a8ff-2a26b514b076',TO_TIMESTAMP('2022-09-02 17:15:35','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-02 17:15:35','YYYY-MM-DD HH24:MI:SS'),100,200009,'AD_InfoWindow_ID','c.ad_infowindow_id',720)
;

-- Sep 2, 2022, 5:15:51 PM SGT
CREATE OR REPLACE VIEW AD_Field_vt(AD_Language, AD_Window_ID, AD_Tab_ID, AD_Field_ID, AD_Table_ID, AD_Column_ID, Name, Description, Help, IsDisplayed, DisplayLogic, DisplayLength, SeqNo, SortNo, IsSameLine, IsHeading, IsFieldOnly, IsReadOnly, isencryptedfield, ObscureType, ColumnName, ColumnSQL, FieldLength, VFormat, DefaultValue, IsKey, IsParent, IsMandatory, IsIdentifier, IsTranslated, AD_Reference_Value_ID, Callout, AD_Reference_ID, AD_Val_Rule_ID, AD_Process_ID, IsAlwaysUpdateable, ReadOnlyLogic, MandatoryLogic, IsUpdateable, isencryptedcolumn, IsSelectionColumn, TableName, ValueMin, ValueMax, fieldgroup, validationcode, Included_Tab_ID, FieldGroupType, IsCollapsedByDefault, InfoFactoryClass, IsAutocomplete, IsAllowCopy, IsDisplayedGrid, SeqNoGrid, SeqNoSelection, XPosition, ColumnSpan, NumLines, IsToolbarButton, FormatPattern, IsAdvancedField, IsDefaultFocus, AD_Chart_ID, AD_LabelStyle_ID, AD_FieldStyle_ID, PA_DashboardContent_ID, Placeholder, IsHtml, IsQuickForm, AD_Val_Rule_Lookup_ID, validationcodelookup, AD_InfoWindow_ID) AS 
SELECT trl.ad_language AS AD_Language, t.ad_window_id AS AD_Window_ID, f.ad_tab_id AS AD_Tab_ID, f.ad_field_id AS AD_Field_ID, tbl.ad_table_id AS AD_Table_ID, f.ad_column_id AS AD_Column_ID, trl.name AS Name, trl.description AS Description, trl.help AS Help, f.isdisplayed AS IsDisplayed, f.displaylogic AS DisplayLogic, f.displaylength AS DisplayLength, f.seqno AS SeqNo, f.sortno AS SortNo, f.issameline AS IsSameLine, f.isheading AS IsHeading, f.isfieldonly AS IsFieldOnly, f.isreadonly AS IsReadOnly, f.isencrypted AS isencryptedfield, f.obscuretype AS ObscureType, c.columnname AS ColumnName, COALESCE(f.columnsql, c.columnsql) AS ColumnSQL, c.fieldlength AS FieldLength, COALESCE(f.vformat, c.vformat) AS VFormat, COALESCE(f.defaultvalue, c.defaultvalue) AS DefaultValue, c.iskey AS IsKey, c.isparent AS IsParent, COALESCE(f.ismandatory, c.ismandatory) AS IsMandatory, c.isidentifier AS IsIdentifier, c.istranslated AS IsTranslated, COALESCE(f.ad_reference_value_id, c.ad_reference_value_id) AS AD_Reference_Value_ID, c.callout AS Callout, 
COALESCE(f.ad_reference_id, c.ad_reference_id) AS AD_Reference_ID, COALESCE(f.ad_val_rule_id, c.ad_val_rule_id) AS AD_Val_Rule_ID, c.ad_process_id AS AD_Process_ID, COALESCE(f.isalwaysupdateable, c.isalwaysupdateable) AS IsAlwaysUpdateable, COALESCE(f.readonlylogic, c.readonlylogic) AS ReadOnlyLogic, COALESCE(f.mandatorylogic, c.mandatorylogic) AS MandatoryLogic, COALESCE(f.isupdateable, c.isupdateable) AS IsUpdateable, c.isencrypted AS isencryptedcolumn, COALESCE(f.isselectioncolumn, c.isselectioncolumn) AS IsSelectionColumn, tbl.tablename AS TableName, c.valuemin AS ValueMin, c.valuemax AS ValueMax, fgt.name AS fieldgroup, vr.code AS validationcode, f.included_tab_id AS Included_Tab_ID, fg.fieldgrouptype AS FieldGroupType, fg.iscollapsedbydefault AS IsCollapsedByDefault, COALESCE(f.infofactoryclass, c.infofactoryclass) AS InfoFactoryClass, c.isautocomplete AS IsAutocomplete, COALESCE(f.isallowcopy, c.isallowcopy) AS IsAllowCopy, f.isdisplayedgrid AS IsDisplayedGrid, f.seqnogrid AS SeqNoGrid, 
c.seqnoselection AS SeqNoSelection, f.xposition AS XPosition, f.columnspan AS ColumnSpan, f.numlines AS NumLines, COALESCE(f.istoolbarbutton, c.istoolbarbutton) AS IsToolbarButton, c.formatpattern AS FormatPattern, f.isadvancedfield AS IsAdvancedField, f.isdefaultfocus AS IsDefaultFocus, c.ad_chart_id AS AD_Chart_ID, f.ad_labelstyle_id AS AD_LabelStyle_ID, f.ad_fieldstyle_id AS AD_FieldStyle_ID, c.pa_dashboardcontent_id AS PA_DashboardContent_ID, COALESCE(trl.placeholder, ct.placeholder) AS Placeholder, c.ishtml AS IsHtml, f.isquickform AS IsQuickForm, COALESCE(f.ad_val_rule_lookup_id, c.ad_val_rule_lookup_id) AS AD_Val_Rule_Lookup_ID, vrf.code AS validationcodelookup, c.ad_infowindow_id AS AD_InfoWindow_ID 
FROM ad_field f
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

