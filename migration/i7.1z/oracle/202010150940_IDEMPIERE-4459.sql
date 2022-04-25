SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4459
-- Oct 15, 2020, 9:38:15 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214326,0,'Display Logic','If the Field is displayed, the result determines if the field is actually displayed','format := {expression} [{logic} {expression}]<br> 
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
Strings may be in single quotes (optional)',200089,'DisplayLogic',2000,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_DATE('2020-10-15 09:38:15','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-15 09:38:15','YYYY-MM-DD HH24:MI:SS'),100,283,'Y','N','D','N','N','N','Y','835e7d84-da0d-448f-b851-d03203219fe2','Y',0,'N','N','N','N')
;

-- Oct 15, 2020, 9:38:27 AM CEST
ALTER TABLE AD_InfoRelated ADD DisplayLogic VARCHAR2(2000 CHAR) DEFAULT NULL 
;

-- Oct 15, 2020, 9:39:16 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan,NumLines) VALUES (206520,'Display Logic','If the Field is displayed, the result determines if the field is actually displayed','format := {expression} [{logic} {expression}]<br> 
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
Strings may be in single quotes (optional)',200100,214326,'Y',2000,130,'N','N','N','N',0,0,'Y',TO_DATE('2020-10-15 09:39:16','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-15 09:39:16','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6ba1b12a-abbb-4e56-92ea-2391ffa6e5fb','Y',100,5,3)
;

-- Oct 15, 2020, 6:39:04 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, ColumnSpan=5, NumLines=1, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-15 18:39:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206500
;

-- Oct 15, 2020, 6:39:27 PM CEST
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, NumLines=1, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-15 18:39:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206520
;

SELECT register_migration_script('202010150940_IDEMPIERE-4459.sql') FROM dual
;
