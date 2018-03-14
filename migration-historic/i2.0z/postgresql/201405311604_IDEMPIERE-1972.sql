-- May 31, 2014 10:33:25 AM ICT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (0,'N',0,211274,'N','N','N',0,'N',2000,'N','N','N','Y','f39fb481-a7f3-477b-924f-653478cf27b5','Y','DisplayLogic','If the Field is displayed, the result determines if the field is actually displayed','format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
@AD_Table_ID@=14 | @Language@!GERGER <br>
@PriceLimit@>10 | @PriceList@>@PriceActual@<br>
@Name@>J<br>
Strings may be in single quotes (optional)','Display Logic','Y',TO_TIMESTAMP('2014-05-31 10:33:19','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2014-05-31 10:33:19','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N','N',283,14,200129)
;

-- May 31, 2014 10:33:35 AM ICT
ALTER TABLE AD_InfoProcess ADD COLUMN DisplayLogic VARCHAR(2000) DEFAULT NULL 
;

-- May 31, 2014 10:35:29 AM ICT
INSERT INTO AD_Field (SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,Created) VALUES (0,'N',200142,0,'N','N',120,'Y',203050,'N','format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
@AD_Table_ID@=14 | @Language@!GERGER <br>
@PriceLimit@>10 | @PriceList@>@PriceActual@<br>
@Name@>J<br>
Strings may be in single quotes (optional)','If the Field is displayed, the result determines if the field is actually displayed','Display Logic','c6112319-f905-4614-a2ee-f27945e414be','Y','N',100,0,100,TO_TIMESTAMP('2014-05-31 10:35:23','YYYY-MM-DD HH24:MI:SS'),'Y','Y',60,1,'N',0,1,1,'N','N',211274,'D',TO_TIMESTAMP('2014-05-31 10:35:23','YYYY-MM-DD HH24:MI:SS'))
;

-- May 31, 2014 10:36:44 AM ICT
UPDATE AD_Field SET SeqNo=50,Updated=TO_TIMESTAMP('2014-05-31 10:36:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203035
;

-- May 31, 2014 10:36:44 AM ICT
UPDATE AD_Field SET SeqNo=60,Updated=TO_TIMESTAMP('2014-05-31 10:36:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203036
;

-- May 31, 2014 10:36:44 AM ICT
UPDATE AD_Field SET SeqNo=70,Updated=TO_TIMESTAMP('2014-05-31 10:36:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203037
;

-- May 31, 2014 10:36:44 AM ICT
UPDATE AD_Field SET SeqNo=80,Updated=TO_TIMESTAMP('2014-05-31 10:36:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203038
;

-- May 31, 2014 10:36:44 AM ICT
UPDATE AD_Field SET SeqNo=90, ColumnSpan=5,Updated=TO_TIMESTAMP('2014-05-31 10:36:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203050
;

-- May 31, 2014 10:39:24 AM ICT
UPDATE AD_Field SET SeqNo=90, NumLines=2,Updated=TO_TIMESTAMP('2014-05-31 10:39:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203050
;
SELECT register_migration_script('201405311604_IDEMPIERE-1972.sql') FROM dual
;
