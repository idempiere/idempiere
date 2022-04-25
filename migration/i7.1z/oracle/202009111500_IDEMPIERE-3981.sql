SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3981 - Lookup tab & field level control options, Lookup Dynamic validation and overwrite Lookup Dynamic validation & isselection at field level
-- Jun 3,  2019 10:05:06 BRT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203338,0,0,'Y',TO_DATE('2019-06-03 10:05:05','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-06-03 10:05:05','YYYY-MM-DD HH24:MI:SS'),100,'IsAllowAdvancedLookup','Allow Advanced Lookup','Allow Advanced Lookup','D','f410a3ed-f6f5-4c16-9a02-a50f91d60dbc')
;

-- Jun 3,  2019 10:05:06 BRT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Name,Description,Help,PrintName,PO_Description,PO_Help,PO_Name,PO_PrintName,Placeholder, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Name,t.Description,t.Help,t.PrintName,t.PO_Description,t.PO_Help,t.PO_Name,t.PO_PrintName,t.Placeholder, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=203338 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Jun 3,  2019 10:12:24 BRT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203339,0,0,'Y',TO_DATE('2019-06-03 10:12:24','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-06-03 10:12:24','YYYY-MM-DD HH24:MI:SS'),100,'IsLookupOnlySelection','Lookup Only Selection Columns','When defined to true Lookup panel will display only selection columns. Default to false.','Lookup Only Selection Columns','D','ae484903-8b6e-405e-bc39-06a4ec1add9a')
;

-- Jun 3,  2019 10:12:24 BRT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Name,Description,Help,PrintName,PO_Description,PO_Help,PO_Name,PO_PrintName,Placeholder, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Name,t.Description,t.Help,t.PrintName,t.PO_Description,t.PO_Help,t.PO_Name,t.PO_PrintName,t.Placeholder, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=203339 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Jun 3,  2019 10:12:54 BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213944,0,'Lookup Only Selection Columns','When defined to true Lookup panel will display only selection columns. Default to false.',106,'IsLookupOnlySelection','''N''',1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_DATE('2019-06-03 10:12:54','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-06-03 10:12:54','YYYY-MM-DD HH24:MI:SS'),100,203339,'Y','N','D','N','N','N','Y','836a3ca4-0000-465c-8f75-ea22f41cb44a','Y',0,'N','N','N')
;

-- Jun 3,  2019 10:12:54 BRT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name,Placeholder, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name,t.Placeholder, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=213944 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jun 3,  2019 10:12:56 BRT
ALTER TABLE AD_Tab ADD IsLookupOnlySelection CHAR(1) DEFAULT 'N' CHECK (IsLookupOnlySelection IN ('Y','N'))
;

-- Jun 3,  2019 10:13:23 BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213945,0,'Allow Advanced Lookup',106,'IsAllowAdvancedLookup','''Y''',1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_DATE('2019-06-03 10:13:22','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-06-03 10:13:22','YYYY-MM-DD HH24:MI:SS'),100,203338,'Y','N','D','N','N','N','Y','8104b7fa-75ce-4eea-843d-337f6c8de731','Y',0,'N','N','N')
;

-- Jun 3,  2019 10:13:23 BRT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name,Placeholder, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name,t.Placeholder, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=213945 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jun 3,  2019 10:13:24 BRT
ALTER TABLE AD_Tab ADD IsAllowAdvancedLookup CHAR(1) DEFAULT 'Y' CHECK (IsAllowAdvancedLookup IN ('Y','N'))
;

-- Jun 3,  2019 10:14:26 BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (213946,0,'Selection Column','Is this column used for Lookup rows in windows','If selected, the column is listed in the first Lookup window tab and in the selection part of the window',107,'IsSelectionColumn',1,'N','N','N','N','N',0,'N',17,53365,0,0,'Y',TO_DATE('2019-06-03 10:14:26','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-06-03 10:14:26','YYYY-MM-DD HH24:MI:SS'),100,1656,'Y','N','D','N','N','N','Y','746eedd3-e345-4aee-bd4e-72d46e02a90b','Y',0,'N','N')
;

