SET SQLBLANKLINES ON
SET DEFINE OFF

-- Nov 20, 2012 10:23:24 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (0,'N','N',0,107,200945,'D',319,'N','N','N',0,'N',1,'N',17,'N',422,'N','Y','322001b2-6cd1-48b1-95c9-3505a8d5b2cc','Y','N','IsUpdateable','Determines, if the field can be updated','Y','The Updatable checkbox indicates if a field can be updated by the user.','Updatable','Y',TO_DATE('2012-11-20 10:23:23','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2012-11-20 10:23:23','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Nov 20, 2012 10:23:24 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200945 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 20, 2012 10:25:37 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (0,'N','N',0,107,200946,'D',319,'N','N','N',0,'N',1,'N',17,'N',2468,'N','Y','11acfc29-8d0c-41d0-9b55-d6bc9ed0efc5','Y','N','IsAlwaysUpdateable','The column is always updateable, even if the record is not active or processed','N','If selected and if the window / tab is not read only, you can always update the column.  This might be useful for comments, etc.','Always Updateable','Y',TO_DATE('2012-11-20 10:25:36','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2012-11-20 10:25:36','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Nov 20, 2012 10:25:37 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200946 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 20, 2012 10:27:09 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (0,'N','N',0,107,200947,'D','N','N','N',0,'N',2000,'N',14,'N',50074,'N','Y','05b02875-be4b-4b02-8e64-0a2e5f691b30','Y','N','MandatoryLogic','Mandatory Logic','Y',TO_DATE('2012-11-20 10:27:08','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2012-11-20 10:27:08','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Nov 20, 2012 10:27:09 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200947 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 20, 2012 10:28:40 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (0,'N','N',0,107,200948,'D','N','N','N',0,'N',2000,'N',14,'N',1663,'N','Y','fa2aef1e-7608-469a-a5ad-b59da47a1bdc','Y','N','ReadOnlyLogic','Logic to determine if field is read only (applies only when field is read-write)','format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
\@AD_Table_ID@=14 | @Language@!GERGER <br>
\@PriceLimit@>10 | @PriceList@>@PriceActual@<br>
\@Name@>J<br>
Strings may be in single quotes (optional)','Read Only Logic','Y',TO_DATE('2012-11-20 10:28:39','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2012-11-20 10:28:39','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Nov 20, 2012 10:28:40 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200948 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 20, 2012 10:29:59 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (0,'N','N',0,107,200949,'D',319,'N','N','N',0,'N',1,'N',17,'N',200187,'N','Y','380dff82-a310-4d2a-b338-37c7fbac5cd0','Y','N','IsToolbarButton','Add the column button to the toolbar','Y','There IsToolbarButton check box indicates if this column button is part of the toolbar''s process button popup list or render as field.','Toolbar Button','Y',TO_DATE('2012-11-20 10:29:58','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2012-11-20 10:29:58','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Nov 20, 2012 10:29:59 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200949 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 20, 2012 10:31:09 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
ALTER TABLE AD_Field ADD IsUpdateable CHAR(1) DEFAULT NULL
;

-- Nov 20, 2012 10:31:25 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
ALTER TABLE AD_Field ADD IsAlwaysUpdateable CHAR(1) DEFAULT NULL
;

-- Nov 20, 2012 10:31:42 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
ALTER TABLE AD_Field ADD MandatoryLogic NVARCHAR2(2000) DEFAULT NULL 
;

-- Nov 20, 2012 10:31:55 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
ALTER TABLE AD_Field ADD ReadOnlyLogic NVARCHAR2(2000) DEFAULT NULL 
;

-- Nov 20, 2012 10:32:14 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
ALTER TABLE AD_Field ADD IsToolbarButton CHAR(1) DEFAULT NULL
;

-- Nov 20, 2012 10:34:08 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',107,1,'N','N',200946,'Y',200834,'N','If selected and if the window / tab is not read only, you can always update the column.  This might be useful for comments, etc.','D','The column is always updateable, even if the record is not active or processed','Always Updateable','cf3cb628-3c15-4ce8-ace9-0275dd0b2bf4','Y','N',100,0,TO_DATE('2012-11-20 10:34:07','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-20 10:34:07','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 20, 2012 10:34:08 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200834 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 20, 2012 10:34:09 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',107,2000,'N','N',200947,'Y',200835,'N','D','Mandatory Logic','d4b711de-c2d0-4de1-b304-9e340e3eac1b','Y','N',100,0,TO_DATE('2012-11-20 10:34:08','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-20 10:34:08','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 20, 2012 10:34:09 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200835 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 20, 2012 10:34:09 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',107,2000,'N','N',200948,'Y',200836,'N','format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
\@AD_Table_ID@=14 | @Language@!GERGER <br>
\@PriceLimit@>10 | @PriceList@>@PriceActual@<br>
\@Name@>J<br>
Strings may be in single quotes (optional)','D','Logic to determine if field is read only (applies only when field is read-write)','Read Only Logic','735d01aa-e36e-414f-a694-8aa158bc710d','Y','N',100,0,TO_DATE('2012-11-20 10:34:09','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-20 10:34:09','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 20, 2012 10:34:09 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200836 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 20, 2012 10:34:10 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',107,1,'N','N',200949,'Y',200837,'N','There IsToolbarButton check box indicates if this column button is part of the toolbar''s process button popup list or render as field.','D','Add the column button to the toolbar','Toolbar Button','1b7d74f1-710f-42c9-899c-8bd656345be7','Y','N',100,0,TO_DATE('2012-11-20 10:34:09','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-20 10:34:09','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 20, 2012 10:34:10 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200837 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 20, 2012 10:34:10 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',107,1,'N','N',200945,'Y',200838,'N','The Updatable checkbox indicates if a field can be updated by the user.','D','Determines, if the field can be updated','Updatable','4e815d13-e435-449c-bd31-3fb1321e3273','Y','N',100,0,TO_DATE('2012-11-20 10:34:10','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-20 10:34:10','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 20, 2012 10:34:10 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200838 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 20, 2012 10:41:56 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET SeqNo=80,Updated=TO_DATE('2012-11-20 10:41:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=130
;

-- Nov 20, 2012 10:41:56 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET SeqNo=90,Updated=TO_DATE('2012-11-20 10:41:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5808
;

-- Nov 20, 2012 10:41:56 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET SeqNo=100,Updated=TO_DATE('2012-11-20 10:41:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4259
;

-- Nov 20, 2012 10:41:56 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET SeqNo=110,Updated=TO_DATE('2012-11-20 10:41:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1551
;

-- Nov 20, 2012 10:41:56 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET SeqNo=120,Updated=TO_DATE('2012-11-20 10:41:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=132
;

-- Nov 20, 2012 10:41:56 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET SeqNo=130,Updated=TO_DATE('2012-11-20 10:41:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200276
;

-- Nov 20, 2012 10:41:56 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET SeqNo=140,Updated=TO_DATE('2012-11-20 10:41:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=924
;

-- Nov 20, 2012 10:41:56 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET ColumnSpan=5, NumLines=3, SeqNo=150, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2012-11-20 10:41:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200836
;

-- Nov 20, 2012 10:41:56 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET ColumnSpan=2, SeqNo=270, IsDisplayed='Y', XPosition=4,Updated=TO_DATE('2012-11-20 10:41:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200834
;

-- Nov 20, 2012 10:41:56 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET SeqNo=280, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2012-11-20 10:41:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13424
;

-- Nov 20, 2012 10:41:56 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET SeqNo=290, IsDisplayed='Y', XPosition=4,Updated=TO_DATE('2012-11-20 10:41:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200838
;

-- Nov 20, 2012 10:41:56 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET SeqNo=300, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2012-11-20 10:41:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=62468
;

-- Nov 20, 2012 10:41:56 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET SeqNo=310, IsDisplayed='Y', XPosition=4,Updated=TO_DATE('2012-11-20 10:41:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200837
;

-- Nov 20, 2012 10:41:56 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET ColumnSpan=5, NumLines=3, SeqNo=320, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2012-11-20 10:41:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200835
;

-- Nov 20, 2012 10:41:56 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET SeqNo=330,Updated=TO_DATE('2012-11-20 10:41:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53280
;

-- Nov 20, 2012 10:41:56 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET SeqNo=340,Updated=TO_DATE('2012-11-20 10:41:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200275
;

-- Nov 20, 2012 10:41:56 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET SeqNo=350,Updated=TO_DATE('2012-11-20 10:41:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200771
;

-- Nov 20, 2012 10:41:56 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET SeqNo=360,Updated=TO_DATE('2012-11-20 10:41:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=136
;

-- Nov 20, 2012 10:41:56 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET SeqNo=370,Updated=TO_DATE('2012-11-20 10:41:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=139
;

-- Nov 20, 2012 10:41:56 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET SeqNo=380,Updated=TO_DATE('2012-11-20 10:41:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200350
;

-- Nov 20, 2012 10:41:57 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET SeqNo=390,Updated=TO_DATE('2012-11-20 10:41:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200348
;

-- Nov 20, 2012 10:41:57 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET SeqNo=400,Updated=TO_DATE('2012-11-20 10:41:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200349
;

-- Nov 20, 2012 10:52:45 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (0,'N','N',0,464,200950,'D',319,'N','N','N',0,'N',1,'N',17,'N',2468,'N','Y','c15fad16-44e0-45f3-bad6-59fe05a0fba2','Y','N','IsAlwaysUpdateable','The column is always updateable, even if the record is not active or processed','N','If selected and if the window / tab is not read only, you can always update the column.  This might be useful for comments, etc.','Always Updateable','Y',TO_DATE('2012-11-20 10:52:44','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2012-11-20 10:52:44','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Nov 20, 2012 10:52:45 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200950 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 20, 2012 10:53:35 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (0,'N','N',0,464,200951,'D','N','N','N',0,'N',2000,'N',14,'N',50074,'N','Y','cc4f018d-8a72-44ba-a331-8f060b451f49','Y','N','MandatoryLogic','Mandatory Logic','Y',TO_DATE('2012-11-20 10:53:34','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2012-11-20 10:53:34','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Nov 20, 2012 10:53:35 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200951 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 20, 2012 10:54:21 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (0,'N','N',0,464,200952,'D','N','N','N',0,'N',2000,'N',14,'N',1663,'N','Y','31667b0e-a034-482b-88b5-c92b02a55eb4','Y','N','ReadOnlyLogic','Logic to determine if field is read only (applies only when field is read-write)','format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
\@AD_Table_ID@=14 | @Language@!GERGER <br>
\@PriceLimit@>10 | @PriceList@>@PriceActual@<br>
\@Name@>J<br>
Strings may be in single quotes (optional)','Read Only Logic','Y',TO_DATE('2012-11-20 10:54:20','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2012-11-20 10:54:20','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Nov 20, 2012 10:54:21 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200952 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 20, 2012 10:56:34 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (0,'N','N',0,464,200953,'D',4,'N','N','N',0,'N',22,'N',18,115,'N',121,'N','Y','e23e4239-f209-4a8a-8aeb-bf3740f6c849','Y','N','AD_Reference_Value_ID','Required to specify, if data type is Table or List','The Reference Value indicates where the reference values are stored.  It must be specified if the data type is Table or List.  ','Reference Key','Y',TO_DATE('2012-11-20 10:56:33','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2012-11-20 10:56:33','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Nov 20, 2012 10:56:34 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200953 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 20, 2012 10:57:29 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (0,'N','N',0,464,200954,'D',319,'N','N','N',0,'N',1,'N',17,'N',392,'N','Y','9d2512c0-51ac-410f-87a5-273c8f2a07d8','Y','N','IsMandatory','Data entry is required in this column','The field must have a value for the record to be saved to the database.','Mandatory','Y',TO_DATE('2012-11-20 10:57:28','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2012-11-20 10:57:28','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Nov 20, 2012 10:57:29 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200954 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 20, 2012 10:58:31 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (0,'N','N',0,464,200955,'D','N','N','N',0,'N',10,'N',11,'N',1810,'N','Y','f0cfce31-5e3f-42cc-9c8b-d9f5476472af','Y','N','XPosition','Absolute X (horizontal) position in 1/72 of an inch','1','Absolute X (horizontal) position in 1/72 of an inch','X Position','Y',TO_DATE('2012-11-20 10:58:30','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2012-11-20 10:58:30','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Nov 20, 2012 10:58:31 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200955 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 20, 2012 10:59:37 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (0,'N','N',0,464,200956,'D','N','N','N',0,'N',10,'N',11,'N',200099,'N','Y','6580f465-df1d-4d26-8140-4d3d898b1695','Y','N','NumLines','Number of lines for a field','1','Number of lines for a field','Number of Lines','Y',TO_DATE('2012-11-20 10:59:36','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2012-11-20 10:59:36','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Nov 20, 2012 10:59:37 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200956 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 20, 2012 11:00:28 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (0,'N','N',0,464,200957,'D','N','N','N',0,'N',10,'N',11,'N',200098,'N','Y','22679939-1059-4656-9d76-12bc8adf2cc3','Y','N','ColumnSpan','Number of column for a box of field','1','Column Span','Y',TO_DATE('2012-11-20 11:00:27','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2012-11-20 11:00:27','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Nov 20, 2012 11:00:28 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200957 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 20, 2012 11:01:47 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (0,'N','N',0,464,200958,'D',319,'N','N','N',0,'N',1,'N',17,'N',200187,'N','Y','7cb0302c-bfb7-4900-9a26-532115c47d6b','Y','N','IsToolbarButton','Add the column button to the toolbar','Y','There IsToolbarButton check box indicates if this column button is part of the toolbar''s process button popup list or render as field.','Toolbar Button','Y',TO_DATE('2012-11-20 11:01:46','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2012-11-20 11:01:46','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Nov 20, 2012 11:01:47 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200958 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 20, 2012 11:02:36 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
ALTER TABLE AD_UserDef_Field ADD IsAlwaysUpdateable CHAR(1) DEFAULT NULL
;

-- Nov 20, 2012 11:02:52 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
ALTER TABLE AD_UserDef_Field ADD MandatoryLogic NVARCHAR2(2000) DEFAULT NULL 
;

-- Nov 20, 2012 11:03:06 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
ALTER TABLE AD_UserDef_Field ADD ReadOnlyLogic NVARCHAR2(2000) DEFAULT NULL 
;

-- Nov 20, 2012 11:03:23 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
ALTER TABLE AD_UserDef_Field ADD AD_Reference_Value_ID NUMBER(10) DEFAULT NULL 
;

-- Nov 20, 2012 11:03:40 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
ALTER TABLE AD_UserDef_Field ADD IsMandatory CHAR(1) DEFAULT NULL 
;

-- Nov 20, 2012 11:03:57 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
ALTER TABLE AD_UserDef_Field ADD XPosition NUMBER(10) DEFAULT NULL
;

-- Nov 20, 2012 11:04:13 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
ALTER TABLE AD_UserDef_Field ADD NumLines NUMBER(10) DEFAULT NULL
;

-- Nov 20, 2012 11:04:25 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
ALTER TABLE AD_UserDef_Field ADD ColumnSpan NUMBER(10) DEFAULT NULL
;

-- Nov 20, 2012 11:04:42 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
ALTER TABLE AD_UserDef_Field ADD IsToolbarButton CHAR(1) DEFAULT NULL
;

-- Nov 20, 2012 11:07:13 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',395,36,'N','N',60530,'Y',200848,'N','D','AD_UserDef_Field_UU','acb689b0-0b6d-43cb-b792-3dc106740640','Y','N',100,0,TO_DATE('2012-11-20 11:07:12','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-20 11:07:12','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 20, 2012 11:07:13 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200848 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 20, 2012 11:07:14 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',395,1,'N','N',200950,'Y',200849,'N','If selected and if the window / tab is not read only, you can always update the column.  This might be useful for comments, etc.','D','The column is always updateable, even if the record is not active or processed','Always Updateable','2f360b2b-148a-4682-8e3d-73c670f47597','Y','N',100,0,TO_DATE('2012-11-20 11:07:13','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-20 11:07:13','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 20, 2012 11:07:14 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200849 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 20, 2012 11:07:15 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',395,10,'N','N',200957,'Y',200850,'N','D','Number of column for a box of field','Column Span','76af747a-9278-4f90-b03b-b40d041c705b','Y','N',100,0,TO_DATE('2012-11-20 11:07:14','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-20 11:07:14','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 20, 2012 11:07:15 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200850 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 20, 2012 11:07:15 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',395,1,'N','N',200954,'Y',200851,'N','The field must have a value for the record to be saved to the database.','D','Data entry is required in this column','Mandatory','40f3d314-2bf3-41f6-b1bc-8eff6f01e909','Y','N',100,0,TO_DATE('2012-11-20 11:07:15','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-20 11:07:15','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 20, 2012 11:07:15 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200851 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 20, 2012 11:07:16 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',395,2000,'N','N',200951,'Y',200852,'N','D','Mandatory Logic','1bd15b5f-d46d-42be-9904-d60fd01bc5f2','Y','N',100,0,TO_DATE('2012-11-20 11:07:15','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-20 11:07:15','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 20, 2012 11:07:16 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200852 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 20, 2012 11:07:16 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',395,10,'N','N',200956,'Y',200853,'N','Number of lines for a field','D','Number of lines for a field','Number of Lines','28229856-2b06-4788-b1ec-0790477e744f','Y','N',100,0,TO_DATE('2012-11-20 11:07:16','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-20 11:07:16','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 20, 2012 11:07:16 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200853 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 20, 2012 11:07:17 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',395,2000,'N','N',200952,'Y',200854,'N','format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
\@AD_Table_ID@=14 | @Language@!GERGER <br>
\@PriceLimit@>10 | @PriceList@>@PriceActual@<br>
\@Name@>J<br>
Strings may be in single quotes (optional)','D','Logic to determine if field is read only (applies only when field is read-write)','Read Only Logic','e744a943-39ab-49c1-8ed2-5fb8ea367a1d','Y','N',100,0,TO_DATE('2012-11-20 11:07:16','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-20 11:07:16','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 20, 2012 11:07:17 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200854 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 20, 2012 11:07:17 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',395,22,'N','N',200953,'Y',200855,'N','The Reference Value indicates where the reference values are stored.  It must be specified if the data type is Table or List.  ','D','Required to specify, if data type is Table or List','Reference Key','3ba09cfb-d887-46d1-89be-53bc78496bca','Y','N',100,0,TO_DATE('2012-11-20 11:07:17','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-20 11:07:17','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 20, 2012 11:07:17 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200855 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 20, 2012 11:07:18 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',395,1,'N','N',200958,'Y',200856,'N','There IsToolbarButton check box indicates if this column button is part of the toolbar''s process button popup list or render as field.','D','Add the column button to the toolbar','Toolbar Button','b0e1932a-90e6-4b3c-a9e1-ff78bfbafb31','Y','N',100,0,TO_DATE('2012-11-20 11:07:17','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-20 11:07:17','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 20, 2012 11:07:18 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200856 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 20, 2012 11:07:18 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',395,10,'N','N',200955,'Y',200857,'N','Absolute X (horizontal) position in 1/72 of an inch','D','Absolute X (horizontal) position in 1/72 of an inch','X Position','fb9b7e57-2d10-4f71-86c4-aa81635e2bcf','Y','N',100,0,TO_DATE('2012-11-20 11:07:18','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-20 11:07:18','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 20, 2012 11:07:18 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200857 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 20, 2012 11:18:15 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET NumLines=3, SeqNo=100,Updated=TO_DATE('2012-11-20 11:18:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5052
;

-- Nov 20, 2012 11:18:15 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET SeqNo=110, IsDisplayed='Y', XPosition=2,Updated=TO_DATE('2012-11-20 11:18:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5053
;

-- Nov 20, 2012 11:18:15 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET SeqNo=120, IsDisplayed='Y', XPosition=5,Updated=TO_DATE('2012-11-20 11:18:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5054
;

-- Nov 20, 2012 11:18:15 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET ColumnSpan=5, NumLines=3, SeqNo=130, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2012-11-20 11:18:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200854
;

-- Nov 20, 2012 11:18:15 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET ColumnSpan=2, SeqNo=150, IsDisplayed='Y', XPosition=4,Updated=TO_DATE('2012-11-20 11:18:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200849
;

-- Nov 20, 2012 11:18:15 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET ColumnSpan=2, SeqNo=170, IsDisplayed='Y', XPosition=4,Updated=TO_DATE('2012-11-20 11:18:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200851
;

-- Nov 20, 2012 11:18:15 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET ColumnSpan=2, SeqNo=180, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2012-11-20 11:18:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200855
;

-- Nov 20, 2012 11:18:15 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET ColumnSpan=2, SeqNo=190, IsDisplayed='Y', XPosition=4,Updated=TO_DATE('2012-11-20 11:18:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200856
;

-- Nov 20, 2012 11:18:15 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET ColumnSpan=5, NumLines=3, SeqNo=200, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2012-11-20 11:18:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200852
;

-- Nov 20, 2012 11:18:15 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET NumLines=3, SeqNo=210, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2012-11-20 11:18:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11252
;

-- Nov 20, 2012 11:18:15 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET SeqNo=220, AD_FieldGroup_ID=200000, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2012-11-20 11:18:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5051
;

-- Nov 20, 2012 11:18:15 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET SeqNo=230, AD_FieldGroup_ID=200000, IsDisplayed='Y', XPosition=5,Updated=TO_DATE('2012-11-20 11:18:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5057
;

-- Nov 20, 2012 11:18:15 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET ColumnSpan=2, SeqNo=240, AD_FieldGroup_ID=200001, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2012-11-20 11:18:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200857
;

-- Nov 20, 2012 11:18:15 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET ColumnSpan=2, SeqNo=250, AD_FieldGroup_ID=200001, IsDisplayed='Y', XPosition=4,Updated=TO_DATE('2012-11-20 11:18:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200850
;

-- Nov 20, 2012 11:18:15 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET ColumnSpan=2, SeqNo=260, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2012-11-20 11:18:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200853
;

-- Nov 20, 2012 11:18:15 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET SeqNo=0, IsDisplayed='N', XPosition=1,Updated=TO_DATE('2012-11-20 11:18:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200848
;

-- Nov 20, 2012 11:28:00 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
CREATE OR REPLACE VIEW AD_FIELD_V AS
  SELECT t.AD_Window_ID, f.AD_Tab_ID, f.AD_Field_ID, tbl.AD_Table_ID, f.AD_Column_ID,
 f.NAME, f.Description, f.Help, f.IsDisplayed, f.DisplayLogic, f.DisplayLength,
 f.SeqNo, f.SortNo, f.IsSameLine, f.IsHeading, f.IsFieldOnly, f.IsReadOnly,
 f.IsEncrypted AS IsEncryptedField, f.ObscureType,
 c.ColumnName, c.ColumnSQL, c.FieldLength, c.VFormat,
 COALESCE(f.DefaultValue, c.DefaultValue) AS DefaultValue,
 c.IsKey, c.IsParent,
 COALESCE(f.IsMandatory, c.IsMandatory) AS IsMandatory,
    c.IsIdentifier, c.IsTranslated, COALESCE(f.AD_Reference_Value_ID, c.AD_Reference_Value_ID) AS AD_Reference_Value_ID,
 c.Callout, COALESCE(f.AD_Reference_ID, c.AD_Reference_ID) AS AD_Reference_ID,
    COALESCE(f.AD_Val_Rule_ID, c.AD_Val_Rule_ID) AS AD_Val_Rule_ID, c.AD_Process_ID,
 COALESCE(f.Isalwaysupdateable , C.Isalwaysupdateable) As Isalwaysupdateable,
 COALESCE(f.Readonlylogic,  c.Readonlylogic ) As Readonlylogic,
 COALESCE(f.Mandatorylogic , C.Mandatorylogic) As Mandatorylogic,
 COALESCE(f.isupdateable, c.isupdateable) AS isupdateable, c.IsEncrypted AS IsEncryptedColumn,
    c.IsSelectionColumn,
 tbl.TableName, c.ValueMin, c.ValueMax,
 fg.NAME AS FieldGroup, vr.Code AS ValidationCode,
 f.Included_Tab_ID, fg.FieldGroupType, fg.IsCollapsedByDefault,
 COALESCE(f.InfoFactoryClass, c.InfoFactoryClass) as InfoFactoryClass,
 c.IsAutocomplete, COALESCE(f.IsAllowCopy, c.IsAllowCopy) AS IsAllowCopy,
        f.isdisplayedgrid,
        f.seqnogrid,
        c.seqnoselection, f.xposition, f.columnspan, f.numlines,
 COALESCE(f.istoolbarbutton , c.istoolbarbutton ) As istoolbarbutton
FROM AD_FIELD f
  INNER JOIN AD_TAB t ON (f.AD_Tab_ID = t.AD_Tab_ID)
  LEFT OUTER JOIN AD_FIELDGROUP fg ON (f.AD_FieldGroup_ID = fg.AD_FieldGroup_ID)
  LEFT OUTER JOIN AD_COLUMN c ON (f.AD_Column_ID = c.AD_Column_ID)
 INNER JOIN AD_TABLE tbl ON (c.AD_Table_ID = tbl.AD_Table_ID)
 LEFT OUTER JOIN AD_VAL_RULE vr ON (vr.AD_Val_Rule_ID = COALESCE(f.AD_Val_Rule_ID, c.AD_Val_Rule_ID))
WHERE f.IsActive = 'Y'
  AND c.IsActive = 'Y';

-- Nov 20, 2012 11:28:00 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
CREATE OR REPLACE VIEW AD_FIELD_VT AS
    SELECT trl.AD_LANGUAGE, t.AD_Window_ID, f.AD_Tab_ID, f.AD_Field_ID, tbl.AD_Table_ID, f.AD_Column_ID,
   trl.NAME, trl.Description, trl.Help, f.IsDisplayed, f.DisplayLogic, f.DisplayLength,
   f.SeqNo, f.SortNo, f.IsSameLine, f.IsHeading, f.IsFieldOnly, f.IsReadOnly,
   f.IsEncrypted AS IsEncryptedField, f.ObscureType,
   c.ColumnName, c.ColumnSQL, c.FieldLength, c.VFormat,
   COALESCE(f.DefaultValue, c.DefaultValue) AS DefaultValue,
   c.IsKey, c.IsParent,
   COALESCE(f.IsMandatory, c.IsMandatory) AS IsMandatory,
      c.IsIdentifier, c.IsTranslated, COALESCE(f.AD_Reference_Value_ID, c.AD_Reference_Value_ID) AS AD_Reference_Value_ID,
   c.Callout, COALESCE(f.AD_Reference_ID, c.AD_Reference_ID) AS AD_Reference_ID,
      COALESCE(f.AD_Val_Rule_ID, c.AD_Val_Rule_ID) as AD_Val_Rule_ID, c.AD_Process_ID,
   COALESCE(f.Isalwaysupdateable , C.Isalwaysupdateable) As Isalwaysupdateable,
   COALESCE(f.Readonlylogic,  c.Readonlylogic ) As Readonlylogic,
   COALESCE(f.Mandatorylogic , C.Mandatorylogic) As Mandatorylogic,
   COALESCE(f.isupdateable, c.isupdateable) AS isupdateable, c.IsEncrypted AS IsEncryptedColumn, c.IsSelectionColumn,
   tbl.TableName, c.ValueMin, c.ValueMax,
   fgt.NAME AS FieldGroup, vr.Code AS ValidationCode,
   f.Included_Tab_ID, fg.FieldGroupType, fg.IsCollapsedByDefault,
   COALESCE(f.InfoFactoryClass, c.InfoFactoryClass) as InfoFactoryClass,
   c.IsAutocomplete, COALESCE(f.IsAllowCopy, c.IsAllowCopy) AS IsAllowCopy,
        f.isdisplayedgrid,
        f.seqnogrid,
        c.seqnoselection, f.xposition, f.columnspan, f.numlines,
  COALESCE(f.istoolbarbutton , c.istoolbarbutton ) As istoolbarbutton
  FROM AD_FIELD f
   INNER JOIN AD_FIELD_TRL trl ON (f.AD_Field_ID = trl.AD_Field_ID)
    INNER JOIN AD_TAB t ON (f.AD_Tab_ID = t.AD_Tab_ID)
    LEFT OUTER JOIN AD_FIELDGROUP fg ON (f.AD_FieldGroup_ID = fg.AD_FieldGroup_ID)
    LEFT OUTER JOIN AD_FIELDGROUP_TRL fgt ON
   (f.AD_FieldGroup_ID = fgt.AD_FieldGroup_ID AND trl.AD_LANGUAGE=fgt.AD_LANGUAGE)
    LEFT OUTER JOIN AD_COLUMN c ON (f.AD_Column_ID = c.AD_Column_ID)
   INNER JOIN AD_TABLE tbl ON (c.AD_Table_ID = tbl.AD_Table_ID)
   LEFT OUTER JOIN AD_VAL_RULE vr ON (vr.AD_Val_Rule_ID=COALESCE(f.AD_Val_Rule_ID, c.AD_Val_Rule_ID))
  WHERE f.IsActive = 'Y'
  AND c.IsActive = 'Y';

-- Nov 20, 2012 12:13:04 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_FieldGroup (FieldGroupType,EntityType,IsCollapsedByDefault,Name,AD_FieldGroup_UU,AD_FieldGroup_ID,AD_Client_ID,Created,CreatedBy,Updated,AD_Org_ID,UpdatedBy,IsActive) VALUES ('C','D','N','Overwritten From Column','a0d14c47-fa7e-4286-9818-e684e87171d7',200004,0,TO_DATE('2012-11-20 12:13:03','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-11-20 12:13:03','YYYY-MM-DD HH24:MI:SS'),0,100,'Y')
;

-- Nov 20, 2012 12:13:04 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_FieldGroup_Trl (AD_Language,AD_FieldGroup_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_FieldGroup_Trl_UU ) SELECT l.AD_Language,t.AD_FieldGroup_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_FieldGroup t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_FieldGroup_ID=200004 AND NOT EXISTS (SELECT * FROM AD_FieldGroup_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_FieldGroup_ID=t.AD_FieldGroup_ID)
;

-- Nov 20, 2012 12:24:35 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET SeqNo=140, IsDisplayed='Y', XPosition=2,Updated=TO_DATE('2012-11-20 12:24:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=142
;

-- Nov 20, 2012 12:24:35 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET SeqNo=150,Updated=TO_DATE('2012-11-20 12:24:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=924
;

-- Nov 20, 2012 12:24:35 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET SeqNo=170,Updated=TO_DATE('2012-11-20 12:24:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=137
;

-- Nov 20, 2012 12:24:35 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET SeqNo=180,Updated=TO_DATE('2012-11-20 12:24:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200274
;

-- Nov 20, 2012 12:24:35 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET SeqNo=190,Updated=TO_DATE('2012-11-20 12:24:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=138
;

-- Nov 20, 2012 12:24:35 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET SeqNo=200,Updated=TO_DATE('2012-11-20 12:24:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8343
;

-- Nov 20, 2012 12:24:35 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET SeqNo=210,Updated=TO_DATE('2012-11-20 12:24:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=140
;

-- Nov 20, 2012 12:24:35 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET SeqNo=220,Updated=TO_DATE('2012-11-20 12:24:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=141
;

-- Nov 20, 2012 12:24:35 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET SeqNo=230, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2012-11-20 12:24:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=62468
;

-- Nov 20, 2012 12:24:35 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET SeqNo=240,Updated=TO_DATE('2012-11-20 12:24:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53280
;

-- Nov 20, 2012 12:24:35 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET SeqNo=250,Updated=TO_DATE('2012-11-20 12:24:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200275
;

-- Nov 20, 2012 12:24:35 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET SeqNo=260, IsDisplayed='Y', XPosition=2,Updated=TO_DATE('2012-11-20 12:24:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200771
;

-- Nov 20, 2012 12:24:35 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET SeqNo=270, AD_FieldGroup_ID=200004, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2012-11-20 12:24:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13425
;

-- Nov 20, 2012 12:24:35 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET ColumnSpan=2, SeqNo=280, IsDisplayed='Y', XPosition=4,Updated=TO_DATE('2012-11-20 12:24:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200837
;

-- Nov 20, 2012 12:24:35 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET SeqNo=290, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2012-11-20 12:24:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=54402
;

-- Nov 20, 2012 12:24:35 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET SeqNo=300, IsDisplayed='Y', XPosition=4,Updated=TO_DATE('2012-11-20 12:24:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=54401
;

-- Nov 20, 2012 12:24:35 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET ColumnSpan=2, SeqNo=310, AD_FieldGroup_ID=200004, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2012-11-20 12:24:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200838
;

-- Nov 20, 2012 12:24:36 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET SeqNo=320, AD_FieldGroup_ID=200004, IsDisplayed='Y', XPosition=4,Updated=TO_DATE('2012-11-20 12:24:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200834
;

-- Nov 20, 2012 12:24:36 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET SeqNo=330, AD_FieldGroup_ID=200004, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2012-11-20 12:24:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13424
;

-- Nov 20, 2012 12:24:36 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET SeqNo=340, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2012-11-20 12:24:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200835
;

-- Nov 20, 2012 12:24:36 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET SeqNo=350, AD_FieldGroup_ID=200004, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2012-11-20 12:24:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200836
;

-- Nov 21, 2012 10:43:01 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=28',Updated=TO_DATE('2012-11-21 10:43:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200837
;

-- Nov 21, 2012 10:43:01 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=30 | @AD_Reference_ID@=28',Updated=TO_DATE('2012-11-21 11:50:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200855
;

-- Nov 21, 2012 11:58:01 AM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=28',Updated=TO_DATE('2012-11-21 11:58:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200856
;

-- Nov 21, 2012 2:18:12 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (0,'N','N',0,464,200959,'D',1,'N','N','N',0,'N',10,'N',18,'N',120,'N','Y','81b17412-3ebc-4191-b0b1-050dfbdcc3d4','Y','N','AD_Reference_ID','System Reference and Validation','The Reference could be a display type, list or table validation.','Reference','Y',TO_DATE('2012-11-21 14:18:11','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2012-11-21 14:18:11','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Nov 21, 2012 2:18:12 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200959 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 21, 2012 2:19:09 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
ALTER TABLE AD_UserDef_Field ADD AD_Reference_ID NUMBER(10) DEFAULT NULL 
;

-- Nov 21, 2012 2:23:17 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',395,10,'N','N',200959,'Y',200858,'N','The Reference could be a display type, list or table validation.','D','System Reference and Validation','Reference','2e669f8a-65f1-46e4-a5c1-1a4edef9421f','Y','N',100,0,TO_DATE('2012-11-21 14:23:16','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-21 14:23:16','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 21, 2012 2:23:17 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200858 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 21, 2012 2:25:54 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET ColumnSpan=2, SeqNo=180, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2012-11-21 14:25:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200858
;

-- Nov 21, 2012 2:25:54 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET SeqNo=200,Updated=TO_DATE('2012-11-21 14:25:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200855
;

-- Nov 21, 2012 2:25:54 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET SeqNo=210,Updated=TO_DATE('2012-11-21 14:25:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200852
;

-- Nov 21, 2012 2:25:54 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET SeqNo=220,Updated=TO_DATE('2012-11-21 14:25:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11252
;

-- Nov 21, 2012 2:25:54 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET SeqNo=230,Updated=TO_DATE('2012-11-21 14:25:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5051
;

-- Nov 21, 2012 2:25:54 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET SeqNo=240,Updated=TO_DATE('2012-11-21 14:25:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5057
;

-- Nov 21, 2012 2:25:54 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET SeqNo=250,Updated=TO_DATE('2012-11-21 14:25:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200857
;

-- Nov 21, 2012 2:25:54 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET SeqNo=260,Updated=TO_DATE('2012-11-21 14:25:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200850
;

-- Nov 21, 2012 2:25:54 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET SeqNo=270,Updated=TO_DATE('2012-11-21 14:25:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200853
;

-- Nov 21, 2012 2:28:56 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET IsCentrallyMaintained='N', Help='You can overwrite the Display Type, but only use this if you aware of the consequences.', AD_FieldGroup_ID=200004, Description='System Reference - optional Overwrite', Name='Reference Overwrite',Updated=TO_DATE('2012-11-21 14:28:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200858
;

-- Nov 21, 2012 2:28:56 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field_Trl SET IsTranslated='N' WHERE AD_Field_ID=200858
;

-- Nov 21, 2012 3:46:11 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
ALTER TABLE AD_UserDef_Field MODIFY DisplayLogic NVARCHAR2(2000) DEFAULT NULL 
;

-- Nov 21, 2012 3:46:11 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
-- ALTER TABLE AD_UserDef_Field MODIFY DisplayLogic NULL
-- ;

-- Nov 22, 2012 3:31:16 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Element SET Name='Always Updatable', PrintName='Always Updatable',Updated=TO_DATE('2012-11-22 15:31:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=2468
;

-- Nov 22, 2012 3:31:16 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=2468
;

-- Nov 22, 2012 3:31:16 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Column SET ColumnName='IsAlwaysUpdateable', Name='Always Updatable', Description='The column is always updateable, even if the record is not active or processed', Help='If selected and if the window / tab is not read only, you can always update the column.  This might be useful for comments, etc.' WHERE AD_Element_ID=2468
;

-- Nov 22, 2012 3:31:16 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Process_Para SET ColumnName='IsAlwaysUpdateable', Name='Always Updatable', Description='The column is always updateable, even if the record is not active or processed', Help='If selected and if the window / tab is not read only, you can always update the column.  This might be useful for comments, etc.', AD_Element_ID=2468 WHERE UPPER(ColumnName)='ISALWAYSUPDATEABLE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Nov 22, 2012 3:31:16 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Process_Para SET ColumnName='IsAlwaysUpdateable', Name='Always Updatable', Description='The column is always updateable, even if the record is not active or processed', Help='If selected and if the window / tab is not read only, you can always update the column.  This might be useful for comments, etc.' WHERE AD_Element_ID=2468 AND IsCentrallyMaintained='Y'
;

-- Nov 22, 2012 3:31:16 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET Name='Always Updatable', Description='The column is always updateable, even if the record is not active or processed', Help='If selected and if the window / tab is not read only, you can always update the column.  This might be useful for comments, etc.' WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=2468) AND IsCentrallyMaintained='Y'
;

-- Nov 22, 2012 3:31:16 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_PrintFormatItem pi SET PrintName='Always Updatable', Name='Always Updatable' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=2468)
;

-- Nov 22, 2012 3:38:25 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Column SET AD_Reference_Value_ID=319, IsMandatory='N', AD_Reference_ID=17,Updated=TO_DATE('2012-11-22 15:38:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6349
;

-- Nov 22, 2012 3:39:51 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Column SET AD_Reference_Value_ID=319, IsMandatory='N', AD_Reference_ID=17,Updated=TO_DATE('2012-11-22 15:39:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6352
;

-- Nov 22, 2012 3:40:28 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Column SET AD_Reference_Value_ID=319, IsMandatory='N', AD_Reference_ID=17,Updated=TO_DATE('2012-11-22 15:40:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6356
;

-- Nov 22, 2012 3:42:22 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Column SET AD_Reference_Value_ID=319, AD_Reference_ID=17,Updated=TO_DATE('2012-11-22 15:42:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6353
;

-- Nov 22, 2012 3:49:32 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET SeqNo=90, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2012-11-22 15:49:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5050
;

-- Nov 22, 2012 3:49:32 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET SeqNo=110, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2012-11-22 15:49:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5053
;

-- Nov 22, 2012 3:49:32 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET SeqNo=120, IsDisplayed='Y', XPosition=4,Updated=TO_DATE('2012-11-22 15:49:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5054
;

-- Nov 22, 2012 3:49:32 PM COT
-- IDEMPIERE-163: Adding UI Fields to  AD_Field and Ad_Userdef_Field
UPDATE AD_Field SET SeqNo=240, IsDisplayed='Y', XPosition=4,Updated=TO_DATE('2012-11-22 15:49:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5057
;

-- Nov 23, 2012 12:13:22 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Field SET SeqNo=140, IsDisplayed='Y', XPosition=2,Updated=TO_DATE('2012-11-23 12:13:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200771
;

-- Nov 23, 2012 12:13:22 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Field SET SeqNo=200, IsDisplayed='Y', XPosition=2,Updated=TO_DATE('2012-11-23 12:13:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=142
;

-- Nov 23, 2012 12:13:22 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Field SET SeqNo=210,Updated=TO_DATE('2012-11-23 12:13:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8343
;

-- Nov 23, 2012 12:13:22 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Field SET SeqNo=220,Updated=TO_DATE('2012-11-23 12:13:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=140
;

-- Nov 23, 2012 12:13:22 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Field SET SeqNo=230,Updated=TO_DATE('2012-11-23 12:13:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=141
;

-- Nov 23, 2012 12:13:22 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Field SET SeqNo=260,Updated=TO_DATE('2012-11-23 12:13:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13425
;

-- Nov 23, 2012 12:13:22 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Field SET SeqNo=270,Updated=TO_DATE('2012-11-23 12:13:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200837
;

-- Nov 23, 2012 12:13:22 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Field SET SeqNo=280,Updated=TO_DATE('2012-11-23 12:13:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=54402
;

-- Nov 23, 2012 12:13:22 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Field SET SeqNo=290,Updated=TO_DATE('2012-11-23 12:13:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=54401
;

-- Nov 23, 2012 12:13:22 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Field SET SeqNo=300,Updated=TO_DATE('2012-11-23 12:13:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200838
;

-- Nov 23, 2012 12:13:22 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Field SET SeqNo=310,Updated=TO_DATE('2012-11-23 12:13:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200834
;

-- Nov 23, 2012 12:13:22 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Field SET SeqNo=320,Updated=TO_DATE('2012-11-23 12:13:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13424
;

-- Nov 23, 2012 12:13:22 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Field SET SeqNo=330, IsDisplayed='Y', XPosition=4,Updated=TO_DATE('2012-11-23 12:13:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=62468
;

-- Nov 23, 2012 12:37:33 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Field SET SeqNo=260, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2012-11-23 12:37:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200350
;

-- Nov 23, 2012 12:37:34 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Field SET SeqNo=270, IsDisplayed='Y', XPosition=4,Updated=TO_DATE('2012-11-23 12:37:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200348
;

-- Nov 23, 2012 12:37:34 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Field SET SeqNo=280, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2012-11-23 12:37:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200349
;

-- Nov 23, 2012 12:37:34 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Field SET SeqNo=290,Updated=TO_DATE('2012-11-23 12:37:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13425
;

-- Nov 23, 2012 12:37:34 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Field SET SeqNo=300,Updated=TO_DATE('2012-11-23 12:37:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200837
;

-- Nov 23, 2012 12:37:34 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Field SET SeqNo=310,Updated=TO_DATE('2012-11-23 12:37:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=54402
;

-- Nov 23, 2012 12:37:34 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Field SET SeqNo=320,Updated=TO_DATE('2012-11-23 12:37:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=54401
;

-- Nov 23, 2012 12:37:34 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Field SET SeqNo=330,Updated=TO_DATE('2012-11-23 12:37:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200838
;

-- Nov 23, 2012 12:37:34 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Field SET SeqNo=340,Updated=TO_DATE('2012-11-23 12:37:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200834
;

-- Nov 23, 2012 12:37:34 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Field SET SeqNo=350,Updated=TO_DATE('2012-11-23 12:37:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13424
;

-- Nov 23, 2012 12:37:34 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Field SET SeqNo=360,Updated=TO_DATE('2012-11-23 12:37:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=62468
;

-- Nov 23, 2012 12:37:34 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Field SET SeqNo=370,Updated=TO_DATE('2012-11-23 12:37:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200835
;

-- Nov 23, 2012 12:37:34 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Field SET SeqNo=380,Updated=TO_DATE('2012-11-23 12:37:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200836
;

-- Nov 23, 2012 12:37:34 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Field SET SeqNo=390,Updated=TO_DATE('2012-11-23 12:37:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=136
;

-- Nov 23, 2012 12:37:34 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Field SET SeqNo=400,Updated=TO_DATE('2012-11-23 12:37:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=139
;

-- Nov 23, 2012 12:38:25 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_FieldGroup SET FieldGroupType='C', IsCollapsedByDefault='Y',Updated=TO_DATE('2012-11-23 12:38:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_FieldGroup_ID=200000
;

update ad_field set seqnogrid=seqno where ad_tab_id=107
;

-- hide org field on grid for system only windows (all org=0 in this case)
update ad_field set isdisplayedgrid='N'
where ad_column_id in (select ad_column_id from ad_column where ad_element_id=113) /* ad_org_id */
and ad_field_id < 1000000
and ad_column_id in (select c.ad_column_id from ad_column c join ad_table t on t.ad_table_id=c.ad_table_id where t.accesslevel='4')
;

-- Nov 23, 2012 12:46:44 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Column SET DefaultValue=NULL,Updated=TO_DATE('2012-11-23 12:46:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200946
;

-- Nov 23, 2012 12:48:19 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Column SET DefaultValue=NULL,Updated=TO_DATE('2012-11-23 12:48:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200949
;

-- Nov 23, 2012 12:48:38 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Column SET DefaultValue=NULL,Updated=TO_DATE('2012-11-23 12:48:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200945
;

-- Nov 23, 2012 12:50:37 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Column SET DefaultValue=NULL,Updated=TO_DATE('2012-11-23 12:50:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200950
;

-- Nov 23, 2012 12:51:12 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Column SET DefaultValue=NULL,Updated=TO_DATE('2012-11-23 12:51:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200955
;

-- Nov 23, 2012 12:52:07 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Column SET DefaultValue=NULL,Updated=TO_DATE('2012-11-23 12:52:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200956
;

-- Nov 23, 2012 12:52:50 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Column SET DefaultValue=NULL,Updated=TO_DATE('2012-11-23 12:52:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200957
;

-- Nov 23, 2012 12:53:54 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Column SET DefaultValue=NULL,Updated=TO_DATE('2012-11-23 12:53:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200958
;

-- Nov 23, 2012 1:04:11 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Column SET DefaultValue=NULL,Updated=TO_DATE('2012-11-23 13:04:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6349
;

-- Nov 23, 2012 1:04:40 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
ALTER TABLE AD_UserDef_Field MODIFY IsDisplayed CHAR(1) DEFAULT NULL 
;

-- Nov 23, 2012 1:04:41 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
ALTER TABLE AD_UserDef_Field MODIFY IsDisplayed NULL
;

-- Nov 23, 2012 1:05:41 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Column SET DefaultValue=NULL,Updated=TO_DATE('2012-11-23 13:05:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6352
;

-- Nov 23, 2012 1:05:44 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
ALTER TABLE AD_UserDef_Field MODIFY IsReadOnly CHAR(1) DEFAULT NULL 
;

-- Nov 23, 2012 1:05:45 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
ALTER TABLE AD_UserDef_Field MODIFY IsReadOnly NULL
;

-- Nov 23, 2012 1:06:07 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Column SET DefaultValue=NULL,Updated=TO_DATE('2012-11-23 13:06:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6356
;

-- Nov 23, 2012 1:06:11 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
ALTER TABLE AD_UserDef_Field MODIFY IsSameLine CHAR(1) DEFAULT NULL 
;

-- Nov 23, 2012 1:06:11 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
ALTER TABLE AD_UserDef_Field MODIFY IsSameLine NULL
;

-- Nov 23, 2012 1:32:08 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Field SET SeqNo=70, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2012-11-23 13:32:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5049
;

-- Nov 23, 2012 1:32:08 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Field SET SeqNo=80,Updated=TO_DATE('2012-11-23 13:32:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5044
;

-- Nov 23, 2012 1:32:08 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Field SET SeqNo=100, IsDisplayed='Y', XPosition=4,Updated=TO_DATE('2012-11-23 13:32:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5053
;

-- Nov 23, 2012 1:32:08 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Field SET SeqNo=110,Updated=TO_DATE('2012-11-23 13:32:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5052
;

-- Nov 23, 2012 1:32:08 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Field SET SeqNo=120, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2012-11-23 13:32:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5056
;

-- Nov 23, 2012 1:32:08 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Field SET SeqNo=130, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2012-11-23 13:32:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5055
;

-- Nov 23, 2012 1:32:08 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Field SET SeqNo=140, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2012-11-23 13:32:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11252
;

-- Nov 23, 2012 1:32:09 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Field SET SeqNo=150, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2012-11-23 13:32:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200857
;

-- Nov 23, 2012 1:32:09 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Field SET SeqNo=160, IsDisplayed='Y', XPosition=4,Updated=TO_DATE('2012-11-23 13:32:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200850
;

-- Nov 23, 2012 1:32:09 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Field SET SeqNo=170, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2012-11-23 13:32:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200853
;

-- Nov 23, 2012 1:32:09 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Field SET SeqNo=210, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2012-11-23 13:32:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5054
;

-- Nov 23, 2012 1:32:09 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Field SET SeqNo=220, IsDisplayed='Y', XPosition=4,Updated=TO_DATE('2012-11-23 13:32:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200849
;

-- Nov 23, 2012 1:32:09 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Field SET SeqNo=230, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2012-11-23 13:32:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200851
;

-- Nov 23, 2012 1:32:09 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Field SET SeqNo=240, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2012-11-23 13:32:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200852
;

-- Nov 23, 2012 1:32:09 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Field SET SeqNo=250,Updated=TO_DATE('2012-11-23 13:32:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200854
;

-- Nov 23, 2012 1:32:09 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Field SET SeqNo=260,Updated=TO_DATE('2012-11-23 13:32:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5051
;

-- Nov 23, 2012 1:32:09 PM COT
-- IDEMPIERE-163 Implement isupdateable and isalwaysupdateable on ad_field
UPDATE AD_Field SET SeqNo=270,Updated=TO_DATE('2012-11-23 13:32:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5057
;

SELECT register_migration_script('201211211000_IDEMPIERE-163.sql') FROM dual
;

