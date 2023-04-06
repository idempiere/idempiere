-- IDEMPIERE-3334 Adding support for Readonly Logic, Set Pressed Logic on custom toolbar button
-- Apr 7, 2017 9:46:15 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212976,0,'Read Only Logic','Logic to determine if field is read only (applies only when field is read-write)','format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples:  <br>
<ul>
<li> @AD_Table_ID@=14 | @Language@!GERGER</li>
<li> @PriceLimit@>10 | @PriceList@>@PriceActual@</li>
<li> @Name@>J</li>
</ul>
Strings may be in single quotes (optional)',200003,'ReadOnlyLogic',2000,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_TIMESTAMP('2017-04-07 09:46:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-07 09:46:14','YYYY-MM-DD HH24:MI:SS'),100,1663,'Y','N','D','N','N','N','Y','2c970c5d-b093-4b8a-b7df-da5260cb3afc','Y',0,'N','N')
;

-- Apr 7, 2017 9:46:25 AM IST
ALTER TABLE AD_ToolBarButton ADD COLUMN ReadOnlyLogic VARCHAR(2000) DEFAULT NULL 
;

-- Apr 7, 2017 9:47:37 AM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203068,0,0,'Y',TO_TIMESTAMP('2017-04-07 09:47:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-07 09:47:36','YYYY-MM-DD HH24:MI:SS'),100,'PressedLogic','Pressed Logic','Pressed Logic','D','3e4c5b2b-2b91-400f-8e18-fd1aee4627ff')
;

-- Apr 7, 2017 9:47:52 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212977,0,'Pressed Logic',200003,'PressedLogic',2000,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_TIMESTAMP('2017-04-07 09:47:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-07 09:47:51','YYYY-MM-DD HH24:MI:SS'),100,203068,'Y','N','D','N','N','N','Y','e7df64af-a5db-4469-9620-d1008f2b6ae6','Y',0,'N','N')
;

-- Apr 7, 2017 9:47:53 AM IST
ALTER TABLE AD_ToolBarButton ADD COLUMN PressedLogic VARCHAR(2000) DEFAULT NULL 
;

-- Apr 7, 2017 9:48:42 AM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (204384,'Pressed Logic',200002,212977,'Y','@IsCustomization@=Y',0,130,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-04-07 09:48:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-07 09:48:40','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','fe0b2b2f-8f24-46d9-b497-c7fdbc6df87e','Y',130,1,1,1,'N','N','N')
;

-- Apr 7, 2017 9:49:03 AM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (204385,'Read Only Logic','Logic to determine if field is read only (applies only when field is read-write)','format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples:  <br>
<ul>
<li> @AD_Table_ID@=14 | @Language@!GERGER</li>
<li> @PriceLimit@>10 | @PriceList@>@PriceActual@</li>
<li> @Name@>J</li>
</ul>
Strings may be in single quotes (optional)',200002,212976,'Y','@IsCustomization@=Y',0,140,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-04-07 09:49:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-07 09:49:00','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d721042e-1aa8-4c00-8c8c-615b7202bc7a','Y',140,1,1,1,'N','N','N')
;

-- Apr 7, 2017 9:49:33 AM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, ColumnSpan=5, NumLines=3, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-04-07 09:49:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204384
;

-- Apr 7, 2017 9:49:33 AM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, ColumnSpan=5, NumLines=3, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-04-07 09:49:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204385
;

-- Apr 7, 2017 9:49:33 AM IST
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-04-07 09:49:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202546
;

-- Apr 7, 2017 9:49:33 AM IST
UPDATE AD_Field SET SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-04-07 09:49:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202547
;


-- Nov 17, 2022, 4:48:50 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm,DisplayLogic) VALUES (207419,'Pressed Logic',200028,212977,'Y',0,110,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-11-17 16:48:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-11-17 16:48:49','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','9105d7d0-5208-4c49-ae06-69eb62367f81','Y',90,1,5,3,'N','N','N','N',NULL)
;

-- Nov 17, 2022, 4:49:18 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm,DisplayLogic) VALUES (207420,'Read Only Logic','Logic to determine if field is read only (applies only when field is read-write)','format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := {|}|{&}<br>
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
Strings may be in single quotes (optional)',200028,212976,'Y',0,120,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-11-17 16:49:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-11-17 16:49:17','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','766bf507-7d6b-4e17-b95a-1d6acb73da51','Y',100,1,5,3,'N','N','N','N',NULL)
;

SELECT register_migration_script('202211091000_IDEMPIERE-3334.sql') FROM dual
;

