SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3996 Implement DisplayLogic for PrintFormatItem
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,AD_Element_ID,AD_Table_ID,AD_Reference_ID) VALUES (212961,0,'N',0,'N','N','N',0,'N',2000,'N','N','N','Y','932e491f-ae59-4081-b774-6e4e50a7426a',TO_DATE('2017-01-23 17:20:33','YYYY-MM-DD HH24:MI:SS'),'Y','DisplayLogic','If the Field is displayed, the result determines if the field is actually displayed','format := {expression} [{logic} {expression}]<br> 
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
Strings may be in single quotes (optional)','Display Logic','Y','Y',100,100,'N','N',0,0,TO_DATE('2017-01-23 17:20:33','YYYY-MM-DD HH24:MI:SS'),'D','N','N',283,489,14)
;

ALTER TABLE AD_PrintFormatItem ADD DisplayLogic VARCHAR2(2000) DEFAULT NULL 
;

INSERT INTO AD_Field (SortNo,AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (0,204366,'N',0,'N','N',415,'Y','N','format := {expression} [{logic} {expression}]<br> 
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
Strings may be in single quotes (optional)',0,TO_DATE('2017-01-23 17:23:21','YYYY-MM-DD HH24:MI:SS'),'If the Field is displayed, the result determines if the field is actually displayed','Display Logic','559f985c-2b0d-4b10-a05d-d0b54371f075','Y','N',100,100,'Y','Y',415,1,'N',0,TO_DATE('2017-01-23 17:23:21','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',212961,'D',426)
;

SELECT register_migration_script('201906261250_IDEMPIERE-3996.sql') FROM dual
;

