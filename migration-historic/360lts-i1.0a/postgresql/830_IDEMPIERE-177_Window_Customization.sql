-- Aug 9, 2010 8:47:17 PM CEST
-- Default comment for updating dictionary
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2010-08-09 20:47:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=13424
;

-- Aug 9, 2010 8:48:24 PM CEST
-- Default comment for updating dictionary
UPDATE AD_Column SET DefaultValue='''Y''',Updated=TO_TIMESTAMP('2010-08-09 20:48:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6349
;

-- Aug 9, 2010 8:48:38 PM CEST
-- Default comment for updating dictionary
UPDATE AD_Column SET DefaultValue='''N''',Updated=TO_TIMESTAMP('2010-08-09 20:48:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6352
;

-- Aug 9, 2010 8:48:42 PM CEST
-- Default comment for updating dictionary
insert into t_alter_column values('ad_userdef_field','IsReadOnly','CHAR(1)',null,'N')
;

-- Aug 9, 2010 8:48:43 PM CEST
-- Default comment for updating dictionary
UPDATE AD_UserDef_Field SET IsReadOnly='N' WHERE IsReadOnly IS NULL
;

-- Aug 9, 2010 8:49:01 PM CEST
-- Default comment for updating dictionary
insert into t_alter_column values('ad_userdef_field','IsDisplayed','CHAR(1)',null,'Y')
;

-- Aug 9, 2010 8:49:01 PM CEST
-- Default comment for updating dictionary
UPDATE AD_UserDef_Field SET IsDisplayed='Y' WHERE IsDisplayed IS NULL
;

-- Aug 9, 2010 8:49:19 PM CEST
-- Default comment for updating dictionary
UPDATE AD_Column SET DefaultValue='''N''',Updated=TO_TIMESTAMP('2010-08-09 20:49:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6356
;

-- Aug 9, 2010 8:49:23 PM CEST
-- Default comment for updating dictionary
insert into t_alter_column values('ad_userdef_field','IsSameLine','CHAR(1)',null,'N')
;

-- Aug 9, 2010 8:49:23 PM CEST
-- Default comment for updating dictionary
UPDATE AD_UserDef_Field SET IsSameLine='N' WHERE IsSameLine IS NULL
;

-- Aug 9, 2010 8:49:47 PM CEST
-- Default comment for updating dictionary
UPDATE AD_Column SET DefaultValue='0',Updated=TO_TIMESTAMP('2010-08-09 20:49:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6355
;

-- Aug 9, 2010 8:49:51 PM CEST
-- Default comment for updating dictionary
insert into t_alter_column values('ad_userdef_field','SeqNo','NUMERIC(10)',null,'0')
;

-- Aug 9, 2010 8:49:51 PM CEST
-- Default comment for updating dictionary
UPDATE AD_UserDef_Field SET SeqNo=0 WHERE SeqNo IS NULL
;

-- Aug 9, 2010 8:52:43 PM CEST
-- Default comment for updating dictionary
UPDATE AD_Column SET DefaultValue='''''',Updated=TO_TIMESTAMP('2010-08-09 20:52:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6351
;

-- Aug 9, 2010 8:52:50 PM CEST
-- Default comment for updating dictionary
insert into t_alter_column values('ad_userdef_field','DisplayLogic','VARCHAR(2000)',null,'')
;

-- Aug 9, 2010 8:55:45 PM CEST
-- Default comment for updating dictionary
insert into t_alter_column values('ad_userdef_field','DefaultValue','VARCHAR(2000)',null,'')
;

-- Mar 5, 2012 2:16:34 PM CET
-- IDEMPIERE-177 Window Customization
UPDATE AD_Column SET Callout='org.compiere.model.CalloutWindowCustomization.window',Updated=TO_TIMESTAMP('2012-03-05 14:16:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6395
;

-- Mar 5, 2012 2:35:54 PM CET
-- IDEMPIERE-177 Window Customization
INSERT INTO AD_Val_Rule (AD_Client_ID,AD_Org_ID,AD_Val_Rule_ID,Code,Created,CreatedBy,EntityType,IsActive,Name,Type,Updated,UpdatedBy) VALUES (0,0,200000,'AD_Window.AD_Window_ID IN (SELECT AD_Window_Access.AD_Window_ID FROM AD_Window_Access WHERE AD_Window_Access.AD_Role_ID=@#AD_Role_ID@)',TO_TIMESTAMP('2012-03-05 14:35:52','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Window of Role','S',TO_TIMESTAMP('2012-03-05 14:35:52','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 5, 2012 2:36:34 PM CET
-- IDEMPIERE-177 Window Customization
UPDATE AD_Column SET AD_Val_Rule_ID=200000,Updated=TO_TIMESTAMP('2012-03-05 14:36:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6395
;

-- Mar 5, 2012 2:48:07 PM CET
-- IDEMPIERE-177 Window Customization
UPDATE AD_Column SET AD_Val_Rule_ID=163,Updated=TO_TIMESTAMP('2012-03-05 14:48:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6380
;

-- Mar 5, 2012 3:41:45 PM CET
-- IDEMPIERE-177 Window Customization
UPDATE AD_Column SET Callout='org.compiere.model.CalloutWindowCustomization.tab',Updated=TO_TIMESTAMP('2012-03-05 15:41:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6380
;

-- Mar 5, 2012 3:51:23 PM CET
-- IDEMPIERE-177 Window Customization
UPDATE AD_Column SET AD_Val_Rule_ID=52005,Updated=TO_TIMESTAMP('2012-03-05 15:51:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6345
;

-- Mar 5, 2012 3:53:30 PM CET
-- IDEMPIERE-177 Window Customization
UPDATE AD_Column SET Callout='org.compiere.model.CalloutWindowCustomization.field',Updated=TO_TIMESTAMP('2012-03-05 15:53:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6345
;

-- Mar 7, 2012 11:02:11 AM CET
-- IDEMPIERE-177 Window Customization
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsSyncDatabase,IsTranslated,IsUpdateable,Name,SeqNo,Updated,UpdatedBy,Version) VALUES (0,200018,1663,0,10,466,'ReadOnlyLogic',TO_TIMESTAMP('2012-03-07 11:02:09','YYYY-MM-DD HH24:MI:SS'),100,'Logic to determine if field is read only (applies only when field is read-write)','D',2000,'format := {expression} [{logic} {expression}]<br> 
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
Strings may be in single quotes (optional)','Y','Y','Y','N','N','N','N','N','N','N','N','N','N','Y','Read Only Logic',0,TO_TIMESTAMP('2012-03-07 11:02:09','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Mar 7, 2012 11:02:11 AM CET
-- IDEMPIERE-177 Window Customization
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200018 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 7, 2012 11:02:19 AM CET
-- IDEMPIERE-177 Window Customization
ALTER TABLE AD_UserDef_Tab ADD COLUMN ReadOnlyLogic VARCHAR(2000) DEFAULT NULL 
;

-- Mar 7, 2012 11:02:34 AM CET
-- IDEMPIERE-177 Window Customization
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,Updated,UpdatedBy) VALUES (0,200018,200003,0,394,TO_TIMESTAMP('2012-03-07 11:02:33','YYYY-MM-DD HH24:MI:SS'),100,'Logic to determine if field is read only (applies only when field is read-write)',2000,'D','format := {expression} [{logic} {expression}]<br> 
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
Strings may be in single quotes (optional)','Y','Y','Y','N','N','N','N','N','Read Only Logic',TO_TIMESTAMP('2012-03-07 11:02:33','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 7, 2012 11:02:34 AM CET
-- IDEMPIERE-177 Window Customization
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200003 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 7, 2012 11:02:41 AM CET
-- IDEMPIERE-177 Window Customization
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=200003
;

-- Apr 3, 2012 3:11:59 PM CEST
-- IDEMPIERE-177 Window Customization
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2012-04-03 15:11:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6396
;

-- Apr 3, 2012 3:13:25 PM CEST
-- IDEMPIERE-177 Window Customization
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2012-04-03 15:13:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6399
;

-- Apr 3, 2012 3:15:11 PM CEST
-- IDEMPIERE-177 Window Customization
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2012-04-03 15:15:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6381
;

-- Apr 3, 2012 3:16:32 PM CEST
-- IDEMPIERE-177 Window Customization
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2012-04-03 15:16:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6346
;

UPDATE AD_System
  SET LastMigrationScriptApplied='830_IDEMPIERE-177_Window_Customization.sql'
WHERE LastMigrationScriptApplied<'830_IDEMPIERE-177_Window_Customization.sql'
   OR LastMigrationScriptApplied IS NULL
;
