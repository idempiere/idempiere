SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4005 : Force grid mode when Find panel closes
-- Jul 10, 2019, 10:30:08 AM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200152,0,0,TO_DATE('2019-07-10 10:30:08','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2019-07-10 10:30:08','YYYY-MM-DD HH24:MI:SS'),0,0,'Y','ZK_GRID_AFTER_FIND','N','The display mode can swith automatically on grid when the find panel closes','D','C','d3d69e9a-47d8-4fe8-80e6-564af031f9e5')
;

-- Jul 10, 2019, 10:30:36 AM CEST
INSERT INTO AD_Reference (AD_Reference_ID,Name,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200170,'ViewFindResult','L',0,0,'Y',TO_DATE('2019-07-10 10:30:35','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2019-07-10 10:30:35','YYYY-MM-DD HH24:MI:SS'),0,'D','N','718b69d3-4b62-4d7d-a137-470e4e272052')
;

-- Jul 10, 2019, 10:30:51 AM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,Description,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200474,'Default','Use what is defined on the Sysconfig key',200170,'0',0,0,'Y',TO_DATE('2019-07-10 10:30:50','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2019-07-10 10:30:50','YYYY-MM-DD HH24:MI:SS'),0,'D','f4ec3670-1ae8-4442-afb3-c74d2df7a06e')
;

-- Jul 10, 2019, 10:30:59 AM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200475,'Always in Grid View',200170,'1',0,0,'Y',TO_DATE('2019-07-10 10:30:59','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2019-07-10 10:30:59','YYYY-MM-DD HH24:MI:SS'),0,'D','ca0109d2-766d-4123-832c-f614c8c52ef2')
;

-- Jul 10, 2019, 10:31:07 AM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200476,'According to threshold',200170,'2',0,0,'Y',TO_DATE('2019-07-10 10:31:07','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2019-07-10 10:31:07','YYYY-MM-DD HH24:MI:SS'),0,'D','a81e98ac-ddae-410c-8a20-d447ceed5486')
;

-- Jul 10, 2019, 10:31:26 AM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203345,0,0,'Y',TO_DATE('2019-07-10 10:31:26','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2019-07-10 10:31:26','YYYY-MM-DD HH24:MI:SS'),0,'ViewFindResult','View find result','Does the system must switch to grid mode after the Find panel closes','View find result','D','d9def948-0c09-46cb-800b-b5937bb8bec3')
;

-- Jul 10, 2019, 10:31:39 AM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203346,0,0,'Y',TO_DATE('2019-07-10 10:31:39','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2019-07-10 10:31:39','YYYY-MM-DD HH24:MI:SS'),0,'GridAfterFindThreshold','Threshold','Force grid view when Find panel closes if number of records exceed threshold','Threshold','D','4a809a40-c995-4f36-a6cb-2859ca2fa345')
;

-- Jul 10, 2019, 10:32:08 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (213965,0,'View find result','Does the system must switch to grid mode after the Find panel closes',200174,'ViewFindResult','0',1,'N','N','Y','N','N',0,'N',17,200170,0,0,'Y',TO_DATE('2019-07-10 10:32:07','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2019-07-10 10:32:07','YYYY-MM-DD HH24:MI:SS'),0,203345,'Y','N','D','N','N','N','Y','d66b873b-9544-4298-94d3-883751355b8d','N',0,'N','N','N','N')
;

-- Jul 10, 2019, 10:32:09 AM CEST
ALTER TABLE AD_UserPreference ADD ViewFindResult CHAR(1) DEFAULT '0' NOT NULL
;

-- Jul 10, 2019, 10:32:30 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,MandatoryLogic,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (213966,0,'Threshold','Force grid view when Find panel closes if number of records exceed threshold',200174,'GridAfterFindThreshold',10,'N','N','N','N','N',0,'N',11,0,0,'Y',TO_DATE('2019-07-10 10:32:30','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2019-07-10 10:32:30','YYYY-MM-DD HH24:MI:SS'),0,203346,'Y','N','U','N','N','@ViewFindResult@ = 2','N','Y','ebc023d1-3d96-4761-ba09-39db3da385c0','N',0,'N','N','N','N')
;

-- Jul 10, 2019, 10:32:31 AM CEST
ALTER TABLE AD_UserPreference ADD GridAfterFindThreshold NUMBER(10) DEFAULT NULL 
;

-- Jul 10, 2019, 10:32:35 AM CEST
UPDATE AD_Column SET EntityType='D',Updated=TO_DATE('2019-07-10 10:32:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=213966
;

-- Jul 10, 2019, 10:33:18 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206133,'View find result','Does the system must switch to grid mode after the Find panel closes',200189,213965,'Y',1,130,'N','N','N','N',0,0,'Y',TO_DATE('2019-07-10 10:33:18','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2019-07-10 10:33:18','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','c3637c90-40dd-42f3-8248-b47b4b97491e','Y',130,2)
;

-- Jul 10, 2019, 10:33:18 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206134,'Threshold','Force grid view when Find panel closes if number of records exceed threshold',200189,213966,'Y',10,140,'N','N','N','N',0,0,'Y',TO_DATE('2019-07-10 10:33:18','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2019-07-10 10:33:18','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','eafb72af-6375-4b17-830a-c19ddecc56a3','Y',140,2)
;

-- Jul 10, 2019, 10:33:28 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2019-07-10 10:33:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206134
;

-- Jul 10, 2019, 10:33:46 AM CEST
UPDATE AD_Field SET DisplayLogic='@ViewFindResult@ = 2', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-07-10 10:33:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206134
;

SELECT register_migration_script('201907101055_IDEMPIERE-4005.sql') FROM dual
;