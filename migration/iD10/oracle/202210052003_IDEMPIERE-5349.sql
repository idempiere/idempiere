-- 
SELECT register_migration_script('202210052003_IDEMPIERE-5349.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jul 18, 2022, 1:03:26 AM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU,Placeholder) VALUES (203631,0,0,'Y',TO_TIMESTAMP('2022-07-18 01:03:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-18 01:03:25','YYYY-MM-DD HH24:MI:SS'),100,'AlwaysUpdatableLogic','Always Updatable Logic','Logic to determine if field is Updatable irrespective if record''s active status or processed status. This logic Applicable only if Always Updatable is N.','format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := |&()<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
<ul>
<li> @AD_Table_ID@=14 | @Language@!GERGER</li>
<li> @PriceLimit@>10 | @PriceList@>@PriceActual@</li>
<li> @Name@>J</li>
</ul>
Strings may be in single quotes (optional)','Always Updatable Logic','D','6b65a5c3-82d6-480c-b682-4ef0b2235ea4','Logical Expression')
;

-- Jul 18, 2022, 1:25:45 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,Placeholder,IsHtml) VALUES (215059,1,'Always Updatable Logic','Logic to determine if field is Updatable irrespective if record''s active status or processed status. This logic Applicable only if Always Updatable is N.','format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := |&()<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
<ul>
<li> @AD_Table_ID@=14 | @Language@!GERGER</li>
<li> @PriceLimit@>10 | @PriceList@>@PriceActual@</li>
<li> @Name@>J</li>
</ul>
Strings may be in single quotes (optional)',101,'AlwaysUpdatableLogic',2000,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_TIMESTAMP('2022-07-18 01:25:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-18 01:25:02','YYYY-MM-DD HH24:MI:SS'),100,203631,'Y','N','D','N','N','N','Y','35580780-38d7-4150-bf30-50aee7c224c3','Y','N','N','Logical Expression','N')
;

-- Jul 18, 2022, 1:27:58 AM IST
ALTER TABLE AD_Column ADD AlwaysUpdatableLogic VARCHAR2(2000 CHAR) DEFAULT NULL 
;

-- Jul 18, 2022, 1:31:52 AM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207127,'Always Updatable Logic','Logic to determine if field is Updatable irrespective if record''s active status or processed status. This logic Applicable only if Always Updatable is N.','format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := |&()<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
<ul>
<li> @AD_Table_ID@=14 | @Language@!GERGER</li>
<li> @PriceLimit@>10 | @PriceList@>@PriceActual@</li>
<li> @Name@>J</li>
</ul>
Strings may be in single quotes (optional)',101,215059,'Y','@IsUpdateable@=Y',1,365,'Y','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-07-18 01:31:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-18 01:31:51','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c107491c-1ff2-471c-aa1a-bf4f5815055a','Y',425,4,1,1,'N','N','N','N')
;

-- Jul 18, 2022, 1:34:24 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,Placeholder,IsHtml) VALUES (215060,1,'Always Updatable Logic','Logic to determine if field is Updatable irrespective if record''s active status or processed status. This logic Applicable only if Always Updatable is N.','format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := |&()<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
<ul>
<li> @AD_Table_ID@=14 | @Language@!GERGER</li>
<li> @PriceLimit@>10 | @PriceList@>@PriceActual@</li>
<li> @Name@>J</li>
</ul>
Strings may be in single quotes (optional)',107,'AlwaysUpdatableLogic',2000,'N','N','Y','N','N',0,'N',14,0,0,'Y',TO_TIMESTAMP('2022-07-18 01:34:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-18 01:34:24','YYYY-MM-DD HH24:MI:SS'),100,203631,'Y','N','D','N','N','N','Y','9d2ad2a9-9f37-4e3e-a777-aec80752e5e4','Y','N','N','N','Logical Expression','N')
;

-- Jul 18, 2022, 1:38:47 AM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,AD_FieldGroup_ID,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207128,'Always Updatable Logic','Logic to determine if field is Updatable irrespective if record''s active status or processed status. This logic Applicable only if Always Updatable is N.','format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := |&()<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
<ul>
<li> @AD_Table_ID@=14 | @Language@!GERGER</li>
<li> @PriceLimit@>10 | @PriceList@>@PriceActual@</li>
<li> @Name@>J</li>
</ul>
Strings may be in single quotes (optional)',107,215060,'Y',1,405,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-07-18 01:38:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-18 01:38:46','YYYY-MM-DD HH24:MI:SS'),100,'N','Y',200004,'D','640506ad-bf67-46b0-8d7c-2adb526c92e0','Y',405,4,2,1,'N','N','N','N')
;

