SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4616 : Lead : add IsVendorLead
-- 2020-12-31 09:47:20
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203450,0,0,'Y',TO_DATE('2020-12-31 09:47:20','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2020-12-31 09:47:20','YYYY-MM-DD HH24:MI:SS'),0,'IsVendorLead','Vendor Lead','This contact is a vendor lead','Vendor leads can be converted into full contacts with Business Partners.','Vendor Lead','D','78171db5-d69e-4afa-a384-8d36641ab6b1')
;

-- 2020-12-31 09:47:52
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214342,0,'Vendor Lead','This contact is a vendor lead','Vendor leads can be converted into full contacts with Business Partners.',114,'IsVendorLead','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_DATE('2020-12-31 09:47:52','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2020-12-31 09:47:52','YYYY-MM-DD HH24:MI:SS'),0,203450,'Y','N','D','Y','N','N','Y','f446cbfd-ada5-4d5c-a984-3ff62a4161ad','Y','N','N','N','N')
;

-- 2020-12-31 09:47:54
ALTER TABLE AD_User ADD IsVendorLead CHAR(1) DEFAULT 'N' CHECK (IsVendorLead IN ('Y','N')) NOT NULL
;

-- 2020-12-31 09:48:14
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (206543,'Vendor Lead','This contact is a vendor lead','Vendor leads can be converted into full contacts with Business Partners.',53429,214342,'Y',0,250,0,'N','N','N','N',0,0,'Y',TO_DATE('2020-12-31 09:48:14','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2020-12-31 09:48:14','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','cc661c8b-945d-4b76-a62a-a3258aa51f5d','Y',240,1,1,1,'N','N','N')
;

-- 2020-12-31 09:48:39
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, IsToolbarButton=NULL,Updated=TO_DATE('2020-12-31 09:48:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=62151
;

-- 2020-12-31 09:48:39
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=6, IsToolbarButton=NULL,Updated=TO_DATE('2020-12-31 09:48:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206543
;

-- 2020-12-31 09:48:39
UPDATE AD_Field SET SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-12-31 09:48:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=62133
;

-- 2020-12-31 09:48:39
UPDATE AD_Field SET SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-12-31 09:48:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=62134
;

-- 2020-12-31 09:48:39
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-12-31 09:48:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=62132
;

-- 2020-12-31 09:48:39
UPDATE AD_Field SET SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-12-31 09:48:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=62135
;

-- 2020-12-31 09:48:39
UPDATE AD_Field SET SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-12-31 09:48:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=62143
;

-- 2020-12-31 09:48:39
UPDATE AD_Field SET SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-12-31 09:48:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=62140
;

-- 2020-12-31 09:48:39
UPDATE AD_Field SET SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-12-31 09:48:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=62725
;

-- 2020-12-31 09:48:39
UPDATE AD_Field SET SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-12-31 09:48:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=62724
;

-- 2020-12-31 09:48:39
UPDATE AD_Field SET SeqNo=190, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-12-31 09:48:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=62139
;

-- 2020-12-31 09:48:39
UPDATE AD_Field SET SeqNo=200, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-12-31 09:48:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=62144
;

-- 2020-12-31 09:48:39
UPDATE AD_Field SET SeqNo=210, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-12-31 09:48:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=62155
;

-- 2020-12-31 09:48:39
UPDATE AD_Field SET SeqNo=220, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-12-31 09:48:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=62147
;

-- 2020-12-31 09:48:39
UPDATE AD_Field SET SeqNo=230, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-12-31 09:48:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=62148
;

-- 2020-12-31 09:48:39
UPDATE AD_Field SET SeqNo=240, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-12-31 09:48:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=62149
;

-- 2020-12-31 09:48:39
UPDATE AD_Field SET SeqNo=250, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-12-31 09:48:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=62150
;

-- 2020-12-31 09:48:39
UPDATE AD_Field SET SeqNo=260, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-12-31 09:48:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=62130
;

-- 2020-12-31 09:49:07
UPDATE AD_Tab SET WhereClause='(AD_User.IsSalesLead=''Y'' OR AD_User.IsVendorLead=''Y'')',Updated=TO_DATE('2020-12-31 09:49:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Tab_ID=53429
;

-- 2021-01-04 10:34:12
UPDATE AD_Window SET Help='The Lead Window allows you to maintain Leads (can be Sales or Purchase). These are unqualified contacts to who you wish to recruit or market to. ',Updated=TO_DATE('2021-01-04 10:34:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Window_ID=53153
;

-- 2021-01-04 10:34:37
UPDATE AD_Process_Para SET DisplayLogic='@CreateOpportunity@ = Y',Updated=TO_DATE('2021-01-04 10:34:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Process_Para_ID=53583
;

-- 2021-01-04 10:34:40
UPDATE AD_Process_Para SET DisplayLogic='@CreateOpportunity@ = Y',Updated=TO_DATE('2021-01-04 10:34:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Process_Para_ID=53584
;

-- 2021-01-04 10:34:46
UPDATE AD_Process_Para SET DisplayLogic='@CreateOpportunity@ = Y',Updated=TO_DATE('2021-01-04 10:34:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Process_Para_ID=53585
;

-- 2021-01-04 10:34:48
UPDATE AD_Process_Para SET DisplayLogic='@CreateOpportunity@ = Y',Updated=TO_DATE('2021-01-04 10:34:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Process_Para_ID=53586
;

-- 2021-01-04 10:34:51
UPDATE AD_Process_Para SET DisplayLogic='@CreateOpportunity@ = Y',Updated=TO_DATE('2021-01-04 10:34:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Process_Para_ID=53587
;

-- 2021-01-04 10:34:53
UPDATE AD_Process_Para SET DisplayLogic='@CreateOpportunity@ = Y',Updated=TO_DATE('2021-01-04 10:34:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Process_Para_ID=53588
;

-- 2021-01-04 10:35:09
UPDATE AD_Process_Para SET DefaultValue='@IsSalesLead@',Updated=TO_DATE('2021-01-04 10:35:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Process_Para_ID=53582
;

SELECT register_migration_script('202012311000_IDEMPIERE-4616.sql') FROM dual
;