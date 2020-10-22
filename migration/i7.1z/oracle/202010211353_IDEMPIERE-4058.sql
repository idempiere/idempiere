SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4058 tab editor: new options for editing and customizing fields (window customization)
-- Oct 8, 2019, 1:34:57 PM BRT
UPDATE AD_Process SET AccessLevel='7',Updated=TO_DATE('2019-10-08 13:34:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Process_ID=200015
;

-- Oct 8, 2019, 1:35:16 PM BRT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,AD_ToolBarButton_ID,Name,Updated,UpdatedBy,IsCustomization,AD_ToolBarButton_UU,Action,AD_Tab_ID,AD_Process_ID,DisplayLogic,SeqNo,EntityType) VALUES (0,0,TO_DATE('2019-10-08 13:35:16','YYYY-MM-DD HH24:MI:SS'),0,'Tab Editor','Y',200109,'Tab Editor',TO_DATE('2019-10-08 13:35:16','YYYY-MM-DD HH24:MI:SS'),0,'N','3efa5e1a-99f1-4316-9724-7cc6f5b694eb','W',394,200015,'@IsActive@=Y',10,'D')
;

-- Oct 8, 2019, 1:37:02 PM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214327,0,'Field Group','Logical grouping of fields','The Field Group indicates the logical group that this field belongs to (History, Amounts, Quantities)',464,'AD_FieldGroup_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_DATE('2019-10-08 13:37:02','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2019-10-08 13:37:02','YYYY-MM-DD HH24:MI:SS'),0,1500,'Y','N','D','N','N','N','Y','f69f9b76-94c6-466e-b7b7-5bd86ae339ba','Y',0,'N','N','N')
;

-- Oct 8, 2019, 1:37:07 PM BRT
UPDATE AD_Column SET FKConstraintName='ADFieldGroup_ADUserDefField', FKConstraintType='N',Updated=TO_DATE('2019-10-08 13:37:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=214327
;

-- Oct 8, 2019, 1:37:07 PM BRT
ALTER TABLE AD_UserDef_Field ADD AD_FieldGroup_ID NUMBER(10) DEFAULT NULL
;

-- Oct 8, 2019, 1:37:07 PM BRT
ALTER TABLE AD_UserDef_Field ADD CONSTRAINT ADFieldGroup_ADUserDefField FOREIGN KEY (AD_FieldGroup_ID) REFERENCES ad_fieldgroup(ad_fieldgroup_id) DEFERRABLE INITIALLY DEFERRED
;

-- Oct 8, 2019, 1:37:45 PM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206521,'Field Group','Logical grouping of fields','The Field Group indicates the logical group that this field belongs to (History, Amounts, Quantities)',395,214327,'Y',22,330,'N','N','N','N',0,0,'Y',TO_DATE('2019-10-08 13:37:45','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2019-10-08 13:37:45','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','6f71bd66-6a96-40ad-a016-42f74fcb3c95','Y',330,2)
;

-- Oct 8, 2019, 1:38:59 PM BRT
UPDATE AD_Field SET SeqNo=155, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-10-08 13:38:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206521
;

-- Oct 9, 2020, 8:40:22 AM BRT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Window customization Language != Session Language',0,0,'Y',TO_DATE('2020-10-09 08:40:22','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-09 08:40:22','YYYY-MM-DD HH24:MI:SS'),100,200641,'TabEditorWrongLanguage','D','dcf44ca0-91e1-4c26-a684-6c645ef11eeb')
;

SELECT register_migration_script('202010211353_IDEMPIERE-4058.sql') FROM dual
;