-- Jul 18, 2022, 1:40:40 AM IST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, ColumnSpan=5, NumLines=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-07-18 01:40:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207128
;

-- Jul 18, 2022, 1:44:16 AM IST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, ColumnSpan=5, NumLines=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-07-18 01:44:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207127
;

-- Jul 18, 2022, 1:48:53 AM IST
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2022-07-18 01:48:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215060
;

-- Jul 18, 2022, 1:49:21 AM IST
ALTER TABLE AD_Field ADD AlwaysUpdatableLogic VARCHAR2(2000 CHAR) DEFAULT NULL 
;

-- Jul 18, 2022, 2:12:30 AM IST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217380,'210fc421-54d7-452c-b054-00517ab2a85a',TO_TIMESTAMP('2022-07-18 02:12:24','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-18 02:12:24','YYYY-MM-DD HH24:MI:SS'),100,200008,'alwaysupdatablelogic','COALESCE(f.alwaysupdatablelogic, c.alwaysupdatablelogic)',710)
;

-- Jul 18, 2022, 2:14:15 AM IST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217381,'5303286c-ad9f-4d49-89ad-5db70a48e11c',TO_TIMESTAMP('2022-07-18 02:14:08','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-18 02:14:08','YYYY-MM-DD HH24:MI:SS'),100,200009,'alwaysupdatablelogic','COALESCE(f.alwaysupdatablelogic, c.alwaysupdatablelogic)',720)
;

