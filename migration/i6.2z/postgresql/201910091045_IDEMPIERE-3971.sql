-- https://idempiere.atlassian.net/browse/IDEMPIERE-3971
-- Oct 9, 2019, 8:45:23 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214060,0,'Reference','System Reference and Validation','The Reference could be a display type, list or table validation.',200233,'AD_Reference_ID',22,'N','N','N','N','N',0,'N',18,1,0,0,'Y',TO_TIMESTAMP('2019-10-09 08:45:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-09 08:45:23','YYYY-MM-DD HH24:MI:SS'),100,120,'Y','N','U','N','N','N','Y','e0a1bcc3-8130-4271-8f92-5f392759b70c','Y',0,'N','N','N','N')
;

-- Oct 9, 2019, 8:45:25 AM BRT
UPDATE AD_Column SET FKConstraintName='ADReference_ADUserDefProcParam', FKConstraintType='N',Updated=TO_TIMESTAMP('2019-10-09 08:45:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214060
;

-- Oct 9, 2019, 8:45:25 AM BRT
ALTER TABLE AD_UserDef_Proc_Parameter ADD COLUMN AD_Reference_ID NUMERIC(10) DEFAULT NULL
;

-- Oct 9, 2019, 8:45:25 AM BRT
ALTER TABLE AD_UserDef_Proc_Parameter ADD CONSTRAINT ADReference_ADUserDefProcParam FOREIGN KEY (AD_Reference_ID) REFERENCES ad_reference(ad_reference_id) DEFERRABLE INITIALLY DEFERRED
;

-- Oct 9, 2019, 8:45:40 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214061,0,'Reference Key','Required to specify, if data type is Table or List','The Reference Value indicates where the reference values are stored.  It must be specified if the data type is Table or List.  ',200233,115,'AD_Reference_Value_ID',22,'N','N','N','N','N',0,'N',18,4,0,0,'Y',TO_TIMESTAMP('2019-10-09 08:45:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-09 08:45:40','YYYY-MM-DD HH24:MI:SS'),100,121,'Y','N','U','N','N','N','Y','8c733922-36ff-4df7-99ba-2ee5028ecdcd','Y',0,'N','N','N','N')
;

-- Oct 9, 2019, 8:45:42 AM BRT
UPDATE AD_Column SET FKConstraintName='ADReferenceValue_ADUserDefProc', FKConstraintType='N',Updated=TO_TIMESTAMP('2019-10-09 08:45:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214061
;

-- Oct 9, 2019, 8:45:42 AM BRT
ALTER TABLE AD_UserDef_Proc_Parameter ADD COLUMN AD_Reference_Value_ID NUMERIC(10) DEFAULT NULL
;

-- Oct 9, 2019, 8:45:42 AM BRT
ALTER TABLE AD_UserDef_Proc_Parameter ADD CONSTRAINT ADReferenceValue_ADUserDefProc FOREIGN KEY (AD_Reference_Value_ID) REFERENCES ad_reference(ad_reference_id) DEFERRABLE INITIALLY DEFERRED
;

-- Oct 9, 2019, 8:46:00 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214062,0,'Dynamic Validation','Dynamic Validation Rule','These rules define how an entry is determined to valid. You can use variables for dynamic (context sensitive) validation.',200233,'AD_Val_Rule_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2019-10-09 08:46:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-09 08:46:00','YYYY-MM-DD HH24:MI:SS'),100,139,'Y','N','U','N','N','N','Y','ff72629a-f1be-4012-9617-99b6a980af35','Y',0,'N','N','N','N')
;

