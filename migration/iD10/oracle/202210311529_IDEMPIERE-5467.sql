-- IDEMPIERE-5467
SELECT register_migration_script('202210311529_IDEMPIERE-5467.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Oct 31, 2022, 3:29:03 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215630,0,'Range','The parameter is a range of values','The Range checkbox indicates that this parameter is a range of values.',897,'IsRange','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2022-10-31 15:29:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-31 15:29:02','YYYY-MM-DD HH24:MI:SS'),100,404,'Y','N','D','N','N','N','Y','dfe41787-eea0-4bf2-8cf8-4c294ae9e384','Y',0,'N','N','N','N')
;

-- Oct 31, 2022, 3:29:05 PM CET
ALTER TABLE AD_InfoColumn ADD IsRange CHAR(1) DEFAULT 'N' CHECK (IsRange IN ('Y','N')) NOT NULL
;

-- Oct 31, 2022, 3:31:48 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207409,'Range','The parameter is a range of values','The Range checkbox indicates that this parameter is a range of values.',844,215630,'Y','@QueryOperator@=''=''',0,330,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-10-31 15:31:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-31 15:31:48','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','23f54a5d-4e01-4f83-8225-c9dcd10b5595','Y',200,1,1,1,'N','N','N','N')
;

-- Oct 31, 2022, 3:34:55 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=260, XPosition=2,Updated=TO_TIMESTAMP('2022-10-31 15:34:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207409
;

-- Oct 31, 2022, 3:34:55 PM CET
UPDATE AD_Field SET SeqNo=270,Updated=TO_TIMESTAMP('2022-10-31 15:34:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13603
;

-- Oct 31, 2022, 3:34:55 PM CET
UPDATE AD_Field SET SeqNo=280,Updated=TO_TIMESTAMP('2022-10-31 15:34:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201622
;

-- Oct 31, 2022, 3:34:55 PM CET
UPDATE AD_Field SET SeqNo=290,Updated=TO_TIMESTAMP('2022-10-31 15:34:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201623
;

-- Oct 31, 2022, 3:34:55 PM CET
UPDATE AD_Field SET SeqNo=300,Updated=TO_TIMESTAMP('2022-10-31 15:34:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13597
;

-- Oct 31, 2022, 3:34:55 PM CET
UPDATE AD_Field SET SeqNo=310,Updated=TO_TIMESTAMP('2022-10-31 15:34:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205588
;

-- Oct 31, 2022, 3:34:55 PM CET
UPDATE AD_Field SET SeqNo=320,Updated=TO_TIMESTAMP('2022-10-31 15:34:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206178
;

-- Oct 31, 2022, 3:34:55 PM CET
UPDATE AD_Field SET SeqNo=330,Updated=TO_TIMESTAMP('2022-10-31 15:34:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206409
;

-- Nov 2, 2022, 1:05:05 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215634,0,'Default Logic 2','Default value hierarchy, separated by ;','The defaults are evaluated in the order of definition, the first not null value becomes the default value of the column. The values are separated by comma or semicolon. a) Literals:. ''Text'' or 123 b) Variables - in format @Variable@ - Login e.g. #Date, #AD_Org_ID, #AD_Tenant_ID - Accounting Schema: e.g. $C_AcctSchema_ID, $C_Calendar_ID - Global defaults: e.g. DateFormat - Window values (all Picks, CheckBoxes, RadioButtons, and DateDoc/DateAcct) c) SQL code with the tag: @SQL=SELECT something AS DefaultValue FROM ... The SQL statement can contain variables.  There can be no other value other than the SQL statement. The default is only evaluated, if no user preference is defined.  Default definitions are ignored for record columns as Key, Parent, Tenant as well as Buttons.',897,'DefaultValue2',2000,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2022-11-02 13:05:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-11-02 13:05:05','YYYY-MM-DD HH24:MI:SS'),100,1529,'Y','N','D','N','N','N','Y','818e812b-dff2-44f2-a6ce-fc12572a1418','Y',0,'N','N','N','N')
;

-- Nov 2, 2022, 1:05:07 PM CET
ALTER TABLE AD_InfoColumn ADD DefaultValue2 VARCHAR2(2000 CHAR) DEFAULT NULL 
;

-- Nov 2, 2022, 1:05:36 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215635,0,'Placeholder2',897,'Placeholder2',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2022-11-02 13:05:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-11-02 13:05:36','YYYY-MM-DD HH24:MI:SS'),100,203164,'Y','N','D','N','N','N','Y','d4ded311-b942-4108-ae5e-e6770dd2b9fd','Y',0,'N','N','N','N')
;

-- Nov 2, 2022, 1:05:37 PM CET
ALTER TABLE AD_InfoColumn ADD Placeholder2 VARCHAR2(255 CHAR) DEFAULT NULL 
;

-- Nov 2, 2022, 1:07:16 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207411,'Default Logic 2','Default value hierarchy, separated by ;','The defaults are evaluated in the order of definition, the first not null value becomes the default value of the column. The values are separated by comma or semicolon. a) Literals:. ''Text'' or 123 b) Variables - in format @Variable@ - Login e.g. #Date, #AD_Org_ID, #AD_Tenant_ID - Accounting Schema: e.g. $C_AcctSchema_ID, $C_Calendar_ID - Global defaults: e.g. DateFormat - Window values (all Picks, CheckBoxes, RadioButtons, and DateDoc/DateAcct) c) SQL code with the tag: @SQL=SELECT something AS DefaultValue FROM ... The SQL statement can contain variables.  There can be no other value other than the SQL statement. The default is only evaluated, if no user preference is defined.  Default definitions are ignored for record columns as Key, Parent, Tenant as well as Buttons.',844,215634,'Y','@IsRange@=Y',0,340,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-11-02 13:07:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-11-02 13:07:16','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','72729959-a426-42db-9003-39ca086e05ff','Y',210,1,1,1,'N','N','N','N')
;

-- Nov 2, 2022, 1:07:46 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207412,'Placeholder2',844,215635,'Y','@IsRange@=Y',0,350,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-11-02 13:07:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-11-02 13:07:46','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b3767594-080c-44dc-9fce-32aa8eecfa6c','Y',220,1,1,1,'N','N','N','N')
;

-- Nov 2, 2022, 1:10:05 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=270, XPosition=4, ColumnSpan=2,Updated=TO_TIMESTAMP('2022-11-02 13:10:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207411
;

-- Nov 2, 2022, 1:10:05 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=280, XPosition=7, ColumnSpan=2,Updated=TO_TIMESTAMP('2022-11-02 13:10:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207412
;

-- Nov 2, 2022, 1:10:05 PM CET
UPDATE AD_Field SET SeqNo=290,Updated=TO_TIMESTAMP('2022-11-02 13:10:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13603
;

-- Nov 2, 2022, 1:10:05 PM CET
UPDATE AD_Field SET SeqNo=300,Updated=TO_TIMESTAMP('2022-11-02 13:10:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201622
;

-- Nov 2, 2022, 1:10:05 PM CET
UPDATE AD_Field SET SeqNo=310,Updated=TO_TIMESTAMP('2022-11-02 13:10:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201623
;

-- Nov 2, 2022, 1:10:05 PM CET
UPDATE AD_Field SET SeqNo=320,Updated=TO_TIMESTAMP('2022-11-02 13:10:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13597
;

-- Nov 2, 2022, 1:10:05 PM CET
UPDATE AD_Field SET SeqNo=330,Updated=TO_TIMESTAMP('2022-11-02 13:10:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205588
;

-- Nov 2, 2022, 1:10:05 PM CET
UPDATE AD_Field SET SeqNo=340,Updated=TO_TIMESTAMP('2022-11-02 13:10:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206178
;

-- Nov 2, 2022, 1:10:05 PM CET
UPDATE AD_Field SET SeqNo=350,Updated=TO_TIMESTAMP('2022-11-02 13:10:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206409
;

-- Nov 2, 2022, 3:56:18 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215636,0,'Placeholder2',898,'Placeholder2',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2022-11-02 15:56:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-11-02 15:56:18','YYYY-MM-DD HH24:MI:SS'),100,203164,'Y','N','D','N','N','N','Y','fd9f96fe-5be5-46f1-94b8-fe60e8862182','Y',0,'N','N','N','N')
;

-- Nov 2, 2022, 3:56:19 PM CET
ALTER TABLE AD_InfoColumn_Trl ADD Placeholder2 VARCHAR2(255 CHAR) DEFAULT NULL 
;

-- Nov 2, 2022, 3:56:40 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207413,'Placeholder2',845,215636,'Y',0,100,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-11-02 15:56:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-11-02 15:56:39','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7c908cea-25bf-4956-bcae-72c7f64952ff','Y',80,1,1,1,'N','N','N','N')
;

-- Nov 2, 2022, 3:56:54 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, XPosition=1, ColumnSpan=5,Updated=TO_TIMESTAMP('2022-11-02 15:56:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207413
;

-- Nov 2, 2022, 3:56:54 PM CET
UPDATE AD_Field SET SeqNo=100,Updated=TO_TIMESTAMP('2022-11-02 15:56:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13615
;

-- Nov 2, 2022, 3:57:15 PM CET
UPDATE AD_Column SET IsTranslated='Y',Updated=TO_TIMESTAMP('2022-11-02 15:57:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215635
;

