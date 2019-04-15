SET SQLBLANKLINES ON
SET DEFINE OFF

-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
-- Apr 15, 2019, 11:03:47 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (213899,0,'Entity Type','Dictionary Entity Type; Determines ownership and synchronization','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.  

For customizations, copy the entity and select "User"!',200066,'EntityType','@SQL=select get_sysconfig(''DEFAULT_ENTITYTYPE'',''U'',0,0) from dual',40,'N','N','Y','N','N',0,'N',18,389,0,0,'Y',TO_DATE('2019-04-15 11:03:47','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-04-15 11:03:47','YYYY-MM-DD HH24:MI:SS'),100,1682,'Y','N','@EntityType@=D','U','N','N','N','Y','529ec6b3-d8af-4f97-b426-5be52bdb5ed2','Y',0,'N','N','N','N')
;

-- Apr 15, 2019, 11:03:52 AM BRT
UPDATE AD_Column SET FKConstraintName='EntityType_ADZoomCondition', FKConstraintType='N',Updated=TO_DATE('2019-04-15 11:03:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213899
;

-- Apr 15, 2019, 11:03:52 AM BRT
--ALTER TABLE AD_ZoomCondition ADD EntityType VARCHAR2(40) NOT NULL
--;

-- Apr 15, 2019, 11:04:33 AM BRT
UPDATE AD_Table SET AD_Window_ID=100,Updated=TO_DATE('2019-04-15 11:04:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200066
;

-- Apr 15, 2019, 11:05:27 AM BRT
UPDATE AD_Column SET IsMandatory='N',Updated=TO_DATE('2019-04-15 11:05:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213899
;

-- Apr 15, 2019, 11:05:32 AM BRT
UPDATE AD_Column SET FKConstraintName='EntityType_ADZoomCondition', FKConstraintType='N',Updated=TO_DATE('2019-04-15 11:05:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213899
;

-- Apr 15, 2019, 11:05:32 AM BRT
ALTER TABLE AD_ZoomCondition ADD EntityType VARCHAR2(40) DEFAULT NULL 
;

-- Apr 15, 2019, 11:05:32 AM BRT
ALTER TABLE AD_ZoomCondition ADD CONSTRAINT EntityType_ADZoomCondition FOREIGN KEY (EntityType) REFERENCES ad_entitytype(entitytype) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 15, 2019, 11:06:18 AM BRT
UPDATE AD_Column SET EntityType='D',Updated=TO_DATE('2019-04-15 11:06:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213899
;

-- Apr 15, 2019, 11:06:38 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206036,'Entity Type','Dictionary Entity Type; Determines ownership and synchronization','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.  

For customizations, copy the entity and select "User"!',200077,213899,'Y',40,110,'N','N','N','N',0,0,'Y',TO_DATE('2019-04-15 11:06:37','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-04-15 11:06:37','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','02ba6491-75e0-4187-8f22-2ebb7b4c2fd4','Y',90,2)
;

-- Apr 15, 2019, 11:06:51 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:06:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206036
;

-- Apr 15, 2019, 11:06:51 AM BRT
UPDATE AD_Field SET SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:06:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202338
;

-- Apr 15, 2019, 11:06:51 AM BRT
UPDATE AD_Field SET SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:06:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201831
;

-- Apr 15, 2019, 11:06:51 AM BRT
UPDATE AD_Field SET SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:06:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202540
;

-- Apr 15, 2019, 11:06:51 AM BRT
UPDATE AD_Field SET SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:06:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202337
;

-- Apr 15, 2019, 11:06:51 AM BRT
UPDATE AD_Field SET SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:06:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201837
;

-- Apr 15, 2019, 11:06:51 AM BRT
UPDATE AD_Field SET SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:06:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201828
;

-- Apr 15, 2019, 11:07:21 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (213900,0,'Entity Type','Dictionary Entity Type; Determines ownership and synchronization','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.  

For customizations, copy the entity and select "User"!',200207,'EntityType','@SQL=select get_sysconfig(''DEFAULT_ENTITYTYPE'',''U'',0,0) from dual',40,'N','N','N','N','N',0,'N',18,389,0,0,'Y',TO_DATE('2019-04-15 11:07:21','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-04-15 11:07:21','YYYY-MM-DD HH24:MI:SS'),100,1682,'Y','N','@EntityType@=D','D','N','N','N','Y','dcdc586f-0133-46b9-9bb8-5d162f73927b','Y',0,'N','N','N','N')
;

-- Apr 15, 2019, 11:07:25 AM BRT
UPDATE AD_Column SET FKConstraintName='EntityType_ADStyle', FKConstraintType='N',Updated=TO_DATE('2019-04-15 11:07:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213900
;

-- Apr 15, 2019, 11:07:25 AM BRT
ALTER TABLE AD_Style ADD EntityType VARCHAR2(40) DEFAULT NULL 
;

-- Apr 15, 2019, 11:07:25 AM BRT
ALTER TABLE AD_Style ADD CONSTRAINT EntityType_ADStyle FOREIGN KEY (EntityType) REFERENCES ad_entitytype(entitytype) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 15, 2019, 11:07:32 AM BRT
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_DATE('2019-04-15 11:07:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213900
;

-- Apr 15, 2019, 11:08:03 AM BRT
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_DATE('2019-04-15 11:08:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213899
;

-- Apr 15, 2019, 11:08:26 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (213901,0,'Entity Type','Dictionary Entity Type; Determines ownership and synchronization','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.  

For customizations, copy the entity and select "User"!',200208,'EntityType','@SQL=select get_sysconfig(''DEFAULT_ENTITYTYPE'',''U'',0,0) from dual',40,'N','N','N','N','N',0,'N',18,389,0,0,'Y',TO_DATE('2019-04-15 11:08:26','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-04-15 11:08:26','YYYY-MM-DD HH24:MI:SS'),100,1682,'Y','N','@EntityType@=D','U','N','N','N','Y','0082956f-70e8-4bf0-98e0-1df01b9db4b0','Y',0,'N','N','N','N')
;

-- Apr 15, 2019, 11:08:28 AM BRT
UPDATE AD_Column SET FKConstraintName='EntityType_ADStyleLine', FKConstraintType='N',Updated=TO_DATE('2019-04-15 11:08:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213901
;

-- Apr 15, 2019, 11:08:28 AM BRT
ALTER TABLE AD_StyleLine ADD EntityType VARCHAR2(40) DEFAULT NULL 
;

-- Apr 15, 2019, 11:08:28 AM BRT
ALTER TABLE AD_StyleLine ADD CONSTRAINT EntityType_ADStyleLine FOREIGN KEY (EntityType) REFERENCES ad_entitytype(entitytype) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 15, 2019, 11:08:37 AM BRT
UPDATE AD_Column SET IsMandatory='Y', EntityType='D',Updated=TO_DATE('2019-04-15 11:08:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213901
;

-- Apr 15, 2019, 11:08:47 AM BRT
UPDATE AD_Table SET AccessLevel='6',Updated=TO_DATE('2019-04-15 11:08:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200208
;

-- Apr 15, 2019, 11:08:56 AM BRT
UPDATE AD_Table SET AccessLevel='6',Updated=TO_DATE('2019-04-15 11:08:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200207
;

-- Apr 15, 2019, 11:09:36 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206037,'Entity Type','Dictionary Entity Type; Determines ownership and synchronization','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.  

For customizations, copy the entity and select "User"!',200213,213900,'Y',40,60,'N','N','N','N',0,0,'Y',TO_DATE('2019-04-15 11:09:36','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-04-15 11:09:36','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c86b7ac9-3ea4-4073-8d34-053ea350a40f','Y',40,2)
;

-- Apr 15, 2019, 11:09:49 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:09:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206037
;

-- Apr 15, 2019, 11:09:49 AM BRT
UPDATE AD_Field SET SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:09:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204199
;

-- Apr 15, 2019, 11:09:49 AM BRT
UPDATE AD_Field SET SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:09:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204202
;

-- Apr 15, 2019, 11:10:01 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206038,'Entity Type','Dictionary Entity Type; Determines ownership and synchronization','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.  

For customizations, copy the entity and select "User"!',200214,213901,'Y',40,90,'N','N','N','N',0,0,'Y',TO_DATE('2019-04-15 11:10:01','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-04-15 11:10:01','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','0ef32b4c-a3c6-4e33-ada9-e3f3a3cd9848','Y',70,2)
;

-- Apr 15, 2019, 11:10:13 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:10:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206038
;

-- Apr 15, 2019, 11:10:13 AM BRT
UPDATE AD_Field SET SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:10:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204208
;

-- Apr 15, 2019, 11:10:13 AM BRT
UPDATE AD_Field SET SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:10:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204209
;

-- Apr 15, 2019, 11:10:13 AM BRT
UPDATE AD_Field SET SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:10:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204210
;

-- Apr 15, 2019, 11:10:13 AM BRT
UPDATE AD_Field SET SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:10:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204212
;

-- Apr 15, 2019, 11:10:50 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (213902,0,'Entity Type','Dictionary Entity Type; Determines ownership and synchronization','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.  

For customizations, copy the entity and select "User"!',200003,'EntityType','@SQL=select get_sysconfig(''DEFAULT_ENTITYTYPE'',''U'',0,0) from dual',40,'N','N','N','N','N',0,'N',18,389,0,0,'Y',TO_DATE('2019-04-15 11:10:50','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-04-15 11:10:50','YYYY-MM-DD HH24:MI:SS'),100,1682,'Y','N','@EntityType@=D','D','N','N','N','Y','2d76f892-68a4-4b25-8788-54be8f433d38','Y',0,'N','N','N','N')
;

-- Apr 15, 2019, 11:10:52 AM BRT
UPDATE AD_Column SET FKConstraintName='EntityType_ADToolBarButton', FKConstraintType='N',Updated=TO_DATE('2019-04-15 11:10:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213902
;

-- Apr 15, 2019, 11:10:52 AM BRT
ALTER TABLE AD_ToolBarButton ADD EntityType VARCHAR2(40) DEFAULT NULL 
;

-- Apr 15, 2019, 11:10:52 AM BRT
ALTER TABLE AD_ToolBarButton ADD CONSTRAINT EntityType_ADToolBarButton FOREIGN KEY (EntityType) REFERENCES ad_entitytype(entitytype) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 15, 2019, 11:11:14 AM BRT
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_DATE('2019-04-15 11:11:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213902
;

-- Apr 15, 2019, 11:11:46 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206039,'Entity Type','Dictionary Entity Type; Determines ownership and synchronization','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.  

For customizations, copy the entity and select "User"!',200002,213902,'Y',40,130,'N','N','N','N',0,0,'Y',TO_DATE('2019-04-15 11:11:45','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-04-15 11:11:45','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d7b93ca1-e491-45a5-a586-35adfa4845e0','Y',130,2)
;

-- Apr 15, 2019, 11:11:57 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:11:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206039
;

-- Apr 15, 2019, 11:11:57 AM BRT
UPDATE AD_Field SET SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:11:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200056
;

-- Apr 15, 2019, 11:11:57 AM BRT
UPDATE AD_Field SET SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:11:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200057
;

-- Apr 15, 2019, 11:11:57 AM BRT
UPDATE AD_Field SET SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:11:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200051
;

-- Apr 15, 2019, 11:11:57 AM BRT
UPDATE AD_Field SET SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:11:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202527
;

-- Apr 15, 2019, 11:11:57 AM BRT
UPDATE AD_Field SET SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:11:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200053
;

-- Apr 15, 2019, 11:11:57 AM BRT
UPDATE AD_Field SET SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:11:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200753
;

-- Apr 15, 2019, 11:11:57 AM BRT
UPDATE AD_Field SET SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:11:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202546
;

-- Apr 15, 2019, 11:11:57 AM BRT
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:11:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202547
;

-- Apr 15, 2019, 11:11:57 AM BRT
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:11:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204606
;

-- Apr 15, 2019, 11:12:38 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206040,'Entity Type','Dictionary Entity Type; Determines ownership and synchronization','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.  

For customizations, copy the entity and select "User"!',200028,213902,'Y',40,100,'N','N','N','N',0,0,'Y',TO_DATE('2019-04-15 11:12:38','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-04-15 11:12:38','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5787f4a0-ac79-42f2-9121-0c18fac81ab2','Y',80,2)
;

-- Apr 15, 2019, 11:12:55 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:12:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206040
;

-- Apr 15, 2019, 11:12:55 AM BRT
UPDATE AD_Field SET SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:12:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200746
;

-- Apr 15, 2019, 11:12:55 AM BRT
UPDATE AD_Field SET SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:12:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200741
;

-- Apr 15, 2019, 11:12:55 AM BRT
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:12:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200749
;

-- Apr 15, 2019, 11:13:31 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (213903,0,'Entity Type','Dictionary Entity Type; Determines ownership and synchronization','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.  

For customizations, copy the entity and select "User"!',53169,'EntityType','@SQL=select get_sysconfig(''DEFAULT_ENTITYTYPE'',''U'',0,0) from dual',40,'N','N','N','N','N',0,'N',18,389,0,0,'Y',TO_DATE('2019-04-15 11:13:31','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-04-15 11:13:31','YYYY-MM-DD HH24:MI:SS'),100,1682,'Y','N','@EntityType@=D','D','N','N','N','Y','03e45d96-7bff-45e9-93f7-2db8530426af','Y',0,'N','N','N','N')
;

-- Apr 15, 2019, 11:13:33 AM BRT
UPDATE AD_Column SET FKConstraintName='EntityType_ADSearchDefinition', FKConstraintType='N',Updated=TO_DATE('2019-04-15 11:13:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213903
;

-- Apr 15, 2019, 11:13:33 AM BRT
ALTER TABLE AD_SearchDefinition ADD EntityType VARCHAR2(40) DEFAULT NULL 
;

-- Apr 15, 2019, 11:13:33 AM BRT
ALTER TABLE AD_SearchDefinition ADD CONSTRAINT EntityType_ADSearchDefinition FOREIGN KEY (EntityType) REFERENCES ad_entitytype(entitytype) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 15, 2019, 11:13:38 AM BRT
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_DATE('2019-04-15 11:13:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213903
;

-- Apr 15, 2019, 11:14:21 AM BRT
UPDATE AD_Table SET AD_Window_ID=53069,Updated=TO_DATE('2019-04-15 11:14:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=53169
;

-- Apr 15, 2019, 11:14:45 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206041,'Entity Type','Dictionary Entity Type; Determines ownership and synchronization','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.  

For customizations, copy the entity and select "User"!',53193,213903,'Y',40,150,'N','N','N','N',0,0,'Y',TO_DATE('2019-04-15 11:14:45','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-04-15 11:14:45','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','2d771805-e3a5-4fef-96db-d7a6473676de','Y',150,2)
;

-- Apr 15, 2019, 11:15:02 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:15:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206041
;

-- Apr 15, 2019, 11:15:02 AM BRT
UPDATE AD_Field SET SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:15:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56708
;

-- Apr 15, 2019, 11:15:02 AM BRT
UPDATE AD_Field SET SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:15:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56707
;

-- Apr 15, 2019, 11:15:02 AM BRT
UPDATE AD_Field SET SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:15:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56702
;

-- Apr 15, 2019, 11:15:02 AM BRT
UPDATE AD_Field SET SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:15:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56718
;

-- Apr 15, 2019, 11:15:02 AM BRT
UPDATE AD_Field SET SeqNo=90,Updated=TO_DATE('2019-04-15 11:15:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56711
;

-- Apr 15, 2019, 11:15:02 AM BRT
UPDATE AD_Field SET SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:15:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56712
;

-- Apr 15, 2019, 11:15:02 AM BRT
UPDATE AD_Field SET SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:15:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56705
;

-- Apr 15, 2019, 11:15:02 AM BRT
UPDATE AD_Field SET SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:15:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56710
;

-- Apr 15, 2019, 11:15:02 AM BRT
UPDATE AD_Field SET SeqNo=130,Updated=TO_DATE('2019-04-15 11:15:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56706
;

-- Apr 15, 2019, 11:15:02 AM BRT
UPDATE AD_Field SET SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:15:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56714
;

-- Apr 15, 2019, 11:15:02 AM BRT
UPDATE AD_Field SET SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:15:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56717
;

-- Apr 15, 2019, 11:15:02 AM BRT
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:15:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204596
;

-- Apr 15, 2019, 11:15:02 AM BRT
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:15:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56703
;

-- Apr 15, 2019, 11:15:29 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (213904,0,'Entity Type','Dictionary Entity Type; Determines ownership and synchronization','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.  

For customizations, copy the entity and select "User"!',200216,'EntityType','@SQL=select get_sysconfig(''DEFAULT_ENTITYTYPE'',''U'',0,0) from dual',40,'N','N','N','N','N',0,'N',18,389,0,0,'Y',TO_DATE('2019-04-15 11:15:29','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-04-15 11:15:29','YYYY-MM-DD HH24:MI:SS'),100,1682,'Y','N','@EntityType@=D','U','N','N','N','Y','94dd884e-a302-4300-8869-353950a48bf1','Y',0,'N','N','N','N')
;

-- Apr 15, 2019, 11:15:31 AM BRT
UPDATE AD_Column SET FKConstraintName='EntityType_PADocumentStatus', FKConstraintType='N',Updated=TO_DATE('2019-04-15 11:15:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213904
;

-- Apr 15, 2019, 11:15:31 AM BRT
ALTER TABLE PA_DocumentStatus ADD EntityType VARCHAR2(40) DEFAULT NULL 
;

-- Apr 15, 2019, 11:15:31 AM BRT
ALTER TABLE PA_DocumentStatus ADD CONSTRAINT EntityType_PADocumentStatus FOREIGN KEY (EntityType) REFERENCES ad_entitytype(entitytype) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 15, 2019, 11:15:38 AM BRT
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_DATE('2019-04-15 11:15:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213904
;

-- Apr 15, 2019, 11:15:45 AM BRT
UPDATE AD_Column SET EntityType='D',Updated=TO_DATE('2019-04-15 11:15:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213904
;

-- Apr 15, 2019, 11:16:09 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206042,'Entity Type','Dictionary Entity Type; Determines ownership and synchronization','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.  

For customizations, copy the entity and select "User"!',200222,213904,'Y',40,180,'N','N','N','N',0,0,'Y',TO_DATE('2019-04-15 11:16:09','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-04-15 11:16:09','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','0606eb2e-5262-49ec-af02-d66af64cb012','Y',180,2)
;

-- Apr 15, 2019, 11:16:44 AM BRT
UPDATE AD_Field SET SeqNo=30, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:16:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204401
;

-- Apr 15, 2019, 11:16:44 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:16:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206042
;

-- Apr 15, 2019, 11:16:44 AM BRT
UPDATE AD_Field SET SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:16:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204402
;

-- Apr 15, 2019, 11:16:44 AM BRT
UPDATE AD_Field SET SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:16:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204416
;

-- Apr 15, 2019, 11:16:44 AM BRT
UPDATE AD_Field SET SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:16:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204404
;

-- Apr 15, 2019, 11:16:44 AM BRT
UPDATE AD_Field SET SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:16:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204405
;

-- Apr 15, 2019, 11:16:44 AM BRT
UPDATE AD_Field SET SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:16:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204406
;

-- Apr 15, 2019, 11:16:44 AM BRT
UPDATE AD_Field SET SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:16:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204407
;

-- Apr 15, 2019, 11:16:44 AM BRT
UPDATE AD_Field SET SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:16:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204409
;

-- Apr 15, 2019, 11:16:44 AM BRT
UPDATE AD_Field SET SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:16:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204408
;

-- Apr 15, 2019, 11:16:44 AM BRT
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:16:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204411
;

-- Apr 15, 2019, 11:16:44 AM BRT
UPDATE AD_Field SET SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:16:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204410
;

-- Apr 15, 2019, 11:16:44 AM BRT
UPDATE AD_Field SET SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:16:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204412
;

-- Apr 15, 2019, 11:16:44 AM BRT
UPDATE AD_Field SET SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:16:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204413
;

-- Apr 15, 2019, 11:16:44 AM BRT
UPDATE AD_Field SET SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:16:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204414
;

-- Apr 15, 2019, 11:16:44 AM BRT
UPDATE AD_Field SET SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:16:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204415
;

-- Apr 15, 2019, 11:16:44 AM BRT
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-04-15 11:16:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204984
;

-- set defaults for existing dictionary records
update ad_zoomcondition set entitytype = 'D' where ad_zoomcondition_id in (200001,200002,200003,200004,200005,200006);
update ad_style set entitytype = 'D' where ad_style_id in (200000);
update ad_styleline set entitytype = 'D' where ad_styleline_id in (200000);
update ad_toolbarbutton set entitytype = 'D' where ad_toolbarbutton_id in (200042,200059,200060,200061,200062,200063,200064,200066,200069,200070,200071,200072,200068,200073,200074,200075,200045,200077,200034,200046,200047,200048,200029,200031,200032,200033,200035,200037,200038,200039,200040,200030,200036,200057,200078,200056,200055,200054,200053,200052,200051,200050,200049,200043,200058,200041,200079,200082,200083,200084,200085,200086,200081,200067,200044,200088,200096,200097);
update AD_SearchDefinition set entitytype = 'D' where ad_searchdefinition_id in (50000,50001);
update pa_documentstatus set entitytype = 'D' where pa_documentstatus_id in (200000,200001,200002,200003,200005,200004);

SELECT register_migration_script('201904151144_IDEMPIERE-3952.sql') FROM dual
;