-- Oct 9, 2019, 8:46:02 AM BRT
UPDATE AD_Column SET FKConstraintName='ADValRule_ADUserDefProcParamet', FKConstraintType='N',Updated=TO_TIMESTAMP('2019-10-09 08:46:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214062
;

-- Oct 9, 2019, 8:46:02 AM BRT
ALTER TABLE AD_UserDef_Proc_Parameter ADD COLUMN AD_Val_Rule_ID NUMERIC(10) DEFAULT NULL
;

-- Oct 9, 2019, 8:46:02 AM BRT
ALTER TABLE AD_UserDef_Proc_Parameter ADD CONSTRAINT ADValRule_ADUserDefProcParamet FOREIGN KEY (AD_Val_Rule_ID) REFERENCES ad_val_rule(ad_val_rule_id) DEFERRABLE INITIALLY DEFERRED
;

-- Oct 9, 2019, 8:46:36 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214063,0,'Default Logic 2','Default value hierarchy, separated by ;','The defaults are evaluated in the order of definition, the first not null value becomes the default value of the column. The values are separated by comma or semicolon. a) Literals:. ''Text'' or 123 b) Variables - in format @Variable@ - Login e.g. #Date, #AD_Org_ID, #AD_Client_ID - Accounting Schema: e.g. $C_AcctSchema_ID, $C_Calendar_ID - Global defaults: e.g. DateFormat - Window values (all Picks, CheckBoxes, RadioButtons, and DateDoc/DateAcct) c) SQL code with the tag: @SQL=SELECT something AS DefaultValue FROM ... The SQL statement can contain variables.  There can be no other value other than the SQL statement. The default is only evaluated, if no user preference is defined.  Default definitions are ignored for record columns as Key, Parent, Client as well as Buttons.',200233,'DefaultValue2',2000,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2019-10-09 08:46:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-09 08:46:35','YYYY-MM-DD HH24:MI:SS'),100,1529,'Y','N','U','N','N','N','Y','da8ee557-d9d1-4ed7-b129-3e83efe39e70','Y',0,'N','N','N')
;

-- Oct 9, 2019, 8:46:37 AM BRT
ALTER TABLE AD_UserDef_Proc_Parameter ADD COLUMN DefaultValue2 VARCHAR(2000) DEFAULT NULL
;

-- Oct 9, 2019, 8:46:54 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214064,0,'Placeholder',200233,'Placeholder',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2019-10-09 08:46:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-09 08:46:54','YYYY-MM-DD HH24:MI:SS'),100,203163,'Y','N','U','N','N','N','Y','c4a41150-cd3f-4faf-893b-f2ad62a055ae','Y',0,'N','N','N','N')
;

-- Oct 9, 2019, 8:46:55 AM BRT
ALTER TABLE AD_UserDef_Proc_Parameter ADD COLUMN Placeholder VARCHAR(255) DEFAULT NULL
;

-- Oct 9, 2019, 8:47:23 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214065,0,'Placeholder2',200233,'Placeholder2',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2019-10-09 08:47:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-09 08:47:23','YYYY-MM-DD HH24:MI:SS'),100,203164,'Y','N','U','N','N','N','Y','3c28e134-1b0b-458f-8076-eb96b678cd3b','Y',0,'N','N','N','N')
;

-- Oct 9, 2019, 8:47:25 AM BRT
ALTER TABLE AD_UserDef_Proc_Parameter ADD COLUMN Placeholder2 VARCHAR(255) DEFAULT NULL
;

-- Oct 9, 2019, 8:48:40 AM BRT
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2019-10-09 08:48:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214060
;

-- Oct 9, 2019, 8:48:53 AM BRT
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2019-10-09 08:48:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214061
;

-- Oct 9, 2019, 8:49:13 AM BRT
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2019-10-09 08:49:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214062
;

-- Oct 9, 2019, 8:49:28 AM BRT
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2019-10-09 08:49:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214063
;

-- Oct 9, 2019, 8:49:42 AM BRT
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2019-10-09 08:49:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214064
;

-- Oct 9, 2019, 8:49:58 AM BRT
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2019-10-09 08:49:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214065
;

-- Oct 9, 2019, 8:50:17 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206186,'Reference','System Reference and Validation','The Reference could be a display type, list or table validation.',200235,214060,'Y',22,140,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-10-09 08:50:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-09 08:50:16','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b7bde4d7-9288-4090-b73e-6ec8908126a9','Y',140,2)
;

-- Oct 9, 2019, 8:50:17 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206187,'Reference Key','Required to specify, if data type is Table or List','The Reference Value indicates where the reference values are stored.  It must be specified if the data type is Table or List.  ',200235,214061,'Y',22,150,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-10-09 08:50:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-09 08:50:17','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5ab7818d-48e0-4e82-a984-aae926e18df6','Y',150,2)
;

-- Oct 9, 2019, 8:50:17 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206188,'Dynamic Validation','Dynamic Validation Rule','These rules define how an entry is determined to valid. You can use variables for dynamic (context sensitive) validation.',200235,214062,'Y',22,160,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-10-09 08:50:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-09 08:50:17','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','4405f6ec-f63f-4d68-a046-4672e33c933c','Y',160,2)
;

-- Oct 9, 2019, 8:50:17 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206189,'Default Logic 2','Default value hierarchy, separated by ;','The defaults are evaluated in the order of definition, the first not null value becomes the default value of the column. The values are separated by comma or semicolon. a) Literals:. ''Text'' or 123 b) Variables - in format @Variable@ - Login e.g. #Date, #AD_Org_ID, #AD_Client_ID - Accounting Schema: e.g. $C_AcctSchema_ID, $C_Calendar_ID - Global defaults: e.g. DateFormat - Window values (all Picks, CheckBoxes, RadioButtons, and DateDoc/DateAcct) c) SQL code with the tag: @SQL=SELECT something AS DefaultValue FROM ... The SQL statement can contain variables.  There can be no other value other than the SQL statement. The default is only evaluated, if no user preference is defined.  Default definitions are ignored for record columns as Key, Parent, Client as well as Buttons.',200235,214063,'Y',2000,170,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-10-09 08:50:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-09 08:50:17','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','57b7dbbd-6845-42d6-8f54-ba0961b77dba','Y',170,5)
;

-- Oct 9, 2019, 8:50:17 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206190,'Placeholder',200235,214064,'Y',255,180,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-10-09 08:50:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-09 08:50:17','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','0d271d9d-7e9b-48c6-9aec-e3133f89f66a','Y',180,5)
;

-- Oct 9, 2019, 8:50:17 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206191,'Placeholder2',200235,214065,'Y',255,190,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-10-09 08:50:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-09 08:50:17','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','4dba44e7-e226-44fe-86a3-0516fc249f92','Y',190,5)
;

-- Oct 9, 2019, 8:51:13 AM BRT
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, IsAdvancedField='Y',Updated=TO_TIMESTAMP('2019-10-09 08:51:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206186
;

-- Oct 9, 2019, 8:51:23 AM BRT
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, IsAdvancedField='Y',Updated=TO_TIMESTAMP('2019-10-09 08:51:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206187
;

-- Oct 9, 2019, 8:51:29 AM BRT
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, IsAdvancedField='Y',Updated=TO_TIMESTAMP('2019-10-09 08:51:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206188
;

-- Oct 9, 2019, 8:51:34 AM BRT
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, IsAdvancedField='Y',Updated=TO_TIMESTAMP('2019-10-09 08:51:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206189
;

-- Oct 9, 2019, 8:53:08 AM BRT
UPDATE AD_Field SET SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ColumnSpan=2, NumLines=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-09 08:53:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205270
;

-- Oct 9, 2019, 8:53:12 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-09 08:53:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206189
;

-- Oct 9, 2019, 8:53:16 AM BRT
UPDATE AD_Field SET SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-09 08:53:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205276
;

-- Oct 9, 2019, 8:53:20 AM BRT
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-09 08:53:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205269
;

-- Oct 9, 2019, 8:53:24 AM BRT
UPDATE AD_Field SET SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-09 08:53:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205267
;

-- Oct 9, 2019, 8:53:28 AM BRT
UPDATE AD_Field SET SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-09 08:53:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206186
;

-- Oct 9, 2019, 8:53:32 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-09 08:53:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206187
;

-- Oct 9, 2019, 8:53:36 AM BRT
UPDATE AD_Field SET SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-09 08:53:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206188
;

-- Oct 9, 2019, 9:00:16 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-09 09:00:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206190
;

-- Oct 9, 2019, 9:00:20 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-09 09:00:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206191
;

-- Oct 9, 2019, 9:00:24 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-09 09:00:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206186
;

-- Oct 9, 2019, 9:00:28 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-09 09:00:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206187
;

-- Oct 9, 2019, 9:00:32 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-09 09:00:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206188
;

-- Oct 9, 2019, 9:00:36 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-09 09:00:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205270
;

-- Oct 9, 2019, 9:00:40 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-09 09:00:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206189
;

-- Oct 9, 2019, 9:00:44 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-09 09:00:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205267
;

-- Oct 9, 2019, 9:00:48 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-09 09:00:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205275
;

-- Oct 9, 2019, 9:00:53 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-09 09:00:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205269
;

-- Oct 9, 2019, 9:00:57 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=190, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-09 09:00:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205276
;

-- Oct 9, 2019, 9:02:01 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214066,0,'Range','The parameter is a range of values','The Range checkbox indicates that this parameter is a range of values.',200233,'IsRange',1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2019-10-09 09:02:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-09 09:02:01','YYYY-MM-DD HH24:MI:SS'),100,404,'Y','N','U','N','N','N','Y','a0ee1368-ee8c-44f6-93b4-1fbfca01817e','Y',0,'N','N','N')
;

-- Oct 9, 2019, 9:02:02 AM BRT
ALTER TABLE AD_UserDef_Proc_Parameter ADD COLUMN IsRange CHAR(1) DEFAULT NULL CHECK (IsRange IN ('Y','N'))
;

-- Oct 9, 2019, 9:02:42 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214067,0,'Mandatory','Data entry is required in this column','The field must have a value for the record to be saved to the database.',200233,'IsMandatory',1,'N','N','N','N','N',0,'N',17,319,0,0,'Y',TO_TIMESTAMP('2019-10-09 09:02:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-09 09:02:42','YYYY-MM-DD HH24:MI:SS'),100,392,'Y','N','D','N','N','N','Y','b7641677-94c3-49d4-921a-396923f042a7','Y',0,'N','N','N')
;

-- Oct 9, 2019, 9:02:43 AM BRT
ALTER TABLE AD_UserDef_Proc_Parameter ADD COLUMN IsMandatory CHAR(1) DEFAULT NULL
;

-- Oct 9, 2019, 9:03:17 AM BRT
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2019-10-09 09:03:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214066
;

-- Oct 9, 2019, 9:04:20 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214068,0,'Min. Value','Minimum Value for a field','The Minimum Value indicates the lowest  allowable value for a field.',200233,'ValueMin',20,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2019-10-09 09:04:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-09 09:04:20','YYYY-MM-DD HH24:MI:SS'),100,1060,'Y','N','D','N','N','N','Y','2adee1cc-6b16-4b4c-a43b-c91c9c9d2065','Y',0,'N','N','N')
;

-- Oct 9, 2019, 9:04:22 AM BRT
ALTER TABLE AD_UserDef_Proc_Parameter ADD COLUMN ValueMin VARCHAR(20) DEFAULT NULL
;

-- Oct 9, 2019, 9:06:05 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214069,0,'Max. Value','Maximum Value for a field','The Maximum Value indicates the highest allowable value for a field',200233,'ValueMax',20,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2019-10-09 09:06:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-09 09:06:05','YYYY-MM-DD HH24:MI:SS'),100,1059,'Y','N','D','N','N','N','Y','3ebf7eef-10f4-4f97-87a7-abe92946f204','Y',0,'N','N','N')
;

-- Oct 9, 2019, 9:06:07 AM BRT
ALTER TABLE AD_UserDef_Proc_Parameter ADD COLUMN ValueMax VARCHAR(20) DEFAULT NULL
;

-- Oct 9, 2019, 9:07:09 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206192,'Range','The parameter is a range of values','The Range checkbox indicates that this parameter is a range of values.',200235,214066,'Y',1,200,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-10-09 09:07:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-09 09:07:09','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','97f5d5ca-dd53-4487-93e2-6d2692382581','Y',200,2,2)
;

-- Oct 9, 2019, 9:07:09 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206193,'Mandatory','Data entry is required in this column','The field must have a value for the record to be saved to the database.',200235,214067,'Y',1,210,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-10-09 09:07:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-09 09:07:09','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','aeded41f-a3a8-4fdf-9913-be99f60e1f73','Y',210,2)
;

-- Oct 9, 2019, 9:07:09 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206194,'Min. Value','Minimum Value for a field','The Minimum Value indicates the lowest  allowable value for a field.',200235,214068,'Y',20,220,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-10-09 09:07:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-09 09:07:09','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','2af2f9db-258b-459a-8217-4fba77dfa250','Y',220,2)
;

-- Oct 9, 2019, 9:07:09 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206195,'Max. Value','Maximum Value for a field','The Maximum Value indicates the highest allowable value for a field',200235,214069,'Y',20,230,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-10-09 09:07:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-09 09:07:09','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','810550ab-4cfe-4d86-8911-ce9595b1201e','Y',230,2)
;

-- Oct 9, 2019, 9:08:19 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-09 09:08:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206192
;

-- Oct 9, 2019, 9:08:23 AM BRT
UPDATE AD_Field SET SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-09 09:08:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205261
;

-- Oct 9, 2019, 9:08:27 AM BRT
UPDATE AD_Field SET SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-09 09:08:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205262
;

-- Oct 9, 2019, 9:08:32 AM BRT
UPDATE AD_Field SET SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-09 09:08:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205263
;

-- Oct 9, 2019, 9:08:36 AM BRT
UPDATE AD_Field SET SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-09 09:08:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206190
;

-- Oct 9, 2019, 9:08:40 AM BRT
UPDATE AD_Field SET SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-09 09:08:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206191
;

-- Oct 9, 2019, 9:08:44 AM BRT
UPDATE AD_Field SET SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-09 09:08:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206186
;

-- Oct 9, 2019, 9:08:48 AM BRT
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-09 09:08:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206187
;

-- Oct 9, 2019, 9:08:52 AM BRT
UPDATE AD_Field SET SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-09 09:08:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206188
;

-- Oct 9, 2019, 9:08:56 AM BRT
UPDATE AD_Field SET SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-09 09:08:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205270
;

-- Oct 9, 2019, 9:09:00 AM BRT
UPDATE AD_Field SET SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-09 09:09:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206189
;

-- Oct 9, 2019, 9:09:04 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-09 09:09:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206194
;

-- Oct 9, 2019, 9:09:08 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-09 09:09:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206195
;

-- Oct 9, 2019, 9:09:12 AM BRT
UPDATE AD_Field SET SeqNo=190, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-09 09:09:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205267
;

-- Oct 9, 2019, 9:09:16 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=200, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-09 09:09:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206193
;

-- Oct 9, 2019, 9:09:20 AM BRT
UPDATE AD_Field SET SeqNo=210, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-09 09:09:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205275
;

-- Oct 9, 2019, 9:09:24 AM BRT
UPDATE AD_Field SET SeqNo=220, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-09 09:09:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205269
;

-- Oct 9, 2019, 9:09:28 AM BRT
UPDATE AD_Field SET SeqNo=230, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-09 09:09:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205276
;

-- Oct 9, 2019, 9:09:54 AM BRT
UPDATE AD_Field SET DisplayLogic='@IsRange@=''Y''', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-09 09:09:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206191
;

-- Oct 9, 2019, 9:10:11 AM BRT
UPDATE AD_Field SET DisplayLogic='@IsRange@=''Y''', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-09 09:10:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206189
;

-- Oct 9, 2019, 9:10:20 AM BRT
UPDATE AD_Field SET IsReadOnly='Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-09 09:10:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206192
;

-- Oct 9, 2019, 9:11:48 AM BRT
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, IsAdvancedField='Y',Updated=TO_TIMESTAMP('2019-10-09 09:11:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206194
;

-- Oct 9, 2019, 9:11:54 AM BRT
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, IsAdvancedField='N',Updated=TO_TIMESTAMP('2019-10-09 09:11:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206194
;

-- Oct 9, 2019, 9:13:49 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214070,0,'Sequence','Method of ordering records; lowest number comes first','The Sequence indicates the order of records',200233,'SeqNo',22,'N','N','N','N','N',0,'N',11,0,0,'Y',TO_TIMESTAMP('2019-10-09 09:13:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-09 09:13:49','YYYY-MM-DD HH24:MI:SS'),100,566,'Y','N','D','N','N','N','Y','907d7178-28fd-4d85-aa89-49dd714e7fe3','Y',0,'N','N','N')
;

-- Oct 9, 2019, 9:13:51 AM BRT
ALTER TABLE AD_UserDef_Proc_Parameter ADD COLUMN SeqNo NUMERIC(10) DEFAULT NULL
;

-- Oct 9, 2019, 9:14:26 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214071,0,'Value Format','Format of the value; Can contain fixed format elements, Variables: "_lLoOaAcCa09"','<B>Validation elements:</B>
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

Example of format "(000)_000-0000"',200233,'VFormat',40,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2019-10-09 09:14:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-09 09:14:26','YYYY-MM-DD HH24:MI:SS'),100,616,'Y','N','D','N','N','N','Y','bb90e98c-7d60-4274-888c-cd00c37347c1','Y',0,'N','N','N')
;

-- Oct 9, 2019, 9:14:28 AM BRT
ALTER TABLE AD_UserDef_Proc_Parameter ADD COLUMN VFormat VARCHAR(40) DEFAULT NULL
;

-- Oct 9, 2019, 9:14:46 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206196,'Sequence','Method of ordering records; lowest number comes first','The Sequence indicates the order of records',200235,214070,'Y',22,240,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-10-09 09:14:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-09 09:14:46','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a64fe786-50b3-452e-a204-de0d2317ce04','Y',240,2)
;

-- Oct 9, 2019, 9:14:46 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206197,'Value Format','Format of the value; Can contain fixed format elements, Variables: "_lLoOaAcCa09"','<B>Validation elements:</B>
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

Example of format "(000)_000-0000"',200235,214071,'Y',40,250,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-10-09 09:14:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-09 09:14:46','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c5765891-c41f-4a9b-bc02-d5ac965cb1ee','Y',250,2)
;

-- Oct 9, 2019, 9:16:04 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-09 09:16:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206196
;

-- Oct 9, 2019, 9:16:08 AM BRT
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-09 09:16:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206186
;

-- Oct 9, 2019, 9:16:12 AM BRT
UPDATE AD_Field SET SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-09 09:16:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206187
;

-- Oct 9, 2019, 9:16:16 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-09 09:16:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206197
;

-- Oct 9, 2019, 9:16:20 AM BRT
UPDATE AD_Field SET SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-09 09:16:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206188
;

-- Oct 9, 2019, 9:16:24 AM BRT
UPDATE AD_Field SET SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-09 09:16:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205270
;

-- Oct 9, 2019, 9:16:28 AM BRT
UPDATE AD_Field SET SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-09 09:16:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206189
;

-- Oct 9, 2019, 9:16:32 AM BRT
UPDATE AD_Field SET SeqNo=190, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-09 09:16:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206194
;

-- Oct 9, 2019, 9:16:36 AM BRT
UPDATE AD_Field SET SeqNo=200, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-09 09:16:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206195
;

-- Oct 9, 2019, 9:16:40 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=210, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-09 09:16:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206193
;

-- Oct 9, 2019, 9:16:44 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=220, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-09 09:16:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205267
;

-- Oct 9, 2019, 9:16:48 AM BRT
UPDATE AD_Field SET SeqNo=230, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-09 09:16:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205275
;

-- Oct 9, 2019, 9:16:52 AM BRT
UPDATE AD_Field SET SeqNo=240, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-09 09:16:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205269
;

-- Oct 9, 2019, 9:16:56 AM BRT
UPDATE AD_Field SET SeqNo=250, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-09 09:16:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205276
;



SELECT register_migration_script('201910091045_IDEMPIERE-3971.sql') FROM dual
;