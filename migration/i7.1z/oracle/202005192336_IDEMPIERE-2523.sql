SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-2523 improve method to add comment to log script
-- May 19, 2020, 11:32:52 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203417,0,0,'Y',TO_DATE('2020-05-19 23:32:22','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-05-19 23:32:22','YYYY-MM-DD HH24:MI:SS'),100,'MigrationScriptComment','Migration Script Comment',NULL,NULL,'Migration Script Comment','D','f6a393c7-fe39-45d9-834b-2d6b43a92093')
;

-- May 19, 2020, 11:34:33 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214200,0,'Migration Script Comment',200174,'MigrationScriptComment',NULL,255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_DATE('2020-05-19 23:34:32','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-05-19 23:34:32','YYYY-MM-DD HH24:MI:SS'),100,203417,'Y','N','D','N','N','N','Y','da1fd9e7-cc0f-467d-a994-752fc6213b88','Y',0,'N','N','N','N')
;

-- May 19, 2020, 11:34:37 PM CEST
ALTER TABLE AD_UserPreference ADD MigrationScriptComment VARCHAR2(255) DEFAULT NULL 
;

-- May 19, 2020, 11:34:49 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206407,'Migration Script Comment',200189,214200,'Y',255,150,'N','N','N','N',0,0,'Y',TO_DATE('2020-05-19 23:34:48','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-05-19 23:34:48','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','15bae19e-2b5a-4300-808d-69123803bdc6','Y',150,5)
;

-- May 19, 2020, 11:35:41 PM CEST
UPDATE AD_Field SET DisplayLogic='@P|LogMigrationScript@=Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsQuickEntry='Y', IsToolbarButton=NULL,Updated=TO_DATE('2020-05-19 23:35:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206407
;

-- May 19, 2020, 11:36:13 PM CEST
UPDATE AD_SysConfig SET IsActive='N',Updated=TO_DATE('2020-05-20 00:01:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_SysConfig_ID IN (50003,50008)
;

SELECT register_migration_script('202005192336_IDEMPIERE-2523.sql') FROM dual
;

