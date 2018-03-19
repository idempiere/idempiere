-- May 29, 2014 2:05:43 PM ICT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (0,'N',0,211272,'N','N','N',0,'N',2000,'N','N','N','Y','1a19bfbb-e413-4e31-b635-a40068f21a0d','Y','DefaultValue','Default value hierarchy, separated by ;','The defaults are evaluated in the order of definition, the first not null value becomes the default value of the column. The values are separated by comma or semicolon. a) Literals:. ''Text'' or 123 b) Variables - in format @Variable@ - Login e.g. #Date, #AD_Org_ID, #AD_Client_ID - Accounting Schema: e.g. $C_AcctSchema_ID, $C_Calendar_ID - Global defaults: e.g. DateFormat - Window values (all Picks, CheckBoxes, RadioButtons, and DateDoc/DateAcct) c) SQL code with the tag: @SQL=SELECT something AS DefaultValue FROM ... The SQL statement can contain variables.  There can be no other value other than the SQL statement. The default is only evaluated, if no user preference is defined.  Default definitions are ignored for record columns as Key, Parent, Client as well as Buttons.','Default Logic','Y',TO_TIMESTAMP('2014-05-29 14:05:37','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2014-05-29 14:05:37','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N','N',272,10,897)
;

-- May 29, 2014 2:05:50 PM ICT
ALTER TABLE AD_InfoColumn ADD COLUMN DefaultValue VARCHAR(2000) DEFAULT NULL 
;

-- May 29, 2014 2:07:35 PM ICT
INSERT INTO AD_Field (SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,Created) VALUES (0,'N',844,0,'N','N',240,'Y',203048,'N','The defaults are evaluated in the order of definition, the first not null value becomes the default value of the column. The values are separated by comma or semicolon. a) Literals:. ''Text'' or 123 b) Variables - in format @Variable@ - Login e.g. #Date, #AD_Org_ID, #AD_Client_ID - Accounting Schema: e.g. $C_AcctSchema_ID, $C_Calendar_ID - Global defaults: e.g. DateFormat - Window values (all Picks, CheckBoxes, RadioButtons, and DateDoc/DateAcct) c) SQL code with the tag: @SQL=SELECT something AS DefaultValue FROM ... The SQL statement can contain variables.  There can be no other value other than the SQL statement. The default is only evaluated, if no user preference is defined.  Default definitions are ignored for record columns as Key, Parent, Client as well as Buttons.','Default value hierarchy, separated by ;','Default Logic','df17ed00-801b-4e24-892c-5b15760ef9f6','Y','N',100,0,100,TO_TIMESTAMP('2014-05-29 14:07:29','YYYY-MM-DD HH24:MI:SS'),'Y','Y',150,1,'N',0,1,1,'N','N',211272,'D',TO_TIMESTAMP('2014-05-29 14:07:29','YYYY-MM-DD HH24:MI:SS'))
;

-- May 29, 2014 2:08:42 PM ICT
UPDATE AD_Field SET SeqNo=180, IsDisplayed='Y', XPosition=1, ColumnSpan=5,Updated=TO_TIMESTAMP('2014-05-29 14:08:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203048
;

-- May 29, 2014 2:08:42 PM ICT
UPDATE AD_Field SET SeqNo=190,Updated=TO_TIMESTAMP('2014-05-29 14:08:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201635
;

-- May 29, 2014 2:08:42 PM ICT
UPDATE AD_Field SET SeqNo=200,Updated=TO_TIMESTAMP('2014-05-29 14:08:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201636
;

-- May 29, 2014 2:08:42 PM ICT
UPDATE AD_Field SET SeqNo=210,Updated=TO_TIMESTAMP('2014-05-29 14:08:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13603
;

-- May 29, 2014 2:08:42 PM ICT
UPDATE AD_Field SET SeqNo=220,Updated=TO_TIMESTAMP('2014-05-29 14:08:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201622
;

-- May 29, 2014 2:08:42 PM ICT
UPDATE AD_Field SET SeqNo=230,Updated=TO_TIMESTAMP('2014-05-29 14:08:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201623
;

-- May 29, 2014 2:08:42 PM ICT
UPDATE AD_Field SET SeqNo=240,Updated=TO_TIMESTAMP('2014-05-29 14:08:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13597
;
SELECT register_migration_script('201405291604_IDEMPIERE-1792.sql') FROM dual
;