-- Jun 3,  2019 10:14:26 BRT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name,Placeholder, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name,t.Placeholder, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=213946 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jun 3,  2019 10:14:32 BRT
UPDATE AD_Column SET AD_Reference_Value_ID=319,Updated=TO_DATE('2019-06-03 10:14:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213946
;

-- Jun 3,  2019 10:14:36 BRT
ALTER TABLE AD_Field ADD IsSelectionColumn CHAR(1) DEFAULT NULL
;

-- Jun 3,  2019 10:15:30 BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206078,'Lookup Only Selection Columns','When defined to true Lookup panel will display only selection columns. Default to false.',106,213944,'Y',1,350,'N','N','N','N',0,0,'Y',TO_DATE('2019-06-03 10:15:30','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-06-03 10:15:30','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','9366c40e-e96c-41db-a22b-ee9da56e4f9c','Y',330,2,2)
;

-- Jun 3,  2019 10:15:30 BRT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Name,Description,Help,Placeholder, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Name,t.Description,t.Help,t.Placeholder, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=206078 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jun 3,  2019 10:15:30 BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206079,'Allow Advanced Lookup',106,213945,'Y',1,360,'N','N','N','N',0,0,'Y',TO_DATE('2019-06-03 10:15:30','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-06-03 10:15:30','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d178ab39-3383-48ef-aa45-937c8bad5756','Y',340,2,2)
;

-- Jun 3,  2019 10:15:30 BRT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Name,Description,Help,Placeholder, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Name,t.Description,t.Help,t.Placeholder, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=206079 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jun 3,  2019 10:16:31 BRT
UPDATE AD_Field SET Name='Lookup Only Selection Columns', Description='When defined to true Lookup panel will display only selection columns. Default to false.', Help=NULL, IsDisplayed='Y', SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=2, ColumnSpan=1, IsToolbarButton=NULL, Placeholder=NULL,Updated=TO_DATE('2019-06-03 10:16:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206078
;

-- Jun 3,  2019 10:16:31 BRT
UPDATE AD_Field SET Name='Allow Advanced Lookup', Description=NULL, Help=NULL, IsDisplayed='Y', SeqNo=190, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=3, IsToolbarButton=NULL, Placeholder=NULL,Updated=TO_DATE('2019-06-03 10:16:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206079
;

-- Jun 3,  2019 10:16:32 BRT
UPDATE AD_Field SET Name='Order Column', Description='Column determining the order', Help='Integer Column of the table determining the order (display, sort, ..). If defined, the Order By replaces the default Order By clause. It should be fully qualified (i.e. "tablename.columnname").', SeqNo=200, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, Placeholder=NULL,Updated=TO_DATE('2019-06-03 10:16:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5709
;

-- Jun 3,  2019 10:16:32 BRT
UPDATE AD_Field SET Name='Included Column', Description='Column determining if a Table Column is included in Ordering', Help='If a Included Column is defined, it decides, if a column is active in the ordering - otherwise it is determined that the Order Column has a value of one or greater', SeqNo=210, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, Placeholder=NULL,Updated=TO_DATE('2019-06-03 10:16:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5708
;

-- Jun 3,  2019 10:16:32 BRT
UPDATE AD_Field SET Name='Link Column', Description='Link Column for Multi-Parent tables', Help='The Link Column indicates which column is the primary key for those situations where there is more than one parent.  Only define it, if the table has more than one parent column (e.g. AD_User_Roles).', SeqNo=220, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, Placeholder=NULL,Updated=TO_DATE('2019-06-03 10:16:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1546
;

-- Jun 3,  2019 10:16:32 BRT
UPDATE AD_Field SET Name='Parent Column', Description='The link column on the parent tab.', Help=NULL, SeqNo=230, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, Placeholder=NULL,Updated=TO_DATE('2019-06-03 10:16:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=57266
;

-- Jun 3,  2019 10:16:32 BRT
UPDATE AD_Field SET Name='Process', Description='Process or Report', Help='The Process field identifies a unique Process or Report in the system.', SeqNo=240, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, Placeholder=NULL,Updated=TO_DATE('2019-06-03 10:16:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2575
;

-- Jun 3,  2019 10:16:32 BRT
UPDATE AD_Field SET Name='Display Logic', Description='If the Field is displayed, the result determines if the field is actually displayed', Help='format := {expression} [{logic} {expression}]<br>
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br>
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
'||chr(64)||'AD_Table_ID@=14 | @Language@!GERGER <br>
'||chr(64)||'PriceLimit@>10 | @PriceList@>@PriceActual@<br>
'||chr(64)||'Name@>J<br>
Strings may be in single quotes (optional)', SeqNo=250, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, Placeholder=NULL,Updated=TO_DATE('2019-06-03 10:16:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11265
;

-- Jun 3,  2019 10:16:32 BRT
UPDATE AD_Field SET Name='Read Only', Description='Field is read only', Help='The Read Only indicates that this field may only be Read.  It may not be updated.', SeqNo=260, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, Placeholder=NULL,Updated=TO_DATE('2019-06-03 10:16:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=929
;

-- Jun 3,  2019 10:16:32 BRT
UPDATE AD_Field SET Name='Insert Record', Description='The user can insert a new Record', Help='If not selected, the user cannot create a new Record.  This is automatically disabled, if the Tab is Read Only.', SeqNo=270, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, Placeholder=NULL,Updated=TO_DATE('2019-06-03 10:16:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11998
;

-- Jun 3,  2019 10:16:32 BRT
UPDATE AD_Field SET Name='Active', Description='The record is active in the system', Help='There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.', SeqNo=280, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, Placeholder=NULL,Updated=TO_DATE('2019-06-03 10:16:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=271
;

-- Jun 3,  2019 10:16:32 BRT
UPDATE AD_Field SET Name='Read Only Logic', Description='Logic to determine if field is read only (applies only when field is read-write)', Help='format := {expression} [{logic} {expression}]<br>
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br>
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
'||chr(64)||'AD_Table_ID@=14 | @Language@!GERGER <br>
'||chr(64)||'PriceLimit@>10 | @PriceList@>@PriceActual@<br>
'||chr(64)||'Name@>J<br>
Strings may be in single quotes (optional)', SeqNo=290, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, Placeholder=NULL,Updated=TO_DATE('2019-06-03 10:16:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11266
;

-- Jun 3,  2019 10:16:32 BRT
UPDATE AD_Field SET Name='Commit Warning', Description='Warning displayed when saving', Help='Warning or information displayed when committing the record', SeqNo=300, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, Placeholder=NULL,Updated=TO_DATE('2019-06-03 10:16:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1548
;

-- Jun 3,  2019 10:16:32 BRT
UPDATE AD_Field SET Name='Sql WHERE', Description='Fully qualified SQL WHERE clause', Help='The Where Clause indicates the SQL WHERE clause to use for record selection. The WHERE clause is added to the query. Fully qualified means "tablename.columnname".', SeqNo=310, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, Placeholder=NULL,Updated=TO_DATE('2019-06-03 10:16:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1550
;

-- Jun 3,  2019 10:16:32 BRT
UPDATE AD_Field SET Name='Sql ORDER BY', Description='Fully qualified ORDER BY clause', Help='The ORDER BY Clause indicates the SQL ORDER BY clause to use for record selection', SeqNo=320, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, Placeholder=NULL,Updated=TO_DATE('2019-06-03 10:16:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1549
;

-- Jun 3,  2019 10:16:32 BRT
UPDATE AD_Field SET Name='Image', Description='Image or Icon', Help='Images and Icon can be used to display supported graphic formats (gif, jpg, png).
You can either load the image (in the database) or point to a graphic via a URI (i.e. it can point to a resource, http address)', SeqNo=330, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, Placeholder=NULL,Updated=TO_DATE('2019-06-03 10:16:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4956
;

-- Jun 3,  2019 10:16:32 BRT
UPDATE AD_Field SET Name='Context Help', Description=NULL, Help=NULL, SeqNo=340, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, Placeholder=NULL,Updated=TO_DATE('2019-06-03 10:16:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201811
;

-- Jun 3,  2019 10:16:32 BRT
UPDATE AD_Field SET Name='Create Fields', Description='Create Field from Table Column, which do not exist in the Tab yet', Help='Based on the table columns of this Tab, this procedure creates the missing Fields', SeqNo=350, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, Placeholder=NULL,Updated=TO_DATE('2019-06-03 10:16:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5131
;

-- Jun 3,  2019 10:16:32 BRT
UPDATE AD_Field SET Name='Copy Tab Fields', Description='Copy Fields from other Tab', Help=NULL, SeqNo=360, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, Placeholder=NULL,Updated=TO_DATE('2019-06-03 10:16:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3205
;

-- Jun 3,  2019 10:17:00 BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206080,'Selection Column','Is this column used for Lookup rows in windows','If selected, the column is listed in the first Lookup window tab and in the selection part of the window',107,213946,'Y',1,490,'N','N','N','N',0,0,'Y',TO_DATE('2019-06-03 10:17:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-06-03 10:17:00','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6585def5-e85e-4926-8367-2dd50d5725d2','Y',470,2)
;

-- Jun 3,  2019 10:17:00 BRT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Name,Description,Help,Placeholder, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Name,t.Description,t.Help,t.Placeholder, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=206080 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jun 3,  2019 10:17:22 BRT
UPDATE AD_Field SET Name='Placeholder', Description=NULL, Help=NULL, SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, Placeholder=NULL,Updated=TO_DATE('2019-06-03 10:17:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205345
;

-- Jun 3,  2019 10:17:23 BRT
UPDATE AD_Field SET Name='Read Only', Description='Field is read only', Help='The Read Only indicates that this field may only be Read.  It may not be updated.', SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, Placeholder=NULL,Updated=TO_DATE('2019-06-03 10:17:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=924
;

-- Jun 3,  2019 10:17:23 BRT
UPDATE AD_Field SET Name='Display Logic', Description='If the Field is displayed, the result determines if the field is actually displayed', Help='format := {expression} [{logic} {expression}]<br>
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br>
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
'||chr(64)||'AD_Table_ID@=14 | @Language@!GERGER <br>
'||chr(64)||'PriceLimit@>10 | @PriceList@>@PriceActual@<br>
'||chr(64)||'Name@>J<br>
Strings may be in single quotes (optional)', SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, Placeholder=NULL,Updated=TO_DATE('2019-06-03 10:17:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=133
;

-- Jun 3,  2019 10:17:23 BRT
UPDATE AD_Field SET Name='Sequence', Description='Method of ordering records; lowest number comes first', Help='The Sequence indicates the order of records', SeqNo=190, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, Placeholder=NULL,Updated=TO_DATE('2019-06-03 10:17:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=137
;

-- Jun 3,  2019 10:17:23 BRT
UPDATE AD_Field SET Name='Grid Sequence No', Description=NULL, Help=NULL, SeqNo=200, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, Placeholder=NULL,Updated=TO_DATE('2019-06-03 10:17:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200274
;

-- Jun 3,  2019 10:17:23 BRT
UPDATE AD_Field SET Name='Record Sort No', Description='Determines in what order the records are displayed', Help='The Record Sort No indicates the ascending sort sequence of the records. If the number is negative, the records are sorted descending.
Example: A tab with C_DocType_ID (1), DocumentNo (-2) will be sorted ascending by document type and descending by document number (SQL: ORDER BY C_DocType, DocumentNo DESC)', SeqNo=210, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, Placeholder=NULL,Updated=TO_DATE('2019-06-03 10:17:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=138
;

-- Jun 3,  2019 10:17:23 BRT
UPDATE AD_Field SET Name='Advanced Field', Description=NULL, Help=NULL, SeqNo=220, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, Placeholder=NULL,Updated=TO_DATE('2019-06-03 10:17:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202362
;

-- Jun 3,  2019 10:17:23 BRT
UPDATE AD_Field SET Name='Encrypted', Description='Display or Storage is encrypted', Help='Display encryption (in Window/Tab/Field) - all characters are displayed as ''*'' - in the database it is stored in clear text. You will not be able to report on these columns.<br>
Data storage encryption (in Table/Column) - data is stored encrypted in the database (dangerous!) and you will not be able to report on those columns. Independent from Display encryption.', SeqNo=230, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, Placeholder=NULL,Updated=TO_DATE('2019-06-03 10:17:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=142
;

-- Jun 3,  2019 10:17:23 BRT
UPDATE AD_Field SET Name='Obscure', Description='Type of obscuring the data (limiting the display)', Help=NULL, SeqNo=240, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, Placeholder=NULL,Updated=TO_DATE('2019-06-03 10:17:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8343
;

-- Jun 3,  2019 10:17:23 BRT
UPDATE AD_Field SET Name='Heading only', Description='Field without Column - Only label is displayed', Help='The Heading Only checkbox indicates if just the label will display on the screen', SeqNo=250, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, Placeholder=NULL,Updated=TO_DATE('2019-06-03 10:17:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=140
;

-- Jun 3,  2019 10:17:23 BRT
UPDATE AD_Field SET Name='Default Focus', Description=NULL, Help=NULL, SeqNo=260, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, Placeholder=NULL,Updated=TO_DATE('2019-06-03 10:17:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202341
;

-- Jun 3,  2019 10:17:23 BRT
UPDATE AD_Field SET Name='Field Only', Description='Label is not displayed', Help='The Field Only checkbox indicates that the column will display without a label.', SeqNo=270, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, Placeholder=NULL,Updated=TO_DATE('2019-06-03 10:17:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=141
;

-- Jun 3,  2019 10:17:23 BRT
UPDATE AD_Field SET Name='X Position', Description='Absolute X (horizontal) position in 1/72 of an inch', Help='Absolute X (horizontal) position in 1/72 of an inch', SeqNo=280, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, Placeholder=NULL,Updated=TO_DATE('2019-06-03 10:17:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200350
;

-- Jun 3,  2019 10:17:23 BRT
UPDATE AD_Field SET Name='Column Span', Description='Number of column for a box of field', Help=NULL, SeqNo=290, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, Placeholder=NULL,Updated=TO_DATE('2019-06-03 10:17:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200348
;

-- Jun 3,  2019 10:17:23 BRT
UPDATE AD_Field SET Name='Number of Lines', Description='Number of lines for a field', Help='Number of lines for a field', SeqNo=300, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, Placeholder=NULL,Updated=TO_DATE('2019-06-03 10:17:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200349
;

-- Jun 3,  2019 10:17:23 BRT
UPDATE AD_Field SET Name='Label Style', Description='Label CSS Style', Help=NULL, SeqNo=310, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, Placeholder=NULL,Updated=TO_DATE('2019-06-03 10:17:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204213
;

-- Jun 3,  2019 10:17:23 BRT
UPDATE AD_Field SET Name='Field Style', Description='Field CSS Style ', Help=NULL, SeqNo=320, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, Placeholder=NULL,Updated=TO_DATE('2019-06-03 10:17:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204214
;

-- Jun 3,  2019 10:17:23 BRT
UPDATE AD_Field SET Name='Reference Overwrite', Description='System Reference - optional Overwrite', Help='You can overwrite the Display Type, but only use this if you aware of the consequences.', SeqNo=330, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, Placeholder=NULL,Updated=TO_DATE('2019-06-03 10:17:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13425
;

-- Jun 3,  2019 10:17:23 BRT
UPDATE AD_Field SET Name='Toolbar Button', Description='Show the button on the toolbar, the window, or both', Help='The IsToolbarButton field indicates if this button is part of the toolbar''s process button popup list, or render as field in window, or both.', SeqNo=340, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, Placeholder=NULL,Updated=TO_DATE('2019-06-03 10:17:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200837
;

-- Jun 3,  2019 10:17:23 BRT
UPDATE AD_Field SET Name='Reference Key', Description='Required to specify, if data type is Table or List', Help='The Reference Value indicates where the reference values are stored.  It must be specified if the data type is Table or List.  ', SeqNo=350, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, Placeholder=NULL,Updated=TO_DATE('2019-06-03 10:17:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=54402
;

-- Jun 3,  2019 10:17:23 BRT
UPDATE AD_Field SET Name='Dynamic Validation', Description='Dynamic Validation Rule', Help='These rules define how an entry is determined to valid. You can use variables for dynamic (context sensitive) validation.', SeqNo=360, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, Placeholder=NULL,Updated=TO_DATE('2019-06-03 10:17:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=54401
;

-- Jun 3,  2019 10:17:23 BRT
UPDATE AD_Field SET Name='Updatable', Description='Determines, if the field can be updated', Help='The Updatable checkbox indicates if a field can be updated by the user.', SeqNo=370, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, Placeholder=NULL,Updated=TO_DATE('2019-06-03 10:17:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200838
;

-- Jun 3,  2019 10:17:23 BRT
UPDATE AD_Field SET Name='Always Updatable', Description='The column is always updateable, even if the record is not active or processed', Help='If selected and if the window / tab is not read only, you can always update the column.  This might be useful for comments, etc.', SeqNo=380, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, Placeholder=NULL,Updated=TO_DATE('2019-06-03 10:17:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200834
;

-- Jun 3,  2019 10:17:23 BRT
UPDATE AD_Field SET Name='Mandatory Overwrite', Description='Overwrite Field Mandatory status', Help='The field must have a value for the record to be saved to the database.', SeqNo=390, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, Placeholder=NULL,Updated=TO_DATE('2019-06-03 10:17:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13424
;

-- Jun 3,  2019 10:17:23 BRT
UPDATE AD_Field SET Name='Allow Copy', Description='Determine if a column must be copied when pushing the button to copy record', Help=NULL, SeqNo=400, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, Placeholder=NULL,Updated=TO_DATE('2019-06-03 10:17:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=62468
;

-- Jun 3,  2019 10:17:23 BRT
UPDATE AD_Field SET Name='Selection Column', Description='Is this column used for Lookup rows in windows', Help='If selected, the column is listed in the first Lookup window tab and in the selection part of the window', IsDisplayed='Y', SeqNo=410, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL, Placeholder=NULL,Updated=TO_DATE('2019-06-03 10:17:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206080
;

-- Jun 3,  2019 10:17:23 BRT
UPDATE AD_Field SET Name='Default Logic', Description='Default value hierarchy, separated by ;', Help='The defaults are evaluated in the order of definition, the first not null value becomes the default value of the column. The values are separated by comma or semicolon. a) Literals:. ''Text'' or 123 b) Variables - in format @Variable@ - Login e.g. #Date, #AD_Org_ID, #AD_Client_ID - Accounting Schema: e.g. $C_AcctSchema_ID, $C_Calendar_ID - Global defaults: e.g. DateFormat - Window values (all Picks, CheckBoxes, RadioButtons, and DateDoc/DateAcct) c) SQL code with the tag: @SQL=SELECT something AS DefaultValue FROM ... The SQL statement can contain variables.  There can be no other value other than the SQL statement. The default is only evaluated, if no user preference is defined.  Default definitions are ignored for record columns as Key, Parent, Client as well as Buttons.', SeqNo=420, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, Placeholder=NULL,Updated=TO_DATE('2019-06-03 10:17:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53280
;

-- Jun 3,  2019 10:17:23 BRT
UPDATE AD_Field SET Name='Value Format', Description='Format of the value; Can contain fixed format elements, Variables: "_lLoOaAcCa09"', Help='<B>Validation elements:</B>
 	(Space) any character
_	Space (fixed character)
l	any Letter a..Z NO space
L	any Letter a..Z NO space converted to upper case
o	any Letter a..Z or space
O	any Letter a..Z or space converted to upper case
a	any Letters & Digits NO space
A	any Letters & Digits NO space converted to upper case
c	any Letters & Digits or space
C	any Letters & Digits or space converted to upper case
0	Digits 0..9 NO space
9	Digits 0..9 or space

Example of format "(000)_000-0000"', SeqNo=430, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, Placeholder=NULL,Updated=TO_DATE('2019-06-03 10:17:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203500
;

-- Jun 3,  2019 10:17:23 BRT
UPDATE AD_Field SET Name='Read Only Logic', Description='Logic to determine if field is read only (applies only when field is read-write)', Help='format := {expression} [{logic} {expression}]<br>
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br>
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
'||chr(64)||'AD_Table_ID@=14 | @Language@!GERGER <br>
'||chr(64)||'PriceLimit@>10 | @PriceList@>@PriceActual@<br>
'||chr(64)||'Name@>J<br>
Strings may be in single quotes (optional)', SeqNo=440, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, Placeholder=NULL,Updated=TO_DATE('2019-06-03 10:17:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200836
;

-- Jun 3,  2019 10:17:23 BRT
UPDATE AD_Field SET Name='Mandatory Logic', Description=NULL, Help=NULL, SeqNo=450, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, Placeholder=NULL,Updated=TO_DATE('2019-06-03 10:17:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200835
;

-- Jun 3,  2019 10:17:23 BRT
UPDATE AD_Field SET Name='Display Length', Description='Length of the display in characters', Help='The display length is mainly for String fields. The length has no impact, if the data type of the field is - Integer, Number, Amount	(length determined by the system) - YesNo	(Checkbox) - List, Table, TableDir	(length of combo boxes are determined by their content at runtime)', SeqNo=460, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, Placeholder=NULL,Updated=TO_DATE('2019-06-03 10:17:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=136
;

-- Jun 3,  2019 10:17:23 BRT
UPDATE AD_Field SET Name='Same Line', Description='Displayed on same line as previous field', Help='The Same Line checkbox indicates that the field will display on the same line as the previous field.', SeqNo=470, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, Placeholder=NULL,Updated=TO_DATE('2019-06-03 10:17:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=139
;

-- Jun 22, 2019, 3:44:56 PM BRT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203344,0,0,'Y',TO_DATE('2019-06-22 15:44:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-06-22 15:44:55','YYYY-MM-DD HH24:MI:SS'),100,'AD_Val_Rule_Lookup_ID','Dynamic Validation (Lookup)','Override Dynamic Validation Rule for Lookup Window','For some situations the dynamic validation rule for a Lookup window should be different from user data entry window. ','Validation (Lookup)','D','5e3b66a8-aa38-4a77-85de-09d07a44e559')
;

-- Jun 22, 2019, 3:45:21 PM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213962,1,'Dynamic Validation (Lookup)','Override Dynamic Validation Rule for Lookup Window','For some situations the dynamic validation rule for a Lookup window should be different from user data entry window. ',101,'AD_Val_Rule_Lookup_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_DATE('2019-06-22 15:45:21','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-06-22 15:45:21','YYYY-MM-DD HH24:MI:SS'),100,203344,'Y','N','D','N','N','N','Y','b5847bc2-5224-462a-8f69-7eff6a4626c5','Y','N','N','N')
;

-- Jun 22, 2019, 3:45:34 PM BRT
ALTER TABLE AD_Column ADD AD_Val_Rule_Lookup_ID NUMBER(10) DEFAULT NULL
;

-- Jun 22, 2019, 3:46:42 PM BRT
-- ALTER TABLE AD_Column MODIFY AD_Val_Rule_Lookup_ID NUMBER(10) DEFAULT NULL;

-- Jun 22, 2019, 3:47:55 PM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206091,'Dynamic Validation (Lookup)','Override Dynamic Validation Rule for Lookup Window','For some situations the dynamic validation rule for a Lookup window should be different from user data entry window. ',101,213962,'Y',22,490,'N','N','N','N',0,0,'Y',TO_DATE('2019-06-22 15:47:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-06-22 15:47:55','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a63e0dc2-6972-4b2b-87d7-5deb978523f5','Y',460,2)
;

-- Jun 22, 2019, 3:48:16 PM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 15:48:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206091
;

-- Jun 22, 2019, 3:48:16 PM BRT
UPDATE AD_Field SET SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 15:48:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205668
;

-- Jun 22, 2019, 3:48:16 PM BRT
UPDATE AD_Field SET SeqNo=190, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 15:48:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56279
;

-- Jun 22, 2019, 3:48:16 PM BRT
UPDATE AD_Field SET SeqNo=200, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 15:48:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56374
;

-- Jun 22, 2019, 3:48:16 PM BRT
UPDATE AD_Field SET SeqNo=210, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 15:48:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=310
;

-- Jun 22, 2019, 3:48:17 PM BRT
UPDATE AD_Field SET SeqNo=220, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 15:48:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2526
;

-- Jun 22, 2019, 3:48:17 PM BRT
UPDATE AD_Field SET SeqNo=230, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 15:48:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59619
;

-- Jun 22, 2019, 3:48:17 PM BRT
UPDATE AD_Field SET SeqNo=240, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 15:48:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204220
;

-- Jun 22, 2019, 3:48:17 PM BRT
UPDATE AD_Field SET SeqNo=250, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 15:48:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=171
;

-- Jun 22, 2019, 3:48:17 PM BRT
UPDATE AD_Field SET SeqNo=260, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 15:48:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2574
;

-- Jun 22, 2019, 3:48:17 PM BRT
UPDATE AD_Field SET SeqNo=270, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 15:48:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2573
;

-- Jun 22, 2019, 3:48:17 PM BRT
UPDATE AD_Field SET SeqNo=280, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 15:48:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=161
;

-- Jun 22, 2019, 3:48:17 PM BRT
UPDATE AD_Field SET SeqNo=290, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 15:48:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=162
;

-- Jun 22, 2019, 3:48:17 PM BRT
UPDATE AD_Field SET SeqNo=300, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 15:48:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202518
;

-- Jun 22, 2019, 3:48:17 PM BRT
UPDATE AD_Field SET SeqNo=310, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 15:48:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202519
;

-- Jun 22, 2019, 3:48:17 PM BRT
UPDATE AD_Field SET SeqNo=320, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 15:48:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=160
;

-- Jun 22, 2019, 3:48:17 PM BRT
UPDATE AD_Field SET SeqNo=330, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 15:48:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=166
;

-- Jun 22, 2019, 3:48:17 PM BRT
UPDATE AD_Field SET SeqNo=340, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 15:48:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2370
;

-- Jun 22, 2019, 3:48:17 PM BRT
UPDATE AD_Field SET SeqNo=350, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 15:48:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10128
;

-- Jun 22, 2019, 3:48:17 PM BRT
UPDATE AD_Field SET SeqNo=360, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 15:48:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5122
;

-- Jun 22, 2019, 3:48:17 PM BRT
UPDATE AD_Field SET SeqNo=370, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 15:48:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=169
;

-- Jun 22, 2019, 3:48:17 PM BRT
UPDATE AD_Field SET SeqNo=380, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 15:48:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4941
;

-- Jun 22, 2019, 3:48:17 PM BRT
UPDATE AD_Field SET SeqNo=390, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 15:48:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50188
;

-- Jun 22, 2019, 3:48:17 PM BRT
UPDATE AD_Field SET SeqNo=400, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 15:48:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=168
;

-- Jun 22, 2019, 3:48:17 PM BRT
UPDATE AD_Field SET SeqNo=410, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 15:48:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=159
;

-- Jun 22, 2019, 3:48:17 PM BRT
UPDATE AD_Field SET SeqNo=420, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 15:48:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4940
;

-- Jun 22, 2019, 3:48:17 PM BRT
UPDATE AD_Field SET SeqNo=430, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 15:48:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200288
;

-- Jun 22, 2019, 3:48:17 PM BRT
UPDATE AD_Field SET SeqNo=440, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 15:48:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56317
;

-- Jun 22, 2019, 3:48:17 PM BRT
UPDATE AD_Field SET SeqNo=450, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 15:48:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=62467
;

-- Jun 22, 2019, 3:48:17 PM BRT
UPDATE AD_Field SET SeqNo=460, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 15:48:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202257
;

-- Jun 22, 2019, 3:48:17 PM BRT
UPDATE AD_Field SET SeqNo=470, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 15:48:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200648
;

-- Jun 22, 2019, 3:48:17 PM BRT
UPDATE AD_Field SET SeqNo=480, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 15:48:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=167
;

-- Jun 22, 2019, 3:48:17 PM BRT
UPDATE AD_Field SET SeqNo=490, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 15:48:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=825
;

-- Jun 22, 2019, 3:49:47 PM BRT
UPDATE AD_Column SET AD_Reference_ID=18, AD_Reference_Value_ID=100,Updated=TO_DATE('2019-06-22 15:49:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213962
;

-- Jun 22, 2019, 3:50:33 PM BRT
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=19 | @AD_Reference_ID@=28 | @AD_Reference_ID@=30 | @AD_Reference_ID@=200012 | @AD_Reference_ID@=200138 | @AD_Reference_ID@=200139', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 15:50:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206091
;

-- Jun 22, 2019, 3:53:30 PM BRT
INSERT INTO AD_Tab (AD_Tab_ID,Name,Description,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,AD_Column_ID,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup) VALUES (200269,'Used in Column (Lookup)','Used in Column (Lookup)',103,30,'Y',101,0,0,'Y',TO_DATE('2019-06-22 15:53:30','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-06-22 15:53:30','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',213962,'N','N',1,'N','D','N','N','cb281c2a-e9ae-4c1d-b2bc-2dcc651573b0','B','N','Y')
;

-- Jun 22, 2019, 3:53:59 PM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (206124,'Table','Database Table information','The Database Table provides the information of the table definition',200269,114,'Y',14,10,1,'N','N','N','N',0,0,'Y',TO_DATE('2019-06-22 15:53:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-06-22 15:53:58','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','D','35c05ad3-66b1-4055-9907-9aa096c2fe81','Y',10,1,2,1,'N','N','N')
;

-- Jun 22, 2019, 3:53:59 PM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Reference_ID,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (206125,'Column','Column in the table','Link to the database column of the table',200269,109,'Y',14,20,'N','N','N','N',0,0,'Y',TO_DATE('2019-06-22 15:53:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-06-22 15:53:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D',30,'05062b37-d438-4de9-a352-20e30fdabd8b','Y',20,1,2,1,'N','N','N')
;

-- Jun 22, 2019, 3:53:59 PM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (206126,'DB Column Name','Name of the column in the database','The Column Name indicates the name of a column on a table as defined in the database.',200269,116,'Y',11,30,2,'Y','N','N','N',0,0,'Y',TO_DATE('2019-06-22 15:53:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-06-22 15:53:59','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','D','cd428dc7-129e-4d65-911d-e80acf0890e2','Y',30,4,2,1,'N','N','N')
;

-- Jun 22, 2019, 3:56:11 PM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (206128,'Dynamic Validation (Lookup)','Override Dynamic Validation Rule for Lookup Window','For some situations the dynamic validation rule for a Lookup window should be different from user data entry window. ',773,213962,'Y',22,140,'Y','N','N','N',0,0,'Y',TO_DATE('2019-06-22 15:56:11','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-06-22 15:56:11','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c7b43c7f-0e01-499d-b127-19482aa9ffa7','Y',130,4,2,1,'N','N','N')
;

-- Jun 22, 2019, 3:57:01 PM BRT
UPDATE AD_Field SET EntityType='D', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 15:57:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206124
;

-- Jun 22, 2019, 3:57:10 PM BRT
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 15:57:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206126
;

-- Jun 22, 2019, 3:57:30 PM BRT
UPDATE AD_Field SET SeqNo=360,IsDisplayed='Y', Updated=TO_DATE('2019-06-22 16:02:19','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=206126
;

-- Jun 22, 2019, 4:02:05 PM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213963,0,'Dynamic Validation (Lookup)','Override Dynamic Validation Rule for Lookup Window','For some situations the dynamic validation rule for a Lookup window should be different from user data entry window. ',107,'AD_Val_Rule_Lookup_ID',22,'N','N','N','N','N',0,'N',18,100,0,0,'Y',TO_DATE('2019-06-22 16:02:04','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-06-22 16:02:04','YYYY-MM-DD HH24:MI:SS'),100,203344,'Y','N','D','N','N','N','Y','3915d31e-9a86-4f6f-b717-9453a56466f2','Y','N','N','N')
;

-- Jun 22, 2019, 4:02:19 PM BRT
UPDATE AD_Column SET FKConstraintName='ADValRuleLookup_ADField', FKConstraintType='N',Updated=TO_DATE('2019-06-22 16:02:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213963
;

-- Jun 22, 2019, 4:02:19 PM BRT
ALTER TABLE AD_Field ADD AD_Val_Rule_Lookup_ID NUMBER(10) DEFAULT NULL
;

-- Jun 22, 2019, 4:02:19 PM BRT
ALTER TABLE AD_Field ADD CONSTRAINT ADValRuleLookup_ADField FOREIGN KEY (AD_Val_Rule_Lookup_ID) REFERENCES ad_val_rule(ad_val_rule_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jun 22, 2019, 4:02:54 PM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206129,'Dynamic Validation (Lookup)','Override Dynamic Validation Rule for Lookup Window','For some situations the dynamic validation rule for a Lookup window should be different from user data entry window. ',107,213963,'Y',22,480,'N','N','N','N',0,0,'Y',TO_DATE('2019-06-22 16:02:54','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-06-22 16:02:54','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','1f1ef182-bb87-4c57-9f56-05f0bdd73f2f','Y',480,2)
;

-- Jun 22, 2019, 4:03:18 PM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=370, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 16:03:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206129
;

-- Jun 22, 2019, 4:03:18 PM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=380, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 16:03:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200838
;

-- Jun 22, 2019, 4:03:18 PM BRT
UPDATE AD_Field SET SeqNo=390, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 16:03:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200834
;

-- Jun 22, 2019, 4:03:18 PM BRT
UPDATE AD_Field SET SeqNo=400, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 16:03:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13424
;

-- Jun 22, 2019, 4:03:18 PM BRT
UPDATE AD_Field SET SeqNo=410, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 16:03:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=62468
;

-- Jun 22, 2019, 4:03:18 PM BRT
UPDATE AD_Field SET SeqNo=420, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 16:03:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206080
;

-- Jun 22, 2019, 4:03:18 PM BRT
UPDATE AD_Field SET SeqNo=430, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 16:03:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53280
;

-- Jun 22, 2019, 4:03:18 PM BRT
UPDATE AD_Field SET SeqNo=440, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 16:03:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203500
;

-- Jun 22, 2019, 4:03:18 PM BRT
UPDATE AD_Field SET SeqNo=450, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 16:03:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200836
;

-- Jun 22, 2019, 4:03:18 PM BRT
UPDATE AD_Field SET SeqNo=460, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 16:03:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200835
;

-- Jun 22, 2019, 4:03:18 PM BRT
UPDATE AD_Field SET SeqNo=470, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 16:03:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=136
;

-- Jun 22, 2019, 4:03:18 PM BRT
UPDATE AD_Field SET SeqNo=480, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 16:03:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=139
;

-- Jun 22, 2019, 4:04:07 PM BRT
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=19 | @AD_Reference_ID@=28 | @AD_Reference_ID@=30 | @AD_Reference_ID@=200012 | @AD_Reference_ID@=200138 | @AD_Reference_ID@=200139', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 16:04:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206129
;

-- Jun 22, 2019, 5:04:27 PM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213964,0,'Dynamic Validation (Lookup)','Override Dynamic Validation Rule for Lookup Window','For some situations the dynamic validation rule for a Lookup window should be different from user data entry window. ',464,'AD_Val_Rule_Lookup_ID',22,'N','N','N','N','N',0,'N',18,100,0,0,'Y',TO_DATE('2019-06-22 17:04:27','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-06-22 17:04:27','YYYY-MM-DD HH24:MI:SS'),100,203344,'Y','N','D','N','N','N','Y','fbebb64d-8f86-4d3d-ab30-93a5b4b45827','Y',0,'N','N','N')
;

-- Jun 22, 2019, 5:04:30 PM BRT
UPDATE AD_Column SET FKConstraintName='ADValRuleLookup_ADUserDefField', FKConstraintType='N',Updated=TO_DATE('2019-06-22 17:04:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213964
;

-- Jun 22, 2019, 5:04:30 PM BRT
ALTER TABLE AD_UserDef_Field ADD AD_Val_Rule_Lookup_ID NUMBER(10) DEFAULT NULL
;

-- Jun 22, 2019, 5:04:30 PM BRT
ALTER TABLE AD_UserDef_Field ADD CONSTRAINT ADValRuleLookup_ADUserDefField FOREIGN KEY (AD_Val_Rule_Lookup_ID) REFERENCES ad_val_rule(ad_val_rule_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jun 22, 2019, 5:05:21 PM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206130,'Dynamic Validation (Lookup)','Override Dynamic Validation Rule for Lookup Window','For some situations the dynamic validation rule for a Lookup window should be different from user data entry window. ',395,213964,'Y',22,330,'N','N','N','N',0,0,'Y',TO_DATE('2019-06-22 17:05:21','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-06-22 17:05:21','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','0d5d42b9-0dde-4e4d-aaec-7bd4a7a799b6','Y',330,2)
;

-- Jun 22, 2019, 5:06:06 PM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=240, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 17:06:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203266
;

-- Jun 22, 2019, 5:06:06 PM BRT
UPDATE AD_Field SET SeqNo=250, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 17:06:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204221
;

-- Jun 22, 2019, 5:06:06 PM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=260, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 17:06:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206130
;

-- Jun 22, 2019, 5:06:06 PM BRT
UPDATE AD_Field SET SeqNo=270, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 17:06:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5054
;

-- Jun 22, 2019, 5:06:06 PM BRT
UPDATE AD_Field SET SeqNo=280, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 17:06:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200849
;

-- Jun 22, 2019, 5:06:06 PM BRT
UPDATE AD_Field SET SeqNo=290, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 17:06:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200851
;

-- Jun 22, 2019, 5:06:06 PM BRT
UPDATE AD_Field SET SeqNo=300, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 17:06:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200852
;

-- Jun 22, 2019, 5:06:06 PM BRT
UPDATE AD_Field SET SeqNo=310, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 17:06:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203499
;

-- Jun 22, 2019, 5:06:06 PM BRT
UPDATE AD_Field SET SeqNo=320, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 17:06:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200854
;

-- Jun 22, 2019, 5:06:06 PM BRT
UPDATE AD_Field SET SeqNo=330, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 17:06:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5051
;

-- Jun 22, 2019, 5:06:06 PM BRT
UPDATE AD_Field SET SeqNo=340, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 17:06:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5057
;

-- Jun 22, 2019, 5:06:28 PM BRT
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=19 | @AD_Reference_ID@=28 | @AD_Reference_ID@=30 | @AD_Reference_ID@=200012', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-06-22 17:06:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206130
;

-- Dec 2, 2019, 10:34:01 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (214124,0,'Lookup Only Selection Columns','When defined to true Lookup panel will display only selection columns. Default to false.',466,'IsLookupOnlySelection',NULL,1,'N','N','N','N','N',0,'N',17,319,0,0,'Y',TO_DATE('2019-12-02 10:34:01','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-12-02 10:34:01','YYYY-MM-DD HH24:MI:SS'),100,203339,'Y','N','D','N','N','N','Y','e0688e8f-13b3-4b5a-bf12-8ea1a25928b9','Y',0,'N','N','N')
;

-- Dec 2, 2019, 10:34:51 AM BRT
ALTER TABLE AD_UserDef_Tab ADD IsLookupOnlySelection CHAR(1) DEFAULT NULL
;

-- Dec 2, 2019, 10:35:07 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (214125,0,'Allow Advanced Lookup',466,'IsAllowAdvancedLookup','''Y''',1,'N','N','N','N','N',0,'N',17,319,0,0,'Y',TO_DATE('2019-12-02 10:35:07','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-12-02 10:35:07','YYYY-MM-DD HH24:MI:SS'),100,203338,'Y','N','D','N','N','N','Y','388580fd-aa4e-4d75-be90-c344874a2924','Y',0,'N','N','N')
;

-- Dec 2, 2019, 10:35:11 AM BRT
UPDATE AD_Column SET DefaultValue=NULL,Updated=TO_DATE('2019-12-02 10:35:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214125
;

-- Dec 2, 2019, 10:35:13 AM BRT
ALTER TABLE AD_UserDef_Tab ADD IsAllowAdvancedLookup CHAR(1) DEFAULT NULL
;

-- Dec 2, 2019, 10:35:51 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206313,'Lookup Only Selection Columns','When defined to true Lookup panel will display only selection columns. Default to false.',394,214124,'Y',1,130,'N','N','N','N',0,0,'Y',TO_DATE('2019-12-02 10:35:51','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-12-02 10:35:51','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a4bdb38c-0ccc-4c90-a778-9b1099be6a76','Y',130,2)
;

-- Dec 2, 2019, 10:35:51 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206314,'Allow Advanced Lookup',394,214125,'Y',1,140,'N','N','N','N',0,0,'Y',TO_DATE('2019-12-02 10:35:51','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-12-02 10:35:51','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','cf924414-1783-4868-8c8e-c7d1bccc9133','Y',140,2)
;

-- Dec 2, 2019, 10:36:04 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2019-12-02 10:36:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206314
;

-- Aug 6, 2020 4:41:29 PM IST
UPDATE AD_Field SET SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 16:41:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206078
;

-- Aug 6, 2020 4:41:29 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=190, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 16:41:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206079
;

-- Aug 6, 2020 4:41:29 PM IST
UPDATE AD_Field SET SeqNo=200, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 16:41:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204121
;

-- Aug 6, 2020 4:41:29 PM IST
UPDATE AD_Field SET SeqNo=210, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 16:41:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5709
;

-- Aug 6, 2020 4:41:29 PM IST
UPDATE AD_Field SET SeqNo=220, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 16:41:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5708
;

-- Aug 6, 2020 4:41:29 PM IST
UPDATE AD_Field SET SeqNo=230, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 16:41:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1546
;

-- Aug 6, 2020 4:41:29 PM IST
UPDATE AD_Field SET SeqNo=240, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 16:41:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=57266
;

-- Aug 6, 2020 4:41:29 PM IST
UPDATE AD_Field SET SeqNo=250, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 16:41:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2575
;

-- Aug 6, 2020 4:41:29 PM IST
UPDATE AD_Field SET SeqNo=260, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 16:41:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11265
;

-- Aug 6, 2020 4:41:29 PM IST
UPDATE AD_Field SET SeqNo=270, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 16:41:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=929
;

-- Aug 6, 2020 4:41:29 PM IST
UPDATE AD_Field SET SeqNo=280, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 16:41:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11998
;

-- Aug 6, 2020 4:41:29 PM IST
UPDATE AD_Field SET SeqNo=290, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 16:41:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=271
;

-- Aug 6, 2020 4:41:29 PM IST
UPDATE AD_Field SET SeqNo=300, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 16:41:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11266
;

-- Aug 6, 2020 4:41:29 PM IST
UPDATE AD_Field SET SeqNo=310, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 16:41:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1548
;

-- Aug 6, 2020 4:41:29 PM IST
UPDATE AD_Field SET SeqNo=320, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 16:41:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1550
;

-- Aug 6, 2020 4:41:29 PM IST
UPDATE AD_Field SET SeqNo=330, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 16:41:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1549
;

-- Aug 6, 2020 4:41:29 PM IST
UPDATE AD_Field SET SeqNo=340, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 16:41:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4956
;

-- Aug 6, 2020 4:41:29 PM IST
UPDATE AD_Field SET SeqNo=350, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 16:41:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201811
;

-- Aug 6, 2020 4:41:29 PM IST
UPDATE AD_Field SET SeqNo=360, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 16:41:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206396
;

-- Aug 6, 2020 4:41:29 PM IST
UPDATE AD_Field SET SeqNo=370, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 16:41:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206397
;

-- Aug 6, 2020 4:41:29 PM IST
UPDATE AD_Field SET SeqNo=380, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 16:41:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5131
;

-- Aug 6, 2020 4:41:29 PM IST
UPDATE AD_Field SET SeqNo=390, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 16:41:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3205
;

-- Aug 6, 2020 7:06:53 PM IST
UPDATE AD_Field SET SeqNo=250, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 19:06:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204221
;

-- Aug 6, 2020 7:06:53 PM IST
UPDATE AD_Field SET SeqNo=270, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 19:06:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5054
;

-- Aug 6, 2020 7:06:53 PM IST
UPDATE AD_Field SET SeqNo=280, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 19:06:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200849
;

-- Aug 6, 2020 7:06:53 PM IST
UPDATE AD_Field SET SeqNo=290, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 19:06:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200851
;

-- Aug 6, 2020 7:06:53 PM IST
UPDATE AD_Field SET SeqNo=300, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 19:06:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200852
;

-- Aug 6, 2020 7:06:53 PM IST
UPDATE AD_Field SET SeqNo=310, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 19:06:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203499
;

-- Aug 6, 2020 7:06:54 PM IST
UPDATE AD_Field SET SeqNo=320, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 19:06:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200854
;

-- Aug 6, 2020 7:06:54 PM IST
UPDATE AD_Field SET SeqNo=330, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 19:06:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5051
;

-- Aug 6, 2020 7:06:54 PM IST
UPDATE AD_Field SET SeqNo=340, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 19:06:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5057
;

-- Aug 6, 2020 7:07:47 PM IST
UPDATE AD_Field SET SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 19:07:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205345
;

-- Aug 6, 2020 7:07:47 PM IST
UPDATE AD_Field SET SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 19:07:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205244
;

-- Aug 6, 2020 7:07:47 PM IST
UPDATE AD_Field SET SeqNo=200, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 19:07:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=137
;

-- Aug 6, 2020 7:07:47 PM IST
UPDATE AD_Field SET SeqNo=210, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 19:07:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200274
;

-- Aug 6, 2020 7:07:47 PM IST
UPDATE AD_Field SET SeqNo=220, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 19:07:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=138
;

-- Aug 6, 2020 7:07:47 PM IST
UPDATE AD_Field SET SeqNo=230, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 19:07:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202362
;

-- Aug 6, 2020 7:07:47 PM IST
UPDATE AD_Field SET SeqNo=240, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 19:07:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=142
;

-- Aug 6, 2020 7:07:47 PM IST
UPDATE AD_Field SET SeqNo=250, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 19:07:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8343
;

-- Aug 6, 2020 7:07:47 PM IST
UPDATE AD_Field SET SeqNo=260, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 19:07:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=140
;

-- Aug 6, 2020 7:07:47 PM IST
UPDATE AD_Field SET SeqNo=270, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 19:07:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202341
;

-- Aug 6, 2020 7:07:47 PM IST
UPDATE AD_Field SET SeqNo=280, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 19:07:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=141
;

-- Aug 6, 2020 7:07:47 PM IST
UPDATE AD_Field SET SeqNo=290, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 19:07:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200350
;

-- Aug 6, 2020 7:07:47 PM IST
UPDATE AD_Field SET SeqNo=300, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 19:07:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200348
;

-- Aug 6, 2020 7:07:47 PM IST
UPDATE AD_Field SET SeqNo=310, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 19:07:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200349
;

-- Aug 6, 2020 7:07:47 PM IST
UPDATE AD_Field SET SeqNo=320, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 19:07:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204213
;

-- Aug 6, 2020 7:07:47 PM IST
UPDATE AD_Field SET SeqNo=330, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 19:07:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204214
;

-- Aug 6, 2020 7:07:47 PM IST
UPDATE AD_Field SET SeqNo=340, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 19:07:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13425
;

-- Aug 6, 2020 7:07:47 PM IST
UPDATE AD_Field SET SeqNo=350, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 19:07:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200837
;

-- Aug 6, 2020 7:07:47 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=360, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 19:07:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=54402
;

-- Aug 6, 2020 7:07:48 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=370, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 19:07:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=54401
;

-- Aug 6, 2020 7:07:48 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=380, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 19:07:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206129
;

-- Aug 6, 2020 7:07:48 PM IST
UPDATE AD_Field SET SeqNo=430, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 19:07:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206080
;

-- Aug 6, 2020 7:07:48 PM IST
UPDATE AD_Field SET SeqNo=440, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 19:07:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53280
;

-- Aug 6, 2020 7:07:48 PM IST
UPDATE AD_Field SET SeqNo=450, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 19:07:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203500
;

-- Aug 6, 2020 7:07:48 PM IST
UPDATE AD_Field SET SeqNo=460, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 19:07:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200836
;

-- Aug 6, 2020 7:07:48 PM IST
UPDATE AD_Field SET SeqNo=470, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 19:07:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200835
;

-- Aug 6, 2020 7:07:48 PM IST
UPDATE AD_Field SET SeqNo=480, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 19:07:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=136
;

-- Aug 6, 2020 7:07:48 PM IST
UPDATE AD_Field SET SeqNo=490, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-08-06 19:07:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=139
;

CREATE OR REPLACE VIEW ad_field_v AS
 SELECT t.ad_window_id, f.ad_tab_id, f.ad_field_id, tbl.ad_table_id, f.ad_column_id, f.name, f.description, f.help, f.isdisplayed, f.displaylogic, f.displaylength, f.seqno, f.sortno, f.issameline, f.isheading, f.isfieldonly, f.isreadonly, f.isencrypted AS isencryptedfield, f.obscuretype, c.columnname, c.columnsql, c.fieldlength, COALESCE(f.VFormat, c.VFormat) AS VFormat, COALESCE(f.defaultvalue, c.defaultvalue) AS defaultvalue, c.iskey, c.isparent, COALESCE(f.ismandatory, c.ismandatory) AS ismandatory, c.isidentifier, c.istranslated, COALESCE(f.ad_reference_value_id, c.ad_reference_value_id) AS ad_reference_value_id, c.callout, COALESCE(f.ad_reference_id, c.ad_reference_id) AS ad_reference_id, COALESCE(f.ad_val_rule_id, c.ad_val_rule_id) AS ad_val_rule_id, c.ad_process_id, COALESCE(f.isalwaysupdateable, c.isalwaysupdateable) AS isalwaysupdateable, COALESCE(f.readonlylogic, c.readonlylogic) AS readonlylogic, COALESCE(f.mandatorylogic, c.mandatorylogic) AS mandatorylogic, COALESCE(f.isupdateable, c.isupdateable) AS isupdateable, c.isencrypted AS isencryptedcolumn, COALESCE(f.isselectioncolumn, c.isselectioncolumn) AS isselectioncolumn, tbl.tablename, c.valuemin, c.valuemax, fg.name AS fieldgroup, vr.code AS validationcode, f.included_tab_id, fg.fieldgrouptype, fg.iscollapsedbydefault, COALESCE(f.infofactoryclass, c.infofactoryclass) AS infofactoryclass, c.isautocomplete, COALESCE(f.isallowcopy, c.isallowcopy) AS isallowcopy, f.isdisplayedgrid, f.seqnogrid, c.seqnoselection, f.xposition, f.columnspan, f.numlines, COALESCE(f.istoolbarbutton, c.istoolbarbutton) AS istoolbarbutton, c.formatpattern, f.isadvancedfield, f.isdefaultfocus, c.ad_chart_id, f.ad_labelstyle_id, f.ad_fieldstyle_id, c.pa_dashboardcontent_id, COALESCE(f.placeholder, c.placeholder) AS placeholder, c.ishtml, f.isquickform, COALESCE(f.ad_val_rule_Lookup_id, c.ad_val_rule_Lookup_id) AS ad_val_rule_Lookup_id, vrf.code AS validationcodeLookup
   FROM ad_field f
   JOIN ad_tab t ON f.ad_tab_id = t.ad_tab_id
   LEFT JOIN ad_fieldgroup fg ON f.ad_fieldgroup_id = fg.ad_fieldgroup_id
   LEFT JOIN ad_column c ON f.ad_column_id = c.ad_column_id
   JOIN ad_table tbl ON c.ad_table_id = tbl.ad_table_id
   LEFT JOIN ad_val_rule vr ON vr.ad_val_rule_id = COALESCE(f.ad_val_rule_id, c.ad_val_rule_id)
   LEFT JOIN ad_val_rule vrf ON vrf.ad_val_rule_id = COALESCE(f.ad_val_rule_Lookup_id, c.ad_val_rule_Lookup_id)
  WHERE f.isactive = 'Y' AND c.isactive = 'Y'
;

CREATE OR REPLACE VIEW ad_field_vt AS
 SELECT trl.ad_language, t.ad_window_id, f.ad_tab_id, f.ad_field_id, tbl.ad_table_id, f.ad_column_id, trl.name, trl.description, trl.help, f.isdisplayed, f.displaylogic, f.displaylength, f.seqno, f.sortno, f.issameline, f.isheading, f.isfieldonly, f.isreadonly, f.isencrypted AS isencryptedfield, f.obscuretype, c.columnname, c.columnsql, c.fieldlength, COALESCE(f.VFormat, c.VFormat) AS VFormat, COALESCE(f.defaultvalue, c.defaultvalue) AS defaultvalue, c.iskey, c.isparent, COALESCE(f.ismandatory, c.ismandatory) AS ismandatory, c.isidentifier, c.istranslated, COALESCE(f.ad_reference_value_id, c.ad_reference_value_id) AS ad_reference_value_id, c.callout, COALESCE(f.ad_reference_id, c.ad_reference_id) AS ad_reference_id, COALESCE(f.ad_val_rule_id, c.ad_val_rule_id) AS ad_val_rule_id, c.ad_process_id, COALESCE(f.isalwaysupdateable, c.isalwaysupdateable) AS isalwaysupdateable, COALESCE(f.readonlylogic, c.readonlylogic) AS readonlylogic, COALESCE(f.mandatorylogic, c.mandatorylogic) AS mandatorylogic, COALESCE(f.isupdateable, c.isupdateable) AS isupdateable, c.isencrypted AS isencryptedcolumn, COALESCE(f.isselectioncolumn, c.isselectioncolumn) AS isselectioncolumn, tbl.tablename, c.valuemin, c.valuemax, fgt.name AS fieldgroup, vr.code AS validationcode, f.included_tab_id, fg.fieldgrouptype, fg.iscollapsedbydefault, COALESCE(f.infofactoryclass, c.infofactoryclass) AS infofactoryclass, c.isautocomplete, COALESCE(f.isallowcopy, c.isallowcopy) AS isallowcopy, f.isdisplayedgrid, f.seqnogrid, c.seqnoselection, f.xposition, f.columnspan, f.numlines, COALESCE(f.istoolbarbutton, c.istoolbarbutton) AS istoolbarbutton, c.formatpattern, f.isadvancedfield, f.isdefaultfocus, c.ad_chart_id, f.ad_labelstyle_id, f.ad_fieldstyle_id, c.pa_dashboardcontent_id, COALESCE(trl.placeholder, ct.placeholder) AS placeholder, c.ishtml, f.isquickform, COALESCE(f.ad_val_rule_Lookup_id, c.ad_val_rule_Lookup_id) AS ad_val_rule_Lookup_id, vrf.code AS validationcodeLookup
   FROM ad_field f
   JOIN ad_field_trl trl ON f.ad_field_id = trl.ad_field_id
   JOIN ad_tab t ON f.ad_tab_id = t.ad_tab_id
   LEFT JOIN ad_fieldgroup fg ON f.ad_fieldgroup_id = fg.ad_fieldgroup_id
   LEFT JOIN ad_fieldgroup_trl fgt ON f.ad_fieldgroup_id = fgt.ad_fieldgroup_id AND trl.ad_language = fgt.ad_language
   LEFT JOIN ad_column c ON f.ad_column_id = c.ad_column_id
   LEFT JOIN ad_column_trl ct ON f.ad_column_id = ct.ad_column_id AND trl.ad_language = ct.ad_language
   JOIN ad_table tbl ON c.ad_table_id = tbl.ad_table_id
   LEFT JOIN ad_val_rule vr ON vr.ad_val_rule_id = COALESCE(f.ad_val_rule_id, c.ad_val_rule_id)
   LEFT JOIN ad_val_rule vrf ON vrf.ad_val_rule_id = COALESCE(f.ad_val_rule_Lookup_id, c.ad_val_rule_Lookup_id)
  WHERE f.isactive = 'Y' AND c.isactive = 'Y'
;

CREATE OR REPLACE VIEW AD_TAB_V
(AD_TAB_ID, AD_WINDOW_ID, AD_TABLE_ID, NAME, DESCRIPTION, 
 HELP, SEQNO, ISSINGLEROW, HASTREE, ISINFOTAB, 
 REPLICATIONTYPE, TABLENAME, ACCESSLEVEL, ISSECURITYENABLED, ISDELETEABLE, 
 ISHIGHVOLUME, ISVIEW, HASASSOCIATION, ISTRANSLATIONTAB, ISREADONLY, 
 AD_IMAGE_ID, TABLEVEL, WHERECLAUSE, ORDERBYCLAUSE, COMMITWARNING, 
 READONLYLOGIC, DISPLAYLOGIC, AD_COLUMN_ID, AD_PROCESS_ID, ISSORTTAB, 
 ISINSERTRECORD, ISADVANCEDTAB, AD_COLUMNSORTORDER_ID, AD_COLUMNSORTYESNO_ID, 
 INCLUDED_TAB_ID, PARENT_COLUMN_ID, AD_Tab_UU, AD_Table_UU, TREEDISPLAYEDON,
 MAXQUERYRECORDS, IsAllowAdvancedLookup, IsLookupOnlySelection)
AS 
SELECT t.AD_Tab_ID, t.AD_Window_ID, t.AD_Table_ID, t.Name, t.Description, 
    t.Help, t.SeqNo, t.IsSingleRow, t.HasTree, t.IsInfoTab, tbl.ReplicationType,
    tbl.TableName, tbl.AccessLevel, tbl.IsSecurityEnabled, tbl.IsDeleteable, 
    tbl.IsHighVolume, tbl.IsView, cast('N' as char) AS HasAssociation,
    t.IsTranslationTab, t.IsReadOnly, t.AD_Image_ID, t.TabLevel, 
    t.WhereClause, t.OrderByClause, t.CommitWarning, t.ReadOnlyLogic, t.DisplayLogic,
    t.AD_Column_ID, t.AD_Process_ID, t.IsSortTab, t.IsInsertRecord, t.IsAdvancedTab,
    t.AD_ColumnSortOrder_ID, t.AD_ColumnSortYesNo_ID, t.Included_Tab_ID, t.Parent_Column_ID,
    t.AD_Tab_UU, tbl.AD_Table_UU, t.TreeDisplayedOn, t.MaxQueryRecords,
    t.IsAllowAdvancedLookup, t.IsLookupOnlySelection
FROM AD_Tab t 
	INNER JOIN AD_Table tbl ON (t.AD_Table_ID = tbl.AD_Table_ID)
WHERE t.IsActive='Y'
  AND tbl.IsActive='Y'
;

CREATE OR REPLACE VIEW AD_TAB_VT
(AD_LANGUAGE, AD_TAB_ID, AD_WINDOW_ID, AD_TABLE_ID, NAME, 
 DESCRIPTION, HELP, SEQNO, ISSINGLEROW, HASTREE, 
 ISINFOTAB, REPLICATIONTYPE, TABLENAME, ACCESSLEVEL, ISSECURITYENABLED, 
 ISDELETEABLE, ISHIGHVOLUME, ISVIEW, HASASSOCIATION, ISTRANSLATIONTAB, 
 ISREADONLY, AD_IMAGE_ID, TABLEVEL, WHERECLAUSE, ORDERBYCLAUSE, 
 COMMITWARNING, READONLYLOGIC, DISPLAYLOGIC, AD_COLUMN_ID, AD_PROCESS_ID, 
 ISSORTTAB, ISINSERTRECORD, ISADVANCEDTAB, AD_COLUMNSORTORDER_ID, AD_COLUMNSORTYESNO_ID, 
 INCLUDED_TAB_ID, PARENT_COLUMN_ID, AD_Tab_UU, AD_Table_UU, TREEDISPLAYEDON,
 MAXQUERYRECORDS, IsAllowAdvancedLookup, IsLookupOnlySelection)
AS 
SELECT trl.AD_Language, t.AD_Tab_ID, t.AD_Window_ID, t.AD_Table_ID, trl.Name, trl.Description, 
    trl.Help, t.SeqNo, t.IsSingleRow, t.HasTree, t.IsInfoTab, tbl.ReplicationType,
    tbl.TableName, tbl.AccessLevel, tbl.IsSecurityEnabled, tbl.IsDeleteable, 
    tbl.IsHighVolume, tbl.IsView, cast('N' as char) AS HasAssociation,
    t.IsTranslationTab, t.IsReadOnly, t.AD_Image_ID, t.TabLevel, 
    t.WhereClause, t.OrderByClause, trl.CommitWarning, t.ReadOnlyLogic, t.DisplayLogic,
    t.AD_Column_ID, t.AD_Process_ID, t.IsSortTab, t.IsInsertRecord, t.IsAdvancedTab,
    t.AD_ColumnSortOrder_ID, t.AD_ColumnSortYesNo_ID, t.Included_Tab_ID, t.Parent_Column_ID,
    t.AD_Tab_UU, tbl.AD_Table_UU, t.TreeDisplayedOn, t.MaxQueryRecords,
    t.IsAllowAdvancedLookup, t.IsLookupOnlySelection
FROM AD_Tab t 
	INNER JOIN AD_Table tbl ON (t.AD_Table_ID = tbl.AD_Table_ID)
	INNER JOIN AD_Tab_Trl trl ON (t.AD_Tab_ID = trl.AD_Tab_ID)
WHERE t.IsActive='Y'
  AND tbl.IsActive='Y'
;


SELECT register_migration_script('202009111500_IDEMPIERE-3981.sql') FROM dual
;
