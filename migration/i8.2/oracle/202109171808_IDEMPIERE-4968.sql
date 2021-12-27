SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4968 Enable 2Pack to run java class or script
-- Sep 17, 2021, 6:07:17 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200519,'Script JSR223',50004,'SCJ',0,0,'Y',TO_DATE('2021-09-17 18:07:17','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-09-17 18:07:17','YYYY-MM-DD HH24:MI:SS'),100,'D','9a9c315b-9af4-4e83-be41-5f5057c13061')
;

-- Sep 17, 2021, 6:07:23 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200521,'Shell Script',50004,'SH',0,0,'Y',TO_DATE('2021-09-17 18:07:22','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-09-17 18:07:22','YYYY-MM-DD HH24:MI:SS'),100,'D','48522ab7-f47c-4ee9-a6b3-21fb762b3e1a')
;

-- Sep 17, 2021, 6:28:33 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203542,0,0,'Y',TO_DATE('2021-09-17 18:28:22','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-09-17 18:28:22','YYYY-MM-DD HH24:MI:SS'),100,'ExecCode','Execution Code',NULL,NULL,'Execution Code','D','54a4baac-9786-446a-bd22-acbe58fedfae')
;

-- Sep 17, 2021, 6:28:47 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214590,0,'Execution Code',50006,'ExecCode',0,'N','N','N','N','N',0,'N',36,0,0,'Y',TO_DATE('2021-09-17 18:28:47','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-09-17 18:28:47','YYYY-MM-DD HH24:MI:SS'),100,203542,'Y','N','D','N','N','N','Y','4c3a9c23-86bc-4ffe-b3ad-52703d53e5b2','Y',0,'N','N','N','N')
;

-- Sep 17, 2021, 6:28:50 PM CEST
ALTER TABLE AD_Package_Exp_Detail ADD ExecCode CLOB DEFAULT NULL 
;

-- Sep 17, 2021, 6:29:54 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206750,'Execution Code',50006,214590,'Y','@Type@=SCJ | @Type@=SH',0,340,0,'N','N','N','N',0,0,'Y',TO_DATE('2021-09-17 18:29:53','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-09-17 18:29:53','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f0e80eea-0c09-46a6-b69a-a0a796448e84','Y',340,1,1,1,'N','N','N','N')
;

-- Sep 17, 2021, 6:30:23 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=330, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, ColumnSpan=5, NumLines=8, IsToolbarButton=NULL,Updated=TO_DATE('2021-09-17 18:30:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206750
;

-- Sep 17, 2021, 6:30:23 PM CEST
UPDATE AD_Field SET SeqNo=340, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-09-17 18:30:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50117
;

-- Sep 23, 2021, 6:17:49 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214591,0,'Execution Code',50004,'ExecCode',0,'N','N','N','N','N',0,'N',36,0,0,'Y',TO_DATE('2021-09-23 18:17:48','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-09-23 18:17:48','YYYY-MM-DD HH24:MI:SS'),100,203542,'Y','N','D','N','N','N','Y','19a844b4-e6e2-44eb-ba01-d27b8f10c758','Y',0,'N','N','N','N')
;

-- Sep 23, 2021, 6:17:50 PM CEST
ALTER TABLE AD_Package_Imp_Detail ADD ExecCode CLOB DEFAULT NULL 
;

-- Sep 23, 2021, 6:19:25 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214592,0,'Result','Result of the action taken','The Result indicates the result of any action taken on this request.',50004,'Result',0,'N','N','N','N','N',0,'N',36,0,0,'Y',TO_DATE('2021-09-23 18:19:24','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-09-23 18:19:24','YYYY-MM-DD HH24:MI:SS'),100,546,'N','N','D','N','N','N','Y','0feb2960-ed0e-4a43-8c0b-8c567b0969b1','Y',0,'N','N','N')
;

-- Sep 23, 2021, 6:19:28 PM CEST
ALTER TABLE AD_Package_Imp_Detail ADD Result CLOB DEFAULT NULL 
;

-- Sep 23, 2021, 6:21:01 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206751,'Execution Code',50004,214591,'Y',0,110,0,'N','N','N','N',0,0,'Y',TO_DATE('2021-09-23 18:21:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-09-23 18:21:00','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5da85957-d2ab-42e0-b8fc-fd7d11a49a07','Y',80,1,1,1,'N','N','N','N')
;

-- Sep 23, 2021, 6:21:07 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206752,'Result','Result of the action taken','The Result indicates the result of any action taken on this request.',50004,214592,'Y',0,120,0,'N','N','N','N',0,0,'Y',TO_DATE('2021-09-23 18:21:07','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-09-23 18:21:07','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','921e0126-c9a7-4029-beb8-930a95b64ef7','Y',90,1,1,1,'N','N','N','N')
;

-- Sep 23, 2021, 6:21:45 PM CEST
UPDATE AD_Field SET SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ColumnSpan=5, NumLines=3, IsToolbarButton=NULL,Updated=TO_DATE('2021-09-23 18:21:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206751
;

-- Sep 23, 2021, 6:21:45 PM CEST
UPDATE AD_Field SET SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ColumnSpan=5, NumLines=3, IsToolbarButton=NULL,Updated=TO_DATE('2021-09-23 18:21:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206752
;

-- Sep 23, 2021, 6:21:45 PM CEST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-09-23 18:21:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204550
;

SELECT register_migration_script('202109171808_IDEMPIERE-4968.sql') FROM dual
;