-- Jul 18, 2022, 2:26:01 AM IST
CREATE OR REPLACE VIEW AD_Field_v(AD_Window_ID, AD_Tab_ID, AD_Field_ID, AD_Table_ID, AD_Column_ID, Name, Description, Help, IsDisplayed, DisplayLogic, DisplayLength, SeqNo, SortNo, IsSameLine, IsHeading, IsFieldOnly, IsReadOnly, isencryptedfield, ObscureType, ColumnName, ColumnSQL, FieldLength, VFormat, DefaultValue, IsKey, IsParent, IsMandatory, IsIdentifier, IsTranslated, AD_Reference_Value_ID, Callout, AD_Reference_ID, AD_Val_Rule_ID, AD_Process_ID, IsAlwaysUpdateable, ReadOnlyLogic, MandatoryLogic, IsUpdateable, isencryptedcolumn, IsSelectionColumn, TableName, ValueMin, ValueMax, fieldgroup, validationcode, Included_Tab_ID, FieldGroupType, IsCollapsedByDefault, InfoFactoryClass, IsAutocomplete, IsAllowCopy, IsDisplayedGrid, SeqNoGrid, SeqNoSelection, XPosition, ColumnSpan, NumLines, IsToolbarButton, FormatPattern, IsAdvancedField, IsDefaultFocus, AD_Chart_ID, AD_LabelStyle_ID, AD_FieldStyle_ID, PA_DashboardContent_ID, Placeholder, IsHtml, IsQuickForm, AD_Val_Rule_Lookup_ID, validationcodelookup, AD_InfoWindow_ID, alwaysupdatablelogic) AS SELECT t.ad_window_id AS AD_Window_ID, f.ad_tab_id AS AD_Tab_ID, f.ad_field_id AS AD_Field_ID, tbl.ad_table_id AS AD_Table_ID, f.ad_column_id AS AD_Column_ID, f.name AS Name, f.description AS Description, f.help AS Help, f.isdisplayed AS IsDisplayed, f.displaylogic AS DisplayLogic, f.displaylength AS DisplayLength, f.seqno AS SeqNo, f.sortno AS SortNo, f.issameline AS IsSameLine, f.isheading AS IsHeading, f.isfieldonly AS IsFieldOnly, f.isreadonly AS IsReadOnly, f.isencrypted AS isencryptedfield, f.obscuretype AS ObscureType, c.columnname AS ColumnName, COALESCE(f.columnsql, c.columnsql) AS ColumnSQL, c.fieldlength AS FieldLength, COALESCE(f.vformat, c.vformat) AS VFormat, COALESCE(f.defaultvalue, c.defaultvalue) AS DefaultValue, c.iskey AS IsKey, c.isparent AS IsParent, COALESCE(f.ismandatory, c.ismandatory) AS IsMandatory, c.isidentifier AS IsIdentifier, c.istranslated AS IsTranslated, COALESCE(f.ad_reference_value_id, c.ad_reference_value_id) AS AD_Reference_Value_ID, c.callout AS Callout, COALESCE(f.ad_reference_id, c.ad_reference_id) AS AD_Reference_ID, COALESCE(f.ad_val_rule_id, c.ad_val_rule_id) AS AD_Val_Rule_ID, c.ad_process_id AS AD_Process_ID, COALESCE(f.isalwaysupdateable, c.isalwaysupdateable) AS IsAlwaysUpdateable, COALESCE(f.readonlylogic, c.readonlylogic) AS ReadOnlyLogic, COALESCE(f.mandatorylogic, c.mandatorylogic) AS MandatoryLogic, COALESCE(f.isupdateable, c.isupdateable) AS IsUpdateable,
c.isencrypted AS isencryptedcolumn, COALESCE(f.isselectioncolumn, c.isselectioncolumn) AS IsSelectionColumn, tbl.tablename AS TableName, c.valuemin AS ValueMin, c.valuemax AS ValueMax, fg.name AS fieldgroup, vr.code AS validationcode, f.included_tab_id AS Included_Tab_ID, fg.fieldgrouptype AS FieldGroupType, fg.iscollapsedbydefault AS IsCollapsedByDefault, COALESCE(f.infofactoryclass, c.infofactoryclass) AS InfoFactoryClass, c.isautocomplete AS IsAutocomplete, COALESCE(f.isallowcopy, c.isallowcopy) AS IsAllowCopy, f.isdisplayedgrid AS IsDisplayedGrid, f.seqnogrid AS SeqNoGrid, c.seqnoselection AS SeqNoSelection, f.xposition AS XPosition, f.columnspan AS ColumnSpan, f.numlines AS NumLines, COALESCE(f.istoolbarbutton, c.istoolbarbutton) AS IsToolbarButton, c.formatpattern AS FormatPattern, f.isadvancedfield AS IsAdvancedField, f.isdefaultfocus AS IsDefaultFocus, c.ad_chart_id AS AD_Chart_ID, f.ad_labelstyle_id AS AD_LabelStyle_ID, f.ad_fieldstyle_id AS AD_FieldStyle_ID, c.pa_dashboardcontent_id AS PA_DashboardContent_ID, COALESCE(f.placeholder, c.placeholder) AS Placeholder, c.ishtml AS IsHtml, f.isquickform AS IsQuickForm, COALESCE(f.ad_val_rule_lookup_id, c.ad_val_rule_lookup_id) AS AD_Val_Rule_Lookup_ID, vrf.code AS validationcodelookup, c.ad_infowindow_id AS AD_InfoWindow_ID, COALESCE(f.alwaysupdatablelogic, c.alwaysupdatablelogic) AS alwaysupdatablelogic FROM ad_field f
JOIN ad_tab t ON f.ad_tab_id = t.ad_tab_id
LEFT JOIN ad_fieldgroup fg ON f.ad_fieldgroup_id = fg.ad_fieldgroup_id
LEFT JOIN ad_column c ON f.ad_column_id = c.ad_column_id
JOIN ad_table tbl ON c.ad_table_id = tbl.ad_table_id
LEFT JOIN ad_val_rule vr ON vr.ad_val_rule_id = COALESCE(f.ad_val_rule_id, c.ad_val_rule_id)
LEFT JOIN ad_val_rule vrf ON vrf.ad_val_rule_id = COALESCE(f.ad_val_rule_lookup_id, c.ad_val_rule_lookup_id) WHERE f.isactive = 'Y' AND c.isactive = 'Y'
;


