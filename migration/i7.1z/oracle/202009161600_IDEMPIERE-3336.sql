SET SQLBLANKLINES ON
SET DEFINE OFF

-- 08/04/2017 11h23min15s BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (212979,0,'Entity Type','Dictionary Entity Type; Determines ownership and synchronization','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.

For customizations, copy the entity and select "User"!',200108,'EntityType','U',40,'N','N','N','N','N',0,'N',18,389,0,0,'Y',TO_DATE('2017-04-08 11:23:15','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-04-08 11:23:15','YYYY-MM-DD HH24:MI:SS'),100,1682,'Y','N','@EntityType@=D','D','N','N','N','Y','b70c3127-a44f-4b93-8ed7-8c7782cae0af','Y',0,'N','N','N')
;

-- 08/04/2017 11h23min15s BRT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=212979 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- 08/04/2017 11h23min19s BRT
UPDATE AD_Column SET FKConstraintName='EntityType_ADStatusLineUsedIn', FKConstraintType='N',Updated=TO_DATE('2017-04-08 11:23:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212979
;

-- 08/04/2017 11h23min19s BRT
ALTER TABLE AD_StatusLineUsedIn ADD EntityType VARCHAR2(40 CHAR) DEFAULT 'U'
;

-- 08/04/2017 11h23min19s BRT
ALTER TABLE AD_StatusLineUsedIn ADD CONSTRAINT EntityType_ADStatusLineUsedIn FOREIGN KEY (EntityType) REFERENCES ad_entitytype(entitytype) DEFERRABLE INITIALLY DEFERRED
;

-- 08/04/2017 11h23min25s BRT
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_DATE('2017-04-08 11:23:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212979
;

-- 08/04/2017 11h23min38s BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (204396,'Entity Type','Dictionary Entity Type; Determines ownership and synchronization','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.

For customizations, copy the entity and select "User"!',200115,212979,'Y',40,100,'N','N','N','N',0,0,'Y',TO_DATE('2017-04-08 11:23:38','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-04-08 11:23:38','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','02b6f8ca-4f17-4c7b-b4f8-4d135026fe6f','Y',70,2)
;

-- 08/04/2017 11h23min38s BRT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Name,Description,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Name,t.Description,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=204396 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- 08/04/2017 11h24min15s BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2017-04-08 11:24:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204396
;

-- 08/04/2017 11h24min15s BRT
UPDATE AD_Field SET SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-04-08 11:24:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202574
;

-- 08/04/2017 11h24min15s BRT
UPDATE AD_Field SET SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-04-08 11:24:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202575
;

-- 08/04/2017 11h24min15s BRT
UPDATE AD_Field SET SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-04-08 11:24:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202576
;

-- 08/04/2017 11h24min15s BRT
UPDATE AD_Field SET SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-04-08 11:24:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202577
;

-- 08/04/2017 11h24min15s BRT
UPDATE AD_Field SET SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-04-08 11:24:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202578
;

-- 08/04/2017 11h26min12s BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (212980,0,'Entity Type','Dictionary Entity Type; Determines ownership and synchronization','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.

For customizations, copy the entity and select "User"!',53246,'EntityType','U',40,'N','N','N','N','N',0,'N',18,389,0,0,'Y',TO_DATE('2017-04-08 11:26:12','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-04-08 11:26:12','YYYY-MM-DD HH24:MI:SS'),100,1682,'Y','N','@EntityType@=D','D','N','N','N','Y','63a6fc98-ab62-4381-abc4-3e1350f36b33','Y',0,'N','N','N')
;

-- 08/04/2017 11h26min12s BRT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=212980 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- 08/04/2017 11h26min16s BRT
UPDATE AD_Column SET FKConstraintName='EntityType_ADRelationType', FKConstraintType='N',Updated=TO_DATE('2017-04-08 11:26:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212980
;

-- 08/04/2017 11h26min16s BRT
ALTER TABLE AD_RelationType ADD EntityType VARCHAR2(40 CHAR) DEFAULT 'U'
;

-- 08/04/2017 11h26min16s BRT
ALTER TABLE AD_RelationType ADD CONSTRAINT EntityType_ADRelationType FOREIGN KEY (EntityType) REFERENCES ad_entitytype(entitytype) DEFERRABLE INITIALLY DEFERRED
;

-- 08/04/2017 11h26min21s BRT
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_DATE('2017-04-08 11:26:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212980
;

-- Sep 16, 2020, 3:14:12 PM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206507,'Entity Type','Dictionary Entity Type; Determines ownership and synchronization','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.  

For customizations, copy the entity and select "User"!',53285,212980,'Y',40,120,'N','N','N','N',0,0,'Y',TO_DATE('2020-09-16 15:14:12','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-16 15:14:12','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e53eabd4-26e2-4368-ac3e-fe600baa6819','Y',120,2)
;

-- Sep 16, 2020, 3:14:30 PM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2020-09-16 15:14:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206507
;

-- Sep 16, 2020, 3:14:30 PM BRT
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-09-16 15:14:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204581
;

-- defines all records as user customization
update AD_RelationType set EntityType='U';
update AD_StatusLineUsedIn set EntityType='U';

-- restore core records as EntityType = 'D'
update AD_StatusLineUsedIn set EntityType='D' where AD_StatusLineUsedIn_ID < 1000000;
update AD_RelationType set EntityType='D' where AD_RelationType_ID < 1000000;

-- Sep 20, 2020, 3:26:57 PM CEST
UPDATE AD_Column SET DefaultValue='@SQL=select get_sysconfig(''DEFAULT_ENTITYTYPE'',''U'',0,0) from dual',Updated=TO_DATE('2020-09-20 15:26:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212979
;

-- Sep 20, 2020, 3:27:27 PM CEST
UPDATE AD_Column SET DefaultValue='@SQL=select get_sysconfig(''DEFAULT_ENTITYTYPE'',''U'',0,0) from dual',Updated=TO_DATE('2020-09-20 15:27:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212980
;

SELECT register_migration_script('202009161600_IDEMPIERE-3336.sql') FROM dual
;
