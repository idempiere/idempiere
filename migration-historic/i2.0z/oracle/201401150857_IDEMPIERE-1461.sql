SET SQLBLANKLINES ON
SET DEFINE OFF

-- Nov 27, 2013 8:53:08 AM COT
-- IDEMPIERE-1461 POC for Zoom Logic
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Help,Name,Description,PrintName,AD_Element_UU,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('ZoomLogic',202629,'format := {expression} [{logic} {expression}]<br> 
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
Strings may be in single quotes (optional)','Zoom Logic','the result determines if the zoom condition is applied','Zoom Logic','3dafeed4-bdf0-4cbf-821a-834b0e39a8b0',TO_DATE('2013-11-27 08:53:07','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-11-27 08:53:07','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D')
;

-- Nov 27, 2013 8:55:19 AM COT
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure,FKConstraintType) VALUES (0,'N',0,200066,210891,'N','N','N',0,'N',2000,'N',14,'N','N','Y','fc45039d-0c87-49cc-9c50-b72d0e7a2c91','Y','ZoomLogic','the result determines if the zoom condition is applied','format := {expression} [{logic} {expression}]<br> 
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
Strings may be in single quotes (optional)','Zoom Logic','Y',TO_DATE('2013-11-27 08:55:18','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-11-27 08:55:18','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202629,'N','N')
;

-- Nov 27, 2013 8:55:23 AM COT
ALTER TABLE AD_ZoomCondition ADD ZoomLogic NVARCHAR2(2000) DEFAULT NULL 
;

-- Nov 27, 2013 8:55:39 AM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan) VALUES ('N',200077,36,'N','N',210683,100,'Y',202539,'N','D','AD_ZoomCondition_UU','99b8eae9-2a51-4985-8202-bd4ce28bccc2','N','N',100,0,TO_DATE('2013-11-27 08:55:38','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-11-27 08:55:38','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2)
;

-- Nov 27, 2013 8:55:39 AM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan,NumLines) VALUES ('N',200077,2000,'N','N',210891,110,'Y',202540,'N','format := {expression} [{logic} {expression}]<br> 
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
Strings may be in single quotes (optional)','D','the result determines if the zoom condition is applied','Zoom Logic','bcc492c0-652c-4900-a6fd-514d9e385cf2','Y','N',100,0,TO_DATE('2013-11-27 08:55:39','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-11-27 08:55:39','YYYY-MM-DD HH24:MI:SS'),'Y',0,5,3)
;

-- Nov 27, 2013 8:56:59 AM COT
UPDATE AD_Field SET SeqNo=10, ColumnSpan=2,Updated=TO_DATE('2013-11-27 08:56:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201829
;

-- Nov 27, 2013 8:56:59 AM COT
UPDATE AD_Field SET SeqNo=20, IsDisplayed='Y', XPosition=4, ColumnSpan=2,Updated=TO_DATE('2013-11-27 08:56:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201834
;

-- Nov 27, 2013 8:56:59 AM COT
UPDATE AD_Field SET SeqNo=30, ColumnSpan=2,Updated=TO_DATE('2013-11-27 08:56:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201836
;

-- Nov 27, 2013 8:56:59 AM COT
UPDATE AD_Field SET SeqNo=40, ColumnSpan=2,Updated=TO_DATE('2013-11-27 08:56:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202339
;

-- Nov 27, 2013 8:56:59 AM COT
UPDATE AD_Field SET SeqNo=50, ColumnSpan=5,Updated=TO_DATE('2013-11-27 08:56:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202338
;

-- Nov 27, 2013 8:56:59 AM COT
UPDATE AD_Field SET SeqNo=60, ColumnSpan=5,Updated=TO_DATE('2013-11-27 08:56:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201831
;

-- Nov 27, 2013 8:56:59 AM COT
UPDATE AD_Field SET SeqNo=70, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2013-11-27 08:56:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202540
;

-- Nov 27, 2013 8:56:59 AM COT
UPDATE AD_Field SET SeqNo=80, IsDisplayed='Y', XPosition=1, ColumnSpan=5,Updated=TO_DATE('2013-11-27 08:56:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202337
;

-- Nov 27, 2013 8:56:59 AM COT
UPDATE AD_Field SET SeqNo=90, IsDisplayed='Y', XPosition=1, ColumnSpan=2,Updated=TO_DATE('2013-11-27 08:56:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201837
;

-- Nov 27, 2013 8:56:59 AM COT
UPDATE AD_Field SET SeqNo=100, IsDisplayed='Y', XPosition=5, ColumnSpan=2,Updated=TO_DATE('2013-11-27 08:56:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201828
;

-- Nov 27, 2013 8:56:59 AM COT
UPDATE AD_Field SET SeqNo=0,Updated=TO_DATE('2013-11-27 08:56:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202539
;

-- Nov 27, 2013 9:00:21 AM COT
UPDATE AD_Column SET IsMandatory='N',Updated=TO_DATE('2013-11-27 09:00:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210659
;

-- Nov 27, 2013 9:00:23 AM COT
ALTER TABLE AD_ZoomCondition MODIFY WhereClause NVARCHAR2(2000) DEFAULT NULL 
;

-- Nov 27, 2013 9:00:23 AM COT
ALTER TABLE AD_ZoomCondition MODIFY WhereClause NULL
;

SELECT register_migration_script('201401150857_IDEMPIERE-1461.sql') FROM dual
;