-- Jul 19, 2022, 12:51:35 PM IST
CREATE OR REPLACE VIEW AD_Field_vt(AD_Language, AD_Window_ID, AD_Tab_ID, AD_Field_ID, AD_Table_ID, AD_Column_ID, Name, Description, Help, IsDisplayed, DisplayLogic, DisplayLength, SeqNo, SortNo, IsSameLine, IsHeading, IsFieldOnly, IsReadOnly, isencryptedfield, ObscureType, ColumnName, ColumnSQL, FieldLength, VFormat, DefaultValue, IsKey, IsParent, IsMandatory, IsIdentifier, IsTranslated, AD_Reference_Value_ID, Callout, AD_Reference_ID, AD_Val_Rule_ID, AD_Process_ID, IsAlwaysUpdateable, ReadOnlyLogic, MandatoryLogic, IsUpdateable, isencryptedcolumn, IsSelectionColumn, TableName, ValueMin, ValueMax, fieldgroup, validationcode, Included_Tab_ID, FieldGroupType, IsCollapsedByDefault, InfoFactoryClass, IsAutocomplete, IsAllowCopy, IsDisplayedGrid, SeqNoGrid, SeqNoSelection, XPosition, ColumnSpan, NumLines, IsToolbarButton, FormatPattern, IsAdvancedField, IsDefaultFocus, AD_Chart_ID, AD_LabelStyle_ID, AD_FieldStyle_ID, PA_DashboardContent_ID, Placeholder, IsHtml, IsQuickForm, AD_Val_Rule_Lookup_ID, validationcodelookup, AD_InfoWindow_ID, alwaysupdatablelogic) AS SELECT trl.ad_language AS AD_Language, t.ad_window_id AS AD_Window_ID, f.ad_tab_id AS AD_Tab_ID, f.ad_field_id AS AD_Field_ID, tbl.ad_table_id AS AD_Table_ID, f.ad_column_id AS AD_Column_ID, trl.name AS Name, trl.description AS Description, trl.help AS Help, f.isdisplayed AS IsDisplayed, f.displaylogic AS DisplayLogic, f.displaylength AS DisplayLength, f.seqno AS SeqNo, f.sortno AS SortNo, f.issameline AS IsSameLine, f.isheading AS IsHeading, f.isfieldonly AS IsFieldOnly, f.isreadonly AS IsReadOnly, f.isencrypted AS isencryptedfield, f.obscuretype AS ObscureType, c.columnname AS ColumnName, COALESCE(f.columnsql, c.columnsql) AS ColumnSQL, c.fieldlength AS FieldLength, COALESCE(f.vformat, c.vformat) AS VFormat, COALESCE(f.defaultvalue, c.defaultvalue) AS DefaultValue, c.iskey AS IsKey, c.isparent AS IsParent, COALESCE(f.ismandatory, c.ismandatory) AS IsMandatory, c.isidentifier AS IsIdentifier, c.istranslated AS IsTranslated, COALESCE(f.ad_reference_value_id, c.ad_reference_value_id) AS AD_Reference_Value_ID, c.callout AS Callout, COALESCE(f.ad_reference_id, c.ad_reference_id) AS AD_Reference_ID, COALESCE(f.ad_val_rule_id, c.ad_val_rule_id) AS AD_Val_Rule_ID, c.ad_process_id AS AD_Process_ID, COALESCE(f.isalwaysupdateable, c.isalwaysupdateable) AS IsAlwaysUpdateable, COALESCE(f.readonlylogic, c.readonlylogic) AS ReadOnlyLogic, COALESCE(f.mandatorylogic, c.mandatorylogic) AS MandatoryLogic,
 COALESCE(f.isupdateable, c.isupdateable) AS IsUpdateable, c.isencrypted AS isencryptedcolumn, COALESCE(f.isselectioncolumn, c.isselectioncolumn) AS IsSelectionColumn, tbl.tablename AS TableName, c.valuemin AS ValueMin, c.valuemax AS ValueMax, fgt.name AS fieldgroup, vr.code AS validationcode, f.included_tab_id AS Included_Tab_ID, fg.fieldgrouptype AS FieldGroupType, fg.iscollapsedbydefault AS IsCollapsedByDefault, COALESCE(f.infofactoryclass, c.infofactoryclass) AS InfoFactoryClass, c.isautocomplete AS IsAutocomplete, COALESCE(f.isallowcopy, c.isallowcopy) AS IsAllowCopy, f.isdisplayedgrid AS IsDisplayedGrid, f.seqnogrid AS SeqNoGrid, c.seqnoselection AS SeqNoSelection, f.xposition AS XPosition, f.columnspan AS ColumnSpan, f.numlines AS NumLines, COALESCE(f.istoolbarbutton, c.istoolbarbutton) AS IsToolbarButton, c.formatpattern AS FormatPattern, f.isadvancedfield AS IsAdvancedField, f.isdefaultfocus AS IsDefaultFocus, c.ad_chart_id AS AD_Chart_ID, f.ad_labelstyle_id AS AD_LabelStyle_ID, f.ad_fieldstyle_id AS AD_FieldStyle_ID, c.pa_dashboardcontent_id AS PA_DashboardContent_ID, COALESCE(trl.placeholder, ct.placeholder) AS Placeholder, c.ishtml AS IsHtml, f.isquickform AS IsQuickForm, COALESCE(f.ad_val_rule_lookup_id, c.ad_val_rule_lookup_id) AS AD_Val_Rule_Lookup_ID, vrf.code AS validationcodelookup, c.ad_infowindow_id AS AD_InfoWindow_ID , COALESCE(f.alwaysupdatablelogic, c.alwaysupdatablelogic) AS alwaysupdatablelogic FROM ad_field f
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

-- Jul 19, 2022, 12:54:20 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,Placeholder,IsHtml) 
VALUES (215093,0,'Always Updatable Logic','Logic to determine if field is Updatable irrespective if record''s active status or processed status. This logic Applicable only if Always Updatable is N.','format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := |&()<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
<ul>
<li> @AD_Table_ID@=14 | @Language@!GERGER</li>
<li> @PriceLimit@>10 | @PriceList@>@PriceActual@</li>
<li> @Name@>J</li>
</ul>
Strings may be in single quotes (optional)',464,'AlwaysUpdatableLogic',2000,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_TIMESTAMP('2022-07-19 12:54:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-19 12:54:20','YYYY-MM-DD HH24:MI:SS'),100,203631,'Y','N','D','N','N','N','Y','f4c95800-09bc-4266-805c-57f30cfb26ad','Y',0,'N','N','N','Logical Expression','N')
;

-- Jul 19, 2022, 12:54:25 PM IST
ALTER TABLE AD_UserDef_Field ADD AlwaysUpdatableLogic VARCHAR2(2000 CHAR) DEFAULT NULL 
;

-- Jul 19, 2022, 12:56:35 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207129,'Always Updatable Logic','Logic to determine if field is Updatable irrespective if record''s active status or processed status. This logic Applicable only if Always Updatable is N.','format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := |&()<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
<ul>
<li> @AD_Table_ID@=14 | @Language@!GERGER</li>
<li> @PriceLimit@>10 | @PriceList@>@PriceActual@</li>
<li> @Name@>J</li>
</ul>
Strings may be in single quotes (optional)',395,215093,'Y',1,315,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-07-19 12:56:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-19 12:56:35','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','696f3c56-6f2b-4b7d-925d-560d2cbae017','Y',250,1,5,2,'N','N','Y','N')
;

